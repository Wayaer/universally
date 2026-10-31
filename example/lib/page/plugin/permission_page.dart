import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  final List<Permission> permissions = [
    Permission.camera,
    Permission.microphone,
    Permission.photos,
    Permission.storage,
    Permission.locationWhenInUse,
    Permission.notification,
    Permission.contacts,
    Permission.calendarFullAccess,
    Permission.calendarWriteOnly,
    Permission.bluetooth,
    Permission.phone,
    Permission.sms,
  ];

  final Map<Permission, PermissionStatus> status = {};

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    for (final Permission permission in permissions) {
      try {
        status[permission] = await permission.status;
      } catch (error) {
        DemoLog.instance.add('读取 $permission 状态失败：$error');
      }
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: '权限',
    appBarActions: [IconButton(onPressed: refresh, icon: const Icon(Icons.refresh))],
    children: [
      DemoSection(
        title: 'Permission 状态',
        description: 'permission_handler 最新版本，HarmonyOS 使用 permission_handler_harmonyos 实现。',
        children: [
          for (final Permission permission in permissions)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: TextMedium(permission.toString().split('.').last)),
                  const SizedBox(width: 12),
                  Flexible(
                    child: TextSmall(
                      '${status[permission]} / authorized: ${status[permission]?.authorized ?? false}',
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      color: context.theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      DemoSection(
        title: '请求权限',
        description: 'checkPermission / checkPermissions / checkRequestPermission / checkRequestPermissions。',
        children: [
          DemoButton(
            text: '申请相机权限（带提示）',
            onTap: () async {
              final bool result = await checkRequestPermission(
                Permission.camera,
                beforeRequestPrompt: '需要相机权限以拍摄照片',
                jumpSettingsPrompt: '相机权限未开启，请前往设置开启',
              );
              showToast('结果：$result');
              await refresh();
            },
          ),
          DemoButton(
            text: '申请相机 + 麦克风',
            onTap: () async {
              final bool result = await checkRequestPermissions(
                [Permission.camera, Permission.microphone],
                beforeRequestPrompt: '需要相机与麦克风权限',
                jumpSettingsPrompt: '权限未开启，请前往设置开启',
              );
              showToast('结果：$result');
              await refresh();
            },
          ),
          DemoButton(text: '打开应用设置', icon: Icons.settings, onTap: () => openAppSettings()),
          DemoButton(
            text: 'PermissionDialog',
            onTap: () => PermissionDialog.show(content: '这是权限说明弹窗内容'),
          ),
        ],
      ),
    ],
  );
}
