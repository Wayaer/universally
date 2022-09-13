import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BasicIndicator extends Indicator {
  BasicIndicator(
      {super.key,
      required super.count,
      required super.position,
      required super.index,
      super.layout = IndicatorType.scale,
      super.size = 8,
      super.color = UCS.background,
      Color? activeColor})
      : super(activeColor: activeColor ?? GlobalConfig().currentColor);
}

class BasicCarouselSlider extends CarouselSlider {
  BasicCarouselSlider(
      {super.key,
      required super.itemBuilder,
      required super.itemCount,
      double? height,
      int initialPage = 0,
      double viewportFraction = 1,

      /// 是否启动循环滚动
      bool enableInfiniteScroll = true,

      /// 有拖拽时不暂停滚动
      bool pauseAutoPlayInFiniteScroll = true,

      /// 是否启用手势
      bool pauseAutoPlayOnTouch = true,
      bool autoPlay = true,
      bool pageSnapping = true,

      /// 播放完成后，暂停播放
      bool enlargeCenterPage = false,
      Axis scrollDirection = Axis.horizontal,
      Duration autoPlayInterval = const Duration(seconds: 2),
      ValueChanged<double?>? onScrolled,
      Curve autoPlayCurve = Curves.linear,
      ScrollPhysics? scrollPhysics,
      super.carouselController,

      /// 滚动间隔时间
      Duration autoPlayAnimationDuration = const Duration(milliseconds: 600),
      Function(int? index, CarouselPageChangedReason reason)? onPageChanged})
      : super.builder(
            options: CarouselOptions(
                height: height,
                pageSnapping: pageSnapping,
                pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
                pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
                initialPage: initialPage,
                autoPlayAnimationDuration: autoPlayAnimationDuration,
                enableInfiniteScroll: enableInfiniteScroll,
                autoPlay: autoPlay,
                scrollDirection: scrollDirection,
                viewportFraction: viewportFraction,
                autoPlayInterval: autoPlayInterval,
                autoPlayCurve: autoPlayCurve,
                scrollPhysics: scrollPhysics,
                onPageChanged: onPageChanged,
                onScrolled: onScrolled,
                enlargeCenterPage: enlargeCenterPage));
}

class MainTabPageBuilder extends StatelessWidget {
  const MainTabPageBuilder(
      {super.key,
      required this.widgets,
      required this.onPageChanged,
      this.controller,
      this.canScroll = true});

  final List<Widget> widgets;
  final ValueCallback<int> onPageChanged;
  final CarouselControllerImpl? controller;
  final bool canScroll;

  @override
  Widget build(BuildContext context) => BasicCarouselSlider(
      autoPlay: false,
      pauseAutoPlayOnTouch: false,
      enableInfiniteScroll: false,
      carouselController: controller,
      pageSnapping: true,
      height: double.infinity,
      scrollPhysics: canScroll
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      onPageChanged: (int? index, CarouselPageChangedReason reason) {
        if (index != null) onPageChanged(index);
      },
      itemBuilder: (_, int index, __) => widgets[index],
      itemCount: widgets.length);
}
