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
    super.dividerColor = UCS.transparent,
    super.labelPadding,
    super.dragStartBehavior = DragStartBehavior.start,
    super.overlayColor,
    super.mouseCursor,
    super.enableFeedback,
    super.onTap,
    super.physics,
    super.splashFactory,
    super.splashBorderRadius,
    super.dividerHeight,
    super.unselectedLabelColor = UCS.black70,
    TabAlignment? tabAlignment,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
    Color? indicatorColor,
    Color? labelColor,
    String? fontFamily,
    FontWeight? fontWeight,
    double fontSize = 16,
    double height = 38,
    List<Widget>? tabs,
    List<String>? list,
  })  : assert(tabs != null || list != null),
        super(
            tabAlignment:
                tabAlignment ?? (isScrollable ? TabAlignment.start : null),
            tabs: tabs ??
                list?.builder((value) => Tab(text: value, height: height)) ??
                [],
            labelColor: labelColor ?? Universally().mainColor,
            indicatorColor:
                indicatorColor ?? labelColor ?? Universally().mainColor,
            labelStyle: labelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontWeight: fontWeight),
            unselectedLabelStyle: unselectedLabelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontWeight: fontWeight));

  BaseTabBar.indicator({
    super.key,
    super.controller,
    super.isScrollable = false,
    super.padding,
    super.automaticIndicatorColorAdjustment = true,
    super.labelPadding,
    super.dragStartBehavior = DragStartBehavior.start,
    super.overlayColor,
    super.mouseCursor,
    super.enableFeedback,
    super.onTap,
    super.physics,
    super.splashFactory,
    super.splashBorderRadius,
    super.dividerHeight,
    TabAlignment? tabAlignment,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
    Color? indicatorColor,
    Color labelColor = UCS.white,
    Color unselectedLabelColor = UCS.black70,
    String? fontFamily,
    FontWeight? fontWeight,
    double fontSize = 16,
    double height = 38,
    List<Widget>? tabs,
    List<String>? list,
  })  : assert(tabs != null || list != null),
        super(
            tabAlignment:
                tabAlignment ?? (isScrollable ? TabAlignment.start : null),
            tabs: tabs ??
                list?.builder((value) => Tab(text: value, height: height)) ??
                [],
            indicatorWeight: 0,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                color: indicatorColor ?? Universally().mainColor,
                borderRadius: BorderRadius.circular(4)),
            labelColor: labelColor,
            dividerColor: UCS.transparent,
            unselectedLabelColor: unselectedLabelColor,
            labelStyle: labelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontWeight: fontWeight),
            unselectedLabelStyle: unselectedLabelStyle ??
                TStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontWeight: fontWeight));
}
