import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        padding: const EdgeInsets.all(12),
        appBarTitle: 'TextField',
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          TextLarge('旧版'),
          InputText(
              eyeEnabled: true,
              searchEnabled: true,
              clearEnabled: true,
              extraSearchText: false,
              extraSendSMS: false,
              borderType: BorderType.outline,
              searchTextTap: (String value) {},
              sendSMSTap: (send) async {
                await 1.seconds.delayed();
                send(true);
              }),
          TextLarge('新版'),
          BasicTextField(
            enableClearIcon: true,
            enableEye: true,
            enableSearchIcon: true,
            searchTextTap: (String value) {},
            sendSMSTap: (send) async {
              await 1.seconds.delayed();
              send(true);
            },
          ).setWidth(double.infinity),
          const SizedBox(),
        ]);
  }
}
