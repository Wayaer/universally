import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseIndicator extends FlIndicator {
  const BaseIndicator({
    super.key,
    required super.count,
    required super.position,
    required super.index,
    super.style = FlIndicatorStyle.scale,
    super.size = 8,
    super.color = UCS.background,
    super.activeColor,
  });
}

class BasePageView extends StatelessWidget {
  const BasePageView({
    super.key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.scrollBehavior,
    this.padEnds = true,
    this.findChildIndexCallback,

    /// [FlPageView]
    required this.itemBuilder,
    required this.itemCount,
    this.controller,
    this.height,
    this.aspectRatio = 16 / 9,
    this.animateToClosest = true,
    this.disposeController = true,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.pauseAutoPlayOnScrolling = true,
    this.pauseAutoPlayOnManualNavigate = true,
    this.pauseAutoPlayInFiniteScroll = false,
  });

  /// Controls whether the widget's pages will respond to
  /// [RenderObject.showOnScreen], which will allow for implicit accessibility
  /// scrolling.
  ///
  /// With this flag set to false, when accessibility focus reaches the end of
  /// the current page and the user attempts to move it to the next element, the
  /// focus will traverse to the next widget outside of the page view.
  ///
  /// With this flag set to true, when accessibility focus reaches the end of
  /// the current page and user attempts to move it to the next element, focus
  /// will traverse to the next page in the page view.
  final bool allowImplicitScrolling;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// The [Axis] along which the scroll view's offset increases with each page.
  ///
  /// For the direction in which active scrolling may be occurring, see
  /// [ScrollDirection].
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Whether the page view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the page view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the page view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// If an explicit [ScrollBehavior] is provided to [scrollBehavior], the
  /// [ScrollPhysics] provided by that behavior will take precedence after
  /// [physics].
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  ///
  /// If the [padEnds] is false and [PageController.viewportFraction] < 1.0,
  /// the page will snap to the beginning of the viewport; otherwise, the page
  /// will snap to the center of the viewport.
  final bool pageSnapping;

  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int>? onPageChanged;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.scrollable.hitTestBehavior}
  ///
  /// Defaults to [HitTestBehavior.opaque].
  final HitTestBehavior hitTestBehavior;

  /// {@macro flutter.widgets.scrollable.scrollBehavior}
  ///
  /// The [ScrollBehavior] of the inherited [ScrollConfiguration] will be
  /// modified by default to not apply a [Scrollbar].
  final ScrollBehavior? scrollBehavior;

  /// Whether to add padding to both ends of the list.
  ///
  /// If this is set to true and [PageController.viewportFraction] < 1.0, padding will be added
  /// such that the first and last child slivers will be in the center of
  /// the viewport when scrolled all the way to the start or end, respectively.
  ///
  /// If [PageController.viewportFraction] >= 1.0, this property has no effect.
  ///
  /// This property defaults to true.
  final bool padEnds;

  ///
  final NullableIndexedWidgetBuilder itemBuilder;

  ///
  final ChildIndexGetter? findChildIndexCallback;

  /// ******** [FlPageView] ********
  /// The page controller to use.
  final FlPageViewController? controller;

  /// Number of items in the carousel.
  final int itemCount;

  /// Set carousel height and overrides any existing [aspectRatio].
  final double? height;

  /// Aspect ratio is used if no height have been declared.
  /// Defaults to 16:9 aspect ratio.
  final double aspectRatio;

  ///Determines if carousel should loop to the closest occurence of requested page.
  ///Defaults to true.
  final bool animateToClosest;

  /// Enables auto play, sliding one page at a time.
  /// Use [autoPlayInterval] to determent the frequency of slides.
  /// Defaults to false.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  /// [autoPlay] is set to true.
  /// Defaults to 3 seconds.
  final Duration autoPlayInterval;

  /// Animation duration when auto play slides to the next page.   Defaults to 800 ms.
  final Duration autoPlayAnimationDuration;

  /// Animation curve when auto play slides to the next page. defaults to [Curves.fastOutSlowIn].
  final Curve autoPlayCurve;

  /// If `true`, the auto play function will be paused when user is interacting with
  /// the page view, and will be resumed when user finish interacting.
  /// Default to `true`.
  final bool pauseAutoPlayOnScrolling;

  /// If `true`, the auto play function will be paused when user is calling
  /// controller's `next` or `previous` or `animate` method.
  /// And after the animation complete, the auto play will be resumed.
  /// Default to `true`.
  final bool pauseAutoPlayOnManualNavigate;

  /// If `true`, the auto play function will be paused when user is scrolling
  /// to the edge of the page view.
  final bool pauseAutoPlayInFiniteScroll;

  /// Dispose the controller when the widget is disposed
  final bool disposeController;

  @override
  Widget build(BuildContext context) {
    return FlPageView(
      itemCount: itemCount,
      autoPlay: autoPlay,
      controller: controller,
      disposeController: disposeController,
      height: height,
      aspectRatio: aspectRatio,
      animateToClosest: animateToClosest,
      autoPlayAnimationDuration: autoPlayAnimationDuration,
      autoPlayCurve: autoPlayCurve,
      autoPlayInterval: autoPlayInterval,
      pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
      pauseAutoPlayOnManualNavigate: pauseAutoPlayOnManualNavigate,
      pauseAutoPlayOnScrolling: pauseAutoPlayOnScrolling,
      builder: (FlPageViewController pageController, int? itemCount) =>
          PageView.builder(
        allowImplicitScrolling: allowImplicitScrolling,
        scrollDirection: scrollDirection,
        reverse: reverse,
        physics: physics,
        pageSnapping: pageSnapping,
        onPageChanged: onPageChanged,
        findChildIndexCallback: findChildIndexCallback,
        dragStartBehavior: dragStartBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
        hitTestBehavior: hitTestBehavior,
        scrollBehavior: scrollBehavior,
        padEnds: padEnds,
        controller: pageController,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
