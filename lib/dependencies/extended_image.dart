import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseResizeImage extends ExtendedResizeImage {
  BaseResizeImage.memory(
    Uint8List bytes, {
    double scale = 1.0,
    bool cacheRawData = false,
    String? imageCacheName,
    int? cacheWidth,
    int? cacheHeight,
    double? compressionRatio,
    int? maxBytes,
  }) : super(ExtendedResizeImage.resizeIfNeeded(
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            maxBytes: maxBytes,
            compressionRatio: compressionRatio,
            cacheRawData: cacheRawData,
            imageCacheName: imageCacheName,
            provider: ExtendedMemoryImageProvider(bytes,
                scale: scale,
                cacheRawData: cacheRawData,
                imageCacheName: imageCacheName)));

  BaseResizeImage.asset(
    String assetName, {
    AssetBundle? bundle,
    String? package,
    bool cacheRawData = false,
    String? imageCacheName,
    int? cacheWidth,
    int? cacheHeight,
    double? compressionRatio,
    int? maxBytes,
  }) : super(ExtendedResizeImage.resizeIfNeeded(
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            maxBytes: maxBytes,
            compressionRatio: compressionRatio,
            cacheRawData: cacheRawData,
            imageCacheName: imageCacheName,
            provider: ExtendedAssetImageProvider(assetName,
                bundle: bundle,
                package: package,
                cacheRawData: cacheRawData,
                imageCacheName: imageCacheName)));

  BaseResizeImage.file(
    File file, {
    double scale = 1.0,
    bool cacheRawData = false,
    String? imageCacheName,
    int? cacheWidth,
    int? cacheHeight,
    double? compressionRatio,
    int? maxBytes,
  }) : super(ExtendedResizeImage.resizeIfNeeded(
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            maxBytes: maxBytes,
            compressionRatio: compressionRatio,
            cacheRawData: cacheRawData,
            imageCacheName: imageCacheName,
            provider: ExtendedFileImageProvider(file,
                cacheRawData: cacheRawData,
                scale: scale,
                imageCacheName: imageCacheName)));

  BaseResizeImage.network(
    String url, {
    double scale = 1.0,
    Map<String, String>? headers,
    bool cache = true,
    int retries = 3,
    Duration? timeLimit,
    Duration timeRetry = const Duration(milliseconds: 100),
    CancellationToken? cancelToken,
    String? cacheKey,
    bool printError = true,
    Duration? cacheMaxAge,
    int? cacheWidth,
    int? cacheHeight,
    double? compressionRatio,
    int? maxBytes,
    bool cacheRawData = false,
    String? imageCacheName,
  }) : super(ExtendedResizeImage.resizeIfNeeded(
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            maxBytes: maxBytes,
            compressionRatio: compressionRatio,
            cacheRawData: cacheRawData,
            imageCacheName: imageCacheName,
            provider: ExtendedNetworkImageProvider(url,
                scale: scale,
                headers: headers,
                cache: cache,
                cancelToken: cancelToken,
                retries: retries,
                timeRetry: timeRetry,
                timeLimit: timeLimit,
                cacheKey: cacheKey,
                printError: printError,
                cacheRawData: cacheRawData,
                imageCacheName: imageCacheName,
                cacheMaxAge: cacheMaxAge)));
}

class BaseImage extends ExtendedImage {
  BaseImage(
    ImageProvider image, {
    super.key,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit = BoxFit.cover,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.loadStateChanged,
    super.border,
    super.shape = BoxShape.rectangle,
    super.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.clipBehavior = Clip.antiAlias,
    super.enableLoadState = false,
    super.beforePaintImage,
    super.afterPaintImage,
    super.mode = ExtendedImageMode.none,
    super.enableMemoryCache = true,
    super.clearMemoryCacheIfFailed = true,
    super.onDoubleTap,
    super.initGestureConfigHandler,
    super.enableSlideOutPage = false,
    super.constraints,
    super.extendedImageEditorKey,
    super.initEditorConfigHandler,
    super.heroBuilderForSlidingPage,
    super.clearMemoryCacheWhenDispose = false,
    super.extendedImageGestureKey,
    super.isAntiAlias = false,
    super.handleLoadingProgress = false,
    super.layoutInsets = EdgeInsets.zero,
  }) : super(image: image);

