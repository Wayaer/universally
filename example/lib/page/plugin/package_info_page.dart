import 'dart:convert';

import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PackageInfoPage extends StatelessWidget {
  const PackageInfoPage({super.key});

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: '包信息',
    children: [
      DemoSection(
        title: 'PackageInfoPlus',
        description: '封装 package_info_plus，初始化后可直接读取应用名称、包名、版本与安装渠道。',
        children: [
          DemoResult(
            text: [
              'appName: ${PackageInfoPlus().appName}',
              'packageName: ${PackageInfoPlus().packageName}',
              'version: ${PackageInfoPlus().version}',
              'buildNumber: ${PackageInfoPlus().buildNumber}',
              'buildSignature: ${PackageInfoPlus().buildSignature}',
              'installerStore: ${PackageInfoPlus().installerStore}',
              '',
              const JsonEncoder.withIndent('  ').convert(PackageInfoPlus().data),
            ].join('\n'),
          ),
        ],
      ),
    ],
  );
}
