import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseIndicator extends FlIndicator {
  const BaseIndicator(
      {super.key,
      required super.count,
      required super.position,
      required super.index,
      super.layout = FlIndicatorType.scale,
      super.size = 8,
      super.color = UCS.background,
      super.activeColor});
}

class BaseCarouselSlider extends CarouselSlider {
  BaseCarouselSlider.builder(
      {super.key,
      required super.itemBuilder,
      required super.itemCount,

      /// [controller]
      super.controller,

      /// [aspectRatio]
      double aspectRatio = 16 / 9,

      /// [height]
      double? height = 40,

      /// [initialPage]
      int initialPage = 0,

      /// [viewportFraction]
      double viewportFraction = 1,

      /// [enableInfiniteScroll]
      bool enableInfiniteScroll = true,

      /// [enlargeCenterPage] 播放完成后，暂停播放
      bool enlargeCenterPage = false,

      /// [enlargeStrategy]
      CenterPageEnlargeStrategy enlargeStrategy =
          CenterPageEnlargeStrategy.scale,

      /// [enlargeFactor]
      double enlargeFactor = 0.3,

      /// [pauseAutoPlayOnTouch] 是否启用手势
      bool pauseAutoPlayOnTouch = true,

      /// [pauseAutoPlayOnManualNavigate]
      bool pauseAutoPlayOnManualNavigate = true,

      /// [pauseAutoPlayInFiniteScroll] 有拖拽时不暂停滚动
      bool pauseAutoPlayInFiniteScroll = true,

      /// [pageSnapping]
      bool pageSnapping = true,

      /// [autoPlay]
      bool autoPlay = false,

      /// [autoPlayInterval]
      Duration autoPlayInterval = const Duration(seconds: 2),

      /// [autoPlayAnimationDuration] 滚动间隔时间
      Duration autoPlayAnimationDuration = const Duration(milliseconds: 600),

      /// [autoPlayCurve]
      Curve autoPlayCurve = Curves.linear,

      /// [scrollDirection]
      Axis scrollDirection = Axis.horizontal,

      /// [scrollPhysics]
      ScrollPhysics? scrollPhysics,

      /// [onPageChanged]
      CarouselPageChangedCallback? onPageChanged,

      /// [onScrolled]
      ValueChanged<double?>? onScrolled,

      /// [animateToClosest]
      bool animateToClosest = true,

      /// [reverse]
      bool reverse = false,

      /// [disableCenter]
      bool disableCenter = false,

      /// [padEnds]
      bool padEnds = true,

      /// [clipBehavior]
      Clip clipBehavior = Clip.hardEdge,

      /// [pageViewKey]
      PageStorageKey? pageViewKey,

      /// [options] 会覆盖之前的所有参数
      CarouselSliderOptions? options})
      : assert(itemCount != null && itemCount > 0),
        super.builder(
            options: options ??
                CarouselSliderOptions(
                  height: height,
                  aspectRatio: aspectRatio,
                  viewportFraction: viewportFraction,
                  initialPage: initialPage,
                  enableInfiniteScroll: enableInfiniteScroll,
                  animateToClosest: animateToClosest,
                  reverse: reverse,
                  autoPlay: autoPlay,
                  autoPlayInterval: autoPlayInterval,
                  autoPlayAnimationDuration: autoPlayAnimationDuration,
                  autoPlayCurve: autoPlayCurve,
                  enlargeCenterPage: enlargeCenterPage,
                  onPageChanged: onPageChanged,
                  onScrolled: onScrolled,
                  scrollPhysics: scrollPhysics,
                  pageSnapping: pageSnapping,
                  scrollDirection: scrollDirection,
                  pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
                  pauseAutoPlayOnManualNavigate: pauseAutoPlayOnManualNavigate,
                  pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
                  pageViewKey: pageViewKey,
                  enlargeStrategy: enlargeStrategy,
                  enlargeFactor: enlargeFactor,
                  disableCenter: disableCenter,
                  padEnds: padEnds,
                  clipBehavior: clipBehavior,
                ));