  BaseImage.file(
    File? file, {
    super.key,
    super.scale = 1.0,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit = BoxFit.cover,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.shape = BoxShape.rectangle,
    super.border,
    super.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.clipBehavior = Clip.antiAlias,
    super.enableLoadState = false,
    super.beforePaintImage,
    super.afterPaintImage,
    super.mode = ExtendedImageMode.none,
    super.enableMemoryCache = true,
    super.clearMemoryCacheIfFailed = true,
    super.onDoubleTap,
    super.initGestureConfigHandler,
    super.enableSlideOutPage = false,
    super.constraints,
    super.extendedImageEditorKey,
    super.initEditorConfigHandler,
    super.heroBuilderForSlidingPage,
    super.clearMemoryCacheWhenDispose = false,
    super.extendedImageGestureKey,
    super.cacheWidth,
    super.cacheHeight,
    super.isAntiAlias = false,
    super.compressionRatio,
    super.maxBytes,
    super.cacheRawData = false,
    super.imageCacheName,
    super.layoutInsets = EdgeInsets.zero,
    Widget? failed,
    Widget? loading,
  }) : super.file(file ?? File('file is null'),
            loadStateChanged:
                buildLoadStateChanged(failed: failed, loading: loading));

  BaseImage.memory(
    super.bytes, {
    super.key,
    super.scale = 1.0,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit = BoxFit.cover,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.shape = BoxShape.rectangle,
    super.border,
    super.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.clipBehavior = Clip.antiAlias,
    super.enableLoadState = false,
    super.beforePaintImage,
    super.afterPaintImage,
    super.mode = ExtendedImageMode.none,
    super.enableMemoryCache = true,
    super.clearMemoryCacheIfFailed = true,
    super.onDoubleTap,
    super.initGestureConfigHandler,
    super.enableSlideOutPage = false,
    super.constraints,
    super.extendedImageEditorKey,
    super.initEditorConfigHandler,
    super.heroBuilderForSlidingPage,
    super.clearMemoryCacheWhenDispose = false,
    super.extendedImageGestureKey,
    super.cacheWidth,
    super.cacheHeight,
    super.isAntiAlias = false,
    super.compressionRatio,
    super.maxBytes,
    super.cacheRawData = false,
    super.imageCacheName,
    super.layoutInsets = EdgeInsets.zero,
    Widget? failed,
    Widget? loading,
  }) : super.memory(
            loadStateChanged:
                buildLoadStateChanged(failed: failed, loading: loading));

  BaseImage.asset(
    String? name, {
    super.key,
    super.bundle,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.scale,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit = BoxFit.cover,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.package,
    super.filterQuality = FilterQuality.low,
    super.shape = BoxShape.rectangle,
    super.border,
    super.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.clipBehavior = Clip.antiAlias,
    super.enableLoadState = false,
    super.beforePaintImage,
    super.afterPaintImage,
    super.mode = ExtendedImageMode.none,
    super.enableMemoryCache = true,
    super.clearMemoryCacheIfFailed = true,
    super.onDoubleTap,
    super.initGestureConfigHandler,
    super.enableSlideOutPage = false,
    super.constraints,
    super.extendedImageEditorKey,
    super.initEditorConfigHandler,
    super.heroBuilderForSlidingPage,
    super.clearMemoryCacheWhenDispose = false,
    super.extendedImageGestureKey,
    super.cacheWidth,
    super.cacheHeight,
    super.isAntiAlias = false,
    super.compressionRatio,
    super.maxBytes,
    super.cacheRawData = false,
    super.imageCacheName,
    super.layoutInsets = EdgeInsets.zero,
    Widget? failed,
    Widget? loading,
  }) : super.asset(name ?? 'asset name is null',
            loadStateChanged:
                buildLoadStateChanged(failed: failed, loading: loading));

