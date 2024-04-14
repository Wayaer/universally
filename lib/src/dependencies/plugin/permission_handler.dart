import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 单独获取一个权限
Future<bool> getPermission(
  Permission permission, {
  required String alert,
  GestureTapCallback? cancelTap,
}) async {
  if (!isMobile) return true;
  PermissionStatus permissionStatus = await permission.status;
  if (permissionStatus.isDenied) {
    PermissionPrompt.show(content: alert);
    permissionStatus = await permission.request();
    pop();
  }
  if (!(permissionStatus.isGranted || permissionStatus.isLimited)) {
    final result = await ConfirmAndCancelActionDialog(
        titleText: alert,
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
Future<bool> getPermissions(List<Permission> permissions,
    {required String alert, GestureTapCallback? cancelTap}) async {
  if (!isMobile) return true;
  Map<Permission, bool> status = {};
  for (var element in permissions) {
    final isGranted = await element.isGranted;
    final isLimited = await element.isLimited;
    if (!(isGranted || isLimited)) status.addAll({element: isGranted});
  }
  if (status.isNotEmpty) {
    PermissionPrompt.show(content: alert);
    final permissionsStatus = await status.keys.toList().request();
    permissionsStatus
        .removeWhere((key, value) => value.isGranted || value.isLimited);
    pop();
    if (permissionsStatus.isNotEmpty) {
      final result = await ConfirmAndCancelActionDialog(
          contentText: alert,
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
    return permissionsStatus.isEmpty;
  }
  return true;
}

class PermissionPrompt extends StatelessWidget {
  const PermissionPrompt(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  static show<T>({String title = "权限申请说明", required String content}) =>
      PermissionPrompt(title: title, content: content).popupDialog<T>(
          options: const DialogOptions(fromStyle: PopupFromStyle.fromTop));

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            TextNormal(content, maxLines: 10)
          ]),
    ]);
  }
}
