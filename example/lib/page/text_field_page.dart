import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'TextField',
        children: [
          const SizedBox(height: 20),
          BaseTextField(
              hintText: '请输入',
              enableClearIcon: true,
              enableEye: true,
              borderType: BorderType.underline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              enableSearchIcon: true,
              searchTextTap: (String value) {},
              sendSMSTap: (send) async {
                await 1.seconds.delayed();
                send(true);
              }),
          const SizedBox(height: 20),
          BaseTextField(
              hintText: '请输入',
              enableClearIcon: true,
              sendSMSTextBuilder: (SendState state, int i) {
                switch (state) {
                  case SendState.none:
                    return TextNormal('发送验证码', color: Universally().mainColor);
                  case SendState.sending:
                    return TextNormal('发送中', color: Universally().mainColor);
                  case SendState.resend:
                    return TextNormal('重新发送', color: Universally().mainColor);
                  case SendState.countDown:
                    return TextNormal('$i s', color: Universally().mainColor);
                }
              },
              enableEye: true,
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              enableSearchIcon: true,
              searchTextTap: (String value) {},
              sendSMSTap: (send) async {
                await 1.seconds.delayed();
                send(true);
              }),
          const SizedBox(),
        ]);
  }
}
