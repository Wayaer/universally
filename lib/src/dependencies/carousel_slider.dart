import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseIndicator extends FlIndicator {
  BaseIndicator(
      {super.key,
      required super.count,
      required super.position,
      required super.index,
      super.layout = FlIndicatorType.scale,
      super.size = 8,
      super.color = UCS.background,
      Color? activeColor})
      : super(activeColor: activeColor ?? Universally.to.getTheme()?.mainColor);
}

class BaseCarouselSlider extends CarouselSlider {
  BaseCarouselSlider(
      {super.key,
      required super.itemBuilder,
      required int itemCount,
      double? height = 40,
      int initialPage = 0,
      double viewportFraction = 1,
      bool enableInfiniteScroll = true,

      /// 有拖拽时不暂停滚动
      bool pauseAutoPlayInFiniteScroll = true,

      /// 是否启用手势
      bool pauseAutoPlayOnTouch = true,
      bool? autoPlay,
      bool pageSnapping = true,

      /// 播放完成后，暂停播放
      bool enlargeCenterPage = false,
      Axis scrollDirection = Axis.horizontal,
      Duration autoPlayInterval = const Duration(seconds: 2),
      ValueChanged<double?>? onScrolled,
      Curve autoPlayCurve = Curves.linear,
      ScrollPhysics? scrollPhysics,
      CarouselController? controller,

      /// 滚动间隔时间
      Duration autoPlayAnimationDuration = const Duration(milliseconds: 600),
      Function(int? index, CarouselPageChangedReason reason)? onPageChanged})
      : super.builder(
            itemCount: itemCount,
            carouselController: controller,
            options: CarouselOptions(
                height: height,
                pageSnapping: pageSnapping,
                pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
                pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
                initialPage: initialPage,
                autoPlayAnimationDuration: autoPlayAnimationDuration,
                enableInfiniteScroll: enableInfiniteScroll,
                autoPlay: autoPlay ?? itemCount > 1,
                scrollDirection: scrollDirection,
                viewportFraction: viewportFraction,
                autoPlayInterval: autoPlayInterval,
                autoPlayCurve: autoPlayCurve,
                scrollPhysics: scrollPhysics,
                onPageChanged: onPageChanged,
                onScrolled: onScrolled,
                enlargeCenterPage: enlargeCenterPage));
}

class TabPage extends BaseCarouselSlider {
  TabPage({
    super.key,
    required List<Widget> children,
    ValueCallback<int>? onPageChanged,
    super.controller,
    bool enableScroll = true,
  }) : super(
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
}