  BaseCarouselSlider.items(
      {super.key,
      required super.items,

      /// [controller]
      super.controller,

      /// [aspectRatio]
      double aspectRatio = 16 / 9,

      /// [height]
      double? height = 40,

      /// [initialPage]
      int initialPage = 0,

      /// [viewportFraction]
      double viewportFraction = 1,

      /// [enableInfiniteScroll]
      bool enableInfiniteScroll = true,

      /// [enlargeCenterPage] 播放完成后，暂停播放
      bool enlargeCenterPage = false,

      /// [enlargeStrategy]
      CenterPageEnlargeStrategy enlargeStrategy =
          CenterPageEnlargeStrategy.scale,

      /// [enlargeFactor]
      double enlargeFactor = 0.3,

      /// [pauseAutoPlayOnTouch] 是否启用手势
      bool pauseAutoPlayOnTouch = true,

      /// [pauseAutoPlayOnManualNavigate]
      bool pauseAutoPlayOnManualNavigate = true,

      /// [pauseAutoPlayInFiniteScroll] 有拖拽时不暂停滚动
      bool pauseAutoPlayInFiniteScroll = true,

      /// [pageSnapping]
      bool pageSnapping = true,

      /// [autoPlay]
      bool autoPlay = false,

      /// [autoPlayInterval]
      Duration autoPlayInterval = const Duration(seconds: 2),

      /// [autoPlayAnimationDuration] 滚动间隔时间
      Duration autoPlayAnimationDuration = const Duration(milliseconds: 600),

      /// [autoPlayCurve]
      Curve autoPlayCurve = Curves.linear,

      /// [scrollDirection]
      Axis scrollDirection = Axis.horizontal,

      /// [scrollPhysics]
      ScrollPhysics? scrollPhysics,

      /// [onPageChanged]
      CarouselPageChangedCallback? onPageChanged,

      /// [onScrolled]
      ValueChanged<double?>? onScrolled,

      /// [animateToClosest]
      bool animateToClosest = true,

      /// [reverse]
      bool reverse = false,

      /// [disableCenter]
      bool disableCenter = false,

      /// [padEnds]
      bool padEnds = true,

      /// [clipBehavior]
      Clip clipBehavior = Clip.hardEdge,

      /// [pageViewKey]
      PageStorageKey? pageViewKey,

      /// [options] 会覆盖之前的所有参数
      CarouselSliderOptions? options})
      : assert(items != null && items.isNotEmpty),
        super.items(
            options: options ??
                CarouselSliderOptions(
                  height: height,
                  aspectRatio: aspectRatio,
                  viewportFraction: viewportFraction,
                  initialPage: initialPage,
                  enableInfiniteScroll: enableInfiniteScroll,
                  animateToClosest: animateToClosest,
                  reverse: reverse,
                  autoPlay: autoPlay,
                  autoPlayInterval: autoPlayInterval,
                  autoPlayAnimationDuration: autoPlayAnimationDuration,
                  autoPlayCurve: autoPlayCurve,
                  enlargeCenterPage: enlargeCenterPage,
                  onPageChanged: onPageChanged,
                  onScrolled: onScrolled,
                  scrollPhysics: scrollPhysics,
                  pageSnapping: pageSnapping,
                  scrollDirection: scrollDirection,
                  pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
                  pauseAutoPlayOnManualNavigate: pauseAutoPlayOnManualNavigate,
                  pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
                  pageViewKey: pageViewKey,
                  enlargeStrategy: enlargeStrategy,
                  enlargeFactor: enlargeFactor,
                  disableCenter: disableCenter,
                  padEnds: padEnds,
                  clipBehavior: clipBehavior,
                ));
}

class TabPage extends BaseCarouselSlider {
  TabPage.builder({
    super.key,
    required List<Widget> children,
    ValueCallback<int>? onPageChanged,
    super.controller,
    bool enableScroll = true,
  }) : super.builder(
            autoPlay: false,
            pauseAutoPlayOnTouch: false,
            enableInfiniteScroll: false,
            pageSnapping: true,
            height: double.infinity,
            scrollPhysics: enableScroll
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            onPageChanged: (int? index, CarouselPageChangedReason reason) {
              if (index != null) onPageChanged?.call(index);
            },
            itemCount: children.length,
            itemBuilder: (_, int index, __) => children[index]);

  TabPage.items({
    super.key,
    required List<Widget> children,
    ValueCallback<int>? onPageChanged,
    super.controller,
    bool enableScroll = true,
  }) : super.items(
            autoPlay: false,
            pauseAutoPlayOnTouch: false,
            enableInfiniteScroll: false,
            pageSnapping: true,
            height: double.infinity,
            scrollPhysics: enableScroll
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            onPageChanged: (int? index, CarouselPageChangedReason reason) {
              if (index != null) onPageChanged?.call(index);
            },
            items: children);
}
