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
          const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Partition('默认不加属性'),
                TextSmall('TextSmall'),
                TextNormal('TextNormal'),
                TextLarge('TextLarge'),
                BaseText('BaseText'),
                Text('TStyle', style: TStyle()),
                SizedBox()
              ]).expanded,
          Container(
              height: double.infinity,
              color: context.theme.dividerColor,
              width: 1),
          const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Partition('外层覆盖默认'),
                TextSmall('TextSmall', color: Colors.red),
                TextNormal('TextNormal', color: Colors.red),
                TextLarge('TextLarge', color: Colors.red),
                BaseText('BaseText', color: Colors.red),
                Text('TStyle', style: TStyle(color: Colors.red)),
                SizedBox()
              ]).expanded,
          Container(
              height: double.infinity,
              color: context.theme.dividerColor,
              width: 1),
          const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Partition('style覆盖外层'),
                TextSmall('TextSmall',
                    color: Colors.blue, style: TStyle(color: Colors.red)),
                TextNormal('TextNormal',
                    color: Colors.blue, style: TStyle(color: Colors.red)),
                TextLarge('TextLarge',
                    color: Colors.blue, style: TStyle(color: Colors.red)),
                BaseText('BaseText',
                    color: Colors.blue,
                    usePrimaryColor: true,
                    style: TStyle(color: Colors.red)),
                Text('TStyle', style: TStyle(color: Colors.blue)),
                SizedBox()
              ]).expanded,
        ]);
  }
}
