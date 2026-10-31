import 'package:app/page/plugin/android_intent_page.dart';
import 'package:app/page/plugin/connectivity_plus_page.dart';
import 'package:app/page/plugin/device_info_page.dart';
import 'package:app/page/plugin/package_info_page.dart';
import 'package:app/page/plugin/path_provider_page.dart';
import 'package:app/page/plugin/permission_page.dart';
import 'package:app/page/plugin/shared_preferences_page.dart';
import 'package:app/page/plugin/url_launcher_page.dart';
import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PluginPage extends StatelessWidget {
  const PluginPage({super.key});

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: '原生插件',
    children: [
      DemoSection(
        title: '插件列表',
        description: '所有插件均已更新到最新版本，并通过 universally 统一导出与封装。',
        children: [
          DemoButton(text: '设备信息 DeviceInfoPlus', icon: Icons.phone_android, onTap: () => push(const DeviceInfoPage())),
          DemoButton(text: '包信息 PackageInfoPlus', icon: Icons.info_outline, onTap: () => push(const PackageInfoPage())),
          DemoButton(text: '网络状态 ConnectivityPlus', icon: Icons.wifi, onTap: () => push(const ConnectivityPlusPage())),
          DemoButton(text: '路径 PathProvider', icon: Icons.folder, onTap: () => push(const PathProviderPage())),
          DemoButton(text: '权限 Permission', icon: Icons.security, onTap: () => push(const PermissionPage())),
          DemoButton(
            text: '本地存储 BasePreferences',
            icon: Icons.storage,
            onTap: () => push(const SharedPreferencesPage()),
          ),
          DemoButton(text: 'URL 与商店 UrlLauncher', icon: Icons.link, onTap: () => push(const UrlLauncherPage())),
          DemoButton(text: 'Android Intent', icon: Icons.android, onTap: () => push(const AndroidIntentPage())),
        ],
      ),
    ],
  );
}
