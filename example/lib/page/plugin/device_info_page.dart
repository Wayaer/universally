import 'dart:convert';

import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key});

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  String info = '';

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final BaseDeviceInfo? deviceInfo = await DeviceInfoPlus().platform;
    if (!mounted) return;
    setState(() {
      info = deviceInfo == null ? '当前平台不支持' : const JsonEncoder.withIndent('  ').convert(deviceInfo.data);
    });
  }

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: '设备信息',
    appBarActions: [IconButton(onPressed: load, icon: const Icon(Icons.refresh))],
    children: [
      DemoSection(
        title: 'DeviceInfoPlus',
        description: '封装 device_info_plus，提供 android / ios / macOS / windows / linux / webBrowserInfo 与统一 platform。',
        children: [
          DemoResult(text: info),
          const SizedBox(height: 6),
          DemoButton(
            text: 'Android 版本判断（androidAbove）',
            onTap: () async {
              final bool above = await DeviceInfoPlus().androidAbove(30);
              showToast('Android SDK >= 30: $above');
            },
          ),
        ],
      ),
    ],
  );
}
