import 'package:flutter/foundation.dart';
import 'package:universally/universally.dart';

class DeviceInfoPlus {
  factory DeviceInfoPlus() => _singleton ??= DeviceInfoPlus._();

  DeviceInfoPlus._();

  static DeviceInfoPlus? _singleton;

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<dynamic> get platform async {
    if (isWeb) return webBrowserInfo;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.fuchsia:
        return null;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.linux:
        return linux;
      case TargetPlatform.macOS:
        return macOS;
      case TargetPlatform.windows:
        return windows;
    }
  }

  Future<AndroidDeviceInfo?> get android async {
    if (isAndroid && !isWeb) {
      return await _deviceInfoPlugin.androidInfo;
    }
    return null;
  }

  Future<bool> androidAbove(int version) async {
    if (isAndroid) {
      final android = await this.android;
      return android != null && android.version.sdkInt >= version;
    }
    return false;
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

extension ExtensionWebBrowserInfo on WebBrowserInfo {
  Map<String, dynamic> get map => {
    'browserName': browserName,
    'appCodeName': appCodeName,
    'appName': appName,
    'appVersion': appVersion,
    'deviceMemory': deviceMemory,
    'language': language,
    'languages': languages,
    'platform': platform,
    'product': product,
    'productSub': productSub,
    'userAgent': userAgent,
    'vendor': vendor,
    'vendorSub': vendorSub,
    'hardwareConcurrency': hardwareConcurrency,
    'maxTouchPoints': maxTouchPoints,
  };
}

extension ExtensionLinuxDeviceInfo on LinuxDeviceInfo {
  Map<String, dynamic> get map => {
    'name': name,
    'version': version,
    'id': id,
    'idLike': idLike,
    'versionCodename': versionCodename,
    'versionId': versionId,
    'prettyName': prettyName,
    'buildId': buildId,
    'variant': variant,
    'variantId': variantId,
    'machineId': machineId,
  };
}

extension ExtensionWindowsDeviceInfo on WindowsDeviceInfo {
  Map<String, dynamic> get map => {
    'computerName': computerName,
    'numberOfCores': numberOfCores,
    'systemMemoryInMegabytes': systemMemoryInMegabytes,
    'userName': userName,
    'majorVersion': majorVersion,
    'minorVersion': minorVersion,
    'buildNumber': buildNumber,
    'platformId': platformId,
    'csdVersion': csdVersion,
    'servicePackMajor': servicePackMajor,
    'servicePackMinor': servicePackMinor,
    'suitMask': suitMask,
    'productType': productType,
    'reserved': reserved,
    'buildLab': buildLab,
    'buildLabEx': buildLabEx,
    'digitalProductId': digitalProductId,
    'displayVersion': displayVersion,
    'editionId': editionId,
    'installDate': installDate,
    'productId': productId,
    'productName': productName,
    'registeredOwner': registeredOwner,
    'releaseId': releaseId,
    'deviceId': deviceId,
  };
}

extension ExtensionMacOsDeviceInfo on MacOsDeviceInfo {
  Map<String, dynamic> get map => {
    'computerName': computerName,
    'hostName': hostName,
    'model': model,
    'arch': arch,
    'kernelVersion': kernelVersion,
    'osRelease': osRelease,
    'majorVersion': majorVersion,
    'minorVersion': minorVersion,
    'patchVersion': patchVersion,
    'activeCPUs': activeCPUs,
    'memorySize': memorySize,
    'cpuFrequency': cpuFrequency,
    'systemGUID': systemGUID,
  };
}

extension ExtensionIosDeviceInfo on IosDeviceInfo {
  Map<String, dynamic> get map => {
    'name': name,
    'systemName': systemName,
    'systemVersion': systemVersion,
    'model': model,
    'localizedModel': localizedModel,
    'identifierForVendor': identifierForVendor,
    'isPhysicalDevice': isPhysicalDevice,
    'utsname': utsname.map,
  };
}

extension ExtensionIosUtsname on IosUtsname {
  Map<String, dynamic> get map => {
    'sysname': sysname,
    'nodename': nodename,
    'release': release,
    'version': version,
    'machine': machine,
  };
}

extension ExtensionAndroidDeviceInfo on AndroidDeviceInfo {
  Map<String, dynamic> get map => {
    'version': version.map,
    'board': board,
    'bootloader': bootloader,
    'brand': brand,
    'device': device,
    'display': display,
    'fingerprint': fingerprint,
    'hardware': hardware,
    'host': host,
    'id': id,
    'manufacturer': manufacturer,
    'model': model,
    'product': product,
    'supported32BitAbis': supported32BitAbis,
    'supported64BitAbis': supported64BitAbis,
    'supportedAbis': supportedAbis,
    'tags': tags,
    'type': type,
    'isPhysicalDevice': isPhysicalDevice,
    'systemFeatures': systemFeatures,
    'serialNumber': serialNumber,
    'isLowRamDevice': isLowRamDevice,
  };
}

extension ExtensionAndroidBuildVersion on AndroidBuildVersion {
  Map<String, dynamic> get map => {
    'baseOS': baseOS,
    'sdkInt': sdkInt,
    'release': release,
    'codename': codename,
    'incremental': incremental,
    'previewSdkInt': previewSdkInt,
    'securityPatch': securityPatch,
  };
}
