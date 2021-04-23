import 'package:universally/universally.dart';

/// 打开网页
Future<bool> openUrl(String url) async {
  if (await canLaunch(url)) {
    return await launch(url);
  } else {
    return false;
  }
}

/// ios str 对应app id
/// macOS str 对应app id
/// android str 对应 packageName， marketPackageName 指定打开应用市场的包名
Future<bool> openAppStore(String str, {String? marketPackageName}) async {
  if (isIOS || isMacOS) {
    final String url = 'itms-apps://itunes.apple.com/us/app/$str';
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      return false;
    }
  } else if (isAndroid) {
    return await openAndroidMarket(
        packageName: str, marketPackageName: marketPackageName);
  }
  return false;
}

/// Android str 对应包名
/// ios str 对应 url schemes
Future<bool> isInstalled(String str) async {
  if (isIOS || isMacOS) {
    return await canLaunch(str);
  } else if (isAndroid) {
    return isInstallApp(str);
  }
  return false;
}
