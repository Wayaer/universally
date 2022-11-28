import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BasicNetworkImageProvider extends ExtendedResizeImage {
  BasicNetworkImageProvider(String url,
      {double? compressionRatio = 0.6, double scale = 1})
      : super(
            ExtendedNetworkImageProvider(url,
                scale: scale, imageCacheName: url, cache: true, retries: 1),
            compressionRatio: compressionRatio);
}

/// BasicImage
class BasicImage extends StatefulWidget {
  const BasicImage(
    this.image, {
    super.key,
    this.fit = BoxFit.cover,
    this.failed,
    this.background = UCS.background,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
    this.border,
    this.hasGesture = false,
    this.clearMemoryCacheWhenDispose = true,
    this.clearMemoryCacheIfFailed = true,
    this.imageCacheName,
    this.radius = 2,
  });

  BasicImage.network(
    String url, {
    super.key,
    double compressionRatio = 0.6,
    this.failed,
    this.width,
    this.height,
    this.radius = 2,
    this.shape = BoxShape.rectangle,
    this.background = UCS.background,
    this.border,
    this.fit = BoxFit.cover,
    this.hasGesture = false,
    this.clearMemoryCacheWhenDispose = true,
    this.clearMemoryCacheIfFailed = true,
    int? cacheWidth,
    int? cacheHeight,
    int? maxBytes,
  })  : imageCacheName = url,
        image = ExtendedResizeImage.resizeIfNeeded(
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth,
            provider: ExtendedNetworkImageProvider(url,
                scale: hasGesture ? 2 : 1, imageCacheName: url),
            compressionRatio: compressionRatio,
            maxBytes: maxBytes,
            imageCacheName: url);

  BasicImage.file(
    File file, {
    super.key,
    double compressionRatio = 0.6,
    this.failed,
    this.width,
    this.height,
    this.radius = 2,
    this.shape = BoxShape.rectangle,
    this.background = UCS.background,
    this.border,
    this.fit = BoxFit.cover,
    this.hasGesture = false,
    this.clearMemoryCacheWhenDispose = true,
    this.clearMemoryCacheIfFailed = true,
    int? cacheWidth,
    int? cacheHeight,
    int? maxBytes,
  })  : imageCacheName = file.path,
        image = ExtendedResizeImage.resizeIfNeeded(
            imageCacheName: file.path,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth,
            maxBytes: maxBytes,
            provider: ExtendedFileImageProvider(file,
                scale: hasGesture ? 2 : 1, imageCacheName: file.path),
            compressionRatio: compressionRatio);

  BasicImage.asset(
    String assetName, {
    super.key,
    double compressionRatio = 0.6,
    this.failed,
    this.width,
    this.height,
    this.radius = 2,
    this.shape = BoxShape.rectangle,
    this.background = UCS.background,
    this.border,
    this.fit = BoxFit.cover,
    this.hasGesture = false,
    this.clearMemoryCacheWhenDispose = true,
    this.clearMemoryCacheIfFailed = true,
    int? cacheWidth,
    int? cacheHeight,
    int? maxBytes,
  })  : imageCacheName = assetName,
        image = ExtendedResizeImage.resizeIfNeeded(
            maxBytes: maxBytes,
            compressionRatio: compressionRatio,
            cacheHeight: cacheHeight,
            cacheWidth: cacheWidth,
            imageCacheName: assetName,
            provider: hasGesture
                ? ExtendedExactAssetImageProvider(assetName,
                    scale: hasGesture ? 2 : 1, imageCacheName: assetName)
                : ExtendedAssetImageProvider(assetName,
                    imageCacheName: assetName));

  final String? imageCacheName;

  final BoxFit fit;

  final ImageProvider image;

  /// 加载失败时显示
  final Widget? failed;

  final Color background;

  final double? width;

  final double? height;

  final BoxShape shape;

  final BoxBorder? border;

  final bool hasGesture;

  final bool clearMemoryCacheWhenDispose;

  final bool clearMemoryCacheIfFailed;

  /// [shape]==[BoxShape.rectangle] 时有效
  final double radius;

  @override
  State<BasicImage> createState() => _BasicImageState();
}

class _BasicImageState extends State<BasicImage> {
  @override
  Widget build(BuildContext context) {
    final BoxShape lShape = widget.shape;
    return ExtendedImage(
        color: widget.background,
        image: widget.image,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        enableMemoryCache: true,
        mode: widget.hasGesture
            ? ExtendedImageMode.gesture
            : ExtendedImageMode.none,
        clearMemoryCacheWhenDispose: widget.clearMemoryCacheWhenDispose,
        clearMemoryCacheIfFailed: widget.clearMemoryCacheIfFailed,
        enableLoadState: false,
        shape: lShape,
        border: widget.border,
        borderRadius: lShape == BoxShape.rectangle
            ? BorderRadius.circular(widget.radius)
            : null,
        loadStateChanged: (ExtendedImageState state) {
          if (state.extendedImageLoadState == LoadState.failed) log('图片加载失败');
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return placeholderWidget;
            case LoadState.completed:
              return Image(image: widget.image, fit: widget.fit);
            case LoadState.failed:
              return error(lShape);
          }
        });
  }

  Widget? get placeholderWidget => BasicLoading(size: 10);

  Widget? error(BoxShape lShape) => Container(
      padding: widget.failed == null
          ? const EdgeInsets.symmetric(vertical: 6)
          : EdgeInsets.zero,
      alignment: Alignment.center,
      color: widget.background,
      child: widget.failed ?? GlobalConfig().config.imageFailed);

  @override
  void dispose() {
    super.dispose();
    if (widget.imageCacheName != null) {
      clearMemoryImageCache(widget.imageCacheName);
    }
  }
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
            height: context.mediaQueryPadding.top + 50,
            child: const CloseButton(color: UCS.white)),
        ExtendedImageGesturePageView.builder(
                controller:
                    ExtendedPageController(initialPage: initialPage ?? 1),
                itemCount: itemCount,
                itemBuilder: itemBuilder)
            .expandedNull,
      ]));
}
