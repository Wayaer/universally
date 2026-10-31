import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key});

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  Map<String, dynamic> deviceInfoData = {};

  @override
  void initState() {
    super.initState();
    addPostFrameCallback((_) {
      getDeviceInfo();
    });
  }

  void getDeviceInfo() async {
    final deviceInfo = await DeviceInfoPlus().platform;
    deviceInfoData = deviceInfo?.data ?? {};
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    deviceInfoData.entriesMapKVToList((k, v) {
      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            TextLarge(k),
            TextMedium('$v', maxLines: 10, textAlign: TextAlign.end).flexible,
          ],
        ),
      );
    });
    return BaseScaffold(
      appBarTitleText: 'Device Info',
      spacing: 20,
      padding: EdgeInsets.all(16),
      isScroll: true,
      children: children,
    );
  }
}
