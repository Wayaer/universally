import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

enum TextFontSize { smallest, small, normal, large, extraLarge }

/// Large font
class TextLarge extends BaseText {
  const TextLarge(
    super.text, {
    super.key,
    super.usePrimaryColor = false,
    super.useStyleFirst = false,

    /// [TextSpan]
    super.style,
    super.recognizer,
    super.semanticsLabel,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.spellOut,

    /// [Text]
    super.locale,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.softWrap,
    super.overflow,
    super.maxLines,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,

    /// [TextStyle]
    super.inherit = true,
    super.color,
    super.backgroundColor,
    super.fontFamily,
    super.fontFamilyFallback,
    super.package,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.foreground,
    super.background,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.shadows,
    super.fontFeatures,
    super.leadingDistribution,
    super.fontVariations,
  }) : super(textFontSize: TextFontSize.large);
}

/// 默认字体
/// The formal font
class TextMedium extends BaseText {
  const TextMedium(
    super.text, {
    super.key,
    super.usePrimaryColor = false,
    super.useStyleFirst = false,

    /// [TextSpan]
    super.style,
    super.recognizer,
    super.semanticsLabel,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.spellOut,

    /// [Text]
    super.locale,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.softWrap,
    super.overflow,
    super.maxLines,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,

    /// [TextStyle]
    super.inherit = true,
    super.color,
    super.backgroundColor,
    super.fontFamily,
    super.fontFamilyFallback,
    super.package,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.foreground,
    super.background,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.shadows,
    super.fontFeatures,
    super.leadingDistribution,
    super.fontVariations,
  }) : super(textFontSize: TextFontSize.normal);
}

/// 小字体
/// Small font
class TextSmall extends BaseText {
  const TextSmall(
    super.text, {
    super.key,
    super.usePrimaryColor = false,
    super.useStyleFirst = false,

    /// [TextSpan]
    super.style,
    super.recognizer,
    super.semanticsLabel,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.spellOut,

    /// [Text]
    super.locale,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.softWrap,
    super.overflow,
    super.maxLines,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.textScaler = TextScaler.noScaling,

    /// [TextStyle]
    super.inherit = true,
    super.color,
    super.backgroundColor,
    super.fontFamily,
    super.fontFamilyFallback,
    super.package,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.foreground,
    super.background,
    super.decoration = TextDecoration.none,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.shadows,
    super.fontFeatures,
    super.leadingDistribution,
    super.fontVariations,
  }) : super(textFontSize: TextFontSize.small);
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
    this.usePrimaryColor = false,
    this.textFontSize,
    this.useStyleFirst = false,

    /// [TextSpan]
    this.style,
    this.recognizer,
    this.semanticsLabel,
    this.mouseCursor,
    this.onEnter,
    this.onExit,
    this.spellOut,

    /// [Text]
    this.locale,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.textScaler = TextScaler.noScaling,

