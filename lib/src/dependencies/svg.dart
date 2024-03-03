import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGAsset extends SvgPicture {
  SVGAsset(
    super.assetName, {
    super.key,
    double? size,
    double? height,
    double? width,
    super.matchTextDirection = false,
    super.bundle,
    super.package,
    super.fit = BoxFit.contain,
    super.alignment = Alignment.center,
    super.allowDrawingOutsideViewBox = false,
    super.placeholderBuilder,
    super.semanticsLabel,
    super.excludeFromSemantics = false,
    super.clipBehavior = Clip.hardEdge,
    super.cacheColorFilter = false,
    super.theme,
    ColorFilter? colorFilter,
    BlendMode colorBlendMode = BlendMode.srcIn,
    Color? color,
  }) : super.asset(
            colorFilter: colorFilter ?? _getColorFilter(color, colorBlendMode),
            width: width ?? size,
            height: height ?? size);
}

class SVGNetwork extends SvgPicture {
  SVGNetwork(super.url,
      {super.key,
      double? size,
      double? height,
      double? width,
      super.matchTextDirection = false,
      super.fit = BoxFit.contain,
      super.alignment = Alignment.center,
      super.allowDrawingOutsideViewBox = false,
      super.placeholderBuilder,
      super.semanticsLabel,
      super.excludeFromSemantics = false,
      super.clipBehavior = Clip.hardEdge,
      super.cacheColorFilter = false,
      super.theme,
      ColorFilter? colorFilter,
      BlendMode colorBlendMode = BlendMode.srcIn,
      Color? color,
      super.headers})
      : super.network(
            colorFilter: colorFilter ?? _getColorFilter(color, colorBlendMode),
            width: width ?? size,
            height: height ?? size);
}

ColorFilter? _getColorFilter(Color? color, BlendMode colorBlendMode) =>
    color == null ? null : ColorFilter.mode(color, colorBlendMode);
