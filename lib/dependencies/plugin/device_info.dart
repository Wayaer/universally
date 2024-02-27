import 'package:universally/universally.dart';

class DeviceInfoPlus {
  factory DeviceInfoPlus() => _singleton ??= DeviceInfoPlus._();

  DeviceInfoPlus._();

  static DeviceInfoPlus? _singleton;

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  AndroidDeviceInfo? _androidInfo;

  Future<AndroidDeviceInfo?> get android async {
    if (isAndroid && !isWeb) {
      return _androidInfo ??= await _deviceInfoPlugin.androidInfo;
    }
    return null;
  }

  IosDeviceInfo? _iosInfo;

  Future<IosDeviceInfo?> get ios async {
    if (isIOS && !isWeb) {
      return _iosInfo ??= await _deviceInfoPlugin.iosInfo;
    }
    return null;
  }

  MacOsDeviceInfo? _macOSInfo;

  Future<MacOsDeviceInfo?> get macOS async {
    if (isMacOS && !isWeb) {
      return _macOSInfo ??= await _deviceInfoPlugin.macOsInfo;
    }
    return null;
  }

  WindowsDeviceInfo? _windowsInfo;

  Future<WindowsDeviceInfo?> get windows async {
    if (isWindows && !isWeb) {
      return _windowsInfo ??= await _deviceInfoPlugin.windowsInfo;
    }
    return null;
  }

  LinuxDeviceInfo? _linuxInfo;

  Future<LinuxDeviceInfo?> get linux async {
    if (isLinux && !isWeb) {
      return _linuxInfo ??= await _deviceInfoPlugin.linuxInfo;
    }
    return null;
  }

  WebBrowserInfo? _webBrowserInfo;

  Future<WebBrowserInfo?> get webBrowserInfo async {
    if (!isWeb) return null;
    return _webBrowserInfo ??= await _deviceInfoPlugin.webBrowserInfo;
  }
}
