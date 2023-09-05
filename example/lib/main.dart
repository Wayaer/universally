import 'package:app/page/basic_list_page.dart';
import 'package:app/page/component_page.dart';
import 'package:app/page/gif_page.dart';
import 'package:app/page/hive_preferences.dart';
import 'package:app/page/text_field_page.dart';
import 'package:flutter/material.dart';
import 'package:universally/dependencies/ios_macos_setting.dart';
import 'package:universally/universally.dart';

import 'page/android_system_setting.dart';

Future<void> main() async {
  isBeta = true;

  await Global().setDefaultConfig(ProjectConfig(
      mainColor: Colors.purple.shade900,
      textColor: TextColor(
          largeColor: const Color(0xFF292929),
          veryLargeColor: const Color(0xFF292929),
          defaultColor: const Color(0xFF292929),
          styleColor: const Color(0xFF292929),
          smallColor: const Color(0x804D4D4D)),
      loadingBuilder: (BasicLoading loading) => Container(
          width: loading.size * 2,
          height: loading.size * 2,
          decoration: BoxDecoration(
              color: UCS.black, borderRadius: BorderRadius.circular(10)),
          child: const BasicLoading(
              color: Colors.white, style: SpinKitStyle.fadingCircle)),
      betaApi: '这是设置测试Api',
      releaseApi: '这里设置发布版Api',
      toastOptions: const ToastOptions(ignoring: false)));
  BasicPackageInfo().initialize();
  runApp(BasicApp(
      title: 'Universally',
      providers: [ChangeNotifierProvider(create: (_) => AppState())],
      home: const HomePage(),
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      initState: (context) async {
        BasicConnectivity().addListener((status, result) async {
          switch (result) {
            case ConnectivityResult.wifi:
              showToast('use wifi');
              break;
            case ConnectivityResult.ethernet:
              showToast('use ethernet');
              break;
            case ConnectivityResult.mobile:
              showToast('use Cellular networks');
              break;
            case ConnectivityResult.none:
              showToast('none networks');
              break;
            case ConnectivityResult.bluetooth:
              showToast('use bluetooth');
              break;
            case ConnectivityResult.vpn:
              showToast('use vpn');
              break;
            case ConnectivityResult.other:
              showToast('use other');
              break;
          }
          return true;
        });
        BasicConnectivity().subscription(
            alertUnavailableNetwork: (status, result) =>
                alertOnlyMessage('Network Unavailable'));
      }));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        padding: EdgeInsets.fromLTRB(15, context.statusBarHeight + 15, 15,
            context.bottomNavigationBarHeight + 15),
        isScroll: true,
        isRootPage: true,
        child: Wrap(alignment: WrapAlignment.center, children: [
          Button(onTap: () => push(const ComponentPage()), text: 'Component'),
          Button(
              onTap: () {
                UrlLauncher().openUrl('tel:10086');
              },
              text: 'Call Phone'),
          Button(onTap: () => push(const GifPage()), text: 'Gif'),
          Button(child: const SwitchApiButton(color: Colors.white)),
          Button(onTap: () => push(const TextFieldPage()), text: 'TextField'),
          Button(onTap: () => push(const BasicListPage()), text: 'BasicList'),
          Button(
              onTap: () => push(const HivePreferencesPage()),
              text: 'BHP(BasicHivePreferences)'),
          Button(
              onTap: () {
                showDoubleChooseAlert(
                    title: 'title', left: 'left', right: 'right');
              },
              text: 'showDoubleChooseAlert'),
          Button(onTap: showLoading, text: 'showLoading'),
          Button(
              onTap: () async {
                final res = await getPermission(
                    Permission.requestInstallPackages,
                    alert: '请求安装app权限');
                showToast(res.toString());
              },
              text: 'requestInstallPackages'),
          Button(
              onTap: () async {
                final res = await getPermission(Permission.camera,
                    alert: '本服务需要访问您的“相机”，以修改头像或上传图片');
                showToast(res.toString());
              },
              text: 'getPermission'),
          Button(
              onTap: () async {
                final res = await getPermissions([
                  Permission.camera,
                  Permission.storage,
                  if (isIOS) Permission.photos
                ], alert: '本服务需要访问您的“相机”和“相册”，以修改头像或上传图片');
                showToast(res.toString());
              },
              text: 'getPermissions'),
          Button(
              onTap: () {
                UrlLauncher().openAppStore(
                    packageName: 'com.tencent.mobileqq',
                    appId: isIOS ? '444934666' : '451108668');
              },
              text: 'openAppStore'),
          Button(
              onTap: () async {
                final result = await UrlLauncher().isInstalledApp(
                    packageName: 'com.tencent.mobileqq',
                    appId: isIOS ? '444934666' : '451108668');
                showToast(result.toString());
              },
              text: 'isInstalledApp'),
          Button(
              onTap: () {
                push(const AndroidSystemSettingPage());
              },
              text: 'AndroidSystemSetting'),
          Button(
              onTap: () {
                UrlLauncher().openUrl(IOSSettingUrl.notifications.value);
              },
              text: 'IOSSystemSetting'),
        ]));
  }
}

class Button extends Universal {
  Button({
    super.key,
    Widget? child,
    String? text,
    super.onTap,
  }) : super(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            margin: const EdgeInsets.all(5),
            heroTag: text,
            child: child ??
                BText(text ?? '', style: const TStyle(color: UCS.white)),
            decoration: BoxDecoration(
                border: Border.all(color: Global().currentColor),
                color: Global().currentColor,
                borderRadius: BorderRadius.circular(8)));
}

class AppState with ChangeNotifier {}
