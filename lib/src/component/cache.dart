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
  String text = '0.00 MB';
  String? path;
  double size = 0.00;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback((duration) => 1.seconds.delayed(getSize));
  }

  @override
  void didUpdateWidget(covariant CleanCache oldWidget) {
    super.didUpdateWidget(oldWidget);
    addPostFrameCallback((duration) => 1.seconds.delayed(getSize));
  }

  void getSize() async {
    if (isWeb) return;
    final dir = await PathProvider().getTemporaryDirectory();
    getDirSize(dir!);
    if (isAndroid) {
      final dirs = await PathProvider().getExternalCacheDirectories();
      dirs?.forEach((element) {
        getDirSize(element);
      });
    }
    if (size > 0) {
      final double s = size / 1024 / 1024;
      text = '${s.toStringAsFixed(2)} MB';
    } else {
      text = '0.00 MB';
    }
    if (mounted) setState(() {});
  }

  void getDirSize(Directory dir) {
    if (dir.existsSync()) {
      final files = dir.listSync(recursive: true);
      for (var file in files) {
        if (file.existsSync()) {
          size += file.statSync().size;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => Universal(
    onTap: () {
      if (path == null || path!.isEmpty) return;
      final dir = Directory(path!);
      if (!dir.existsSync()) return;
      dir.delete(recursive: true);
      showToast('已清理');
      size = 0;
      1.seconds.delayed(getSize);
    },
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
  Widget build(BuildContext context) => XSwitch(
    value: push,
    onChanged: (value) {
      if (value == push) return;
      push = value;
      BasePreferences().setBool(UConst.isPush, push);
      setState(() {});
    },
  );
}
