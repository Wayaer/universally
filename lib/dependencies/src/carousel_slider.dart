import 'package:carousel_slider/carousel_slider.dart';
import 'package:universally/universally.dart';
import 'package:flutter/material.dart';

class BaseIndicator extends Indicator {
  BaseIndicator(
      {Key? key,
      required int count,
      required double position,
      required int index,
      Color? activeColor})
      : super(
            key: key,
            size: 8,
            layout: IndicatorType.scale,
            count: count,
            position: position,
            color: UCS.background,
            activeColor: activeColor ?? GlobalConfig().currentColor,
            index: index);
}

class BaseCarouselSlider extends CarouselSlider {
  BaseCarouselSlider(
      {Key? key,
      required ExtendedIndexedWidgetBuilder itemBuilder,
      required int itemCount,
      double? height = 40,
      int initialPage = 0,
      double viewportFraction = 1,
      bool enableInfiniteScroll = true,
      // 有拖拽时不暂停滚动
      bool pauseAutoPlayInFiniteScroll = true,
      // 是否启用手势
      bool pauseAutoPlayOnTouch = true,
      bool autoPlay = true,
      bool pageSnapping = true,
      // 播放完成后，暂停播放
      bool enlargeCenterPage = false,
      Axis scrollDirection = Axis.horizontal,
      Duration autoPlayInterval = const Duration(seconds: 2),
      ValueChanged<double?>? onScrolled,
      Curve autoPlayCurve = Curves.linear,
      ScrollPhysics? scrollPhysics,
      CarouselControllerImpl? controller,

      /// 滚动间隔时间
      Duration autoPlayAnimationDuration = const Duration(milliseconds: 600),
      Function(int? index, CarouselPageChangedReason reason)? onPageChanged})
      : super.builder(
            key: key,
            itemBuilder: itemBuilder,
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
      {Key? key,
      required this.widgets,
      required this.onPageChanged,
      this.controller,
      this.canScroll = true})
      : super(key: key);
  final List<Widget> widgets;
  final ValueCallback<int> onPageChanged;
  final CarouselControllerImpl? controller;
  final bool canScroll;

  @override
  Widget build(BuildContext context) => BaseCarouselSlider(
      autoPlay: false,
      pauseAutoPlayOnTouch: false,
      enableInfiniteScroll: false,
      controller: controller,
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
