import 'package:universally/universally.dart';

/// 打开连接
Future<bool> openUrl(String url) async {
  if (await canLaunch(url)) {
    return await launch(url);
  } else {
    return false;
  }
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

/// 拨打电话
Future<bool> openPhone(String phone) => openUrl('tel:$phone');

/// 发送短信
Future<bool> openSMS(String phone) => openUrl('sms:$phone');

/// ios str 对应app id
/// macOS str 对应app id
/// android str 对应 packageName，安装多个应用商店时会弹窗选择, marketPackageName 指定打开应用市场的包名
Future<bool> openAppStore(String str, {String? marketPackageName}) async {
  if (isIOS || isMacOS) {
    final String url = 'itms-apps://itunes.apple.com/us/app/$str';
    return await openUrl(url);
  } else if (isAndroid) {
    return await Curiosity()
        .native
        .openAndroidAppMarket(str, marketPackageName: marketPackageName);
  }
  return false;
}

/// 是否安装某个app
/// Android str 对应包名
Future<bool> isInstallApp(String str) async {
  if (isIOS || isMacOS) {
    return await canLaunch(str);
  } else if (isAndroid) {
    return await Curiosity().native.hasInstallAppWithAndroid(str);
  }
  return false;
}
