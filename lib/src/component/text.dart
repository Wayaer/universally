import 'package:flutter/gestures.dart';
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

enum TextSize { small, normal, large, extraLarge }

/// extra large font
class TextExtraLarge extends BaseText {
  const TextExtraLarge(
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
    super.style,
  }) : super(textSize: TextSize.extraLarge);
}

/// Large font
class TextLarge extends BaseText {
  const TextLarge(
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
    super.style,
  }) : super(textSize: TextSize.large);
}

/// 默认字体
/// The formal font
class TextNormal extends BaseText {
  const TextNormal(
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
    super.style,
  }) : super(textSize: TextSize.normal);
}

/// 小字体
/// Small font
class TextSmall extends BaseText {
  const TextSmall(
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
    super.style,
  }) : super(textSize: TextSize.small);
}

class BaseText extends StatelessWidget {
  static TextStyle? _mergeStyle(TextStyle? firstStyle, TextStyle? secondStyle) {
    if (firstStyle != null) {
      return firstStyle.merge(secondStyle);
    }
    return secondStyle;
  }

  const BaseText(
    this.text, {
    super.key,
    this.recognizer,
    this.semanticsLabel,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.textWidthBasis,
    this.style,
    this.inherit = true,
    this.color,
    this.backgroundColor,
    this.fontFamily,
    this.fontFamilyFallback,
    this.package,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.foreground,
    this.background,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.shadows,
    this.fontFeatures,
    this.textHeightBehavior,
    this.selectionColor,
    this.textScaler = TextScaler.noScaling,
    this.leadingDistribution,
    this.fontVariations,
    this.useStyleFirst = true,
    this.textSize,
  })  : isRich = false,
        texts = const [],
        styles = const [],
        recognizers = const [],
        semanticsLabels = const [];

  /// 与 [RText] 一致，仅增加 主题适配
  const BaseText.rich({
    super.key,
    required this.texts,
    this.style,
    this.styles = const [],
    this.recognizers = const [],
    this.semanticsLabels = const [],
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.inherit = true,
    this.color,
    this.backgroundColor,
    this.fontFamily,
    this.fontFamilyFallback,
    this.package,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.foreground,
    this.background,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.shadows,
    this.fontFeatures,
    this.selectionColor,
    this.textScaler = TextScaler.noScaling,
    this.leadingDistribution,
    this.fontVariations,
    this.useStyleFirst = true,
    this.textSize,
  })  : isRich = true,
        text = '',
        recognizer = null,
        semanticsLabel = null;

  final String? text;

  /// [text]手势
  final GestureRecognizer? recognizer;

  /// [text]语义 - 语义描述标签，相当于此text的别名
  final String? semanticsLabel;

  /// StrutStyle,影响Text在垂直方向上的布局
  final StrutStyle? strutStyle;

  /// TextAlign,内容对齐方式
  final TextAlign? textAlign;

  /// TextDirection,内容的走向方式
  final TextDirection? textDirection;

  /// Locale，当相同的Unicode字符可以根据不同的地区以不同的方式呈现时，用于选择字体
  final Locale? locale;

  /// bool 文本是否应在软换行时断行
  final bool? softWrap;

  /// TextOverflow，内容溢出时的处理方式
  final TextOverflow? overflow;

  /// double 设置文字的放大缩小，例如，fontSize=10，this.textScaleFactor=2.0，最终得到的文字大小为10*2.0
  final double? textScaleFactor;

  /// int 设置文字的最大展示行数
  final int? maxLines;

  /// TextWidthBasis 测量一行或多行文本宽度
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// 使劲此参数 以下单独字体样式无效
  final TextStyle? style;

  /// TextStyle 以下是字体样式
  /// 默认样式会继承层级最为接近的 DefaultTextStyle，为true 表示继承，false 表示完全重写
  final bool inherit;

  /// 字体颜色，注意： 如果有特殊的foreground，此值必须是null
  final Color? color;

  /// text的前景色，与 [color] 不能同时设置
  final Paint? foreground;

  /// [text]的背景色
  final Paint? background;

  final Color? backgroundColor;
  final String? fontFamily;

  /// 字体大小 默认的是 14
  final double? fontSize;

  /// 字体的粗细程度 FontWeight.w100 -- FontWeight.w900 . 默认是FontWeight.w400，
  final FontWeight? fontWeight;
  final List<String>? fontFamilyFallback;
  final List<FontVariation>? fontVariations;

  final String? package;

  /// [FontStyle.normal]正常 [FontStyle.italic]斜体
  final FontStyle? fontStyle;

  /// 单个字母或者汉字的距离，默认是1.0，负数可以拉近距离
  final double? letterSpacing;

  /// 单词之间添加的空间间隔，负数可以拉近距离
  final double? wordSpacing;

  /// [TextBaseline.ideographic]用来对齐表意文字的水平线
  /// [TextBaseline.alphabetic ]以标准的字母顺序为基线
  final TextBaseline? textBaseline;

  /// 文本的高度 主要用于[TextSpan] 来设置不同的高度
  final double? height;

  /// [text]的划线
  /// [TextDecoration.none] 没有 默认
  /// [TextDecoration.underline] 下划线
  /// [TextDecoration.overline] 上划线
  /// [TextDecoration.lineThrough] 中间的线（删除线）
  final TextDecoration decoration;

