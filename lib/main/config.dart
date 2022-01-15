import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ProjectConfig {
  ProjectConfig(
      {required this.mainColor,
      required this.betaUrl,
      required this.releaseUrl,
      this.pushStyle = RoutePushStyle.cupertino,
      this.pullDownHeader,
      this.pullUpFooter,
      this.scaffoldBackground = UCS.background,
      this.appBarElevation = 0,
      this.appPath,
      this.placeholder = const PlaceholderChild(),
      this.toastOptions =
          const ToastOptions(duration: Duration(seconds: 2), ignoring: true),
      this.pickerWheelOptions,
      this.generalDialogOptions,
      this.bottomSheetOptions,
      this.modalWindowsOptions,
      this.logHasDottedLine = true,
      this.wheelOptions,
      this.initializeSP = true,
      this.loadingStyle = SpinKitStyle.circle,
      this.imageFailed}) {
    imageFailed ??= TextSmall('加载失败', fontSize: 10);
    pullDownHeader ??= ClassicalHeader(
        refreshedText: 'Refresh to complete',
        refreshingText: 'refreshing',
        refreshText: 'The drop-down refresh',
        textColor: UCS.titleTextColor,
        infoColor: mainColor,
        refreshReadyText: 'Release Refresh now',
        showInfo: false);
    pullUpFooter ??= ClassicalFooter(
        showInfo: false,
        noMoreText: '我是有底线的~',
        loadText: 'Pull up to load more',
        loadingText: 'Being loaded',
        loadFailedText: 'Load failed',
        textColor: UCS.titleTextColor,
        infoColor: mainColor,
        loadedText: 'loaded',
        loadReadyText: '123123');
  }

  /// alert 确认按钮颜色
  /// [BaseLoading] loading 颜色
  Color mainColor;

  /// 保存图片和视频的缓存地址
  AppPathModel? appPath;

  /// 测试版 url 包含 debug 模式
  String betaUrl;

  /// 正式版 url
  String releaseUrl;

  /// 当前项目使用的 url
  String? currentUrl;

  /// 当前项目 全局使用的 刷新Header
  Header? pullDownHeader;

  /// 当前项目 全局使用的 刷新Footer
  Footer? pullUpFooter;

  /// 当前项目 全局使用的 [BaseScaffold] 的背景色
  Color scaffoldBackground;

  /// 当前项目 全局使用的 [BaseAppBar] 的 elevation
  double appBarElevation;

  /// list 占位图
  Widget placeholder;

  /// 全局 Toast 配置信息
  ToastOptions toastOptions;

  /// 全局 [PopupModalWindows] 组件配置信息
  ModalWindowsOptions? modalWindowsOptions;

  /// 全局 [BottomSheetOptions] 配置信息
  BottomSheetOptions? bottomSheetOptions;

  /// 全局 [GeneralDialogOptions] 配置信息
  GeneralDialogOptions? generalDialogOptions;

  /// 全局 [PickerWheelOptions] 配置信息
  PickerWheelOptions? pickerWheelOptions;

  /// 全局 [WheelOptions] 配置信息
  WheelOptions? wheelOptions;

  /// 全局log是否添加分割线
  bool logHasDottedLine;

  /// 全局路由跳转样式
  RoutePushStyle pushStyle;

  /// 初始化 shared_preferences
  bool initializeSP;

  /// loading 样式
  SpinKitStyle loadingStyle;

  /// [BaseImage] 加载失败时显示的组件
  Widget? imageFailed;
}

