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
      this.placeholder = const PlaceholderWidget(),
      this.toastOptions =
          const ToastOptions(duration: Duration(seconds: 2), ignoring: true),
      this.pickerWheelOptions,
      this.generalDialogOptions,
      this.bottomSheetOptions,
      this.modalWindowsOptions,
      this.logHasDottedLine = true,
      this.wheelOptions,
      this.initializeSP = true,
      this.loadingStyle = SpinKitStyle.fadingCircle,
      this.imageFailed}) {
    imageFailed ??= TextSmall('加载失败', fontSize: 10);
    pullDownHeader ??= const ClassicHeader(
        dragText: '请尽情拉我',
        armedText: '可以松开我了',
        readyText: '我要开始刷新了',
        processingText: '我在拼命刷新中',
        processedText: '我已经刷新完成了',
        failedText: '我刷新失败了唉',
        noMoreText: '没有更多了',
        showMessage: false);
    pullUpFooter ??= const ClassicFooter(
        dragText: '请尽情拉我',
        armedText: '可以松开我了',
        readyText: '我要准备加载了',
        processingText: '我在拼命加载中',
        processedText: '我已经加载完成了',
        failedText: '我加载失败了唉',
        noMoreText: '没有更多了哦',
        showMessage: false);
  }

  /// alert 确认按钮颜色
  /// [BasicLoading] loading 颜色
  Color mainColor;

  /// 保存图片和视频的缓存地址
  AppPathModel? appPath;

  /// 测试版 url 包含 debug 模式
  String betaUrl;

  /// 正式版 url
  String releaseUrl;

  /// 当前项目 全局使用的 刷新Header
  Header? pullDownHeader;

  /// 当前项目 全局使用的 刷新Footer
  Footer? pullUpFooter;

  /// 当前项目 全局使用的 [BasicScaffold] 的背景色
  Color scaffoldBackground;

  /// 当前项目 全局使用的 [BasicAppBar] 的 elevation
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

  /// [BasicImage] 加载失败时显示的组件
  Widget? imageFailed;
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) => PlaceholderChild(
      child: IconBox(
          direction: Axis.vertical,
          spacing: 12,
          widget: SVGAsset(UAS.noDataIcon, width: 90, package: 'universally'),
          title: TextSmall('什么也没有哎~')));
}
