import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        onWillPopOverlayClose: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'TextField',
        children: [
          const SizedBox(height: 20),
          TextLarge('新版'),
          const SizedBox(height: 20),
          BasicTextField(
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
          BasicTextField(
              hintText: '请输入',
              enableClearIcon: true,
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
