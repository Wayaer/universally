import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TabPageController extends PageController {
  TabPageController({
    super.initialPage = 0,
    super.keepPage = true,
    super.viewportFraction = 1.0,
    super.onAttach,
    super.onDetach,
  });

  int get currentPage => page?.round() ?? initialPage;

  Future<void> animateToOffset(
    double offset, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linear,
  }) {
    return super.animateTo(offset, duration: duration, curve: curve);
  }

  Future<void> animateToPageIndex(
    int page, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linear,
  }) {
    return super.animateToPage(page, duration: duration, curve: curve);
  }
}

class TabPageBar extends StatelessWidget {
  const TabPageBar({
    super.key,
    required this.itemBuilder,
    required this.controller,
    this.backgroundColor,
    this.spacing = 4,
    this.onChanged,
    this.borderSide,
    this.clipper,
  });

  final ValueCallbackTV<List<Widget>, BuildContext> itemBuilder;

  final Color? backgroundColor;

  final ValueCallback<int>? onChanged;

  ///  spacing
  final double spacing;

  /// top border side
  final BorderSide? borderSide;

  /// 用于裁剪 bar
  final CustomClipper<dynamic>? clipper;

  /// controller
  final TabPageController controller;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (BuildContext context, Widget? child) {
      return Universal(
        direction: Axis.horizontal,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: borderSide != null ? Border(top: borderSide!) : null,
        ),
        clipper: clipper,
        height: context.padding.bottom + kToolbarHeight,
        padding: EdgeInsets.only(bottom: context.padding.bottom),
        children: itemBuilder(context).builderEntry((item) {
          return Universal(
            expanded: true,
            onTap: () => onChanged?.call(item.key),
            padding: EdgeInsets.all(spacing),
            height: double.infinity,
            child: item.value,
          );
        }),
      );
    },
  );
}

class TabPage extends PageView {
  TabPage.builder({
    super.key,
    required List<Widget> children,
    super.controller,
    super.onPageChanged,
    super.scrollDirection = Axis.horizontal,
    super.reverse = false,
    super.pageSnapping = true,
    super.dragStartBehavior,
    super.allowImplicitScrolling = false,
    super.restorationId,
    super.clipBehavior = Clip.hardEdge,
    super.hitTestBehavior = HitTestBehavior.opaque,
    super.scrollBehavior,
    super.padEnds = true,
    bool enableScroll = true,
    ScrollPhysics? physics,
  }) : super.builder(
         physics: physics ?? (enableScroll ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics()),
         itemCount: children.length,
         itemBuilder: (BuildContext context, int index) => children[index],
       );

  TabPage.items({
    super.key,
    super.controller,
    super.children,
    super.onPageChanged,
    super.scrollDirection = Axis.horizontal,
    super.reverse = false,
    super.pageSnapping = true,
    super.dragStartBehavior,
    super.allowImplicitScrolling = false,
    super.restorationId,
    super.clipBehavior = Clip.hardEdge,
    super.hitTestBehavior = HitTestBehavior.opaque,
    super.scrollBehavior,
    super.padEnds = true,
    bool enableScroll = true,
    ScrollPhysics? physics,
  }) : super(physics: physics ?? (enableScroll ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics()));
}
