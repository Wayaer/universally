import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseTabBar extends TabBar {
  BaseTabBar({
    super.key,
    super.controller,
    super.isScrollable = false,
    super.padding,
    super.automaticIndicatorColorAdjustment = true,
    super.indicatorWeight = 2.0,
    super.indicatorPadding = EdgeInsets.zero,
    super.indicator,
    super.indicatorSize = TabBarIndicatorSize.label,
    super.dividerColor,
    super.labelPadding,
    super.dragStartBehavior = DragStartBehavior.start,
    super.overlayColor,
    super.mouseCursor,
    super.enableFeedback,
    super.onTap,
    super.physics,
    super.splashFactory,
    super.splashBorderRadius,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
    Color? indicatorColor,
    Color? labelColor,
    super.unselectedLabelColor = UCS.black70,
    String? fontFamily,
    FontType? fontType,
    double fontSize = 16,
    double height = 38,
    List<Widget>? tabs,
    List<String>? list,
  })  : assert(tabs != null || list != null),
        super(
            tabs: tabs ??
                list?.builder((value) => Tab(text: value, height: height)) ??
                [],
            labelColor: labelColor ?? GlobalConfig().currentColor,
            indicatorColor:
                indicatorColor ?? labelColor ?? GlobalConfig().currentColor,
            labelStyle: labelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontType: fontType),
            unselectedLabelStyle: unselectedLabelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontType: fontType));

  BaseTabBar.indicator({
    super.key,
    super.controller,
    super.isScrollable = false,
    super.padding,
    super.automaticIndicatorColorAdjustment = true,
    super.dividerColor,
    super.labelPadding,
    super.dragStartBehavior = DragStartBehavior.start,
    super.overlayColor,
    super.mouseCursor,
    super.enableFeedback,
    super.onTap,
    super.physics,
    super.splashFactory,
    super.splashBorderRadius,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
    Color? indicatorColor,
    Color labelColor = UCS.white,
    Color unselectedLabelColor = UCS.black70,
    String? fontFamily,
    FontType? fontType,
    double fontSize = 16,
    double height = 38,
    List<Widget>? tabs,
    List<String>? list,
  })  : assert(tabs != null || list != null),
        super(
            tabs: tabs ??
                list?.builder((value) => Tab(text: value, height: height)) ??
                [],
            indicatorWeight: 0,
            indicator: BoxDecoration(
                color: indicatorColor ?? GlobalConfig().currentColor,
                borderRadius: BorderRadius.circular(4)),
            labelColor: labelColor,
            indicatorColor: UCS.transparent,
            unselectedLabelColor: unselectedLabelColor,
            labelStyle: labelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontType: fontType),
            unselectedLabelStyle: unselectedLabelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontType: fontType));
}
