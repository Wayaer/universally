import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PackageInfoPage extends StatefulWidget {
  const PackageInfoPage({super.key});

  @override
  State<PackageInfoPage> createState() => _PackageInfoPageState();
}

class _PackageInfoPageState extends State<PackageInfoPage> {
  Map<String, dynamic> packageInfoData = {};

  @override
  void initState() {
    super.initState();
    addPostFrameCallback((_) {
      getPackageInfo();
    });
  }

  void getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    packageInfoData = packageInfo.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    packageInfoData.entriesMapKVToList((k, v) {
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
      appBarTitleText: 'Package Info',
      isScroll: true,
      spacing: 20,
      padding: EdgeInsets.all(16),
      children: children,
    );
  }
}
