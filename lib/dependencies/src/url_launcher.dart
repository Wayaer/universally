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

  /// Android [str] 对应包名
  /// Android [str] corresponds to the package name
  /// ios [str] 对应 url schemes
  /// ios [str] corresponds to the url schemes
  Future<bool> isInstalled(String str) async {
    if (isIOS || isMacOS) {
      return await canLaunchUrl(Uri.parse(str));
    } else if (isAndroid) {
      return isInstallApp(str);
    }
    return false;
  }

  /// 拨打电话
  /// Make a phone call
  Future<bool> openPhone(String phone) => openUrl('tel:$phone');

  /// 发送短信
  /// Send a text message
  Future<bool> openSMS(String phone) => openUrl('sms:$phone');

  /// ios [str] 对应app id
  /// ios [str] corresponds to the APP ID
  /// macOS [str] 对应app id
  /// macOS [str] corresponds to the APP ID
  /// android [str] 对应 packageName，安装多个应用商店时会弹窗选择, marketPackageName 指定打开应用市场的包名
  /// Android [str] corresponds to packageName, which is selected when multiple app stores are installed. "marketPackageName" specifies the name of the package to open the app Market
  Future<bool> openAppStore(
    String str, {
    String? marketPackageName,
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) async {
    if (isIOS || isMacOS) {
      final String url = 'itms-apps://itunes.apple.com/us/app/$str';
      return await openUrl(url,
          mode: mode,
          webOnlyWindowName: webOnlyWindowName,
          webViewConfiguration: webViewConfiguration);
    } else if (isAndroid) {
      return await Curiosity()
          .native
          .openAndroidAppMarket(str, marketPackageName: marketPackageName);
    }
    return false;
  }

  /// 是否安装某个app
  /// Whether to install an app
  /// Android [str] 对应包名
  /// Android [str] corresponds to the package name
  Future<bool> isInstallApp(String str) async {
    if (isIOS || isMacOS) {
      return await canLaunchUrl(Uri.parse(str));
    } else if (isAndroid) {
      return await Curiosity().native.hasInstallAppWithAndroid(str);
    }
    return false;
  }
}
