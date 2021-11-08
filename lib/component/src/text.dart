import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

const int? defaultMaxLines = 1;
const TextOverflow defaultOverflow = TextOverflow.ellipsis;

/// Very large font
class TextVeryLarge extends BaseText {
  TextVeryLarge(String? text,
      {Key? key,
      Color? color,
      int? maxLines,
      double? height,
      double? fontSize,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            color: color,
            key: key,
            maxLines: maxLines,
            height: height,
            letterSpacing: letterSpacing,
            fontSize: fontSize ?? 22,
            overflow: overflow,
            fontType: fontType,
            fontFamily: fontFamily,
            textAlign: textAlign);
}

/// Large font
class TextLarge extends BaseText {
  TextLarge(String? text,
      {Key? key,
      Color? color,
      int? maxLines,
      double? height,
      double? fontSize,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            key: key,
            color: color,
            maxLines: maxLines,
            height: height,
            letterSpacing: letterSpacing,
            fontType: fontType,
            fontFamily: fontFamily,
            fontSize: fontSize ?? 18,
            overflow: overflow,
            textAlign: textAlign);
}

/// 小字体
/// Small font
class TextSmall extends BaseText {
  TextSmall(String? text,
      {Key? key,
      Color? color,
      int? maxLines,
      double? height,
      double? letterSpacing,
      double? fontSize,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            key: key,
            color: color ?? UCS.smallTextColor,
            maxLines: maxLines,
            height: height,
            letterSpacing: letterSpacing,
            fontType: fontType,
            fontSize: fontSize ?? 12,
            overflow: overflow,
            fontFamily: fontFamily,
            textAlign: textAlign);
}

/// 默认字体
/// The default font
class TextDefault extends BaseText {
  TextDefault(String? text,
      {Key? key,
      Color? color,
      Color? backgroundColor,
      int? maxLines,
      double? height,
      double? fontSize,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            key: key,
            color: color,
            letterSpacing: letterSpacing,
            maxLines: maxLines,
            fontType: fontType,
            height: height,
            fontSize: fontSize ?? 14,
            overflow: overflow,
            fontFamily: fontFamily,
            backgroundColor: backgroundColor,
            textAlign: textAlign);
}

/// BaseText
class BaseText extends BText {
  BaseText(String? text,
      {Key? key,
      Color? color,
      TextStyle? style,
      Color? backgroundColor,
      int? maxLines,
      double? fontSize,
      double? height,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text ?? '',
            key: key,
            textAlign: textAlign,
            maxLines: maxLines == null
                ? defaultMaxLines
                : (maxLines == 0 ? null : maxLines),
            overflow: overflow ??
                (maxLines == 0 ? TextOverflow.clip : defaultOverflow),
            style: style ??
                TStyle(
                    letterSpacing: letterSpacing,
                    fontType: fontType,
                    backgroundColor: backgroundColor,
                    fontSize: fontSize,
                    color: color,
                    fontFamily: fontFamily,
                    height: height));
}

/// BaseTextStyle
class TStyle extends BTextStyle {
  TStyle(
      {Color? color,
      double? fontSize,
      double? letterSpacing,
      double? height,
      String? fontFamily,
      FontType? fontType,
      TextDecoration? decoration,
      Color? backgroundColor})
      : super(
            color: color ?? UCS.mainBlack,
            fontSize: fontSize ?? 14,
            height: height,
            letterSpacing: letterSpacing,
            wordSpacing: letterSpacing,
            backgroundColor: backgroundColor,
            decoration: decoration ?? TextDecoration.none,
            fontFamily: fontFamily,
            fontWeight: _getFontWeight(fontType),
            textBaseline: TextBaseline.ideographic);

  static FontWeight? _getFontWeight(FontType? fontType) {
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
