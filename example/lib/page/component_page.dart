import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBarTitleText: 'Component',
        isScroll: true,
        children: [
          UserPrivacyCheckbox(value: false),
          10.heightBox,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextNormal('消息推送'),
            10.widthBox,
            const PushSwitchState(),
          ]),
          10.heightBox,
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextNormal('清理缓存'), 10.widthBox, const CleanCache()]),
          10.heightBox,
          const BaseError(),
        ]);
  }
}
