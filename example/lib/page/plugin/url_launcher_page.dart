import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class UrlLauncherPage extends StatelessWidget {
  const UrlLauncherPage({super.key});

  Future<void> toast(Future<bool> future) async {
    final bool result = await future;
    showToast('结果：$result');
  }

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: 'URL 与商店',
    children: [
      DemoSection(
        title: 'UrlLauncher',
        description: '封装 url_launcher，支持网页、电话、短信、应用商店与第三方应用。',
        children: [
          DemoButton(text: 'openUrl', onTap: () => toast(UrlLauncher().openUrl('https://flutter.dev'))),
          DemoButton(text: 'openUri', onTap: () => toast(UrlLauncher().openUri(Uri.parse('https://pub.dev')))),
          DemoButton(
            text: 'canLaunch',
            onTap: () async =>
                showToast('canLaunch: ${await UrlLauncher().canLaunch(Uri.parse('https://flutter.dev'))}'),
          ),
          DemoButton(text: 'openPhone', onTap: () => toast(UrlLauncher().openPhone('10086'))),
          DemoButton(text: 'openSMS', onTap: () => toast(UrlLauncher().openSMS('10086'))),
          DemoButton(
            text: 'supports / supportsClose',
            onTap: () async {
              final bool supports = await UrlLauncher().supports(LaunchMode.inAppBrowserView);
              final bool close = await UrlLauncher().supportsClose(LaunchMode.inAppBrowserView);
              showToast('supports: $supports / supportsClose: $close');
            },
          ),
          DemoButton(
            text: 'openAppStore',
            onTap: () => toast(
              UrlLauncher().openAppStore(
                packageName: 'com.tencent.mm',
                appId: '414478124',
                bundleName: 'com.tencent.wechat',
              ),
            ),
          ),
          DemoButton(
            text: 'closeWebView',
            onTap: () async {
              await UrlLauncher().closeWebView();
              showToast('已尝试关闭内嵌 WebView');
            },
          ),
          DemoButton(
            text: 'closeWebView',
            onTap: () async {
              await UrlLauncher().closeWebView();
              showToast('已尝试关闭内嵌 WebView');
            },
          ),
          DemoButton(
            text: 'isInstalledApp',
            onTap: () async {
              final bool result = await UrlLauncher().isInstalledApp(
                packageName: 'com.tencent.mm',
                scheme: 'weixin://',
                bundleName: 'com.tencent.wechat',
              );
              showToast('isInstalledApp: $result');
            },
          ),
          DemoButton(
            text: 'launchOtherApp',
            onTap: () async {
              final bool result = await UrlLauncher().launchOtherApp(
                name: '微信',
                androidSchemes: 'weixin://',
                androidPackageName: 'com.tencent.mm',
                iosSchemes: 'weixin://',
                iosAppId: '414478124',
                harmonyBundleName: 'com.tencent.wechat',
              );
              showToast('launchOtherApp: $result');
            },
          ),
        ],
      ),
    ],
  );
}
