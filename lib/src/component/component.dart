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

class BaseDivider extends Divider {
  const BaseDivider(
      {super.color,
      super.key,
      super.endIndent,
      super.indent,
      super.thickness = 0.5,
      super.height = 1});
}

class BaseError extends StatelessWidget {
  const BaseError({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => Universal(
      onTap: onTap,
      child: IconLabel(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          spacing: 10,
          icon: UIS.empty,
          size: 80,
          color: context.theme.textTheme.bodyMedium?.color,
          label:
              const TextMedium('加载失败，点击刷新', fontWeight: FontWeights.medium)));
}

class BasePlaceholder extends StatelessWidget {
  const BasePlaceholder(
      {super.key, this.onTap, this.padding = const EdgeInsets.only(top: 100)});

  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding,
      child: IconLabel(
          onTap: onTap,
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          spacing: 10,
          widget: Icon(UIS.empty,
              size: 80, color: context.theme.textTheme.bodyMedium?.color),
          label: const TextSmall('什么也没有哎~', fontWeight: FontWeights.medium)));
}

/// loading
class BaseLoading extends StatelessWidget {
  const BaseLoading(
      {super.key,
      this.size = 50,
      this.style = SpinKitStyle.fadingCircle,
      this.color,
      this.itemBuilder,
      this.duration = const Duration(milliseconds: 1200),
      this.controller});

  final SpinKitStyle style;
  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  Widget build(BuildContext context) => SpinKit(style,
      size: size,
      itemBuilder: itemBuilder,
      controller: controller,
      duration: duration,
      color: color ?? context.theme.primaryColor);
}

class UButton extends Universal {
  UButton({
    super.key,
    super.color,
    super.margin,
    super.width = double.infinity,
    super.height = 45,
    super.visible = true,
    super.alignment = Alignment.center,
    bool enabled = true,
    Widget? child,
    String? text,
    GestureTapCallback? onTap,
  }) : super(
            heroTag: text,
            child: child ??
                BText(text ?? '', style: const TStyle(color: UCS.white)),
            onTap: enabled ? onTap : null,
            decoration: BoxDecoration(
                border: Universally.to.getTheme() != null
                    ? Border.all(color: Universally.to.getTheme()!.primaryColor)
                    : null,
                color: color ?? Universally.to.getTheme()?.primaryColor,
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
