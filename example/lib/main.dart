import 'package:app/page/carousel_slider_page.dart';
import 'package:app/page/overlay_page.dart';
import 'package:app/page/base_list_page.dart';
import 'package:app/page/changed_builder_page.dart';
import 'package:app/page/component_page.dart';
import 'package:app/page/dialog_page.dart';
import 'package:app/page/gif_page.dart';
import 'package:app/page/hive_preferences.dart';
import 'package:app/page/permission_page.dart';
import 'package:app/page/picker_page.dart';
import 'package:app/page/progress_indicator_page.dart';
import 'package:app/page/spin_kit_page.dart';
import 'package:app/page/tab_bar.dart';
import 'package:app/page/text_field_page.dart';
import 'package:app/page/text_page.dart';
import 'package:app/page/url_lanuncher_page.dart';
import 'package:app/theme.dart';
import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universally/universally.dart';

import 'page/lucky_draw_page.dart';

Future<void> main() async {
  isBeta = true;
  await Universally().setConfig(
      UConfig(
        isCloseOverlay: false,
        betaApi: '这是设置测试Api',
        releaseApi: '这里设置发布版Api',
      ),
      windowOptions: WindowOptions(
          size: WindowsSize.iPhone5P8.value,
          minimumSize: WindowsSize.iPhone4P7.value,
          maximumSize: WindowsSize.iPhone6P1.value,
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          title: 'Universally'));
  PackageInfoPlus().initialize();
  runApp(DevicePreview(
      enabled: isDesktop || isWeb,
      defaultDevice: Devices.ios.iPhone13Mini,
      builder: (context) => const _App()));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AppState())],
        child: BaseMaterialApp(
            title: 'Universally',
            home: const HomePage(),
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            darkTheme: darkTheme,
            theme: lightTheme,
            initState: (context) async {
              ConnectivityPlus().addListener((status, result) async {
                switch (result.first) {
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
            }));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBarTitleText: 'Universally',
        safeBottom: true,
        enableDoubleClickExit: true,
        isScroll: true,
        padding: EdgeInsets.all(10),
        child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 12,
            spacing: 12,
            children: [
              ...UnifiedButtonCategory.values
                  .builder((e) => SwitchApiButton(unifiedButtonCategory: e)),
              SizedBox(width: double.infinity),
              Button(onTap: () => push(const TextPage()), text: 'Text'),
              Button(
                  onTap: () => push(const ComponentPage()), text: 'Component'),
              Button(onTap: () => push(const GifPage()), text: 'Gif'),
              Button(
                  onTap: () => push(const TextFieldPage()), text: 'TextField'),
              Button(onTap: () => push(const BaseListPage()), text: 'BaseList'),
              Button(
                  onTap: () => push(const BaseTabBarPage()),
                  text: 'BaseTabBar'),
              Button(onTap: () => push(const PickerPage()), text: 'Picker'),
              Button(onTap: () => push(const DialogPage()), text: 'Dialog'),
              Button(onTap: () => push(const OverlayPage()), text: 'Overlay'),
              Button(
                  onTap: () => push(const PermissionPage()),
                  text: 'Permission'),
              Button(
                  onTap: () => push(const UrlLauncherPage()),
                  text: 'UrlLauncher'),
              Button(
                  onTap: () => push(const ProgressIndicatorPage()),
                  text: 'ProgressIndicator'),
              Button(
                  onTap: () => push(const CarouselSliderPage()),
                  text: 'CarouselSlider'),
              Button(
                  onTap: () => push(const ChangedBuilderWidgetPage()),
                  text: 'ChangedBuilder'),
              Button(
                  onTap: () => push(const HivePreferencesPage()),
                  text: 'BasePreferences'),
              Button(
                  onTap: () {
                    push(const SpinKitPage());
                  },
                  text: 'SpinKit'),
              Button(onTap: pushLuckyDrawPage, text: 'LuckyDraw'),
            ]));
  }
}

class Button extends StatelessWidget {
  const Button({super.key, this.child, this.text, this.onTap});

  final Widget? child;
  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Universal(
        onPressed: onTap,
        unifiedButtonCategory: UnifiedButtonCategory.elevated,
        child: child ?? Text(text ?? '', textAlign: TextAlign.center));
  }
}

class Partition extends StatelessWidget {
  const Partition(this.title,
      {super.key,
      this.onTap,
      this.textFontSize = TextFontSize.normal,
      this.marginTop = 20});

  final String title;
  final GestureTapCallback? onTap;
  final TextFontSize textFontSize;
  final double marginTop;

  @override
  Widget build(BuildContext context) => Universal(
      onTap: onTap,
      width: double.infinity,
      color: Colors.grey.withValues(alpha: 0.2),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(top: marginTop, bottom: 20),
      child: BaseText(title,
          textFontSize: textFontSize,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold));
}

class AppState with ChangeNotifier {}
