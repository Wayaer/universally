import 'dart:async';
import 'dart:ui';

import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' hide FileImage;
import 'package:universally/universally.dart' hide FileImage;

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
  final AnimationController? controller;

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
    this.controller,
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
  }) : assert(fps == null || duration == null, 'only one of the two can be set [fps] [duration]'),
       assert(fps == null || fps > 0, 'fps must be greater than 0');

  @override
  State<Gif> createState() => _GifState();
}

/// Works as a cache system for already fetched [GifInfo].
@immutable
class GifCache {
  final Map<String, GifInfo> caches = {};

  /// Clears all the stored gifs from the cache.
  void clear() => caches.clear();

  /// Removes single gif from the cache.
  bool evict(Object key) => caches.remove(key) != null ? true : false;
}

/// Stores all the [ImageInfo] and duration of a gif.
@immutable
class GifInfo {
  final List<ImageInfo> frames;
  final Duration duration;

  const GifInfo({required this.frames, required this.duration});
}

class _GifState extends ExtendedState<Gif> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  /// List of [ImageInfo] of every frame of this gif.
  List<ImageInfo> frames = [];

  int frameIndex = 0;

  /// Current rendered frame.
  ImageInfo? get frame => frames.length > frameIndex ? frames[frameIndex] : null;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFrames().then((value) => autostart());
  }

  @override
  Widget build(BuildContext context) {
    final RawImage image = RawImage(
      image: frame?.image,
      width: widget.width,
      height: widget.height,
      scale: frame?.scale ?? 1.0,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
    );
    return widget.placeholder != null && frame == null
        ? widget.placeholder!(context)
        : widget.excludeFromSemantics
        ? image
        : Semantics(
            container: widget.semanticLabel != null,
            image: true,
            label: widget.semanticLabel ?? '',
            child: image,
          );
  }

  @override
  void didUpdateWidget(Gif oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != controller) {
      removeListener();
      controller.dispose();
      initController();
      loadFrames().then((value) => autostart());
    }
  }

  void initController() {
    controller = widget.controller ?? AnimationController(vsync: this, duration: widget.duration);
    controller.addListener(listener);
  }

  void removeListener() {
    controller.removeListener(listener);
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
    if (widget.controller == null) {
      controller.dispose();
    }
  }

  /// Start this gif according to [widget.autostart] and [widget.loop].
  void autostart() {
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
  String getImageKey(ImageProvider provider) {
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

  /// Calculates the [frameIndex] based on the [AnimationController] value.
  ///
  /// The calculation is based on the frames of the gif
  /// and the [Duration] of [AnimationController].
  void listener() {
    if (frames.isNotEmpty && mounted) {
      frameIndex = frames.isEmpty ? 0 : (frames.length * controller.value).floor();
      if (frameIndex >= frames.length) frameIndex = frames.length - 1;
      setState(() {});
    }
  }

  /// Fetches the frames with [_fetchFrames] and saves them into [frames].
  ///
  /// When [frames] is updated [onFetchCompleted] is called.
  Future<void> loadFrames() async {
    if (!mounted) return;
    final useCache = Gif.cache.caches.containsKey(getImageKey(widget.image)) && widget.useCache;

    GifInfo? gif = useCache ? Gif.cache.caches[getImageKey(widget.image)]! : await fetchFrames(widget.image);
    if (gif == null) return;
    if (useCache) {
      Gif.cache.caches.putIfAbsent(getImageKey(widget.image), () => gif);
    }
    frames = gif.frames;
    controller.duration = widget.fps != null
        ? Duration(milliseconds: (frames.length / widget.fps! * 1000).round())
        : widget.duration ?? gif.duration;
    if (widget.onFetchCompleted != null) {
      widget.onFetchCompleted!();
    }
    if (mounted) setState(() {});
  }

  /// Fetches the single gif frames and saves them into the [GifCache] of [Gif]
  Future<GifInfo?> fetchFrames(ImageProvider provider) async {
    Uint8List? bytes;
    if (provider is NetworkImage) {
      try {
        final options = Options(headers: {}, responseType: ResponseType.bytes);
        provider.headers?.forEach((String name, String value) => options.headers?.addAll({name: value}));
        final data = await Dio().get(provider.url, options: options);
        if (data.statusCode == 200) {
          bytes = Uint8List.fromList(data.data);
        }
      } catch (e) {
        debugPrint('Gif network image error:$e');
      }
    } else if (provider is AssetImage) {
      AssetBundleImageKey key = await provider.obtainKey(const ImageConfiguration());
      bytes = (await key.bundle.load(key.name)).buffer.asUint8List();
    } else if (provider is FileImage) {
      bytes = await provider.file.readAsBytes();
    } else if (provider is MemoryImage) {
      bytes = provider.bytes;
    }
    if (bytes == null) return null;
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

  Future<Uint8List> loadGifImageData(NetworkImage provider) async {
    Completer<Uint8List> completer = Completer();
    provider
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool syncCall) {
            info.image.toByteData(format: ImageByteFormat.rawRgba).then((byteData) {
              completer.complete(Uint8List.view(byteData!.buffer));
            });
          }),
        );
    return await completer.future;
  }
}
