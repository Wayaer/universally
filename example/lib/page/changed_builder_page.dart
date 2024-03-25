import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ChangedBuilderWidgetPage extends StatelessWidget {
  const ChangedBuilderWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'Changed builder widget',
        children: [
          const Partition('Switch'),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            BaseXSwitch(value: false),
            BaseSwitch(value: false),
            BaseSwitch.adaptive(value: false),
          ]),
          const Partition('Checkbox'),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            BaseCheckbox(value: false),
            BaseCheckbox.adaptive(value: false),
          ]),
          const Partition('Slider'),
          BaseSlider(value: 0.5),
          BaseSlider.adaptive(value: 0.7),
        ]);
  }
}
