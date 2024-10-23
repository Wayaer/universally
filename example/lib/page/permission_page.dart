import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'Permission',
        children: [
          Button(
              onTap: () async {
                final res = await checkRequestPermission(
                  Permission.requestInstallPackages,
                  promptBeforeRequest: '请求安装app权限',
                  jumpSettingsPrompt: '跳转设置,修改权限',
                );
                showToast(res.toString());
              },
              text: 'requestInstallPackages'),
          Button(
              onTap: () async {
                final res = await checkPermission(Permission.camera);
                showToast(res.toString());
              },
              text: '[camera] checkPermission'),
          Button(
              onTap: () async {
                final res = await checkPermissions(await photosPermission());
                showToast(res.toString());
              },
              text: 'checkPermissions'),
          Button(
              onTap: () async {
                final res = await checkRequestPermission(Permission.camera,
                    jumpSettingsPrompt: '跳转设置,修改权限',
                    promptBeforeRequest: '本服务需要访问您的“相机”，以修改头像或上传图片');
                showToast(res.toString());
              },
              text: '[camera] checkRequestPermission'),
          Button(
              onTap: () async {
                final res = await checkRequestPermissions(
                    await photosPermission(),
                    jumpSettingsPrompt: '跳转设置,修改权限',
                    promptBeforeRequest: '本服务需要访问您的“相册”，以修改头像或上传图片');
                showToast(res.toString());
              },
              text: 'checkRequestPermissions'),
        ]);
  }
}