    /// [TextStyle]
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
    this.leadingDistribution,
    this.fontVariations,
  }) : texts = const [],
       styles = const [],
       recognizers = const [],
       semanticsLabels = const [],
       mouseCursors = const [],
       onEnters = const [],
       onExits = const [],
       locales = const [],
       spellOuts = const [];

  /// 与 [RText] 一致，仅增加 主题适配
  const BaseText.rich({
    super.key,
    this.usePrimaryColor = false,
    this.textFontSize,
    this.useStyleFirst = false,

    /// [TextSpan]
    this.text = '',
    this.texts = const [],
    this.style,
    this.styles = const [],
    this.recognizer,
    this.recognizers = const [],
    this.semanticsLabel,
    this.semanticsLabels = const [],
    this.mouseCursor,
    this.mouseCursors = const [],
    this.onEnter,
    this.onEnters = const [],
    this.onExit,
    this.onExits = const [],
    this.locale,
    this.locales = const [],
    this.spellOut,
    this.spellOuts = const [],

    /// [Text]
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.textScaler = TextScaler.noScaling,

    /// [TextStyle]
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
    this.leadingDistribution,
    this.fontVariations,
  });

  /// 使用主色调设置字体颜色
  final bool usePrimaryColor;

  /// 字体大小
  final TextFontSize? textFontSize;

  /// 当 [color]和[style]中都有值
  /// [useStyleFirst]=true 优先使用style,
  /// [useStyleFirst]=false 优先使用外层,
  final bool useStyleFirst;

  /// ---------- [TextStyle] ----------
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

  final TextLeadingDistribution? leadingDistribution;

  /// ---------- [TextSpan] ----------

  final String? text;

  /// 所有[texts]默认样式
  final TextStyle? style;

  /// [text]手势
  final GestureRecognizer? recognizer;

  /// [text]语义 - 语义描述标签，相当于此text的别名
  final String? semanticsLabel;

  /// [mouseCursor]
  final MouseCursor? mouseCursor;

  /// [onEnter]
  final PointerEnterEventListener? onEnter;

  /// [onExit]
  final PointerExitEventListener? onExit;

  /// [spellOut]
  final bool? spellOut;

  /// ---------- [Text] ----------
  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// StrutStyle,影响Text在垂直方向上的布局
  final StrutStyle? strutStyle;

  /// TextDirection,内容的走向方式
  final TextDirection? textDirection;

  /// Locale，当相同的Unicode字符可以根据不同的地区以不同的方式呈现时，用于选择字体
  final Locale? locale;

  /// bool 文本是否应在软换行时断行
  final bool? softWrap;

  /// TextOverflow，内容溢出时的处理方式
  final TextOverflow? overflow;

  /// int 设置文字的最大展示行数
  final int? maxLines;

  /// {@macro flutter.painting.textPainter.textScaler}
  final TextScaler? textScaler;

  /// TextWidthBasis 测量一行或多行文本宽度
  final TextWidthBasis? textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  /// The color to use when painting the selection.
  final Color? selectionColor;

  /// ---------- [BText.rich] ----------
  /// 排在第一个[text]后面
  final List<String> texts;

  /// [texts]内样式
  final List<TextStyle> styles;

  /// [texts]内手势
  final List<GestureRecognizer?> recognizers;

  /// [texts]内语义 - 语义描述标签，相当于此text的别名
  final List<String> semanticsLabels;

  /// [mouseCursors]
  final List<MouseCursor?> mouseCursors;

  /// [onEnters]
  final List<PointerEnterEventListener?> onEnters;

  /// [onExits]
  final List<PointerExitEventListener?> onExits;

  /// [locales]
  final List<Locale?> locales;

  /// [spellOuts]
  final List<bool?> spellOuts;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = _mergeStyle(_getStyle(context), style);
    return BText.rich(
      useStyleFirst: usePrimaryColor ? false : useStyleFirst,
      text: text,
      texts: texts,
      style: textStyle,
      styles: styles,
      recognizer: recognizer,
      recognizers: recognizers,
      semanticsLabel: semanticsLabel,
      semanticsLabels: semanticsLabels,
      inherit: inherit,
      color: usePrimaryColor ? context.theme.primaryColor : color,
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
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      maxLines: maxLines,
      mouseCursor: mouseCursor,
      onEnter: onEnter,
      onExit: onExit,
      mouseCursors: mouseCursors,
      onEnters: onEnters,
      onExits: onExits,
      locales: locales,
      spellOut: spellOut,
      spellOuts: spellOuts,
      textAlign: textAlign,
      strutStyle: strutStyle,
    );
  }

  TextStyle? _getStyle(BuildContext context) {
    switch (textFontSize) {
      case null:
        return context.textTheme.bodyMedium;
      case TextFontSize.smallest:
        final style = context.textTheme.bodySmall;
        return style?.copyWith(fontSize: (style.fontSize ?? 12) - 2);
      case TextFontSize.small:
        return context.textTheme.bodySmall;
      case TextFontSize.normal:
        return context.textTheme.bodyMedium;
      case TextFontSize.large:
        return context.textTheme.bodyLarge;
      case TextFontSize.extraLarge:
        final style = context.textTheme.bodyLarge;
        return style?.copyWith(fontSize: (style.fontSize ?? 16) + 2);
    }
  }
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
    super.overflow = TextOverflow.ellipsis,
  });

  /// smallest text style
  /// 获取预先设置的 bodySmall
  static TextStyle get smallest => TStyle.small.copyWith(fontSize: (TStyle.small.fontSize ?? 12) - 2);

  /// small text style
  /// 获取预先设置的 bodySmall
  static TextStyle get small => Universally.to.getTheme()?.textTheme.bodySmall ?? const TStyle(fontSize: 12);

  /// medium text style
  /// 获取预先设置的 bodyMedium
  static TextStyle get medium => Universally.to.getTheme()?.textTheme.bodyMedium ?? const TStyle(fontSize: 14);

  /// large text style
  /// 获取预先设置的 bodyLarge
  static TextStyle get large => Universally.to.getTheme()?.textTheme.bodyLarge ?? const TStyle(fontSize: 16);

  /// extra large text style
  /// 获取预先设置的 large
  static TextStyle get extraLarge => TStyle.large.copyWith(fontSize: (TStyle.large.fontSize ?? 16) + 2);
}

class TextBoxPage extends StatelessWidget {
  const TextBoxPage({super.key, required this.text, this.color, this.appBarTitleText, this.toastText = '复制成功'});

  final String? appBarTitleText;
  final String toastText;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => BaseScaffold(
    appBarTitleText: appBarTitleText,
    padding: const EdgeInsets.all(20),
    child: Universal(
      onTap: () {
        text.toClipboard;
        showToast(toastText);
      },
      child: TextMedium(text, color: color),
    ),
  );
}
