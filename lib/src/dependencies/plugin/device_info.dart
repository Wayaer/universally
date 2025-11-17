import 'package:device_info_plus_harmonyos/device_info_plus_harmonyos.dart';
import 'package:universally/universally.dart';

class DeviceInfoPlus {
  factory DeviceInfoPlus() => instance;

  DeviceInfoPlus._();

  static DeviceInfoPlus? _singleton;

  static DeviceInfoPlus get instance => _singleton ??= DeviceInfoPlus._();

  final DeviceInfoPlusPlugin _deviceInfoPlugin = DeviceInfoPlusPlugin();

  Future<BaseDeviceInfo?> get platform {
    if (isWeb) {
      return webBrowserInfo;
    } else if (isAndroid) {
      return android;
    } else if (isIOS) {
      return ios;
    } else if (isHarmonyOS) {
      return harmonyOS;
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

  Future<AndroidDeviceInfo?> get android async {
    if (isAndroid && !isWeb) {
      return await _deviceInfoPlugin.androidInfo;
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

  Future<HarmonyOSDeviceInfo?> get harmonyOS async {
    if (isHarmonyOS && !isWeb) {
      return await _deviceInfoPlugin.harmonyOSInfo;
    }
    return null;
  }

  Future<IosDeviceInfo?> get ios async {
    if (isIOS && !isWeb) {
      return await _deviceInfoPlugin.iosInfo;
    }
    return null;
  }

  Future<MacOsDeviceInfo?> get macOS async {
    if (isMacOS && !isWeb) {
      return await _deviceInfoPlugin.macOsInfo;
    }
    return null;
  }

  Future<WindowsDeviceInfo?> get windows async {
    if (isWindows && !isWeb) {
      return await _deviceInfoPlugin.windowsInfo;
    }
    return null;
  }

  Future<LinuxDeviceInfo?> get linux async {
    if (isLinux && !isWeb) {
      return await _deviceInfoPlugin.linuxInfo;
    }
    return null;
  }

  Future<WebBrowserInfo?> get webBrowserInfo async {
    if (!isWeb) return null;
    return await _deviceInfoPlugin.webBrowserInfo;
  }
}
