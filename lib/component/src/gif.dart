import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

final HttpClient _sharedHttpClient = HttpClient()..autoUncompress = false;

HttpClient get _httpClient {
  HttpClient client = _sharedHttpClient;
  assert(() {
    if (debugNetworkImageHttpClientProvider != null) {
      client = debugNetworkImageHttpClientProvider!();
    }
    return true;
  }());
  return client;
}

/// How to auto start the gif.
enum Autostart {
  /// Don't start.
  no,

  /// Run once everytime a new gif is loaded.
  once,

  /// Loop playback.
  loop,
}

///
/// A widget that renders a Gif controllable with [AnimationController].
///
@immutable
class Gif extends StatefulWidget {
  /// Rendered gifs cache.
  static GifCache cache = GifCache();

  /// [ImageProvider] of this gif. Like [NetworkImage], [AssetImage], [MemoryImage]
  final ImageProvider image;

  /// This playback controller.
  final GifController controller;

  /// Frames per second at which this runs.
  final int? fps;

  /// Whole playback duration.
  final Duration? duration;

  /// If and how to start this gif.
  final Autostart autostart;

  /// Rendered when gif frames fetch is still not completed.
  final Widget Function(BuildContext context)? placeholder;

  /// Called when gif frames fetch is completed.
  final VoidCallback? onFetchCompleted;

  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final bool useCache;

  /// Creates a widget that displays a controllable gif.
  ///
  /// [fps] frames per second at which this should be rendered.
  ///
  /// [duration] whole playback duration for this gif.
  ///
  /// [autostart] if and how to start this gif. Defaults to [Autostart.no].
  ///
  /// [placeholder] this widget is rendered during the gif frames fetch.
  ///
  /// [onFetchCompleted] is called when the frames fetch finishes and the gif can be
  /// rendered.
  ///
  /// Only one of the two can be set: [fps] or [duration]
  /// If [controller.duration] and [fps] are not specified, the original gif
  /// framerate will be used.
  const Gif({
    super.key,
    required this.image,
    required this.controller,
    this.fps,
    this.duration,
    this.autostart = Autostart.no,
    this.placeholder,
    this.onFetchCompleted,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.useCache = true,
  })  : assert(fps == null || duration == null,
            'only one of the two can be set [fps] [duration]'),
        assert(fps == null || fps > 0, 'fps must be greater than 0');

  @override
  State<Gif> createState() => _GifState();
}

///
/// Works as a cache system for already fetched [GifInfo].
///
@immutable
class GifCache {
  final Map<String, GifInfo> caches = {};

  /// Clears all the stored gifs from the cache.
  void clear() => caches.clear();

  /// Removes single gif from the cache.
  bool evict(Object key) => caches.remove(key) != null ? true : false;
}

///
/// Controller that wraps [AnimationController] and protects the [duration] parameter.
/// This falls into a design choice to keep the duration control to the [Gif]
/// widget.
///
class GifController extends AnimationController {
  GifController({required super.vsync});
}

///
/// Stores all the [ImageInfo] and duration of a gif.
///
@immutable
class GifInfo {
  final List<ImageInfo> frames;
  final Duration duration;

  const GifInfo({
    required this.frames,
    required this.duration,
  });
}

class _GifState extends State<Gif> {
  late GifController controller;

  /// List of [ImageInfo] of every frame of this gif.
  List<ImageInfo> _frames = [];

  int _frameIndex = 0;

  /// Current rendered frame.
  ImageInfo? get _frame =>
      _frames.length > _frameIndex ? _frames[_frameIndex] : null;

  @override
  Widget build(BuildContext context) {
    final RawImage image = RawImage(
      image: _frame?.image,
      width: widget.width,
      height: widget.height,
      scale: _frame?.scale ?? 1.0,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
    );
    return widget.placeholder != null && _frame == null
        ? widget.placeholder!(context)
        : widget.excludeFromSemantics
            ? image
            : Semantics(
                container: widget.semanticLabel != null,
                image: true,
                label: widget.semanticLabel ?? '',
                child: image);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFrames().then((value) => _autostart());
  }

