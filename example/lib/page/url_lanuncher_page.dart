import 'package:app/main.dart';
import 'package:app/page/android_system_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class UrlLauncherPage extends StatelessWidget {
  const UrlLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isScroll: true,
      padding: const EdgeInsets.all(12),
      appBarTitleText: 'UrlLauncher',
      children: [...buildMobile, ...buildAndroid, ...buildIOS],
    );
  }

  List<Widget> get buildMobile =>
      !isWeb && isMobile
          ? [
            Button(
              onTap: () {
                UrlLauncher().openUrl('tel:10086');
              },
              text: 'Call 10086',
            ),
            Button(
              onTap: () {
                UrlLauncher().openAppStore(
                  packageName: 'com.tencent.mobileqq',
                  appId: isIOS ? '444934666' : '451108668',
                );
              },
              text: 'openAppStore',
            ),
            Button(
              onTap: () {
                UrlLauncher().launchOtherApp(
                  androidPackageName: 'com.tencent.mobileqq',
                  androidSchemes: 'mqq://',
                  extraAndroidPackageName: 'com.tencent.tim',
                  iosAppId: '444934666',
                  iosSchemes: 'mqq://',
                  name: 'QQ',
                );
              },
              text: 'openQQ',
            ),
          ]
          : [];

  List<Widget> get buildAndroid =>
      !isWeb && isAndroid
          ? [
            Button(
              onTap: () async {
                final result = await UrlLauncher().isInstalledApp(
                  packageName: 'com.tencent.mobileqq',
                );
                showToast(result.toString());
              },
              text: 'isInstalledApp (QQ)',
            ),
            Button(
              onTap: () {
                push(const AndroidSystemSettingPage());
              },
              text: 'AndroidSystemSetting',
            ),
          ]
          : [];

  List<Widget> get buildIOS =>
      !isWeb && isIOS
          ? [
            Button(
              onTap: () {
                UrlLauncher().openUrl(IOSSettingUrl.app.url);
              },
              text: 'IOSSystemSetting for current',
            ),
            Button(
              onTap: () {
                UrlLauncher().openUrl(IOSSettingUrl.notifications.url);
              },
              text: 'IOSSystemSetting - notifications',
            ),
          ]
          : [];
}
