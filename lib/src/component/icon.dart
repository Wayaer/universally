import 'package:flutter/material.dart';
import 'package:universally/src/dependencies/svg.dart';

/// icon svg image 展示
/// 仅支持本地 assets 显示
class FlIcon extends StatelessWidget {
  const FlIcon(
    this.icon, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.color,
    this.semanticLabel,

    /// icon
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.shadows,
    this.textDirection,
    this.applyTextScaling,
    this.blendMode,

    /// svg image 公共
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.excludeFromSemantics = false,
    this.matchTextDirection = false,
    this.package,

    /// svg
    this.allowDrawingOutsideViewBox = false,
    this.bundle,
    this.placeholderBuilder,
    this.semanticsLabel,
    this.clipBehavior = Clip.hardEdge,
    this.colorFilter,

    /// image
    this.frameBuilder,
    this.errorBuilder,
    this.scale,
    this.opacity,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.medium,
    this.cacheWidth,
    this.cacheHeight,
  });

  /// 常用 公共 支持
  final dynamic icon;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final BlendMode? blendMode;

  /// icon 支持
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final bool? applyTextScaling;

  /// svg image 公共支持
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final AssetBundle? bundle;
  final String? package;

  /// svg 支持
  final ColorFilter? colorFilter;
  final WidgetBuilder? placeholderBuilder;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;

  /// image 支持
  final double? scale;
  final Animation<double>? opacity;
  final ImageRepeat repeat;
  final FilterQuality filterQuality;
  final ImageFrameBuilder? frameBuilder;
  final ImageErrorWidgetBuilder? errorBuilder;
  final Rect? centerSlice;
  final bool gaplessPlayback;
  final bool isAntiAlias;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    if (icon is IconData) {
      return Icon(
        icon,
        size: size ?? width ?? height,
        color: color,
        fill: fill,
        weight: weight,
        grade: grade,
        opticalSize: opticalSize,
        shadows: shadows,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
        applyTextScaling: applyTextScaling,
        blendMode: blendMode,
      );
    } else if (icon is String) {
      if (icon.endsWith('.svg')) {
        return SVGAsset(
          icon,
          size: size,
          height: height,
          color: color,
          width: width,
          colorFilter: colorFilter,
          blendMode: blendMode ?? BlendMode.srcIn,
          fit: fit,
          alignment: alignment,
          placeholderBuilder: placeholderBuilder,
          matchTextDirection: matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          clipBehavior: clipBehavior,
          bundle: bundle,
          package: package,
        );
      } else if (isImage) {
        return Image.asset(
          icon,
          height: size ?? height,
          width: size ?? width,
          color: color,
          fit: fit,
          alignment: alignment,
          matchTextDirection: matchTextDirection,
          excludeFromSemantics: excludeFromSemantics,
          bundle: bundle,
          package: package,
          semanticLabel: semanticLabel,
          colorBlendMode: blendMode ?? BlendMode.srcOver,
          scale: scale,
          opacity: opacity,
          repeat: repeat,
          filterQuality: filterQuality,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder,
          centerSlice: centerSlice,
          gaplessPlayback: gaplessPlayback,
          isAntiAlias: isAntiAlias,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
        );
      }
    }
    return SizedBox(width: size ?? width, height: size ?? height);
  }

  bool get isImage {
    final image = icon.toString().toLowerCase();

    /// JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP ICO HEIF/HEIC
    return image.endsWith('.png') ||
        image.endsWith('.jpg') ||
        image.endsWith('.jpeg') ||
        image.endsWith('.webp') ||
        image.endsWith('.gif') ||
        image.endsWith('.bmp') ||
        image.endsWith('.wbmp') ||
        image.endsWith('.heif') ||
        image.endsWith('.heic');
  }
}
