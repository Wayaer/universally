import 'package:universally/universally.dart';

class UrlLauncher {
  factory UrlLauncher() => _singleton ??= UrlLauncher._();

  UrlLauncher._();

  static UrlLauncher? _singleton;

  /// 打开连接
  /// Open the connection
  Future<bool> openUrl(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      return await launchUrl(Uri.parse(url),
          mode: mode,
          webOnlyWindowName: webOnlyWindowName,
          webViewConfiguration: webViewConfiguration);
    } else {
      return false;
    }
  }

  /// 拨打电话
  /// Make a phone call
  Future<bool> openPhone(String phone) => openUrl('tel:$phone');

  /// 发送短信
  /// Send a text message
  Future<bool> openSMS(String phone) => openUrl('sms:$phone');

  Future<bool> openAppStore({
    /// android use
    String? packageName,

    /// 指定打开应用商店的报名
    String? marketPackageName,

    /// android use intent launch
    bool androidUseIntent = true,

    ///  ios macos use
    String? appId,
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) async {
    if ((isIOS || isMacOS) && appId.isNotEmptyOrNull) {
      final String url = 'itms-apps://itunes.apple.com/us/app/$appId';
      return await openUrl(url,
          mode: mode,
          webOnlyWindowName: webOnlyWindowName,
          webViewConfiguration: webViewConfiguration);
    } else if (isAndroid && packageName.isNotEmptyOrNull) {
      final String url = 'market://details?id=$packageName';
      if (androidUseIntent) {
        await AndroidAppMarketIntent(
                packageName: packageName!, package: marketPackageName)
            .launch();
        return true;
      } else {
        return await openUrl(url,
            mode: mode,
            webOnlyWindowName: webOnlyWindowName,
            webViewConfiguration: webViewConfiguration);
      }
    }
    return false;
  }

  /// 是否安装某个app
  Future<bool> isInstalledApp({
    /// android use
    String? packageName,

    /// ios macos use
    String? appId,
  }) async {
    if ((isIOS || isMacOS) && appId.isNotEmptyOrNull) {
      return await canLaunchUrl(Uri.parse(appId!));
    } else if (isAndroid && packageName.isNotEmptyOrNull) {
      final appList = await Curiosity.native.getInstalledApps;
      bool installed = false;
      for (var element in appList) {
        if (element.packageName == packageName) {
          installed = true;
          break;
        }
      }
      return installed;
    }
    return false;
  }
}
