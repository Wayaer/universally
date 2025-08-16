import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseProgressIndicator extends StatelessWidget {
  const BaseProgressIndicator.linear({
    super.key,
    this.value,
    this.width = double.infinity,
    this.height = 4,
    this.borderRadius = BorderRadius.zero,
    this.valueColor,
    this.color,
    this.backgroundColor,
    this.minHeight,
    this.semanticsLabel,
    this.semanticsValue,
  }) : strokeWidth = 4,
       strokeAlign = 0.5,
       strokeCap = null,
       elevation = 2.0,
       indicatorMargin = const EdgeInsets.all(4.0),
       indicatorPadding = const EdgeInsets.all(12.0),
       style = ProgressIndicatorStyle.linear;

  const BaseProgressIndicator.circular({
    super.key,
    this.value,
    this.width = 100,
    this.height = 100,
    this.valueColor,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4,
    this.strokeAlign = 0.5,
    this.strokeCap,
    this.semanticsLabel,
    this.semanticsValue,
  }) : minHeight = null,
       elevation = 2.0,
       indicatorMargin = const EdgeInsets.all(4.0),
       indicatorPadding = const EdgeInsets.all(12.0),
       borderRadius = BorderRadius.zero,
       style = ProgressIndicatorStyle.circular;

  const BaseProgressIndicator.refresh({
    super.key,
    this.value,
    this.width = 100,
    this.height = 100,
    this.color,
    this.valueColor,
    this.backgroundColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = 4,
    this.strokeAlign = 0,
    this.strokeCap,
    this.elevation = 2.0,
    this.indicatorMargin = const EdgeInsets.all(4.0),
    this.indicatorPadding = const EdgeInsets.all(12.0),
  }) : style = ProgressIndicatorStyle.refresh,
       minHeight = null,
       borderRadius = BorderRadius.zero;

  final double width;
  final double height;

  /// ProgressIndicator
  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final String? semanticsLabel;
  final String? semanticsValue;

  /// LinearProgressIndicator
  final double? minHeight;
  final BorderRadiusGeometry borderRadius;

  /// CircularProgressIndicator
  final double strokeWidth;
  final double strokeAlign;
  final StrokeCap? strokeCap;

  /// [RefreshProgressIndicator]
  final double elevation;
  final EdgeInsetsGeometry indicatorMargin;
  final EdgeInsetsGeometry indicatorPadding;

  /// [ProgressIndicatorStyle]
  final ProgressIndicatorStyle style;

  @override
  Widget build(BuildContext context) {
    return ProgressIndicatorOptions(
      width: width,
      height: height,
      style: style,
      value: value,
      color: color ?? context.theme.primaryColor,
      valueColor: valueColor,
      backgroundColor: backgroundColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      borderRadius: borderRadius,
      minHeight: minHeight,
      strokeWidth: strokeWidth,
      strokeAlign: strokeAlign,
      strokeCap: strokeCap,
      elevation: elevation,
      indicatorMargin: indicatorMargin,
      indicatorPadding: indicatorPadding,
    ).widget;
  }
}

class BaseProgressIndicatorListenable extends BaseProgressIndicator {
  const BaseProgressIndicatorListenable.linear({
    super.key,
    required this.listenable,
    this.disposeNotifier = true,
    super.value,
    super.width = double.infinity,
    super.height = 4,
    super.borderRadius = BorderRadius.zero,
    super.valueColor,
    super.color,
    super.backgroundColor,
    super.minHeight,
    super.semanticsLabel,
    super.semanticsValue,
  }) : super.linear();

  const BaseProgressIndicatorListenable.circular({
    super.key,
    required this.listenable,
    this.disposeNotifier = true,
    super.value,
    super.width = 100,
    super.height = 100,
    super.valueColor,
    super.color,
    super.backgroundColor,
    super.strokeWidth = 4,
    super.strokeAlign = 0.5,
    super.strokeCap,
    super.semanticsLabel,
    super.semanticsValue,
  }) : super.circular();

  const BaseProgressIndicatorListenable.refresh({
    super.key,
    required this.listenable,
    this.disposeNotifier = true,
    super.value,
    super.width = 100,
    super.height = 100,
    super.color,
    super.valueColor,
    super.backgroundColor,
    super.semanticsLabel,
    super.semanticsValue,
    super.strokeWidth = 4,
    super.strokeAlign = 0,
    super.strokeCap,
    super.elevation = 2.0,
    super.indicatorMargin = const EdgeInsets.all(4.0),
    super.indicatorPadding = const EdgeInsets.all(12.0),
  }) : super.refresh();

  ///  [ValueListenable]
  final ValueListenable listenable;

  /// 当 [listenable] 是 [ChangeNotifier],dispose 时是否 dispose [ChangeNotifier]
  final bool disposeNotifier;

  @override
  Widget build(BuildContext context) {
    return FlListenableBuilder<ValueListenable>(
      listenable: listenable,
      dispose: (BuildContext context) {
        if (disposeNotifier && listenable is ChangeNotifier) {
          (listenable as ChangeNotifier).dispose();
        }
      },
      builder: (BuildContext context, ValueListenable value) {
        return ProgressIndicatorOptions(
          width: width,
          height: height,
          style: style,
          value: value.value,
          color: color ?? context.theme.primaryColor,
          valueColor: valueColor,
          backgroundColor: backgroundColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
          borderRadius: borderRadius,
          minHeight: minHeight,
          strokeWidth: strokeWidth,
          strokeAlign: strokeAlign,
          strokeCap: strokeCap,
          elevation: elevation,
          indicatorMargin: indicatorMargin,
          indicatorPadding: indicatorPadding,
        ).widget;
      },
    );
  }
}