  /// [decoration]划线的颜色
  final Color? decorationColor;

  /// [decoration]划线的样式
  /// [TextDecorationStyle.solid]实线
  /// [TextDecorationStyle.double] 画两条线
  /// [TextDecorationStyle.dotted] 点线（一个点一个点的）
  /// [TextDecorationStyle.dashed] 虚线（一个长方形一个长方形的线）
  /// [TextDecorationStyle.wavy] 正玄曲线
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;

  /// 只在调试的使用
  final String? debugLabel;

  /// 将在[text]下方绘制的阴影列表
  final List<Shadow>? shadows;
  final List<FontFeature>? fontFeatures;

  /// The color to use when painting the selection.
  final Color? selectionColor;

  /// 排在第一个[text]后面
  final List<String> texts;

  /// [texts]内样式
  final List<TextStyle> styles;

  /// [texts]内手势
  final List<GestureRecognizer?> recognizers;

  /// [texts]内语义 - 语义描述标签，相当于此text的别名
  final List<String> semanticsLabels;

  final bool isRich;

  final TextScaler textScaler;

  final TextLeadingDistribution? leadingDistribution;

  /// 当 [color]和[style]中都有值
  /// [useStyleFirst]=true 优先使用style,
  /// [useStyleFirst]=false 优先使用外层,
  final bool useStyleFirst;

  /// 字体大小
  final TextSize? textSize;

  @override
  Widget build(BuildContext context) {
    if (isRich) {
      return BText.rich(
          key: key,
          style: _mergeStyle(_getStyle(), style),
          inherit: inherit,
          color: color,
          foreground: foreground,
          background: background,
          backgroundColor: backgroundColor,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamilyFallback: fontFamilyFallback,
          fontVariations: fontVariations,
          package: package,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
          shadows: shadows,
          fontFeatures: fontFeatures,
          selectionColor: selectionColor,
          texts: texts,
          styles: styles,
          recognizers: recognizers,
          semanticsLabels: semanticsLabels,
          textScaler: textScaler,
          leadingDistribution: leadingDistribution,
          useStyleFirst: useStyleFirst);
    }
    return BText(text ?? '',
        key: key,
        style: _mergeStyle(_getStyle(), style),
        inherit: inherit,
        color: color,
        foreground: foreground,
        background: background,
        backgroundColor: backgroundColor,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamilyFallback: fontFamilyFallback,
        fontVariations: fontVariations,
        package: package,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        shadows: shadows,
        fontFeatures: fontFeatures,
        selectionColor: selectionColor,
        textScaler: textScaler,
        leadingDistribution: leadingDistribution,
        useStyleFirst: useStyleFirst);
  }

  TextStyle? _getStyle() {
    switch (textSize) {
      case null:
        return Universally.to.getTheme()?.textStyle?.style;
      case TextSize.small:
        return Universally.to.getTheme()?.textStyle?.small;
      case TextSize.normal:
        return Universally.to.getTheme()?.textStyle?.normal;
      case TextSize.large:
        return Universally.to.getTheme()?.textStyle?.large;
      case TextSize.extraLarge:
        return Universally.to.getTheme()?.textStyle?.extraLarge;
    }
  }
}

/// BaseText
// class BaseText extends BText {
//   static TextStyle? _mergeStyle(TextStyle? firstStyle, TextStyle? secondStyle) {
//     if (firstStyle != null) {
//       return firstStyle.merge(secondStyle);
//     }
//     return secondStyle;
//   }
//
//   BaseText(
//     String? text, {
//     super.key,
//     super.letterSpacing,
//     super.wordSpacing,
//     super.fontSize,
//     super.fontFamily,
//     super.fontWeight,
//     super.fontFamilyFallback,
//     super.fontStyle,
//     super.color,
//     super.backgroundColor,
//     super.foreground,
//     super.background,
//     super.height,
//     super.textBaseline = TextBaseline.ideographic,
//     super.inherit = true,
//     super.package,
//     super.locale,
//     super.fontFeatures,
//     super.shadows,
//     super.textAlign,
//     super.decoration = TextDecoration.none,
//     super.decorationColor,
//     super.decorationStyle,
//     super.decorationThickness,
//     super.debugLabel,
//     super.useStyleFirst = false,
//     super.recognizer,
//     super.semanticsLabel,
//     super.strutStyle,
//     super.textDirection,
//     super.softWrap,
//     super.textScaleFactor,
//     super.textWidthBasis,
//     super.textHeightBehavior,
//     super.selectionColor,
//     super.textScaler = TextScaler.noScaling,
//     super.leadingDistribution,
//     super.fontVariations,
//     TextOverflow? overflow,
//     TextStyle? style,
//     int? maxLines,
//   }) : super(text ?? '',
//             maxLines: maxLines == null ? 1 : (maxLines == 0 ? null : maxLines),
//             overflow: overflow ??
//                 (maxLines == 0 ? TextOverflow.clip : TextOverflow.ellipsis),
//             style: (BaseText._mergeStyle(
//                 Universally().config.textStyle?.style, style)));
// }

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
