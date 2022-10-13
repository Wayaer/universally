import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        padding: const EdgeInsets.all(12),
        appBarTitle: 'TextField',
        children: [
          const SizedBox(height: 20),
          TextLarge('旧版'),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          TextLarge('新版'),
          const SizedBox(height: 20),
          BasicTextField(
            borderStyle: InputBorderStyle(borderType: BorderType.outline),
            enableClearIcon: true,
            enableEye: true,
            fillColor: Colors.red,
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
