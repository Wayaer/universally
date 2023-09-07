import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BottomPadding extends StatelessWidget {
  const BottomPadding(
      {super.key,
      this.left = 20,
      this.top = 10,
      this.right = 20,
      this.bottom = 10,
      required this.child,
      this.color});

  final double left;
  final double top;
  final double right;
  final double bottom;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) => Universal(
      color: color,
      padding: EdgeInsets.fromLTRB(
          left, top, right, context.bottomNavigationBarHeight + bottom),
      child: child);
}

class BasicDivider extends Divider {
  const BasicDivider(
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
              size: 80, color: Global().config.textColor?.defaultColor),
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
              color: Global().config.textColor?.smallColor?.withOpacity(0.3)),
          title: TextSmall('什么也没有哎~', fontType: FontType.medium)));
}

class BasicSwitch extends ChangedBuilder<bool> {
  BasicSwitch({
    super.key,
    required super.value,
    Color? activeColor,
    Color? trackColor,
    Color thumbColor = Colors.white,
    super.onChanged,
    super.onWaitChanged,
  }) : super(
            builder: (bool value, onChanged) => XSwitch(
                activeColor: activeColor ?? Global().mainColor,
                trackColor: trackColor,
                thumbColor: thumbColor,
                value: value,
                onChanged: onChanged));
}

class BasicCupertinoSwitch extends ChangedBuilder<bool> {
  BasicCupertinoSwitch({
    super.key,
    required super.value,
    Color? activeColor,
    Color? activeTrackColor,
    MaterialStateProperty<Color?>? trackColor,
    MaterialStateProperty<Color?>? thumbColor,
    super.onChanged,
    super.onWaitChanged,
  }) : super(
            builder: (bool value, onChanged) => Switch.adaptive(
                trackColor: trackColor,
                thumbColor: thumbColor,
                activeTrackColor: activeTrackColor,
                activeColor: activeColor ?? Global().mainColor,
                value: value,
                onChanged: onChanged));
}

class BasicCheckbox extends ChangedBuilder<bool?> {
  BasicCheckbox({
    super.key,
    required super.value,
    Color? activeColor,
    super.onChanged,
    super.onWaitChanged,
    OutlinedBorder? shape,
  }) : super(
            builder: (bool? value, onChanged) => Checkbox(
                shape: shape,
                activeColor: activeColor ?? Global().mainColor,
                value: value,
                onChanged: onChanged));
}

class UButton extends Universal {
  UButton({
    super.key,
    super.color,
    super.margin,
    super.width = double.infinity,
    super.height = 45,
    bool enabled = true,
    super.visible = true,
    Widget? child,
    String? text,
    GestureTapCallback? onTap,
    super.alignment = Alignment.center,
  }) : super(
            heroTag: text,
            child: child ??
                BText(text ?? '', style: const TStyle(color: UCS.white)),
            onTap: enabled ? onTap : null,
            decoration: BoxDecoration(
                border: Border.all(color: Global().mainColor),
                color: color ?? Global().mainColor,
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
