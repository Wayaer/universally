import 'package:app/page/gif_page.dart';
import 'package:app/page/hive_preferences.dart';
import 'package:app/page/text_field_page.dart';
import 'package:app/page/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:universally/component/src/switch_api.dart';
import 'package:universally/universally.dart';

Future<void> main() async {
  isBeta = true;

  await GlobalConfig().setDefaultConfig(ProjectConfig(
      mainColor: Colors.blueAccent,
      textColor: TextColor(
          largeColor: const Color(0xFF292929),
          veryLargeColor: const Color(0xFF292929),
          defaultColor: const Color(0xFF292929),
          styleColor: const Color(0xFF292929),
          smallColor: const Color(0x804D4D4D)),
      loadingBuilder: (SpinKit loading) => Container(
          width: loading.size * 2,
          height: loading.size * 2,
          decoration: BoxDecoration(
              color: UCS.black, borderRadius: BorderRadius.circular(10)),
          child: BasicLoading(
              color: Colors.white, style: SpinKitStyle.fadingCircle)),
      betaUrl: '这是设置测试url',
      releaseUrl: '这里设置发布版url',
      toastOptions: const ToastOptions(ignoring: false)));

  runApp(BasicApp(
      alertNotNetwork: (ConnectivityResult result) {
        return alertOnlyMessage('Not Network')!;
      },
      showNetworkToast: (ConnectivityResult result) {
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
        }
      },
      providers: [ChangeNotifierProvider(create: (_) => AppState())],
      home: const HomePage(),
      initState: (context, bool network, ConnectivityResult? result) async {}));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        padding: EdgeInsets.fromLTRB(
            15, getStatusBarHeight + 15, 15, getBottomNavigationBarHeight + 15),
        isScroll: true,
        child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              if (isMobile) ...[
                ElevatedText(
                    onPressed: () => push(const FlWebViewPage()),
                    text: 'WebView'),
                ElevatedText(
                    onPressed: () =>
                        push(const FlWebViewPage(isCalculateHeight: true)),
                    text: 'WebView CalculateHeight'),
              ],
              ElevatedText(onPressed: _callPhone, text: 'Call Phone'),
              ElevatedText(
                  onPressed: () {
                    showDoubleChooseAlert(
                        title: 'title', left: 'left', right: 'right');
                  },
                  text: 'showDoubleChooseAlert'),
              ElevatedText(
                  onPressed: () {
                    showUserPrivacyAlert(
                        title: 'Universally',
                        onUserAgreementTap: () {},
                        onPrivacyPolicyTap: () {},
                        onConsentTap: () {});
                  },
                  text: 'showUserPrivacyAlert'),
              ElevatedButton(
                  onPressed: () {}, child: const CleanCache(color: UCS.white)),
              ElevatedButton(
                  onPressed: () {},
                  child: const SwitchApiButton(color: UCS.white)),
              ElevatedText(onPressed: () => push(const GifPage()), text: 'Gif'),
              ElevatedText(
                  onPressed: () => push(const TextFieldPage()),
                  text: 'TextField'),
              ElevatedText(
                  onPressed: () => push(const HivePreferencesPage()),
                  text: 'BHP(BasicHivePreferences)'),
              const PushSwitchState(),
              const ElevatedText(onPressed: showLoading, text: 'showLoading'),
            ]));
  }

  Future<void> _callPhone() async {
    await UrlLauncher().openUrl('tel:10086');
  }
}

class ElevatedText extends StatelessWidget {
  const ElevatedText({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) =>
      ElevatedButton(onPressed: onPressed, child: Text(text));
}

class AppState with ChangeNotifier {}
