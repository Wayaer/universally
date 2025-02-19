enum MacOSSettingUrl {
  /// Accessibility 面板相关 ///
  /// 辅助面板根目录
  accessibilityMain('.universalaccess'),

  /// 辅助面板-显示
  accessibilityDisplay('.universalaccess?Seeing_Display'),

  /// 辅助面板-缩放
  accessibilityZoom('.universalaccess?Seeing_Zoom'),

  /// 辅助面板-显示
  accessibilityVoiceOver('.universalaccess?Seeing_VoiceOver'),

  /// 辅助面板-旁白
  accessibilityDescriptions('.universalaccess?Media_Descriptions'),

  /// 辅助面板-描述
  accessibilityCaptions('.universalaccess?Captioning'),

  /// 辅助面板-音频
  accessibilityAudio('.universalaccess?Hearing'),

  /// 辅助面板-键盘
  accessibilityKeyboard('.universalaccess?Keyboard'),

  /// 辅助面板-指针控制
  accessibilityMouseTrackpad('.universalaccess?Mouse'),

  /// 安全&隐私相关
  /// 安全&隐私相关-根目录
  securityMain('.security'),

  /// 安全&隐私相关-通用
  securityGeneral('.security?General'),

  /// 安全&隐私相关-文件保险箱
  securityFileVault('.security?FDE'),

  /// 安全&隐私相关-防火墙
  securityFirewall('.security?Firewall'),

  /// 安全&隐私相关-高级
  securityAdvanced('.security?Advanced'),

  /// 安全&隐私相关-隐私
  securityPrivacy('.security?Privacy'),

  /// 安全&隐私相关-辅助功能
  securityPrivacyAccessibility('.security?Privacy_Accessibility'),

  /// 安全&隐私相关-完全磁盘访问权限
  securityPrivacyAssistive('.security?Privacy_Accessibility'),

  /// 文件和文件夹
  securityPrivacyAllFiles('.security?Privacy_Assistive'),

  /// 安全&隐私相关-定位
  securityPrivacyLocationServices('.security?Privacy_AllFiles'),

  /// 安全&隐私相关-通讯录
  securityPrivacyContacts('.security?Privacy_Contacts'),

  /// 安全&隐私相关-分析与改进
  securityPrivacyDiagnosticsUsage('.security?Privacy_Diagnostics'),

  /// 安全&隐私相关-日历
  securityPrivacyCalendars('.security?Privacy_Calendars'),

  /// 安全&隐私相关-提醒事项
  securityPrivacyReminders('.security?Privacy_Reminders'),

  /// 键盘-听写
  speechDictation('.speech?Dictation'),

  /// 键盘-siri
  speechTextToSpeech('.speech?TTS'),

  /// 共享
  /// 共享-更目录
  sharingMain('s.sharing'),

  /// 共享-屏幕共享
  sharingScreenSharing('s.sharing?Services_ScreenSharing'),

  /// 共享-文件共享
  sharingFileSharing('s.sharing?Services_PersonalFileSharing'),

  /// 共享-打印机共享
  sharingPrinterSharing('s.sharing?Services_PrinterSharing'),

  /// 共享-远程登录
  sharingRemoteLogin('s.sharing?Services_RemoteLogin'),

  /// 共享-远程管理
  sharingRemoteManagement('s.sharing?Services_ARDService'),

  /// 共享-远程apple事件
  sharingRemoteAppleEvents('s.sharing?Services_RemoteAppleEvent'),

  /// 共享-互联网共享
  sharingInternetSharing('s.sharing?Internet'),

  /// 共享-蓝牙共享
  sharingBluetoothSharing('s.sharing?Services_BluetoothSharing');

  const MacOSSettingUrl(this._value);

  final String _value;

  String get value => 'x-apple.systempreferences:com.apple.preference$_value';
}

enum IOSSettingUrl {
  /// setting
  app(''),

  /// notifications ios16+
  notifications('notifications');

  const IOSSettingUrl(this._value);

  final String _value;

  /// 跳转至设置
  String get url => 'app-settings:$_value';
}
