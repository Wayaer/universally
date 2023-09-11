import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class AndroidSystemSettingPage extends StatelessWidget {
  const AndroidSystemSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBarTitleText: 'BaseList',
        child: Wrap(
            alignment: WrapAlignment.center,
            children: SettingIntent.values.builder(
              (item) => Button(
                  onTap: () {
                    AndroidSystemSettingIntent(item,
                            package: BasePackageInfo().packageName)
                        .launch();
                  },
                  text: item.name),
            )));
  }
}
