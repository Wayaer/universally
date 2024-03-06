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
  TextExtraLarge(super.text,
      {TextStyle? style,
      super.key,
      super.color,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 18,
      super.overflow,
      super.textAlign,
      super.fontWeight = FontWeights.semiBold,
      super.fontFamily})
      : super(
            style: BaseText._mergeStyle(
                Universally().config.textStyle?.large, style));
}

/// Large font
class TextLarge extends BaseText {
  TextLarge(super.text,
      {TextStyle? style,
      super.key,
      super.color,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 16,
      super.overflow,
      super.textAlign,
      super.fontWeight = FontWeights.semiBold,
      super.fontFamily})
      : super(
            style: BaseText._mergeStyle(
                Universally().config.textStyle?.large, style));
}

/// 默认字体
/// The formal font
class TextNormal extends BaseText {
  TextNormal(super.text,
      {TextStyle? style,
      super.key,
      super.color,
      super.backgroundColor,
      super.maxLines,
      super.height,
      super.fontSize = 14,
      super.letterSpacing,
      super.overflow,
      super.textAlign,
      super.fontWeight = FontWeight.normal,
      super.fontFamily})
      : super(
            style: BaseText._mergeStyle(
                Universally().config.textStyle?.normal, style));
}

/// 小字体
/// Small font
class TextSmall extends BaseText {
  TextSmall(super.text,
      {TextStyle? style,
      super.key,
      super.fontWeight,
      super.color,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 12,
      super.overflow,
      super.textAlign,
      super.fontFamily})
      : super(
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

  BaseText(String? text,
      {super.key,
      Color? color,
      TextStyle? style,
      Color? backgroundColor,
      int? maxLines,
      double fontSize = 14,
      double? height,
      double? letterSpacing,
      TextOverflow? overflow,
      FontWeight? fontWeight,
      super.textAlign,
      String? fontFamily})
      : super(text ?? '',
            maxLines: maxLines == null ? 1 : (maxLines == 0 ? null : maxLines),
            overflow: overflow ??
                (maxLines == 0 ? TextOverflow.clip : TextOverflow.ellipsis),
            style: TStyle(
                    fontWeight: fontWeight,
                    letterSpacing: letterSpacing,
                    backgroundColor: backgroundColor,
                    fontSize: fontSize,
                    color: color,
                    fontFamily: fontFamily,
                    height: height)
                .merge(BaseText._mergeStyle(
                    Universally().config.textStyle?.style, style)));
}

/// BaseTextStyle
class TStyle extends BTextStyle {
  /// 添加了基础颜色，不适合主题适配
  const TStyle(
      {double? wordSpacing,
      super.fontWeight,
      super.color = UCS.mainBlack,
      super.fontSize = 14,
      super.letterSpacing,
      super.height,
      super.fontFamily,
      super.textBaseline = TextBaseline.ideographic,
      super.backgroundColor,
      super.inherit = true,
      super.fontFamilyFallback,
      super.package,
      super.locale,
      super.fontStyle,
      super.foreground,
      super.background,

      /// [text]的划线
      /// [TextDecoration.none] 没有 默认
      /// [TextDecoration.underline] 下划线
      /// [TextDecoration.overline] 上划线
      /// [TextDecoration.lineThrough] 中间的线（删除线）
      super.decoration = TextDecoration.none,
      super.decorationColor,
      super.decorationStyle,
      super.decorationThickness,
      super.debugLabel,
      super.shadows,
      super.fontFeatures,
      super.fontVariations,
      super.leadingDistribution,
      super.overflow})
      : super(wordSpacing: wordSpacing ?? letterSpacing);

  /// 使用 [Universally().config.textColor?.styleColor] 预设颜色，不适合主题适配
  TStyle.global(
      {super.color,
      super.fontSize = 14,
      super.letterSpacing,
      super.height,
      super.fontFamily,
      super.textBaseline = TextBaseline.ideographic,
      super.fontWeight,
      super.decoration = TextDecoration.none,
      super.backgroundColor})
      : super(wordSpacing: letterSpacing);

  /// 原始数据，不添加任何颜色
  const TStyle.origin(
      {super.color,
      super.fontSize = 14,
      super.letterSpacing,
      super.wordSpacing,
      super.height,
      super.fontFamily,
      super.textBaseline = TextBaseline.ideographic,
      super.fontWeight,
      super.backgroundColor,
      super.inherit = true,
      super.fontFamilyFallback,
      super.package,
      super.locale,
      super.fontStyle,
      super.foreground,
      super.background,
      super.decoration = TextDecoration.none,
      super.decorationColor,
      super.decorationStyle,
      super.decorationThickness,
      super.debugLabel,
      super.shadows,
      super.fontFeatures,
      super.fontVariations,
      super.leadingDistribution,
      super.overflow});
}

class TextBoxPage extends StatelessWidget {
  const TextBoxPage(
      {super.key, required this.text, this.color, this.appBarTitleText});

  final String text;
  final Color? color;
  final String? appBarTitleText;

  @override
  Widget build(BuildContext context) => BaseScaffold(
      appBarTitleText: appBarTitleText,
      padding: const EdgeInsets.all(20),
      child: Universal(
          onTap: () {
            text.toClipboard;
            showToast('复制成功');
          },
          child: TextNormal(text, maxLines: 0, color: color, fontSize: 15)));
}
