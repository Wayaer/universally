import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

extension FontWeights on FontWeight {
  /// normal
  static const FontWeight normal = FontWeight.normal;

  /// medium
  static const FontWeight medium = FontWeight.w500;

  /// semiBold
  static const FontWeight semiBold = FontWeight.w600;

  /// bold
  static const FontWeight bold = FontWeight.bold;
}

class TextThemeStyle {
  TextThemeStyle(
      {this.extraLarge, this.large, this.normal, this.small, this.style});

  /// 超大字体
  TextStyle? extraLarge;

  /// 大字体
  TextStyle? large;

  /// 默认字体
  TextStyle? normal;

  /// 小字体
  TextStyle? small;

  /// [TStyle] color
  TextStyle? style;
}

/// extra large font
class TextExtraLarge extends BaseText {
  TextExtraLarge(
    super.text, {
    super.key,
    super.letterSpacing,
    super.wordSpacing,
    super.fontSize = 18,
    super.fontFamily,
    super.fontWeight,
    super.fontFamilyFallback,
    super.fontStyle,
    super.color,
    super.backgroundColor,
    super.foreground,
    super.background,
    super.height,
    super.textBaseline = TextBaseline.ideographic,
    super.inherit = true,
    super.package,
    super.locale,
    super.fontFeatures,
    super.shadows,
    super.textAlign,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.useStyleFirst = false,
    super.recognizer,
    super.semanticsLabel,
    super.strutStyle,
    super.textDirection,
    super.softWrap,
    super.textScaleFactor,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,
    super.leadingDistribution,
    super.fontVariations,
    super.overflow,
    super.maxLines,
    TextStyle? style,
  }) : super(
            style: BaseText._mergeStyle(
                Universally().config.textStyle?.large, style));
}

/// Large font
class TextLarge extends BaseText {
  TextLarge(
    super.text, {
    super.key,
    super.letterSpacing,
    super.wordSpacing,
    super.fontSize = 16,
    super.fontFamily,
    super.fontWeight,
    super.fontFamilyFallback,
    super.fontStyle,
    super.color,
    super.backgroundColor,
    super.foreground,
    super.background,
    super.height,
    super.textBaseline = TextBaseline.ideographic,
    super.inherit = true,
    super.package,
    super.locale,
    super.fontFeatures,
    super.shadows,
    super.textAlign,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.useStyleFirst = false,
    super.recognizer,
    super.semanticsLabel,
    super.strutStyle,
    super.textDirection,
    super.softWrap,
    super.textScaleFactor,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,
    super.leadingDistribution,
    super.fontVariations,
    super.overflow,
    super.maxLines,
    TextStyle? style,
  }) : super(
            style: BaseText._mergeStyle(
                Universally().config.textStyle?.extraLarge, style));
}

/// 默认字体
/// The formal font
class TextNormal extends BaseText {
  TextNormal(
    super.text, {
    super.key,
    super.letterSpacing,
    super.wordSpacing,
    super.fontSize = 14,
    super.fontFamily,
    super.fontWeight,
    super.fontFamilyFallback,
    super.fontStyle,
    super.color,
    super.backgroundColor,
    super.foreground,
    super.background,
    super.height,
    super.textBaseline = TextBaseline.ideographic,
    super.inherit = true,
    super.package,
    super.locale,
    super.fontFeatures,
    super.shadows,
    super.textAlign,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.useStyleFirst = false,
    super.recognizer,
    super.semanticsLabel,
    super.strutStyle,
    super.textDirection,
    super.softWrap,
    super.textScaleFactor,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,
    super.leadingDistribution,
    super.fontVariations,
    super.overflow,
    super.maxLines,
    TextStyle? style,
  }) : super(
            style: BaseText._mergeStyle(
                Universally().config.textStyle?.normal, style));
}

/// 小字体
/// Small font
class TextSmall extends BaseText {
  TextSmall(
    super.text, {
    super.key,
    super.letterSpacing,
    super.wordSpacing,
    super.fontSize = 12,
    super.fontFamily,
    super.fontWeight,
    super.fontFamilyFallback,
    super.fontStyle,
    super.color,
    super.backgroundColor,
    super.foreground,
    super.background,
    super.height,
    super.textBaseline = TextBaseline.ideographic,
    super.inherit = true,
    super.package,
    super.locale,
    super.fontFeatures,
    super.shadows,
    super.textAlign,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.useStyleFirst = false,
    super.recognizer,
    super.semanticsLabel,
    super.strutStyle,
    super.textDirection,
    super.softWrap,
    super.textScaleFactor,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,
    super.leadingDistribution,
    super.fontVariations,
    super.overflow,
    super.maxLines,
    TextStyle? style,
  }) : super(
            style: BaseText._mergeStyle(
                Universally().config.textStyle?.small, style));
}

/// BaseText
class BaseText extends BText {
  static TextStyle? _mergeStyle(TextStyle? firstStyle, TextStyle? secondStyle) {
    if (firstStyle != null) {
      return firstStyle.merge(secondStyle);
    }
    return secondStyle;
  }

  BaseText(
    String? text, {
    super.key,
    super.letterSpacing,
    super.wordSpacing,
    super.fontSize,
    super.fontFamily,
    super.fontWeight,
    super.fontFamilyFallback,
    super.fontStyle,
    super.color,
    super.backgroundColor,
    super.foreground,
    super.background,
    super.height,
    super.textBaseline = TextBaseline.ideographic,
    super.inherit = true,
    super.package,
    super.locale,
    super.fontFeatures,
    super.shadows,
    super.textAlign,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.useStyleFirst = false,
    super.recognizer,
    super.semanticsLabel,
    super.strutStyle,
    super.textDirection,
    super.softWrap,
    super.textScaleFactor,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,
    super.leadingDistribution,
    super.fontVariations,
    TextOverflow? overflow,
    TextStyle? style,
    int? maxLines,
  }) : super(text ?? '',
            maxLines: maxLines == null ? 1 : (maxLines == 0 ? null : maxLines),
            overflow: overflow ??
                (maxLines == 0 ? TextOverflow.clip : TextOverflow.ellipsis),
            style: (BaseText._mergeStyle(
                Universally().config.textStyle?.style, style)));
}

/// TStyle
class TStyle extends TextStyle {
  /// 添加了基础颜色，不适合主题适配
  const TStyle({
    super.letterSpacing,
    super.wordSpacing,
    super.fontSize,
    super.fontFamily,
    super.fontWeight,
    super.fontFamilyFallback,
    super.fontStyle,
    super.color,
    super.backgroundColor,
    super.foreground,
    super.background,
    super.height,
    super.textBaseline = TextBaseline.ideographic,
    super.inherit = true,
    super.package,
    super.locale,
    super.fontFeatures,
    super.fontVariations,
    super.shadows,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.leadingDistribution,
    super.overflow,
  });
}

class TextBoxPage extends StatelessWidget {
  const TextBoxPage(
      {super.key,
      required this.text,
      this.color,
      this.appBarTitleText,
      this.toastText = '复制成功'});

  final String text;
  final Color? color;
  final String? appBarTitleText;
  final String toastText;

  @override
  Widget build(BuildContext context) => BaseScaffold(
      appBarTitleText: appBarTitleText,
      padding: const EdgeInsets.all(20),
      child: Universal(
          onTap: () {
            text.toClipboard;
            showToast(toastText);
          },
          child: TextNormal(text, maxLines: 0, color: color, fontSize: 15)));
}
