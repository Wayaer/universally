import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 单独获取一个权限
Future<bool> checkRequestPermission(
  Permission permission, {
  /// 请求前提示
  String? promptBeforeRequest,

  /// 请求失败跳转设置提示
  String? jumpSettingsPrompt,
  GestureTapCallback? cancelTap,
}) async {
  if (!isMobile) return true;
  PermissionStatus permissionStatus = await permission.status;
  if (permissionStatus.isDenied) {
    if (promptBeforeRequest != null) {
      PermissionDialog.show(content: promptBeforeRequest);
    }
    permissionStatus = await permission.request();
    pop();
  }
  if (!(permissionStatus.isGranted || permissionStatus.isLimited) &&
      jumpSettingsPrompt != null) {
    final result = await ConfirmCancelActionDialog(
        titleText: '权限申请说明',
        contentText: jumpSettingsPrompt,
        autoClose: false,
        onConfirmTap: () {
          pop(true);
        },
        onCancelTap: () {
          pop(false);
          cancelTap?.call();
        }).show();
    if (result == true) await openAppSettings();
  }
  return permissionStatus.isGranted || permissionStatus.isLimited;
}

/// 必须获取通过全部权限
Future<bool> checkRequestPermissions(List<Permission> permissions,
    {String? promptBeforeRequest,
    String? jumpSettingsPrompt,
    GestureTapCallback? cancelTap}) async {
  if (!isMobile) return true;
  Map<Permission, bool> status = {};
  for (var element in permissions) {
    final isGranted = await element.isGranted;
    final isLimited = await element.isLimited;
    if (!(isGranted || isLimited)) status.addAll({element: isGranted});
  }
  if (status.isNotEmpty) {
    if (promptBeforeRequest != null) {
      PermissionDialog.show(content: promptBeforeRequest);
    }
    final permissionsStatus = await status.keys.toList().request();
    permissionsStatus
        .removeWhere((key, value) => value.isGranted || value.isLimited);
    pop();
    if (permissionsStatus.isNotEmpty) {
      final result = await ConfirmCancelActionDialog(
          titleText: '权限申请说明',
          contentText: jumpSettingsPrompt,
          autoClose: false,
          onConfirmTap: () {
            pop(true);
          },
          onCancelTap: () {
            pop(false);
            cancelTap?.call();
          }).popupBottomSheet();
      if (result == true) await openAppSettings();
    }
    return permissionsStatus.isEmpty;
  }
  return true;
}

class PermissionDialog extends StatelessWidget {
  const PermissionDialog(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  static show<T>({String title = "权限申请说明", required String content}) =>
      PermissionDialog(title: title, content: content)
          .popupBottomSheet<T>(options: const BottomSheetOptions());

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Universal(
          margin: EdgeInsets.fromLTRB(16, context.statusBarHeight + 16, 16, 16),
          decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(16),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLarge(title).setWidth(double.infinity),
            10.heightBox,
            TextMedium(content, maxLines: 10)
          ]),
    ]);
  }
}

Future<List<Permission>> photosPermission({
  /// 是否包含 videos 权限  android sdkInt >= 33
  bool includeVideos = true,

  /// 是否包含 videos 权限  android sdkInt >= 33
  bool includePhotos = true,

  /// 是否包含 audio 权限  android sdkInt >= 33
  bool includeAudio = false,
}) async {
  if (!isMobile) return [];
  if (isAndroid) {
    if (await DeviceInfoPlus().androidAbove(33)) {
      return [
        Permission.photos,
        Permission.audio,
        Permission.videos,
      ];
    } else {
      return [Permission.storage];
    }
  } else if (isIOS) {
    return [Permission.photos];
  }
  return [];
}

Future<Permission?> storagePermission() async {
  if (!isMobile) return null;
  if (isAndroid) {
    if (await DeviceInfoPlus().androidAbove(33)) {
      return Permission.manageExternalStorage;
    } else {
      return Permission.storage;
    }
  }
  return null;
}
