import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// alert 确认按钮颜色
/// [AssetSelect]  Badge 背景色
/// [BaseLoading] loading 颜色
late Color currentColor;

/// 上传文件地址
late String currentUploadUrl;

/// 保存图片和视频的缓存地址
String? currentCacheDir;

/// 测试版 url 包含 debug 模式
late String currentBetaBaseUrl;

/// 正式版 url
late String currentReleaseBaseUrl;

/// 当前项目使用的 url
late String currentBaseUrl;

void setAppConfig({
  required Color mainColor,
  required String betaBaseUrl,
  required String releaseBaseUrl,
}) {
  currentColor = mainColor;

  final bool isRelease = Sp.getBool(UConstant.isRelease) ?? false;

  if (isBeta && !isRelease) {
    currentBetaBaseUrl = betaBaseUrl;
    currentReleaseBaseUrl = releaseBaseUrl;
    currentBaseUrl = currentBetaBaseUrl;
    final String? localApi = Sp.getString(UConstant.localApi);
    if (localApi != null && localApi.length > 5) currentBaseUrl = localApi;
    hasLogTs = Sp.getBool(UConstant.hasLogTs) ?? false;
  } else {
    isBeta = false;
    currentBaseUrl = releaseBaseUrl;
  }
}

/// 初始化一些信息
void initConfig(
    {required String uploadUrl, AppPathModel? appPath, Color? mainColor}) {
  if (mainColor != null) currentColor = mainColor;
  currentUploadUrl = uploadUrl;
  String? path;
  if (appPath != null) {
    if (isAndroid) {
      path = appPath.externalCacheDir! + '/';
    } else if (isIOS) {
      path = appPath.temporaryDirectory;
    } else if (isMacOS) {
      path = appPath.temporaryDirectory;
    }
  }
  if (path != null) currentCacheDir = path;
}

/// loading
class BaseLoading extends StatelessWidget {
  const BaseLoading({Key? key, this.size}) : super(key: key);
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(size: size ?? 50, color: currentColor);
  }
}
