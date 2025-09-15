import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class AndroidSystemSettingPage extends StatelessWidget {
  const AndroidSystemSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'AndroidSystemSetting',
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        children: SettingIntent.values.builder(
          (item) => Button(
            onTap: () {
              AndroidSystemSettingIntent(item, package: PackageInfoPlus().packageName).launch();
            },
            text: item.name,
          ),
        ),
      ),
    );
  }
}