  @override
  void didUpdateWidget(Gif oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != controller) {
      removeListener();
      initController();
    }
    if ((widget.image != oldWidget.image) ||
        (widget.fps != oldWidget.fps) ||
        (widget.duration != oldWidget.duration)) {
      _loadFrames().then((value) {
        if (widget.image != oldWidget.image) {
          _autostart();
        }
      });
    }
    if ((widget.autostart != oldWidget.autostart)) {
      _autostart();
    }
  }

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    controller = widget.controller;
    controller.addListener(_listener);
  }

  void removeListener() {
    controller.removeListener(_listener);
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }

  /// Start this gif according to [widget.autostart] and [widget.loop].
  void _autostart() {
    if (mounted && widget.autostart != Autostart.no) {
      controller.reset();
      if (widget.autostart == Autostart.loop) {
        controller.repeat();
      } else {
        controller.forward();
      }
    }
  }

  /// Get unique image string from [ImageProvider]
  String _getImageKey(ImageProvider provider) {
    if (provider is NetworkImage) {
      return provider.url;
    } else if (provider is AssetImage) {
      return provider.assetName;
    } else if (provider is MemoryImage) {
      return provider.bytes.toString();
    } else if (provider is FileImage) {
      return provider.file.path.toString();
    }
    return '';
  }

  /// Calculates the [_frameIndex] based on the [AnimationController] value.
  ///
  /// The calculation is based on the frames of the gif
  /// and the [Duration] of [AnimationController].
  void _listener() {
    if (_frames.isNotEmpty && mounted) {
      _frameIndex = _frames.isEmpty
          ? 0
          : ((_frames.length - 1) * controller.value).floor();
      if (mounted) setState(() {});
    }
  }

  /// Fetches the frames with [_fetchFrames] and saves them into [_frames].
  ///
  /// When [_frames] is updated [onFetchCompleted] is called.
  Future<void> _loadFrames() async {
    if (!mounted) return;
    final useCache = Gif.cache.caches.containsKey(_getImageKey(widget.image)) &&
        widget.useCache;

    GifInfo gif = useCache
        ? Gif.cache.caches[_getImageKey(widget.image)]!
        : await _fetchFrames(widget.image);
    if (useCache) {
      Gif.cache.caches.putIfAbsent(_getImageKey(widget.image), () => gif);
    }

    _frames = gif.frames;
    controller.duration = widget.fps != null
        ? Duration(milliseconds: (_frames.length / widget.fps! * 1000).round())
        : widget.duration ?? gif.duration;
    if (widget.onFetchCompleted != null) {
      widget.onFetchCompleted!();
    }
    if (mounted) setState(() {});
  }

  /// Fetches the single gif frames and saves them into the [GifCache] of [Gif]
  static Future<GifInfo> _fetchFrames(ImageProvider provider) async {
    late final Uint8List bytes;

    if (provider is NetworkImage) {
      final Uri resolved = Uri.base.resolve(provider.url);
      final HttpClientRequest request = await _httpClient.getUrl(resolved);
      provider.headers?.forEach(
          (String name, String value) => request.headers.add(name, value));
      final HttpClientResponse response = await request.close();
      bytes = await consolidateHttpClientResponseBytes(response);
    } else if (provider is AssetImage) {
      AssetBundleImageKey key =
          await provider.obtainKey(const ImageConfiguration());
      bytes = (await key.bundle.load(key.name)).buffer.asUint8List();
    } else if (provider is FileImage) {
      bytes = await provider.file.readAsBytes();
    } else if (provider is MemoryImage) {
      bytes = provider.bytes;
    }

    Codec codec = await instantiateImageCodec(bytes);
    List<ImageInfo> info = [];
    Duration duration = const Duration();
    for (int i = 0; i < codec.frameCount; i++) {
      FrameInfo frameInfo = await codec.getNextFrame();
      info.add(ImageInfo(image: frameInfo.image));
      duration += frameInfo.duration;
    }
    return GifInfo(frames: info, duration: duration);
  }
}
