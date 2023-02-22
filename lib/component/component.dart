import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

export 'src/gif.dart';
export 'src/list.dart';
export 'src/picker.dart';
export 'src/popup.dart';
export 'src/scaffold.dart';
export 'src/text.dart';
export 'src/text_field.dart';
export 'src/widgets.dart';
export 'user_privacy.dart';
export 'switch_api.dart';

class ScanCodeShowPage extends StatelessWidget {
  const ScanCodeShowPage({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => BasicScaffold(
      appBarTitle: '扫码结果',
      padding: const EdgeInsets.all(20),
      child: SimpleButton(
          onTap: () {
            text.toClipboard;
            showToast('复制成功');
          },
          text: text,
          maxLines: 100,
          textStyle: const TStyle(color: UCS.black, fontSize: 15)));
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
    addPostFrameCallback((_) {
      push = BHP().getBool(UConst.isPush) ?? true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => BasicSwitch(
      value: push,
      onChanged: (value) {
        if (value == push) return;
        push = value;
        BHP().setBool(UConst.isPush, push);
        setState(() {});
      });
}

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

  void getSize() {
    path = GlobalConfig().currentCacheDir;
    if (path == null || path!.isEmpty) return;
    getDirSize(path!);
    if (size > 0) {
      final double s = size / 1024 / 1024;
      text = '${s.toStringAsFixed(2)} MB';
    } else {
      text = '0.00 MB';
    }
    setState(() {});
  }

  void getDirSize(String path) {
    final dir = Directory(path);
    if (dir.existsSync()) {
      final files = dir.listSync(recursive: true);
      files.builder((file) {
        if (file.existsSync()) {
          size += file.statSync().size;
        }
      });
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
      child: TextSmall(text, color: widget.color));
}
