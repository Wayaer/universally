import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

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

class CustomDivider extends Divider {
  const CustomDivider(
      {super.color = UCS.background,
      super.key,
      super.endIndent,
      super.indent,
      super.thickness = 0.5,
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
class BasicFutureBuilder<T> extends CustomFutureBuilder<T> {
  BasicFutureBuilder({
    super.key,
    super.initialData,
    required super.future,
    required super.onDone,
    CustomFutureBuilderNone? onNone,
  }) : super(
            onNone:
                onNone ?? (_, __) => const Center(child: BasicPlaceholder()),
            onWaiting: (_) => const Center(child: BasicLoading()),
            onError: (_, __, reset) => BasicError(onTap: reset));
}

/// 局部 异步加载数据
class BasicStreamBuilder<T> extends CustomStreamBuilder<T> {
  BasicStreamBuilder({
    super.key,
    super.initialData,
    required super.stream,
    required super.onDone,
    CustomBuilderContext? onNone,
  }) : super(
            onNone: onNone ?? (_) => const Center(child: BasicPlaceholder()),
            onWaiting: (_) => const Center(child: BasicLoading()),
            onError: (_, __) => const BasicError());
}

class BasicError extends StatelessWidget {
  const BasicError({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => Universal(
      onTap: onTap,
      child: IconBox(
          onTap: onTap,
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          spacing: 10,
          widget: Icon(WayIcons.empty,
              size: 80, color: GlobalConfig().config.textColor?.defaultColor),
          title: TextDefault('加载失败，点击刷新', fontType: FontType.medium)));
}

class BasicPlaceholder extends StatelessWidget {
  const BasicPlaceholder(
      {super.key, this.onTap, this.padding = const EdgeInsets.only(top: 100)});

  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => PlaceholderChild(
      padding: padding,
      child: IconBox(
          onTap: onTap,
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          spacing: 10,
          widget: Icon(WayIcons.empty,
              size: 80,
              color: GlobalConfig()
                  .config
                  .textColor
                  ?.smallColor
                  ?.withOpacity(0.3)),
          title: TextSmall('什么也没有哎~', fontType: FontType.medium)));
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

class UButton extends SimpleButton {
  UButton({
    super.key,
    super.color,
    required super.text,
    super.textStyle = const TStyle(color: UCS.white),
    super.margin,
    super.width = UConst.longWidth,
    super.height = 45,
    bool enabled = true,
    super.visible = true,
    super.child,
    GestureTapCallback? onTap,
    super.isElastic = true,
    super.alignment = Alignment.center,
  }) : super(
            heroTag: text,
            onTap: enabled ? onTap : null,
            decoration: BoxDecoration(
                border: Border.all(color: GlobalConfig().currentColor),
                color: color ?? GlobalConfig().currentColor,
                borderRadius: BorderRadius.circular(8)));
}

class USpacing extends StatelessWidget {
  const USpacing(
      {super.key,
      this.spacing = 6,
      this.horizontal = false,
      this.color,
      this.height,
      this.width});

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
