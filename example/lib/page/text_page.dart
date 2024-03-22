import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBarTitleText: 'Texts',
        direction: Axis.horizontal,
        safeBottom: true,
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Partition('默认不加属性'),
            TextSmall('TextSmall'),
            TextNormal('TextNormal'),
            TextLarge('TextLarge'),
            TextExtraLarge('TextExtraLarge'),
            const Text('TStyle', style: TStyle()),
          ]).expanded,
          Container(
              height: double.infinity,
              color: context.theme.dividerColor,
              width: 1),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Partition('外层覆盖默认'),
            TextSmall('TextSmall', color: Colors.black),
            TextNormal('TextNormal', color: Colors.black),
            TextLarge('TextLarge', color: Colors.black),
            TextExtraLarge('TextExtraLarge', color: Colors.black),
            const Text('TStyle', style: TStyle(color: Colors.black)),
          ]).expanded,
          Container(
              height: double.infinity,
              color: context.theme.dividerColor,
              width: 1),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Partition('style覆盖外层'),
            TextSmall('TextSmall', style: const TStyle(color: Colors.blue)),
            TextNormal('TextNormal', style: const TStyle(color: Colors.blue)),
            TextLarge('TextLarge', style: const TStyle(color: Colors.blue)),
            TextExtraLarge('TextExtraLarge',
                style: const TStyle(color: Colors.blue)),
            const Text('TStyle', style: TStyle(color: Colors.blue)),
          ]).expanded,
        ]);
  }
}
