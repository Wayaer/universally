import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGAsset extends SvgPicture {
  SVGAsset(
    super.assetName, {
    super.key,
    super.matchTextDirection = false,
    super.fit = BoxFit.contain,
    super.alignment = Alignment.center,
    super.allowDrawingOutsideViewBox = false,
    super.bundle,
    super.package,
    super.placeholderBuilder,
    super.semanticsLabel,
    super.excludeFromSemantics = false,
    super.clipBehavior = Clip.hardEdge,
    double? size,
    double? height,
    double? width,
    ColorFilter? colorFilter,
    BlendMode blendMode = BlendMode.srcIn,
    Color? color,
  }) : super.asset(
         colorFilter:
             colorFilter ??
             (color == null ? null : ColorFilter.mode(color, blendMode)),
         width: width ?? size,
         height: height ?? size,
       );
}

class SVGNetwork extends SvgPicture {
  SVGNetwork(
    super.url, {
    super.key,
    super.matchTextDirection = false,
    super.fit = BoxFit.contain,
    super.alignment = Alignment.center,
    super.allowDrawingOutsideViewBox = false,
    super.placeholderBuilder,
    super.semanticsLabel,
    super.excludeFromSemantics = false,
    super.clipBehavior = Clip.hardEdge,
    super.headers,
    double? size,
    double? height,
    double? width,
    ColorFilter? colorFilter,
    BlendMode blendMode = BlendMode.srcIn,
    Color? color,
  }) : super.network(
         colorFilter:
             colorFilter ??
             (color == null ? null : ColorFilter.mode(color, blendMode)),
         width: width ?? size,
         height: height ?? size,
       );
}
