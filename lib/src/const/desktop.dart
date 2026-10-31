import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart' show TitleBarStyle;

/// 桌面窗口初始化参数，在窗口显示前通过 Universally.setConfig 应用
///
/// 所有参数均为可选，为 null 时保持窗口原有配置
/// 仅在 macOS、Windows、Linux 桌面端生效
class WindowOptions {
  const WindowOptions({
    this.size,
    this.center,
    this.minimumSize,
    this.maximumSize,
    this.alwaysOnTop,
    this.fullScreen,
    this.backgroundColor,
    this.skipTaskbar,
    this.title,
    this.titleBarStyle,
    this.windowButtonVisibility,
  });

  /// 窗口初始大小，单位为逻辑像素，例如 `Size(375, 667)`
  /// 为 null 时沿用当前窗口大小
  final Size? size;

  /// 应用 [size] 后是否将窗口居中显示
  /// 为 true 时窗口会移动到屏幕中央，默认不居中
  final bool? center;

  /// 窗口最小尺寸限制，用户拖拽或代码调整时窗口不会小于该尺寸
  /// 为 null 时不限制最小尺寸
  final Size? minimumSize;

  /// 窗口最大尺寸限制，用户拖拽或代码调整时窗口不会大于该尺寸
  /// 为 null 时不限制最大尺寸
  final Size? maximumSize;

  /// 是否始终置顶，显示在所有普通窗口之上
  /// 为 null 时保持当前置顶状态
  final bool? alwaysOnTop;

  /// 是否以全屏模式显示
  /// 为 false 时会先退出全屏、最大化、最小化状态，再应用其他参数
  final bool? fullScreen;

  /// 窗口背景色，在窗口内容首帧渲染前生效，可避免启动时出现白屏或闪烁
  /// 为 null 时保持系统默认背景
  final Color? backgroundColor;

  /// 是否在任务栏中隐藏窗口，true 表示不显示任务栏图标（Windows 任务栏、macOS Dock）
  /// 为 null 时保持当前任务栏显示状态
  final bool? skipTaskbar;

  /// 窗口标题，显示在窗口标题栏或任务栏中
  /// 为 null 时保持当前标题
  final String? title;

  /// 标题栏样式，仅 macOS 生效，如 `TitleBarStyle.hidden` 隐藏系统标题栏
  /// 为 null 时保持系统默认标题栏
  final TitleBarStyle? titleBarStyle;

  /// 是否显示系统窗口按钮（关闭、最小化、最大化）
  /// 仅在设置 [titleBarStyle] 时生效，为 null 时按显示处理
  final bool? windowButtonVisibility;
}

enum WindowsSize {
  /// set desktop size to iphone 4.7
  iPhone4P7(Size(375, 667)),

  /// set desktop size to iphone 5.4
  iPhone5P4(Size(360, 780)),

  /// set desktop size to iphone 5.5
  iPhone5P5(Size(414, 736)),

  /// set desktop size to iphone 5.8
  iPhone5P8(Size(375, 812)),

  /// set desktop size to iphone 6.1
  iPhone6P1(Size(414, 896)),

  /// set desktop size to iphone 6.7
  iPhone6P7(Size(430, 932)),

  /// set desktop size to 7.9
  iPad7P9(Size(1024, 768)),

  /// set desktop size to ipad 10.5
  iPad10P5(Size(834, 1112)),

  /// set desktop size to ipad 11
  iPad11(Size(834, 1194)),

  /// set desktop size to ipad 11
  iPad12P9(Size(1024, 1366));

  const WindowsSize(this.size);

  final Size size;

  Size get value => size;

  Size scaling([double p = 1]) => Size(size.width / p, size.height / p);

  Size get exchange => Size(size.height, size.width);
}
