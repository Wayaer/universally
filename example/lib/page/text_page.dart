import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'Texts',
      safeBottom: true,
      padding: const EdgeInsets.only(bottom: 20),
      spacing: 20,
      children: [
        Button(onTap: () => push(const RowTextLayoutPage()), text: 'RowTextLayoutBuilder'),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Partition('默认不加属性', marginTop: 0),
                const BaseText('BaseText'),
                BaseText.richText(texts: ['Text', '*', 'rich']),
                const TextSmall('TextSmall'),
                const TextMedium('TextMedium'),
                const TextLarge('TextLarge'),
                const Partition('UsePrimaryColor', textFontSize: TextFontSize.extraSmall),
                const TextLarge('TextLarge', usePrimaryColor: true),
                Text('TStyle', style: TStyle.small),
                const SizedBox(),
              ],
            ).expanded,
            Container(height: double.infinity, color: context.theme.dividerColor, width: 1),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Partition('外层覆盖默认', marginTop: 0),
                const BaseText('BaseText', color: Colors.blue),
                BaseText.richText(
                  color: Colors.blue,
                  texts: ['Text', '*', 'rich'],
                  styles: [
                    TStyle(color: Colors.green),
                    TStyle(color: Colors.yellow),
                  ],
                ),
                const TextSmall('TextSmall', color: Colors.blue),
                const TextMedium('TextMedium', color: Colors.blue),
                const TextLarge('TextLarge', color: Colors.blue),
                const Partition('UsePrimaryColor', textFontSize: TextFontSize.extraSmall),
                const TextMedium('TextMedium', usePrimaryColor: true, color: Colors.blue),
                Text('TStyle', style: TStyle.medium),
                const SizedBox(),
              ],
            ).expanded,
            Container(height: double.infinity, color: context.theme.dividerColor, width: 1),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Partition('style覆盖外层', marginTop: 0),
                const BaseText(
                  'BaseText',
                  useStyleFirst: true,
                  color: Colors.blue,
                  style: TStyle(color: Colors.red),
                ),
                BaseText.richText(
                  useStyleFirst: true,
                  color: Colors.blue,
                  style: TStyle(color: Colors.red),
                  texts: ['Text', '*', 'rich'],
                  styles: [
                    TStyle(color: Colors.green),
                    TStyle(color: Colors.yellow),
                  ],
                ),
                const TextSmall(
                  'TextSmall',
                  useStyleFirst: true,
                  color: Colors.blue,
                  style: TStyle(color: Colors.red),
                ),
                const TextMedium(
                  'TextMedium',
                  useStyleFirst: true,
                  color: Colors.blue,
                  style: TStyle(color: Colors.red),
                ),
                const TextLarge(
                  'TextLarge',
                  useStyleFirst: true,
                  color: Colors.blue,
                  style: TStyle(color: Colors.red),
                ),
                const Partition('UsePrimaryColor', textFontSize: TextFontSize.extraSmall),
                const TextSmall(
                  'TextSmall',
                  usePrimaryColor: true,
                  color: Colors.blue,
                  style: TStyle(color: Colors.red),
                ),
                Text('TStyle', style: TStyle.large),
                const SizedBox(),
              ],
            ).expanded,
          ],
        ).expanded,
      ],
    );
  }
}

class RowTextLayoutPage extends StatelessWidget {
  const RowTextLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final long = '这段文本比较长需要换行,需要占用更多的位置';
    final short = '这段文本比较短';
    return BaseScaffold(
      appBarTitleText: 'RowTextLayoutBuilder',
      safeBottom: true,
      spacing: 20,
      isScroll: true,
      padding: EdgeInsets.all(20),
      children: [buildRow(long, short), buildRow(short, long), buildRow(long, long), buildRow(short, short)],
    );
  }

  Widget buildRow(String leading, String trailing) => RowTextLayoutBuilder(
    leading: [
      TextSpan(
        text: leading,
        style: TStyle.large.copyWith(color: Colors.red),
      ),
    ],
    trailing: [
      TextSpan(
        text: trailing,
        style: TStyle.large.copyWith(color: Colors.blue),
      ),
    ],
    spacing: 4,
    excludeLeadingSpacing: 18,
    excludeTrailingSpacing: 18,
    builder: (leading, leadingBuilder, trailing, trailingBuilder) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 4,
        children: [
          leadingBuilder(FlText.richSpans([...leading, WidgetSpan(child: Icon(Icons.ac_unit, size: 18))])),
          trailingBuilder(
            FlText.richSpans([...trailing, WidgetSpan(child: Icon(Icons.ac_unit, size: 18))], textAlign: TextAlign.end),
          ),
        ],
      );
    },
  );
}
