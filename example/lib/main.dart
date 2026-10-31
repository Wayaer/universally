import 'package:app/page/home_page.dart';
import 'package:app/theme.dart';
import 'package:app/utils/demo.dart';
import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isBeta = true;
  await Universally().setConfig(
    UConfig(
      betaApi: 'https://beta.example.com',
      releaseApi: 'https://api.example.com',
      logCrossLine: true,
      toastOptions: const ToastOptions(alignment: Alignment.center),
    ),
    windowOptions: WindowOptions(
      size: WindowsSize.iPhone5P8.value,
      minimumSize: WindowsSize.iPhone4P7.value,
      maximumSize: WindowsSize.iPhone6P1.value,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      title: 'Universally',
    ),
  );
  await PackageInfoPlus().initialize();
  runApp(
    DevicePreview(
      enabled: isDesktop || isWeb,
      defaultDevice: Devices.ios.iPhone13Mini,
      builder: (BuildContext context) => const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

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
        initState: (BuildContext context) {
          ConnectivityPlus().subscription().then((_) {
            DemoLog.instance.add('网络状态：${ConnectivityPlus().current.builder((e) => e.name).join(', ')}');
          });
          ConnectivityPlus().addListener((bool status, List<ConnectivityResult> result) async {
            DemoLog.instance.add('网络状态变化：${result.builder((e) => e.name).join(', ')}');
            return true;
          });
        },
        onResumed: (_) => DemoLog.instance.add('App onResumed'),
        onPaused: (_) => DemoLog.instance.add('App onPaused'),
        onInactive: (_) => DemoLog.instance.add('App onInactive'),
        onDetached: (_) => DemoLog.instance.add('App onDetached'),
        onHidden: (_) => DemoLog.instance.add('App onHidden'),
      ),
    );
  }
}

class AppState with ChangeNotifier {}
