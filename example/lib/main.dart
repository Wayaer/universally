import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

import 'page/webview_page.dart';

Future<void> main() async {
  isBeta = true;

  /// The first step
  await GlobalConfig().startMain(toastIgnoring: false);

  /// The second step
  GlobalConfig().setAppConfig(
      mainColor: Colors.blueAccent, releaseBaseUrl: '', betaBaseUrl: '');

  runApp(BaseApp(
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
            break;
        }
      },
      providers: [ChangeNotifierProvider(create: (_) => AppState())],
      home: const HomePage(),
      consumer: (Widget child) {
        return child;
      },
      initState: (bool network, ConnectivityResult? result) async {
        final appPath = await Curiosity().native.appPath;

        /// The third step
        GlobalConfig().initConfig(appPath: appPath!);
      }));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        padding: EdgeInsets.fromLTRB(
            15, getStatusBarHeight + 15, 15, getBottomNavigationBarHeight + 15),
        isScroll: true,
        child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: <Widget>[
              ElevatedText(onPressed: _callPhone, text: 'Call Phone'),
              if (isMobile) ...[
                ElevatedText(
                    onPressed: () => push(const FlWebViewPage()),
                    text: 'WebView'),
                ElevatedText(
                    onPressed: () =>
                        push(const FlWebViewPage(isCalculateHeight: true)),
                    text: 'WebView CalculateHeight'),
              ],
              ElevatedButton(
                  onPressed: () {}, child: const CleanCache(color: UCS.white)),
            ]));
  }

  Future<void> _callPhone() async {
    await openUrl('tel:10086');
  }
}

class ElevatedText extends StatelessWidget {
  const ElevatedText({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) =>
      ElevatedButton(onPressed: onPressed, child: Text(text));
}

class AppState with ChangeNotifier {}
