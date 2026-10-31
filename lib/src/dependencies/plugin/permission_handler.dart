import 'dart:async';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

const _defaultBottomSheetOptions = ModalBottomSheetOptions(backgroundColor: Colors.transparent);

extension ExtensionPermissionStatus on PermissionStatus {
  bool get authorized => isGranted || isLimited || isProvisional;
}

/// check permission
Future<bool> checkPermission(Permission permission) async {
  return (await permission.status).authorized;
}

/// check permissions
Future<List<Permission>> checkPermissions(List<Permission> permissions) async {
  final List<Permission> unauthorized = [];
  for (final element in permissions) {
    if (await checkPermission(element)) {
      continue;
    }
    unauthorized.add(element);
  }
  return unauthorized;
}

/// 单独获取一个权限
Future<bool> checkRequestPermission(
  Permission permission, {

  /// 请求前提示
  String? beforeRequestPrompt,

  /// 请求失败跳转设置提示
  String? jumpSettingsPrompt,

  /// 取消点击
  GestureTapCallback? onCancelTap,
}) async {
  PermissionStatus status = await permission.status;
  if (!status.authorized) {
    // 提示弹窗不会阻塞权限请求，同时记录其是否仍显示，避免误 pop 掉当前页面
    bool promptVisible = false;
    if (beforeRequestPrompt != null) {
      promptVisible = true;
      unawaited(PermissionDialog.show(content: beforeRequestPrompt).whenComplete(() => promptVisible = false));
    }
    try {
      status = await permission.request();
    } finally {
      if (promptVisible) pop();
    }
  }
  if (!(status.authorized) && jumpSettingsPrompt != null) {
    final result = await ConfirmCancelActionDialog(
      titleText: '权限申请说明',
      contentText: jumpSettingsPrompt,
      onConfirmTap: () => true,
      onCancelTap: onCancelTap,
    ).show();
    if (result == true) await openAppSettings();
  }
  return status.authorized;
}

/// 必须获取通过全部权限
Future<bool> checkRequestPermissions(
  List<Permission> permissions, {
  String? beforeRequestPrompt,
  String? jumpSettingsPrompt,
  GestureTapCallback? onCancelTap,
}) async {
  final unauthorized = await checkPermissions(permissions);
  if (unauthorized.isNotEmpty) {
    bool promptVisible = false;
    if (beforeRequestPrompt != null) {
      promptVisible = true;
      unawaited(PermissionDialog.show(content: beforeRequestPrompt).whenComplete(() => promptVisible = false));
    }
    final Map<Permission, PermissionStatus> permissionsStatus;
    try {
      permissionsStatus = await unauthorized.request();
    } finally {
      if (promptVisible) pop();
    }
    permissionsStatus.removeWhere((key, value) => value.authorized);
    if (permissionsStatus.isNotEmpty && jumpSettingsPrompt != null) {
      final result = await ConfirmCancelActionDialog(
        titleText: '权限申请说明',
        contentText: jumpSettingsPrompt,
        onConfirmTap: () => true,
        onCancelTap: onCancelTap,
      ).popupModalBottomSheet(options: _defaultBottomSheetOptions);
      if (result == true) await openAppSettings();
    }
    return permissionsStatus.isEmpty;
  }
  return true;
}

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key, required this.title, required this.content});

  final String title;
  final String content;

  static Future<void> show({String title = '权限申请说明', required String content}) =>
      PermissionDialog(title: title, content: content).popupModalBottomSheet(options: _defaultBottomSheetOptions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Universal(
          margin: EdgeInsets.fromLTRB(16, context.statusBarHeight + 40, 16, 16),
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TextLarge(title).setWidth(double.infinity), 10.heightBox, TextMedium(content, maxLines: 10)],
        ),
      ],
    );
  }
}

Future<List<Permission>> photosPermission({
  /// 是否包含 videos 权限  android sdkInt >= 33
  bool includeVideos = true,

  /// 是否包含 audio 权限  android sdkInt >= 33
  bool includeAudio = false,
}) async {
  if (isAndroid) {
    if (await DeviceInfoPlus().androidAbove(33)) {
      return [Permission.photos, if (includeAudio) Permission.audio, if (includeVideos) Permission.videos];
    } else {
      return [Permission.storage];
    }
  }
  return [Permission.photos];
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
