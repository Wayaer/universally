import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// Very large font
class TextVeryLarge extends BasicText {
  TextVeryLarge(String? text,
      {super.key,
      super.color = UCS.largeTextColor,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 18,
      super.style,
      super.overflow,
      super.textAlign,
      super.fontType = FontType.semiBold,
      super.fontFamily})
      : super(text);
}

/// Large font
class TextLarge extends BasicText {
  TextLarge(String? text,
      {super.key,
      super.color = UCS.largeTextColor,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 16,
      super.style,
      super.overflow,
      super.textAlign,
      super.fontType = FontType.semiBold,
      super.fontFamily})
      : super(text);
}

/// 小字体
/// Small font
class TextSmall extends BasicText {
  TextSmall(String? text,
      {super.key,
      super.color = UCS.smallTextColor,
      super.maxLines,
      super.height,
      super.letterSpacing,
      super.fontSize = 12,
      super.style,
      super.overflow,
      super.textAlign,
      super.fontType,
      super.fontFamily})
      : super(text);
}

/// 默认字体
/// The default font
class TextDefault extends BasicText {
  TextDefault(String? text,
      {super.key,
      super.color = UCS.defaultTextColor,
      super.style,
      super.backgroundColor,
      super.maxLines,
      super.height,
      super.fontSize = 14,
      super.letterSpacing,
      super.overflow,
      super.textAlign,
      super.fontType,
      super.fontFamily})
      : super(text);
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
      super.textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text ?? '',
            maxLines: maxLines == null ? 1 : (maxLines == 0 ? null : maxLines),
            overflow: overflow ??
                (maxLines == 0 ? TextOverflow.clip : TextOverflow.ellipsis),
            style: TStyle(
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
  const TStyle(
      {super.color = UCS.mainBlack,
      super.fontSize = 14,
      super.letterSpacing,
      super.height,
      super.fontFamily,
      FontType? fontType,
      FontWeight? fontWeight,
      super.decoration = TextDecoration.none,
      super.backgroundColor})
      : super(
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
                                : FontWeight.normal),
            textBaseline: TextBaseline.ideographic);
}

enum FontType { normal, medium, semiBold, bold }
