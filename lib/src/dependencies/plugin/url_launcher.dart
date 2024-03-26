import 'package:universally/universally.dart';

class UrlLauncher {
  factory UrlLauncher() => _singleton ??= UrlLauncher._();

  UrlLauncher._();

  static UrlLauncher? _singleton;

  /// 打开连接
  /// Open the url
  Future<bool> openUrl(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) async {
    if (await canLaunch(Uri.parse(url))) {
      return await launchUrl(Uri.parse(url),
          mode: mode,
          webOnlyWindowName: webOnlyWindowName,
          webViewConfiguration: webViewConfiguration);
    } else {
      return false;
    }
  }

  /// 打开连接
  /// Open the uri
  Future<bool> openUri(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) async {
    if (await canLaunch(uri)) {
      return await launchUrl(uri,
          mode: mode,
          webOnlyWindowName: webOnlyWindowName,
          webViewConfiguration: webViewConfiguration);
    } else {
      return false;
    }
  }

  Future<bool> canLaunch(Uri url) => canLaunchUrl(url);

  /// Closes the current in-app web view, if one was previously opened by
  /// [launchUrl].
  /// This works only if [supportsCloseForLaunchMode] returns true for the mode
  /// that was used by [launchUrl].
  Future<void> closeWebView() => closeInAppWebView();

  /// Returns true if [mode] is supported by the current platform implementation.
  /// Calling [launchUrl] with an unsupported mode will fall back to a supported
  /// mode, so calling this method is only necessary for cases where the caller
  /// needs to know which mode will be used.
  Future<bool> supports(LaunchMode mode) => supportsLaunchMode(mode);

  /// Returns true if [closeInAppWebView] is supported for [mode] in the current
  /// platform implementation.
  /// If this returns false, [closeInAppWebView] will not work when launching
  /// URLs with [mode].
  Future<bool> supportsClose(LaunchMode mode) =>
      supportsCloseForLaunchMode(mode);

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
