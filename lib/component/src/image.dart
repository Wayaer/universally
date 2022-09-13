import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class NetworkImageProvider extends ExtendedResizeImage {
  NetworkImageProvider(String url, {double? compressionRatio, double scale = 1})
      : super(
            ExtendedNetworkImageProvider(url,
                scale: scale, imageCacheName: url, cache: true, retries: 1),
            compressionRatio: compressionRatio ?? 0.6);
}

/// BasicImage
class BasicImage extends StatelessWidget {
  const BasicImage(this.image,
      {super.key,
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
      this.radius = 2});

  BasicImage.network(
    String? url, {
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
  }) : image = url == null
            ? const AssetImage('')
            : ExtendedResizeImage.resizeIfNeeded(
                provider: ExtendedNetworkImageProvider(url,
                    scale: hasGesture ? 2 : 1, imageCacheName: url),
                compressionRatio: compressionRatio,
                imageCacheName: url);

  BasicImage.file(
    File file, {
    super.key,
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
  }) : image = ExtendedResizeImage.resizeIfNeeded(
            provider: ExtendedFileImageProvider(file,
                scale: hasGesture ? 2 : 1, imageCacheName: file.path),
            compressionRatio: 0.6);

  BasicImage.asset(
    String assetName, {
    super.key,
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
  }) : image = ExtendedResizeImage.resizeIfNeeded(
            provider: hasGesture
                ? ExtendedExactAssetImageProvider(assetName,
                    scale: hasGesture ? 2 : 1, imageCacheName: assetName)
                : ExtendedAssetImageProvider(assetName,
                    imageCacheName: assetName));

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
  Widget build(BuildContext context) {
    final BoxShape lShape = shape;
    return ExtendedImage(
        color: background,
        image: image,
        width: width,
        height: height,
        fit: fit,
        enableMemoryCache: true,
        mode: hasGesture ? ExtendedImageMode.gesture : ExtendedImageMode.none,
        clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
        clearMemoryCacheIfFailed: clearMemoryCacheIfFailed,
        enableLoadState: false,
        shape: lShape,
        border: border,
        borderRadius:
            lShape == BoxShape.rectangle ? BorderRadius.circular(radius) : null,
        loadStateChanged: (ExtendedImageState state) {
          if (state.extendedImageLoadState == LoadState.failed) log('图片加载失败');
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return placeholderWidget;
            case LoadState.completed:
              return Image(image: image, fit: fit);
            case LoadState.failed:
              return error(lShape);
          }
        });
  }

  Widget? get placeholderWidget => BasicLoading(size: 10);

  Widget? error(BoxShape lShape) => Container(
      padding: failed == null
          ? const EdgeInsets.symmetric(vertical: 6)
          : EdgeInsets.zero,
      alignment: Alignment.center,
      color: background,
      child: failed ?? GlobalConfig().config.imageFailed);
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
