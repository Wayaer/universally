import 'package:app/main.dart';
import 'package:app/page/plugin/connectivity_plus_page.dart';
import 'package:app/page/plugin/package_info_page.dart';
import 'package:app/page/plugin/path_provider_page.dart';
import 'package:app/page/plugin/permission_page.dart';
import 'package:app/page/plugin/shared_preferences.dart';
import 'package:app/page/plugin/url_lanuncher_page.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

import 'device_info_page.dart';

class PluginPage extends StatelessWidget {
  const PluginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'Universally',
      safeBottom: true,
      padding: EdgeInsets.all(10),
      isScroll: true,
      children: [
        if (isMobile)
          Button(onTap: () => push(const PermissionPage()), text: 'Permission'),
        Button(
          onTap: () => push(const ConnectivityPlusPage()),
          text: 'ConnectivityPlus',
        ),
        Button(onTap: () => push(const UrlLauncherPage()), text: 'UrlLauncher'),
        Button(
          onTap: () => push(const PathProviderPage()),
          text: 'PathProvider',
        ),
        Button(onTap: () => push(const DeviceInfoPage()), text: 'DeviceInfo'),
        Button(onTap: () => push(const PackageInfoPage()), text: 'PackageInfo'),
        Button(
          onTap: () => push(const SharedPreferencesPage()),
          text: 'SharedPreferences',
        ),
      ],
    );
  }
}
