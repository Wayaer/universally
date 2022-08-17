import 'dart:io';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 消息推送开关
class PushSwitchState extends StatefulWidget {
  const PushSwitchState({Key? key}) : super(key: key);

  @override
  State<PushSwitchState> createState() => _PushStateState();
}

class _PushStateState extends State<PushSwitchState> {
  bool push = false;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback((_) {
      push = SP().getBool(UConstant.isPush) ?? true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => BasicSwitch(
      value: push,
      onChanged: (value) {
        if (value == push) return;
        push = value;
        SP().setBool(UConstant.isPush, push);
        setState(() {});
      });
}

/// 清除缓存右边的组件
/// Clear the component to the right of the cache
class CleanCache extends StatefulWidget {
  const CleanCache({Key? key, this.color}) : super(key: key);

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

class UButton extends SimpleButton {
  UButton({
    Key? key,
    Color? color,
    required String text,
    EdgeInsetsGeometry? margin,
    double width = UConstant.longWidth,
    double height = 45,
    bool enabled = true,
    bool visible = true,
    Widget? child,
    GestureTapCallback? onTap,
  }) : super(
            key: key,
            margin: margin,
            heroTag: text,
            isElastic: true,
            width: width,
            height: height,
            alignment: Alignment.center,
            onTap: enabled ? onTap : null,
            child: child,
            text: text,
            textStyle: const TStyle(color: UCS.white),
            visible: visible,
            decoration: BoxDecoration(
                border: Border.all(color: GlobalConfig().currentColor),
                color: color ?? GlobalConfig().currentColor,
                borderRadius: BorderRadius.circular(8)));
}

class USpacing extends StatelessWidget {
  const USpacing(
      {Key? key,
      this.spacing = 6,
      this.horizontal = false,
      this.color,
      this.height,
      this.width})
      : super(key: key);

  final double? spacing;
  final bool horizontal;
  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) => Container(
      color: color,
      height: height ?? (horizontal ? 0 : spacing),
      width: width ?? (horizontal ? spacing : 0));
}
