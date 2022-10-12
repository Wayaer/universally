import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

export 'src/alert.dart';
export 'src/gif.dart';
export 'src/input_text.dart';
export 'src/list.dart';
export 'src/picker.dart';
export 'src/scaffold.dart';
export 'src/text.dart';
export 'src/text_field.dart';
export 'src/widgets.dart';

class BottomPadding extends Universal {
  BottomPadding(
      {super.key,
      double left = 20,
      double top = 10,
      double right = 20,
      double bottom = 10,
      super.child,
      super.color})
      : super(
            padding: EdgeInsets.fromLTRB(
                left, top, right, getBottomNavigationBarHeight + bottom));
}

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

class CustomDivider extends Divider {
  const CustomDivider(
      {super.color = UCS.background,
      super.key,
      super.endIndent,
      super.indent,
      super.thickness,
      super.height = 1});
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

/// 局部 异步加载数据
class BasicFutureBuilder<T> extends ExtendedFutureBuilder<T> {
  BasicFutureBuilder({
    super.key,
    super.initialData,
    required super.future,
    required super.onDone,
    Widget Function(BuildContext context, Function() reset)? onNull,
    Widget Function(BuildContext context, Function() reset)? onNone,
  }) : super(
            onNull:
                onNull ?? (_, __) => const Center(child: PlaceholderWidget()),
            onNone:
                onNone ?? (_, __) => const Center(child: PlaceholderWidget()),
            onWaiting: (_) => Center(child: BasicLoading()),
            onError: (_, __, reset) => BasicError(onTap: reset));
}

class BasicError extends StatelessWidget {
  const BasicError({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Universal(alignment: Alignment.center, onTap: onTap, children: [
      SVGAsset(UAS.noDataIcon, height: 90, package: 'universally'),
      const SizedBox(height: 10),
      TextDefault('加载失败，点击刷新', fontSize: 13)
    ]);
  }
}

class BasicSwitch extends SwitchState {
  BasicSwitch({
    super.key,
    required super.value,
    Color? activeColor,
    super.activeTrackColor,
    super.onChanged,
    super.onWaitChanged,
  }) : super.adaptive(activeColor: activeColor ?? GlobalConfig().currentColor);
}

class BasicCupertinoSwitch extends CupertinoSwitchState {
  BasicCupertinoSwitch({
    super.key,
    required super.value,
    Color? activeColor,
    super.trackColor,
    super.thumbColor,
    super.onChanged,
    super.onWaitChanged,
  }) : super(activeColor: activeColor ?? GlobalConfig().currentColor);
}

class BasicCheckbox extends CheckboxState {
  BasicCheckbox({
    super.key,
    required super.value,
    Color? activeColor,
    super.onChanged,
    super.onWaitChanged,
  }) : super(activeColor: activeColor ?? GlobalConfig().currentColor);
}
