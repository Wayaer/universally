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
            const BaseText('BaseText'),
            const BaseText.rich(text: 'Base', texts: ['Text', '*', 'rich']),
            const TextSmall('TextSmall'),
            const TextNormal('TextNormal'),
            const TextLarge('TextLarge'),
            const Partition('UsePrimaryColor',
                textFontSize: TextFontSize.smallest),
            const TextLarge('TextLarge', usePrimaryColor: true),
            Text('TStyle', style: TStyle.small),
            const SizedBox()
          ]).expanded,
          Container(
              height: double.infinity,
              color: context.theme.dividerColor,
              width: 1),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Partition('外层覆盖默认'),
            const BaseText('BaseText', color: Colors.blue),
            const BaseText.rich(text: 'Base', color: Colors.blue, texts: [
              'Text',
              '*',
              'rich'
            ], styles: [
              TStyle(color: Colors.green),
              TStyle(color: Colors.yellow),
            ]),
            const TextSmall('TextSmall', color: Colors.blue),
            const TextNormal('TextNormal', color: Colors.blue),
            const TextLarge('TextLarge', color: Colors.blue),
            const Partition('UsePrimaryColor',
                textFontSize: TextFontSize.smallest),
            const TextNormal('TextNormal',
                usePrimaryColor: true, color: Colors.blue),
            Text('TStyle', style: TStyle.medium),
            const SizedBox()
          ]).expanded,
          Container(
              height: double.infinity,
              color: context.theme.dividerColor,
              width: 1),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Partition('style覆盖外层'),
            const BaseText('BaseText',
                useStyleFirst: true,
                color: Colors.blue,
                style: TStyle(color: Colors.red)),
            const BaseText.rich(
                useStyleFirst: true,
                color: Colors.blue,
                text: 'Base',
                style: TStyle(color: Colors.red),
                texts: [
                  'Text',
                  '*',
                  'rich'
                ],
                styles: [
                  TStyle(color: Colors.green),
                  TStyle(color: Colors.yellow),
                ]),
            const TextSmall('TextSmall',
                useStyleFirst: true,
                color: Colors.blue,
                style: TStyle(color: Colors.red)),
            const TextNormal('TextNormal',
                useStyleFirst: true,
                color: Colors.blue,
                style: TStyle(color: Colors.red)),
            const TextLarge('TextLarge',
                useStyleFirst: true,
                color: Colors.blue,
                style: TStyle(color: Colors.red)),
            const Partition('UsePrimaryColor',
                textFontSize: TextFontSize.smallest),
            const TextSmall('TextSmall',
                usePrimaryColor: true,
                color: Colors.blue,
                style: TStyle(color: Colors.red)),
            Text('TStyle', style: TStyle.large),
            const SizedBox()
          ]).expanded,
        ]);
  }
}
