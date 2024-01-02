import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoPlus {
  factory DeviceInfoPlus() => _singleton ??= DeviceInfoPlus._();

  DeviceInfoPlus._();

  static DeviceInfoPlus? _singleton;

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  AndroidDeviceInfo? _androidInfo;

  Future<AndroidDeviceInfo> get android async {
    return _androidInfo ??= await _deviceInfoPlugin.androidInfo;
  }

  IosDeviceInfo? _iosInfo;

  Future<IosDeviceInfo> get ios async {
    return _iosInfo ??= await _deviceInfoPlugin.iosInfo;
  }

  MacOsDeviceInfo? _macOSInfo;

  Future<MacOsDeviceInfo> get macOS async {
    return _macOSInfo ??= await _deviceInfoPlugin.macOsInfo;
  }

  WindowsDeviceInfo? _windowsInfo;

  Future<WindowsDeviceInfo> get windows async {
    return _windowsInfo ??= await _deviceInfoPlugin.windowsInfo;
  }

  LinuxDeviceInfo? _linuxInfo;

  Future<LinuxDeviceInfo> get linux async {
    return _linuxInfo ??= await _deviceInfoPlugin.linuxInfo;
  }
}
