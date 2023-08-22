import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        appBarTitleText: 'Component',
        isScroll: true,
        children: [
          CheckboxWithUserPrivacy(value: false),
          10.heightBox,
          Button(
              text: 'showUserPrivacyAlert',
              onTap: () {
                BHP().setBool(UConst.privacy, false);
                showUserPrivacyAlert(
                    name: 'Universally',
                    onUserAgreementTap: () {},
                    onPrivacyPolicyTap: () {},
                    onConsentTap: () {});
              }),
          10.heightBox,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextDefault('消息推送'),
            10.widthBox,
            const PushSwitchState(),
          ]),
          10.heightBox,
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextDefault('清理缓存'), 10.widthBox, const CleanCache()]),
          10.heightBox,
          const BasicError(),
        ]);
  }
}
