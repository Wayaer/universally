import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 清除缓存右边的组件
/// Clear the component to the right of the cache
class CleanCache extends StatefulWidget {
  const CleanCache({super.key, this.color});

  final Color? color;

  @override
  State<CleanCache> createState() => _CleanCacheState();
}

class _CleanCacheState extends State<CleanCache> {
  final List<Directory> directories = [];

  String text = '0.00 MB';

  @override
  void initState() {
    super.initState();
    addPostFrameCallback((duration) => 1.seconds.delayed(getSize));
  }

  Future<void> collectDirectories() async {
    if (isWeb) return;
    directories.clear();
    final temp = await PathProvider().getTemporaryDirectory();
    if (temp != null) directories.add(temp);
    if (isAndroid) {
      final dirs = await PathProvider().getExternalCacheDirectories();
      if (dirs != null) directories.addAll(dirs);
    }
  }

  Future<void> getSize() async {
    if (isWeb) return;
    await collectDirectories();
    final size = directories.fold<double>(0, (previous, dir) => previous + directorySize(dir));
    text = size > 0 ? '${(size / 1024 / 1024).toStringAsFixed(2)} MB' : '0.00 MB';
    if (mounted) setState(() {});
  }

  double directorySize(Directory dir) {
    if (!dir.existsSync()) return 0;
    double size = 0;
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.existsSync()) {
        size += entity.statSync().size;
      }
    }
    return size;
  }

  Future<void> clearCache() async {
    // 首次统计尚未完成时点击，也要先拿到目录
    if (directories.isEmpty) await collectDirectories();
    if (!mounted) return;
    for (final dir in directories) {
      if (!dir.existsSync()) continue;
      for (final entity in dir.listSync()) {
        if (entity.existsSync()) entity.deleteSync(recursive: true);
      }
    }
    showToast('已清理');
    text = '0.00 MB';
    setState(() {});
    1.seconds.delayed(getSize);
  }

  @override
  Widget build(BuildContext context) => Universal(
    onTap: clearCache,
    child: TextSmall(text, color: widget.color),
  );
}

/// 消息推送开关
class PushSwitchState extends StatefulWidget {
  const PushSwitchState({super.key});

  @override
  State<PushSwitchState> createState() => _PushStateState();
}

class _PushStateState extends State<PushSwitchState> {
  bool push = false;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback((duration) {
      push = BasePreferences().getBool(UConst.isPush) ?? false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => FlSwitch(
    value: push,
    onChanged: (value) {
      if (value == push) return;
      push = value;
      BasePreferences().setBool(UConst.isPush, push);
      setState(() {});
    },
  );
}
