import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// Very large font
class TextVeryLarge extends BaseText {
  TextVeryLarge(String? text,
      {Key? key,
      Color? color,
      TextStyle? style,
      int? maxLines,
      double? height,
      double fontSize = 22,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            color: color ?? UCS.largeTextColor,
            key: key,
            style: style,
            maxLines: maxLines,
            height: height,
            letterSpacing: letterSpacing,
            fontSize: fontSize,
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
      TextStyle? style,
      double fontSize = 18,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            key: key,
            style: style,
            color: color ?? UCS.largeTextColor,
            maxLines: maxLines,
            height: height,
            letterSpacing: letterSpacing,
            fontType: fontType,
            fontFamily: fontFamily,
            fontSize: fontSize,
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
      double fontSize = 12,
      TextStyle? style,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            key: key,
            color: color ?? UCS.smallTextColor,
            maxLines: maxLines,
            height: height,
            style: style,
            letterSpacing: letterSpacing,
            fontType: fontType,
            fontSize: fontSize,
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
      TextStyle? style,
      Color? backgroundColor,
      int? maxLines,
      double? height,
      double fontSize = 14,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text,
            key: key,
            color: color ?? UCS.defaultTextColor,
            letterSpacing: letterSpacing,
            maxLines: maxLines,
            fontType: fontType,
            height: height,
            fontSize: fontSize,
            overflow: overflow,
            style: style,
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
      double fontSize = 14,
      double? height,
      double? letterSpacing,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontType? fontType,
      String? fontFamily})
      : super(text ?? '',
            key: key,
            textAlign: textAlign,
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

/// BaseTextStyle
class TStyle extends BTextStyle {
  const TStyle(
      {Color? color,
      double fontSize = 14,
      double? letterSpacing,
      double? height,
      String? fontFamily,
      FontType? fontType,
      FontWeight? fontWeight,
      TextDecoration? decoration = TextDecoration.none,
      Color? backgroundColor})
      : super(
            color: color ?? UCS.mainBlack,
            fontSize: fontSize,
            height: height,
            letterSpacing: letterSpacing,
            wordSpacing: letterSpacing,
            backgroundColor: backgroundColor,
            decoration: decoration,
            fontFamily: fontFamily,
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
