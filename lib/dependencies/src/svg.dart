import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGAsset extends SvgPicture {
  SVGAsset(
    String assetName, {
    super.key,
    super.color,
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
    super.colorBlendMode = BlendMode.srcIn,
    super.semanticsLabel,
    super.excludeFromSemantics = false,
    super.clipBehavior = Clip.hardEdge,
    super.cacheColorFilter = false,
    super.theme,
  }) : super.asset(assetName, width: width ?? size, height: height ?? size);
}

class SVGFile extends SvgPicture {
  SVGFile(
    File file, {
    super.key,
    super.color,
    double? size,
    double? height,
    double? width,
    super.matchTextDirection = false,
    super.fit = BoxFit.contain,
    super.alignment = Alignment.center,
    super.allowDrawingOutsideViewBox = false,
    super.placeholderBuilder,
    super.colorBlendMode = BlendMode.srcIn,
    super.semanticsLabel,
    super.excludeFromSemantics = false,
    super.clipBehavior = Clip.hardEdge,
    super.cacheColorFilter = false,
    super.theme,
  }) : super.file(file, width: width ?? size, height: height ?? size);
}

class SVGNetwork extends SvgPicture {
  SVGNetwork(
    String url, {
    super.key,
    super.color,
    double? size,
    double? height,
    double? width,
    super.matchTextDirection = false,
    super.fit = BoxFit.contain,
    super.alignment = Alignment.center,
    super.allowDrawingOutsideViewBox = false,
    super.placeholderBuilder,
    super.colorBlendMode = BlendMode.srcIn,
    super.semanticsLabel,
    super.excludeFromSemantics = false,
    super.clipBehavior = Clip.hardEdge,
    super.cacheColorFilter = false,
    super.theme,
  }) : super.network(url, width: width ?? size, height: height ?? size);
}
