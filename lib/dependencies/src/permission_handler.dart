import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 单独获取一个权限
/// Get a separate permission
Future<bool> getPermission(Permission permission, String? text,
    {bool showAlert = true,
    Function? alert,
    GestureTapCallback? cancelTap}) async {
  if (!isMobile) return false;
  PermissionStatus status = await permission.status;
  if (!status.isGranted) {
    status = await permission.request();
    if (showAlert) {
      if (!status.isGranted) {
        if (alert != null) {
          alert.call();
        } else {
          showAlertSureCancel(
              text: '该服务需要开启$text授权',
              sureTap: () async {
                final bool state = await openAppSettings();
                if (!state) showAlertMessage(text: '无法打开设置，请手动前往设置开启权限');
              },
              cancelTap: cancelTap);
        }
      }
    }
    return status.isGranted;
  }
  return true;
}

/// 必须获取通过全部权限
/// You must obtain all permissions
Future<bool> getAllPermissions(List<Permission> permissions, String? text,
    {bool showAlert = true,
    Function? alert,
    GestureTapCallback? cancelTap}) async {
  if (!isMobile) return false;
  final Map<Permission, PermissionStatus> status = await permissions.request();
  permissions = <Permission>[];
  status.forEach((Permission key, PermissionStatus value) {
    if (!value.isGranted) permissions.add(key);
  });
  if (permissions.isNotEmpty) {
    if (showAlert) {
      if (alert != null) {
        alert.call();
      } else {
        showAlertSureCancel(
            text: '该服务需要开启$text授权',
            sureTap: () async {
              final bool state = await openAppSettings();
              if (!state) showAlertMessage(text: '无法打开设置，请手动前往设置开启权限');
            },
            cancelTap: cancelTap);
      }
    }
    return false;
  }
  return true;
}

/// 获取的权限中有其中一个就可以通过
/// One of the permissions obtained can be passed
Future<bool> getPermissions(List<Permission> permissions, String? text,
    {bool showAlert = true,
    Function? alert,
    GestureTapCallback? cancelTap}) async {
  if (!isMobile) return false;
  final List<bool> allState = <bool>[];
  for (final Permission permission in permissions) {
    final bool state = await getPermission(permission, text, showAlert: false);
    allState.add(state);
    if (state) break;
  }
  if (!allState.contains(true)) {
    if (showAlert) {
      if (alert != null) {
        alert.call();
      } else {
        showAlertSureCancel(
            text: '该服务需要开启$text授权',
            sureTap: openAppSettings,
            cancelTap: cancelTap);
      }
    } else {
      final bool state = await openAppSettings();
      if (!state) showAlertMessage(text: '无法打开设置，请手动前往设置开启权限');
    }
    return false;
  }
  return true;
}

/// 请求权限  旧版请求权限
/// Request permission Old version request permission
Future<bool> requestPermission(Permission permission,
    {Function? showAlert}) async {
  if (!isMobile) return false;
  final PermissionStatus status = await permission.status;
  if (!status.isGranted) {
    final Map<Permission, PermissionStatus> statuses =
        await <Permission>[].request();
    if (!(statuses[permission] == PermissionStatus.granted)) {
      if (showAlert != null) {
        showAlert.call();
      } else {
        openAppSettings();
      }
    }
    return statuses[permission] == PermissionStatus.granted;
  }
  return true;
}
