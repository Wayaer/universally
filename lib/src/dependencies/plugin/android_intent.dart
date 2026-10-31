import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class AndroidAppMarketIntent extends AndroidIntent {
  AndroidAppMarketIntent({
    required String packageName,
    super.category,
    super.arguments,
    super.arrayArguments,
    super.package,
    super.componentName,
    super.platform,
    List<int>? flags,
    super.type,
  }) : super(
         action: 'action_view',
         data: 'market://details?id=$packageName',
         flags: [Flag.FLAG_ACTIVITY_NEW_TASK, if (flags != null) ...flags],
       );
}

class AndroidSystemSettingIntent extends AndroidIntent {
  AndroidSystemSettingIntent(
    SettingIntent intent, {
    super.package,
    super.flags,
    super.category,
    super.data,
    Map<String, dynamic>? arguments,
    super.arrayArguments,
    super.componentName,
    super.platform,
    super.type,
  }) : super(
         action: intent.value,
         arguments: {
           if (arguments != null) ...arguments,
           if (intent == SettingIntent.notification && package != null) 'android.provider.extra.APP_PACKAGE': package,
         },
       );
}

/// Android 系统设置
enum SettingIntent {
  /// wifi
  wifi('android.settings.WIFI_SETTINGS'),

  /// wifi ip
  wifiIp('android.settings.WIFI_IP_SETTINGS'),

  /// 定位
  location('android.settings.LOCATION_SOURCE_SETTINGS'),

  /// 安全
  security('android.settings.SECURITY_SETTINGS'),

  /// 密码安全
  passwordSecurity('android.settings.SECURITY_SETTINGS'),

  /// 蓝牙
  bluetooth('android.settings.BLUETOOTH_SETTINGS'),

  /// 移动数据
  cellularNetwork('android.settings.DATA_ROAMING_SETTINGS'),

  /// 语言和时间
  time('android.settings.DATE_SETTINGS'),

  /// 显示和亮度
  displayBrightness('android.settings.DISPLAY_SETTINGS'),

  /// 通知
  notification('android.settings.APP_NOTIFICATION_SETTINGS'),

  /// 声音和振动
  soundVibration('android.settings.SOUND_SETTINGS'),

  /// 内部存储
  internalStorage('android.settings.INTERNAL_STORAGE_SETTINGS'),

  /// 电量管理
  battery('android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS'),

  /// 语言设置
  localeLanguage('android.settings.LOCALE_SETTINGS'),

  /// nfc
  nfc('android.settings.NFC_SETTINGS'),

  /// setting
  setting('android.settings.SETTINGS'),

  /// 手机状态信息的界面
  deviceInfo('android.settings.DEVICE_INFO_SETTINGS'),

  /// 开发者选项设置
  applicationDevelopment('android.settings.APPLICATION_DEVELOPMENT_SETTINGS'),

  /// 选取运营商的界面
  networkOperator('android.settings.NETWORK_OPERATOR_SETTINGS'),

  /// 添加账户界面
  addAccount('android.settings.ADD_ACCOUNT_SETTINGS'),

  /// 双卡和移动网络设置界面
  dataRoaming('android.settings.DATA_ROAMING_SETTINGS'),

  /// 更多连接方式设置界面
  airplaneMode('android.settings.AIRPLANE_MODE_SETTINGS');

  const SettingIntent(this.value);

  final String value;
}
