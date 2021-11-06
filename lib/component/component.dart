import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

export 'src/alert.dart';
export 'src/list.dart';
export 'src/picker.dart';
export 'src/scaffold.dart';
export 'src/text.dart';

/// 清除缓存右边的组件
class CleanCache extends StatefulWidget {
  const CleanCache({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  _CleanCacheState createState() => _CleanCacheState();
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
    path = currentCacheDir;
    if (path == null || path!.isEmpty) return;
    getDirSize(path!);
    if (size > 0) {
      final double s = size / 1024 / 1024;
      text = s.toStringAsFixed(2) + ' MB';
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

class BottomPadding extends Universal {
  BottomPadding(
      {Key? key,
      double left = 20,
      double top = 10,
      double right = 20,
      double bottom = 10,
      Widget? child,
      Color? color})
      : super(
            key: key,
            child: child,
            color: color,
            padding: EdgeInsets.fromLTRB(
                left, top, right, getBottomNavigationBarHeight + bottom));
}

class ScanCodeShowPage extends StatelessWidget {
  const ScanCodeShowPage({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBarTitle: '扫码结果',
        padding: const EdgeInsets.all(20),
        child: SimpleButton(
            onTap: () {
              text.toClipboard;
              showToast('复制成功');
            },
            text: text,
            maxLines: 100,
            textStyle: TStyle(color: UCS.black, fontSize: 15)));
  }
}

class CustomDivider extends Divider {
  const CustomDivider(
      {Color? color,
      Key? key,
      double? endIndent,
      double? indent,
      double? thickness,
      double height = 1})
      : super(
            key: key,
            color: color ?? UCS.background,
            height: height,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent);
}

extension ExtensionNotificationListener on Widget {
  Widget interceptNotificationListener<T extends Notification>(
          {NotificationListenerCallback<T>? onNotification}) =>
      NotificationListener<T>(
          onNotification: (T notification) {
            if (onNotification != null) onNotification(notification);
            return true;
          },
          child: this);
}
