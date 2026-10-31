import 'package:universally/universally.dart';

class DeviceInfoPlus {
  factory DeviceInfoPlus() => _instance;

  DeviceInfoPlus._();

  static final DeviceInfoPlus _instance = DeviceInfoPlus._();

  static DeviceInfoPlus get instance => _instance;

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<BaseDeviceInfo?> get platform {
    if (isWeb) {
      return webBrowserInfo;
    } else if (isAndroid) {
      return android;
    } else if (isIOS) {
      return ios;
    } else if (isMacOS) {
      return macOS;
    } else if (isWindows) {
      return windows;
    } else if (isLinux) {
      return linux;
    } else {
      return Future.value(null);
    }
  }

  AndroidDeviceInfo? _android;

  Future<AndroidDeviceInfo?> get android async {
    if (isAndroid && !isWeb) {
      return _android ??= await _deviceInfoPlugin.androidInfo;
    }
    return null;
  }

  Future<bool> androidAbove(int version) async {
    if (isAndroid && !isWeb) {
      final android = await this.android;
      return android != null && android.version.sdkInt >= version;
    }
    return false;
  }

  IosDeviceInfo? _ios;

  Future<IosDeviceInfo?> get ios async {
    if (isIOS && !isWeb) {
      return _ios ??= await _deviceInfoPlugin.iosInfo;
    }
    return null;
  }

  MacOsDeviceInfo? _macOS;

  Future<MacOsDeviceInfo?> get macOS async {
    if (isMacOS && !isWeb) {
      return _macOS ??= await _deviceInfoPlugin.macOsInfo;
    }
    return null;
  }

  WindowsDeviceInfo? _windows;

  Future<WindowsDeviceInfo?> get windows async {
    if (isWindows && !isWeb) {
      return _windows ??= await _deviceInfoPlugin.windowsInfo;
    }
    return null;
  }

  LinuxDeviceInfo? _linux;

  Future<LinuxDeviceInfo?> get linux async {
    if (isLinux && !isWeb) {
      return _linux ??= await _deviceInfoPlugin.linuxInfo;
    }
    return null;
  }

  WebBrowserInfo? _webBrowserInfo;

  Future<WebBrowserInfo?> get webBrowserInfo async {
    if (!isWeb) return null;
    return _webBrowserInfo ??= await _deviceInfoPlugin.webBrowserInfo;
  }
}
