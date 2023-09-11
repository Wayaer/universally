import 'package:package_info_plus/package_info_plus.dart';

class BasePackageInfo {
  factory BasePackageInfo() => _singleton ??= BasePackageInfo._();

  BasePackageInfo._();

  static BasePackageInfo? _singleton;

  PackageInfo? _packageInfo;

  Future<PackageInfo> initialize() async {
    return _packageInfo = await PackageInfo.fromPlatform();
  }

  PackageInfo get packageInfo {
    assert(_packageInfo != null, 'initialize must be called first');
    return _packageInfo!;
  }

  String get appName => packageInfo.appName;

  String get packageName => packageInfo.packageName;

  String get version => packageInfo.version;

  String get buildNumber => packageInfo.buildNumber;

  String get buildSignature => packageInfo.buildSignature;

  String? get installerStore => packageInfo.installerStore;

  Map<String, dynamic> get data => packageInfo.data;
}
