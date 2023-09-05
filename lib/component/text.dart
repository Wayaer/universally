import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// Very large font
class TextVeryLarge extends BasicText {
  TextVeryLarge(super.text,
      {super.key,
      Color? color,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 18,
      super.style,
      super.overflow,
      super.textAlign,
      super.fontType = FontType.semiBold,
      super.fontWeight,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.veryLargeColor);
}

/// Large font
class TextLarge extends BasicText {
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
      super.fontType = FontType.semiBold,
      super.fontWeight,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.largeColor);
}

/// 小字体
/// Small font
class TextSmall extends BasicText {
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
      super.fontType,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.smallColor);
}

/// 默认字体
/// The default font
class TextDefault extends BasicText {
  TextDefault(super.text,
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
      super.fontType,
      super.fontWeight,
      super.fontFamily})
      : super(color: color ?? Global().config.textColor?.defaultColor);
}

/// BasicText
class BasicText extends BText {
  BasicText(String? text,
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
      FontType? fontType,
      String? fontFamily})
      : super(text ?? '',
            maxLines: maxLines == null ? 1 : (maxLines == 0 ? null : maxLines),
            overflow: overflow ??
                (maxLines == 0 ? TextOverflow.clip : TextOverflow.ellipsis),
            style: TStyle(
                    fontWeight: fontWeight,
                    letterSpacing: letterSpacing,
                    fontType: fontType,
                    backgroundColor: backgroundColor,
                    fontSize: fontSize,
                    color: color,
                    fontFamily: fontFamily,
                    height: height)
                .merge(style));
}

/// BasicTextStyle
class TStyle extends BTextStyle {
  /// 添加了基础颜色，不适合主题适配
  const TStyle(
      {double? wordSpacing,
      FontType? fontType,
      FontWeight? fontWeight,
      Color? color = UCS.mainBlack,
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
      : super(
            color: color,
            wordSpacing: wordSpacing ?? letterSpacing,
            fontWeight: fontWeight ??
                ((fontType == null || fontType == FontType.normal)
                    ? FontWeight.normal
                    : fontType == FontType.medium
                        ? FontWeight.w500
                        : fontType == FontType.semiBold
                            ? FontWeight.w600
                            : fontType == FontType.bold
                                ? FontWeight.bold
                                : FontWeight.normal));

  /// 使用 [Global().config.textColor?.styleColor] 预设颜色，不适合主题适配
  TStyle.global(
      {Color? color,
      super.fontSize = 14,
      super.letterSpacing,
      super.height,
      super.fontFamily,
      super.textBaseline = TextBaseline.ideographic,
      FontType? fontType,
      FontWeight? fontWeight,
      super.decoration = TextDecoration.none,
      super.backgroundColor})
      : super(
            color: color ?? Global().config.textColor?.styleColor,
            wordSpacing: letterSpacing,
            fontWeight: fontWeight ??
                ((fontType == null || fontType == FontType.normal)
                    ? FontWeight.normal
                    : fontType == FontType.medium
                        ? FontWeight.w500
                        : fontType == FontType.semiBold
                            ? FontWeight.w600
                            : fontType == FontType.bold
                                ? FontWeight.bold
                                : FontWeight.normal));

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

  static FontWeight typeToWeight(FontType? fontType) {
    switch (fontType) {
      case FontType.normal:
        return FontWeight.normal;
      case FontType.medium:
        return FontWeight.w500;
      case FontType.semiBold:
        return FontWeight.w600;
      case FontType.bold:
        return FontWeight.bold;
      default:
        return FontWeight.normal;
    }
  }
}

enum FontType { normal, medium, semiBold, bold }

class TextShowPage extends StatelessWidget {
  const TextShowPage({super.key, required this.text, this.appBarTitleText});

  final String text;
  final String? appBarTitleText;

  @override
  Widget build(BuildContext context) => BasicScaffold(
      appBarTitleText: appBarTitleText,
      padding: const EdgeInsets.all(20),
      child: Universal(
          onTap: () {
            text.toClipboard;
            showToast('复制成功');
          },
          child: TextDefault(text,
              maxLines: 100, color: UCS.black, fontSize: 15)));
}