  BaseImage.network(
    String? url, {
    super.key,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit = BoxFit.cover,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.shape = BoxShape.rectangle,
    super.border,
    super.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.clipBehavior = Clip.antiAlias,
    super.enableLoadState = true,
    super.beforePaintImage,
    super.afterPaintImage,
    super.mode = ExtendedImageMode.none,
    super.enableMemoryCache = true,
    super.clearMemoryCacheIfFailed = true,
    super.onDoubleTap,
    super.initGestureConfigHandler,
    super.enableSlideOutPage = false,
    super.constraints,
    super.cancelToken,
    super.retries = 3,
    super.timeLimit,
    super.headers,
    super.cache = true,
    super.scale = 1.0,
    super.timeRetry = const Duration(milliseconds: 100),
    super.extendedImageEditorKey,
    super.initEditorConfigHandler,
    super.heroBuilderForSlidingPage,
    super.clearMemoryCacheWhenDispose = false,
    super.handleLoadingProgress = false,
    super.extendedImageGestureKey,
    super.cacheWidth,
    super.cacheHeight,
    super.isAntiAlias = false,
    super.cacheKey,
    super.printError = true,
    super.compressionRatio,
    super.maxBytes,
    super.cacheRawData = false,
    super.imageCacheName,
    super.cacheMaxAge,
    super.layoutInsets = EdgeInsets.zero,
    Widget? failed,
    Widget? loading,
  }) : super.network(url ?? 'url is null',
            loadStateChanged:
                buildLoadStateChanged(failed: failed, loading: loading));

