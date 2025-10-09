import 'package:flutter/material.dart';

typedef RowTextLayoutBuilderTextBuilder = Widget Function(Widget widget);

typedef RowTextLayoutBuilderRowBuilder =
    Widget Function(
      List<TextSpan> leading,
      RowTextLayoutBuilderTextBuilder leadingBuilder,
      List<TextSpan> trailing,
      RowTextLayoutBuilderTextBuilder trailingBuilder,
    );

/// Row 中展示两段文本
/// 动态计算两段文本长短 优化展示效果
class RowTextLayoutBuilder extends StatelessWidget {
  const RowTextLayoutBuilder({
    super.key,
    required this.leading,
    this.leadingFlex = 1,
    required this.trailing,
    this.trailingFlex = 1,
    required this.builder,
    this.spacing = 0,
    this.excludeLeadingSpacing = 0,
    this.excludeTrailingSpacing = 0,
    this.fit = FlexFit.tight,
  });

  /// leading
  final List<TextSpan> leading;

  /// 排除 leading 间距
  final double excludeLeadingSpacing;

  /// leading Flex 默认为 1
  final int leadingFlex;

  /// trailing
  final List<TextSpan> trailing;

  /// 排除 trailing 间距
  final double excludeTrailingSpacing;

  /// trailing Flex 默认为 1
  final int trailingFlex;

  /// 间距
  final double spacing;

  /// Row 组件构建
  final RowTextLayoutBuilderRowBuilder builder;

  /// [FlexFit.loose]=[Flexible]
  /// [FlexFit.tight]=[Expanded]
  final FlexFit fit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = (constraints.maxWidth - spacing) / 2;
        final maxWidthWithoutExcludeLeadingSpacing = maxWidth - excludeLeadingSpacing;
        final maxWidthWithoutExcludeTrailingSpacing = maxWidth - excludeTrailingSpacing;
        final leadingWidth = getTextSpanWidth(context, leading, maxWidthWithoutExcludeLeadingSpacing);
        final trailingWidth = getTextSpanWidth(context, trailing, maxWidthWithoutExcludeTrailingSpacing);
        bool leadingWithFlexible = false;
        bool trailingWithFlexible = false;
        if (leadingWidth >= maxWidthWithoutExcludeLeadingSpacing) {
          leadingWithFlexible = true;
        }
        if (trailingWidth >= maxWidthWithoutExcludeTrailingSpacing) {
          trailingWithFlexible = true;
        }
        return builder(
          leading,
          (Widget widget) {
            if (leadingWithFlexible) widget = Flexible(flex: leadingFlex, fit: fit, child: widget);
            return widget;
          },
          trailing,
          (Widget widget) {
            if (trailingWithFlexible) widget = Flexible(flex: trailingFlex, fit: fit, child: widget);
            return widget;
          },
        );
      },
    );
  }

  double getTextSpanWidth(BuildContext context, List<TextSpan> textSpans, double maxWidth) {
    try {
      double width = 0;
      for (var textSpan in textSpans) {
        width += getTextWidth(context, textSpan);
      }
      return width;
    } catch (e) {
      return maxWidth;
    }
  }

  double getTextWidth(BuildContext context, TextSpan textSpan) {
    final textPainter = TextPainter(
      locale: Localizations.localeOf(context),
      text: textSpan,
      textScaler: MediaQuery.of(context).textScaler,
      textHeightBehavior: DefaultTextHeightBehavior.maybeOf(context),
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
    );
    textPainter.layout(maxWidth: double.infinity);
    return textPainter.size.width;
  }
}
