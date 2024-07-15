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
    super.labelColor,
    super.indicatorColor,
    TabAlignment? tabAlignment,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
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
    super.indicatorColor,
    TabAlignment? tabAlignment,
    TextStyle? labelStyle,
    TextStyle? unselectedLabelStyle,
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
                color: indicatorColor, borderRadius: BorderRadius.circular(4)),
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

typedef CustomTabBarItemBuilder = Widget Function(int selected, int index);

class CustomTabBar extends StatefulWidget {
  const CustomTabBar(
      {super.key,
      required this.itemBuilder,
      required this.builder,
      this.initial = 0,
      required this.controller,
      this.onTap});

  final CustomTabBarItemBuilder itemBuilder;
  final ValueCallbackTV<Widget, List<Widget>> builder;
  final int initial;
  final TabController controller;
  final ValueCallback<int>? onTap;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initial;
    widget.controller.addListener(listener);
  }

  @override
  void didUpdateWidget(covariant CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller.removeListener(listener);
    widget.controller.addListener(listener);
  }

  void listener() {
    var index = widget.controller.index;
    final maxLength = widget.controller.length;
    if (index < 0) {
      index = 0;
    } else if (index > maxLength) {
      index = maxLength;
    }
    if (index == selected) return;
    selected = index;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(widget.controller.length.generate((int index) {
      return widget.itemBuilder(selected, index);
    }));
  }
}
