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

class TextColor {
  TextColor(
      {this.smallColor,
      this.defaultColor,
      this.largeColor,
      this.veryLargeColor,
      this.styleColor});

  /// 超大字体颜色
  Color? veryLargeColor;

  /// 大字体颜色
  Color? largeColor;

  /// 默认字体颜色
  Color? defaultColor;

  /// 小字体颜色
  Color? smallColor;

  /// [TStyle] color
  Color? styleColor;
}

/// extra large font
class TextExtraLarge extends BaseText {
  TextExtraLarge(super.text,
      {super.key,
      Color? color,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 18,
      super.style,
      super.overflow,
      super.textAlign,
      super.fontWeight = FontWeights.semiBold,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.veryLargeColor);
}

/// Large font
class TextLarge extends BaseText {
  TextLarge(super.text,
      {super.key,
      Color? color,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 16,
      super.style,
      super.overflow,
      super.textAlign,
      super.fontWeight = FontWeights.semiBold,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.largeColor);
}

/// 默认字体
/// The formal font
class TextNormal extends BaseText {
  TextNormal(super.text,
      {super.key,
      Color? color,
      super.style,
      super.backgroundColor,
      super.maxLines,
      super.height,
      super.fontSize = 14,
      super.letterSpacing,
      super.overflow,
      super.textAlign,
      super.fontWeight = FontWeight.normal,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.defaultColor);
}

/// 小字体
/// Small font
class TextSmall extends BaseText {
  TextSmall(super.text,
      {super.key,
      super.fontWeight,
      Color? color,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 12,
      super.style,
      super.overflow,
      super.textAlign,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.smallColor);
}

/// BaseText
class BaseText extends BText {
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
                .merge(style));
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

  /// 使用 [Global().config.textColor?.styleColor] 预设颜色，不适合主题适配
  TStyle.global(
      {Color? color,
      super.fontSize = 14,
      super.letterSpacing,
      super.height,
      super.fontFamily,
      super.textBaseline = TextBaseline.ideographic,
      super.fontWeight,
      super.decoration = TextDecoration.none,
      super.backgroundColor})
      : super(
            color: color ?? Global().config.textColor?.styleColor,
            wordSpacing: letterSpacing);

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
