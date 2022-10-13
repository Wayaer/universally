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
              hintText: '请输入',
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
            hintText: '请输入',
            enableClearIcon: true,
            enableEye: true,
            borderType: BorderType.outline,
            borderRadius: BorderRadius.circular(4),
            fillColor: Colors.red.withOpacity(0.2),
            enableSearchIcon: true,
            searchTextMode: AccessoryMode.inner,
            sendSMSMode: AccessoryMode.inner,
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
