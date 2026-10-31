import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'Component',
      isScroll: true,
      spacing: 6,
      children: [
        Partition('BaseCheckbox'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BaseCheckbox(tristate: true, onChanged: (value) {}),
            BaseCheckbox.adaptive(
              tristate: true,
              onWaitChanged: (value) async {
                await Future.delayed(const Duration(seconds: 1));
                return value;
              },
            ),
          ],
        ),
        Partition('BaseSwitch'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BaseSwitch(value: false, onChanged: (value) {}),
            BaseSwitch(
              value: false,
              onWaitChanged: (value) async {
                await Future.delayed(const Duration(seconds: 1));
                showToast('$value');
                return value;
              },
            ),
          ],
        ),
        Partition('BaseXSwitch'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BaseXSwitch(value: false, onChanged: (value) {}),
            BaseXSwitch(
              value: false,
              onWaitChanged: (value) async {
                await Future.delayed(const Duration(seconds: 1));
                return value;
              },
            ),
          ],
        ),
        Partition('BaseCupertinoSwitch'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BaseCupertinoSwitch(value: false, onChanged: (value) {}),
            BaseCupertinoSwitch(
              value: false,
              onWaitChanged: (value) async {
                await Future.delayed(const Duration(seconds: 1));
                return value;
              },
            ),
          ],
        ),
        Partition('BaseSlider'),
        Column(
          children: [
            BaseSlider(value: 0, onChanged: (value) {}),
            BaseSlider(
              value: 0,
              onWaitChanged: (value) async {
                await Future.delayed(const Duration(seconds: 1));
                return value;
              },
            ),
          ],
        ),
        UserPrivacyCheckbox(value: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const TextMedium('消息推送'), 10.widthBox, const PushSwitchState()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const TextMedium('清理缓存'), 10.widthBox, const CleanCache()],
        ),
        const BaseError(),
      ],
    );
  }
}
