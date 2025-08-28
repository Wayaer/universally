import 'package:universally/universally.dart';

class UrlLauncher {
  factory UrlLauncher() => _singleton ??= UrlLauncher._();

  UrlLauncher._();

  static UrlLauncher? _singleton;

  static UrlLauncher get instance => UrlLauncher();

  /// 打开连接
  /// Open the url
  Future<bool> openUrl(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) async {
    if (await canLaunch(Uri.parse(url))) {
      return await launchUrl(
        Uri.parse(url),
        mode: mode,
        webOnlyWindowName: webOnlyWindowName,
        webViewConfiguration: webViewConfiguration,
      );
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
      return await launchUrl(
        uri,
        mode: mode,
        webOnlyWindowName: webOnlyWindowName,
        webViewConfiguration: webViewConfiguration,
      );
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
      return await openUrl(
        url,
        mode: mode,
        webOnlyWindowName: webOnlyWindowName,
        webViewConfiguration: webViewConfiguration,
      );
    } else if (isAndroid && packageName.isNotEmptyOrNull) {
      final String url = 'market://details?id=$packageName';
      if (androidUseIntent) {
        await AndroidAppMarketIntent(packageName: packageName!, package: marketPackageName).launch();
        return true;
      } else {
        return await openUrl(
          url,
          mode: mode,
          webOnlyWindowName: webOnlyWindowName,
          webViewConfiguration: webViewConfiguration,
        );
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

  Future<bool> launchOtherApp({
    String? uri,

    /// android
    String? androidSchemes,
    String? androidPackageName,
    String? extraAndroidSchemes,
    String? extraAndroidPackageName,

    /// ios
    String? iosAppId,
    String? iosSchemes,
    String? extraIOSSchemes,

    /// app 名称
    required String name,
  }) async {
    bool result = false;
    Future<bool> openStoreDialog(String url) async {
      final data = await ConfirmCancelActionDialog.cupertino(
        titleText: '温馨提示',
        contentText: '您还未安装$name，是否跳转应用商店安装？',
        onConfirmTap: () async {
          return await UrlLauncher().openAppStore(packageName: androidPackageName, appId: iosAppId);
        },
      ).show();
      return data ?? false;
    }

    if (isAndroid) {
      if (!result && androidSchemes != null) {
        result = await UrlLauncher().openUrl(androidSchemes, mode: LaunchMode.externalNonBrowserApplication);
      }
      if (!result && androidPackageName != null) {
        result = await UrlLauncher().openUrl(androidPackageName);
      }
      if (!result && extraAndroidSchemes != null) {
        result = await UrlLauncher().openUrl(extraAndroidSchemes);
      }
      if (!result && extraAndroidPackageName != null) {
        result = await UrlLauncher().openUrl(extraAndroidPackageName);
      }
      if (!result && uri != null) {
        result = await UrlLauncher().openUrl(uri, mode: LaunchMode.externalApplication);
      }
      if (!result && androidPackageName != null) {
        result = await openStoreDialog(androidPackageName);
      }
    } else if (isIOS) {
      if (!result && iosSchemes != null) {
        result = await UrlLauncher().openUrl(iosSchemes);
      }
      if (!result && extraIOSSchemes != null) {
        result = await UrlLauncher().openUrl(extraIOSSchemes);
      }
      if (!result && uri != null) {
        result = await UrlLauncher().openUrl(uri, mode: LaunchMode.externalApplication);
      }
      if (!result && iosAppId != null) result = await openStoreDialog(iosAppId);
    }
    return result;
  }
}
