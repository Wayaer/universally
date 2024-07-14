import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseThemeData {
  BaseThemeData._();

  static ThemeData light({ThemeData? themeData, bool? useMaterial3}) =>
      ThemeData(
        brightness: Brightness.light,
        useMaterial3: useMaterial3,
      ).copyWith();

  static ThemeData dark({ThemeData? themeData, bool? useMaterial3}) =>
      ThemeData(
        brightness: Brightness.dark,
        useMaterial3: useMaterial3,
      ).copyWith();
}

class UThemeData {
  UThemeData({
    this.mainColor,
    this.toastOptions,
    this.generalDialogOptions,
    this.bottomSheetOptions,
    this.modalOptions,
    this.wheelOptions,
    this.loadingOptions,
    this.textStyle,
    this.textField,
  });

  /// [BaseLoading] loading 颜色
  /// [ActionDialog] action 颜色
  Color? mainColor;

  /// 全局 Toast 配置信息
  ToastOptions? toastOptions;

  /// 全局 [ModalWindows] 组件配置信息
  ModalBoxOptions? modalOptions;

  /// 全局 [BottomSheetOptions] 配置信息
  BottomSheetOptions? bottomSheetOptions;

  /// 全局 [DialogOptions] 配置信息
  DialogOptions? generalDialogOptions;

  /// 全局 [WheelOptions] 配置信息
  WheelOptions? wheelOptions;

  /// loading 样式
  LoadingOptions? loadingOptions;

  /// 全局设置 [TextNormal],[TextSmall], [TextLarge], [TextExtraLarge] 字体样式
  TextThemeStyle? textStyle;

  /// 全局设置 [BaseTextField] 部分配置
  TextFieldConfig? textField;
}
