import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

const List<Color> colorList = <Color>[
  ...Colors.accents,
  ...Colors.primaries,
];

class CarouselSliderPage extends StatelessWidget {
  const CarouselSliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselSliderController controllerBuilder = CarouselSliderController();
    CarouselSliderController controllerItems = CarouselSliderController();
    return BaseScaffold(
        isScroll: true,
        appBarTitleText: 'CarouselSlider',
        children: [
          const Partition('CarouselSliderController', marginTop: 0),
          Wrap(children: [
            Button(
                text: 'nextPage',
                onTap: () {
                  controllerBuilder.nextPage();
                  controllerItems.nextPage();
                }),
            Button(
                text: 'previousPage',
                onTap: () {
                  controllerBuilder.previousPage();
                  controllerItems.previousPage();
                }),
            Button(
                text: 'jumpToPage 6',
                onTap: () {
                  controllerBuilder.jumpToPage(6);
                  controllerItems.jumpToPage(6);
                }),
            Button(
                text: 'animateToPage 12',
                onTap: () {
                  controllerBuilder.animateToPage(12);
                  controllerItems.animateToPage(12);
                }),
            Button(
                text: 'startAutoPlay',
                onTap: () {
                  controllerBuilder.startAutoPlay();
                  controllerItems.startAutoPlay();
                }),
            Button(
                text: 'stopAutoPlay',
                onTap: () {
                  controllerBuilder.stopAutoPlay();
                  controllerItems.stopAutoPlay();
                }),
          ]),
          const Partition('CarouselSlider.builder'),
          CarouselSlider.builder(
              controller: controllerBuilder,
              options: const CarouselSliderOptions(
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  autoPlay: true,
                  enlargeCenterPage: true),
              itemCount: colorList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) =>
                  Container(
                      color: colorList[index],
                      alignment: Alignment.center,
                      child: Text('$index'))),
          const Partition('CarouselSlider.items'),
          CarouselSlider.items(
              controller: controllerItems,
              options: const CarouselSliderOptions(
                  autoPlay: true, enlargeCenterPage: true),
              items: colorList.generate((int index) => Container(
                  color: colorList[index],
                  alignment: Alignment.center,
                  child: Text('$index')))),
        ]);
  }
}
