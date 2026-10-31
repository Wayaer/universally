import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PathProviderPage extends StatefulWidget {
  const PathProviderPage({super.key});

  @override
  State<PathProviderPage> createState() => _PathProviderPageState();
}

class _PathProviderPageState extends State<PathProviderPage> {
  String result = '';

  Future<void> showPath(String name, Future<Object?> Function() callback) async {
    final path = await callback();
    setState(() => result = '$name: ${path ?? '不支持当前平台'}');
  }

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: '路径',
    children: [
      DemoSection(
        title: 'PathProvider',
        description: '封装 path_provider，Web 平台返回 null。',
        children: [
          DemoButton(
            text: 'getTemporaryDirectory',
            onTap: () => showPath('临时目录', PathProvider().getTemporaryDirectory),
          ),
          DemoButton(
            text: 'getApplicationSupportDirectory',
            onTap: () => showPath('应用支持目录', PathProvider().getApplicationSupportDirectory),
          ),
          DemoButton(
            text: 'getApplicationDocumentsDirectory',
            onTap: () => showPath('文档目录', PathProvider().getApplicationDocumentsDirectory),
          ),
          DemoButton(
            text: 'getApplicationCacheDirectory',
            onTap: () => showPath('缓存目录', PathProvider().getApplicationCacheDirectory),
          ),
          DemoButton(
            text: 'getExternalStorageDirectory',
            onTap: () => showPath('外部存储', PathProvider().getExternalStorageDirectory),
          ),
          DemoButton(
            text: 'getExternalCacheDirectories',
            onTap: () => showPath('外部缓存', PathProvider().getExternalCacheDirectories),
          ),
          DemoButton(
            text: 'getDownloadsDirectory',
            onTap: () => showPath('下载目录', PathProvider().getDownloadsDirectory),
          ),
          DemoButton(
            text: 'getLibraryDirectory',
            onTap: () => showPath('Library 目录', PathProvider().getLibraryDirectory),
          ),
          DemoButton(text: 'getExternalDirectory', onTap: () => showPath('外部目录', PathProvider().getExternalDirectory)),
          DemoButton(
            text: 'getExternalApplicationCacheDirectory',
            onTap: () => showPath('外部应用缓存', PathProvider().getExternalApplicationCacheDirectory),
          ),
          DemoResult(text: result),
        ],
      ),
    ],
  );
}
