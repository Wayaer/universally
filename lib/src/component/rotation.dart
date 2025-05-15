import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 扩展组件
class BaseExpansionTiles extends StatelessWidget {
  const BaseExpansionTiles({
    super.key,
    this.title,
    this.children = const [],
    this.child,
    this.backgroundColor,
    this.onExpansionChanged,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.fastOutSlowIn,
    this.titleText,
    this.iconData = Icons.expand_more,
    this.icon,
    this.leading,
    this.subtitle,
    this.builder,
    this.shape,
    this.contentPadding,
    this.enabled = true,
  });

  /// 旋转的图标
  final IconData iconData;

  /// 旋转的图标
  final ExpansionTilesRotationIconBuilder? icon;

  /// [ListTile.title]
  final String? titleText;
  final Widget? title;

  /// [ListTile.leading]
  final Widget? leading;

  /// [ListTile.subtitle]
  final Widget? subtitle;

  /// [ListTile.shape]
  final ShapeBorder? shape;

  /// [ListTile.contentPadding]
  final EdgeInsetsGeometry? contentPadding;

  /// [ListTile.enabled]
  final bool enabled;

  /// 展开的子组件
  final List<Widget> children;
  final Widget? child;

  /// 构造器
  final ExpansionTilesBuilderListTile? builder;

  /// 展开时的背景颜色，
  final Color? backgroundColor;

  /// 展开时长
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 展开或关闭监听
  final ValueChanged<bool>? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return ExpansionTiles(
      icon:
          icon ??
          (bool isExpanded) => Icon(
            iconData,
            color:
                isExpanded
                    ? context.theme.primaryColor
                    : context.theme.disabledColor,
          ),
      builder:
          builder ??
          (
            BuildContext context,
            VoidCallback expand,
            bool isExpanded,
            Widget? rotation,
          ) => ListTile(
            onTap: expand,
            leading: leading,
            title: title ?? TextLarge(titleText),
            subtitle: subtitle,
            trailing: rotation,
            shape: shape,
            contentPadding: contentPadding,
            enabled: enabled,
            dense: true,
          ),
      onExpansionChanged: onExpansionChanged,
      backgroundColor: backgroundColor,
      curve: curve,
      duration: duration,
      child: child,
      children: children,
    );
  }
}

typedef BasePopupMenuButtonBuilder<T> = Widget Function(T? value, Widget icon);
typedef BasePopupMenuButtonItemBuilder<T> = Widget Function(T value);

/// 下拉菜单
class BasePopupMenuButton<T> extends StatelessWidget {
  const BasePopupMenuButton({
    required this.list,
    super.key,
    this.initialValue,
    this.iconData = Icons.keyboard_arrow_down_rounded,
    this.onSelected,
    required this.builder,
    required this.itemBuilder,
    this.icon,
    this.offset = const Offset(0, 10),
    this.shape,
    this.padding = const EdgeInsets.all(8.0),
    this.popUpAnimationStyle,
    this.splashRadius,
    this.style,
    this.onOpened,
    this.onCanceled,
    this.constraints,
    this.enableFeedback,
    this.tooltip,
    this.elevation,
    this.shadowColor,
    this.enabled = true,
    this.position,
  });

  /// 初始值
  final T? initialValue;

  /// 菜单列表
  final List<T> list;

  /// [PopupMenuButton.child] 构建
  final BasePopupMenuButtonBuilder<T> builder;

  /// [PopupMenuButton.itemBuilder] 构建
  final BasePopupMenuButtonItemBuilder<T> itemBuilder;

  /// 旋转的图标
  final IconData iconData;

  /// 旋转的icon
  final ToggleRotateIconBuilder? icon;

  /// 选择后回调
  final PopupMenuItemSelected<T>? onSelected;

  /// menu offset
  final Offset offset;

  /// [PopupMenuButton.shape]
  final ShapeBorder? shape;

  /// [PopupMenuButton.padding]
  final EdgeInsetsGeometry padding;

  /// [PopupMenuButton.popUpAnimationStyle]
  final AnimationStyle? popUpAnimationStyle;

  /// [PopupMenuButton.splashRadius]
  final double? splashRadius;

  /// [PopupMenuButton.style]
  final ButtonStyle? style;

  /// [PopupMenuButton.onOpened]
  final VoidCallback? onOpened;

  /// [PopupMenuButton.onCanceled]
  final PopupMenuCanceled? onCanceled;

  /// [PopupMenuButton.constraints]
  final BoxConstraints? constraints;

  /// [PopupMenuButton.enableFeedback]
  final bool? enableFeedback;

  /// [PopupMenuButton.tooltip]
  final String? tooltip;

  ///  [PopupMenuButton.elevation]
  final double? elevation;

  /// [PopupMenuButton.shadowColor]
  final Color? shadowColor;

  /// [PopupMenuButton.enabled]
  final bool enabled;

  /// [PopupMenuButton.position]
  final PopupMenuPosition? position;

  @override
  Widget build(BuildContext context) {
    T? selected = initialValue;
    return PopupMenuButtonRotateBuilder(
      icon:
          icon ??
          Icon(
            iconData,
            color: context.theme.textTheme.bodyMedium?.color,
            size: 22,
          ).toToggleRotateIconBuilder,
      builder: (
        BuildContext context,
        Widget rotateIcon,
        VoidCallback onOpened,
        VoidCallback onClosed,
      ) {
        return PopupMenuButton<T>(
          initialValue: initialValue,
          offset: offset,
          position: position ?? PopupMenuPosition.under,
          onOpened: () {
            onOpened();
            this.onOpened?.call();
          },
          onCanceled: () {
            onClosed();
            onCanceled?.call();
          },
          onSelected: (value) {
            selected = value;
            onClosed();
            onSelected?.call(value);
          },
          shape: shape ?? ArrowShape(borderRadius: BorderRadius.circular(6)),
          constraints: constraints,
          enableFeedback: enableFeedback,
          tooltip: tooltip,
          elevation: elevation,
          shadowColor: shadowColor,
          enabled: enabled,
          padding: padding,
          splashRadius: splashRadius,
          style: style,
          popUpAnimationStyle: popUpAnimationStyle,
          itemBuilder:
              (_) => list.builder(
                (item) =>
                    PopupMenuItem<T>(value: item, child: itemBuilder(item)),
              ),
          child: builder(selected, rotateIcon),
        );
      },
    );
  }
}
