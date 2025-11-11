import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoPlus {
  factory PackageInfoPlus() => instance;

  PackageInfoPlus._();

  static final PackageInfoPlus instance = PackageInfoPlus._();

  PackageInfo? _packageInfo;

  Future<PackageInfo> initialize() async => _packageInfo ??= (await PackageInfo.fromPlatform());

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
