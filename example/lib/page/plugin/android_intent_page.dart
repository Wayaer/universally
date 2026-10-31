import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class AndroidIntentPage extends StatelessWidget {
  const AndroidIntentPage({super.key});

  Future<void> launchIntent(AndroidIntent intent) async {
    if (!isAndroid) {
      showToast('仅 Android 支持');
      return;
    }
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: 'Android Intent',
    children: [
      DemoSection(
        title: 'AndroidSystemSettingIntent',
        description: '跳转 Android 系统设置页面，设置项由 SettingIntent 枚举定义。',
        children: [
          for (final SettingIntent intent in SettingIntent.values)
            DemoButton(
              text: intent.name,
              onTap: () => launchIntent(AndroidSystemSettingIntent(intent, package: PackageInfoPlus().packageName)),
            ),
        ],
      ),
      DemoSection(
        title: 'AndroidAppMarketIntent',
        description: '跳转 Android 应用市场详情页。',
        children: [
          DemoButton(
            text: '打开应用市场',
            onTap: () => launchIntent(AndroidAppMarketIntent(packageName: PackageInfoPlus().packageName)),
          ),
          DemoButton(
            text: '指定应用市场',
            onTap: () => launchIntent(
              AndroidAppMarketIntent(
                packageName: PackageInfoPlus().packageName,
                package: 'com.tencent.android.qqdownloader',
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