  static LoadStateChanged buildLoadStateChanged(
          {Widget? failed, Widget? loading}) =>
      (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return loading ?? const ImageLoading(size: 16);
          case LoadState.completed:
            return null;
          case LoadState.failed:
            _logFailed(state);
            return failed ?? const ImageFailed(alignment: Alignment.center);
        }
      };

  static void _logFailed(ExtendedImageState state) {
    String? value;
    final imageProvider = state.imageProvider;
    if (imageProvider is ExtendedResizeImage) {
      final provider = imageProvider.imageProvider;
      if (provider is ExtendedMemoryImageProvider) {
        value = provider.bytes.length.toString();
      } else if (provider is ExtendedNetworkImageProvider) {
        value = provider.url;
      } else if (provider is ExtendedFileImageProvider) {
        value = provider.file.path;
      } else if (provider is ExtendedAssetImageProvider) {
        value = provider.assetName;
      }
    } else {
      if (imageProvider is MemoryImage) {
        value = imageProvider.bytes.length.toString();
      } else if (imageProvider is NetworkImage) {
        value = imageProvider.url;
      } else if (imageProvider is FileImage) {
        value = imageProvider.file.path;
      } else if (imageProvider is AssetImage) {
        value = imageProvider.assetName;
      }
    }
    '图片加载失败 $value'.log(crossLine: false);
  }

  static ImageProvider buildImageProvider(
    dynamic value, {
    int? cacheWidth,
    int? cacheHeight,
    double? compressionRatio,
    int? maxBytes,
    bool cacheRawData = false,
    String? imageCacheName,
    double scale = 1.0,

    /// [ExtendedNetworkImageProvider]
    Map<String, String>? headers,
    bool cache = true,
    int retries = 3,
    Duration? timeLimit,
    Duration timeRetry = const Duration(milliseconds: 100),
    CancellationToken? cancelToken,
    String? cacheKey,
    bool printError = true,
    Duration? cacheMaxAge,

    /// [ExtendedAssetImageProvider]
    AssetBundle? bundle,
    String? package,
  }) {
    if (value is File) {
      return BaseResizeImage.file(value,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          maxBytes: maxBytes,
          compressionRatio: compressionRatio,
          cacheRawData: cacheRawData,
          imageCacheName: imageCacheName,
          scale: scale);
    } else if (value is Uint8List) {
      return BaseResizeImage.memory(value,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          maxBytes: maxBytes,
          compressionRatio: compressionRatio,
          cacheRawData: cacheRawData,
          imageCacheName: imageCacheName,
          scale: scale);
    } else if (value is String) {
      return value.startsWith('http')
          ? BaseResizeImage.network(value,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
              maxBytes: maxBytes,
              compressionRatio: compressionRatio,
              cacheRawData: cacheRawData,
              imageCacheName: imageCacheName,
              scale: scale,
              headers: headers,
              cache: cache,
              cancelToken: cancelToken,
              retries: retries,
              timeRetry: timeRetry,
              timeLimit: timeLimit,
              cacheKey: cacheKey,
              printError: printError,
              cacheMaxAge: cacheMaxAge)
          : BaseResizeImage.asset(value,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
              maxBytes: maxBytes,
              compressionRatio: compressionRatio,
              cacheRawData: cacheRawData,
              imageCacheName: imageCacheName,
              bundle: bundle,
              package: package);
    }
    return BaseResizeImage.asset('');
  }

  BaseImage.custom(
    dynamic image, {
    super.key,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit = BoxFit.cover,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.border,
    super.shape = BoxShape.rectangle,
    super.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.clipBehavior = Clip.antiAlias,
    super.enableLoadState = true,
    super.beforePaintImage,
    super.afterPaintImage,
    super.mode = ExtendedImageMode.none,
    super.enableMemoryCache = true,
    super.clearMemoryCacheIfFailed = true,
    super.onDoubleTap,
    super.initGestureConfigHandler,
    super.enableSlideOutPage = false,
    super.constraints,
    super.extendedImageEditorKey,
    super.initEditorConfigHandler,
    super.heroBuilderForSlidingPage,
    super.clearMemoryCacheWhenDispose = false,
    super.extendedImageGestureKey,
    super.isAntiAlias = false,
    super.handleLoadingProgress = false,
    super.layoutInsets = EdgeInsets.zero,
    Widget? failed,
    Widget? loading,
    int? cacheWidth,
    int? cacheHeight,
    double? compressionRatio,
    int? maxBytes,
    bool cacheRawData = false,
    String? imageCacheName,
    double scale = 1.0,

    /// [ExtendedNetworkImageProvider]
    Map<String, String>? headers,
    bool cache = true,
    int retries = 3,
    Duration? timeLimit,
    Duration timeRetry = const Duration(milliseconds: 100),
    CancellationToken? cancelToken,
    String? cacheKey,
    bool printError = true,
    Duration? cacheMaxAge,

    /// [ExtendedAssetImageProvider]
    AssetBundle? bundle,
    String? package,
  }) : super(
            image: buildImageProvider(image,
                cacheWidth: cacheWidth,
                cacheHeight: cacheHeight,
                maxBytes: maxBytes,
                compressionRatio: compressionRatio,
                cacheRawData: cacheRawData,
                imageCacheName: imageCacheName,
                scale: scale,
                headers: headers,
                cache: cache,
                cancelToken: cancelToken,
                retries: retries,
                timeRetry: timeRetry,
                timeLimit: timeLimit,
                cacheKey: cacheKey,
                printError: printError,
                cacheMaxAge: cacheMaxAge,
                bundle: bundle,
                package: package),
            loadStateChanged:
                buildLoadStateChanged(failed: failed, loading: loading));
}

class PreviewImage extends StatelessWidget {
  const PreviewImage(
      {super.key,
      this.initialPage,
      required this.itemCount,
      required this.itemBuilder});

  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int? initialPage;

  @override
  Widget build(BuildContext context) => Material(
      color: UCS.black.withOpacity(0.9),
      child: Column(children: <Widget>[
        Universal(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 12),
            height: context.padding.top + 50,
            child: const CloseButton(color: UCS.white)),
        ExtendedImageGesturePageView.builder(
                controller:
                    ExtendedPageController(initialPage: initialPage ?? 1),
                itemCount: itemCount,
                itemBuilder: itemBuilder)
            .expanded,
      ]));
}

class ImageFailed extends StatelessWidget {
  const ImageFailed({super.key, this.failed, this.background, this.alignment});

  final Widget? failed;
  final Color? background;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: failed == null ? const EdgeInsets.all(4) : EdgeInsets.zero,
        alignment: alignment,
        color: background,
        child: failed ?? Global().config.imageFailed);
  }
}

class ImageLoading extends BaseLoading {
  const ImageLoading(
      {super.key,
      super.size = 10,
      super.color,
      super.itemBuilder,
      super.duration = const Duration(milliseconds: 1200),
      super.controller});
}
