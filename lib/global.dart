import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

typedef LoadingCoreBuilder = Widget? Function(BasicLoading loading);

typedef ConsumerBuilder<T> = Widget Function(Widget child);

class ProjectConfig {
  ProjectConfig({
    required this.mainColor,
    this.betaApi = '',
    this.releaseApi = '',
    this.pushStyle = RoutePushStyle.material,
    this.pullDownHeader,
    this.pullUpFooter,
    this.scaffoldBackground,
    this.appBarConfig,
    this.cachePath,
    this.placeholder = const BasicPlaceholder(),
    this.toastOptions = const ToastOptions(
        positioned: Alignment.topCenter,
        duration: Duration(seconds: 2),
        ignoring: true),
    this.generalDialogOptions,
    this.bottomSheetOptions,
    this.modalWindowsOptions,
    this.logCrossLine = true,
    this.wheelOptions,
    this.loadingModalWindowsOptions,
    this.loadingBuilder,
    this.imageFailed,
    this.textColor,
  }) {
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
  /// 如不设置 默认通过 [Curiosity().native.appPath] 获取
  String? cachePath;

  /// 测试版 url 包含 debug 模式
  String betaApi;

  /// 正式版 url
  String releaseApi;

  /// 当前项目 全局使用的 刷新Header
  Header? pullDownHeader;

  /// 当前项目 全局使用的 刷新Footer
  Footer? pullUpFooter;

  /// 当前项目 全局使用的 [BasicScaffold] 的背景色
  Color? scaffoldBackground;

  /// list 占位图
  Widget placeholder;

  /// 全局 Toast 配置信息
  ToastOptions toastOptions;

  /// 全局 [ModalWindows] 组件配置信息
  ModalWindowsOptions? modalWindowsOptions;

  /// 全局 [BottomSheetOptions] 配置信息
  BottomSheetOptions? bottomSheetOptions;

  /// 全局 [DialogOptions] 配置信息
  DialogOptions? generalDialogOptions;

  /// 全局 [WheelOptions] 配置信息
  WheelOptions? wheelOptions;

  /// 全局log是否添加分割线
  bool logCrossLine;

  /// 全局路由跳转样式
  RoutePushStyle pushStyle;

  /// loading 样式
  ModalWindowsOptions? loadingModalWindowsOptions;
  LoadingCoreBuilder? loadingBuilder;

  /// [BasicImage] 加载失败时显示的组件
  Widget? imageFailed;

  /// 字体颜色
  TextColor? textColor;

  /// 当前项目 全局使用的 [BasicAppBar]
  AppBarConfig? appBarConfig;
}

class AppBarConfig {
  AppBarConfig(
      {this.backgroundColor,
      this.titleColor,
      this.elevation,
      this.iconTheme,
      this.systemOverlayStyle});

  /// 当前项目 全局使用的 [BasicAppBar] 的背景色
  Color? backgroundColor;

  /// 当前项目 全局使用的 [BasicAppBar] 的文字颜色
  Color? titleColor;

  /// 当前项目 全局使用的 [BasicAppBar] 的 elevation
  double? elevation;

  /// 当前项目 全局使用的 [BasicAppBar] 的 iconTheme
  IconThemeData? iconTheme;

  /// 当前项目 全局使用的 [BasicAppBar] 的 systemOverlayStyle
  SystemUiOverlayStyle? systemOverlayStyle;
}

class TextColor {
  TextColor(
      {this.smallColor,
      this.defaultColor,
      this.largeColor,
      this.veryLargeColor,
      this.styleColor});

  /// 超大字体颜色
  Color? veryLargeColor;

  /// 大字体颜色
  Color? largeColor;

  /// 默认字体颜色
  Color? defaultColor;

  /// 小字体颜色
  Color? smallColor;

  /// [TStyle] color
  Color? styleColor;
}

class GlobalConfig {
  factory GlobalConfig() => _singleton ??= GlobalConfig._();

  GlobalConfig._();

  static GlobalConfig? _singleton;

  /// alert 确认按钮颜色
  /// [AssetSelect]  Badge 背景色
  /// [BasicLoading] loading 颜色
  late Color currentColor;

  /// 保存图片和视频的缓存地址
  String? currentCacheDir;

  /// 当前项目使用的 url
  late String _currentApi;

  String get currentApi => _currentApi;

  /// 项目配置信息
  ProjectConfig _config = ProjectConfig(mainColor: UCS.mainBlack);

  ProjectConfig get config => _config;

  /// 设置app 一些默认参数
  Future<void> setDefaultConfig(
    ProjectConfig config, {
    bool? enableBeta,
    String? channel,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    _config = config;

    const env = String.fromEnvironment(UConst.channel);
    if (env.isNotEmptyOrNull) {
      currentChannel = env;
      isBeta = currentChannel == UConst.beta;
    }
    if (enableBeta != null) isBeta = enableBeta;
    if (channel != null) currentChannel = channel;

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    /// 初始化本地储存
    await BHP().init();

    currentColor = config.mainColor;
    final bool isRelease = BHP().getBool(UConst.isRelease) ?? false;
    if (isBeta && !isRelease) {
      _currentApi = config.betaApi;
      final String? localApi = BHP().getString(UConst.localApi);
      if (localApi != null && localApi.length > 5) _currentApi = localApi;
      isDebugger = BHP().getBool(UConst.isDebugger) ?? true;
    } else {
      isBeta = false;
      _currentApi = config.releaseApi;
    }

    /// 设置toast
    /// Set the toast
    GlobalOptions().toastOptions = config.toastOptions;

    /// 设置全局log 是否显示 分割线
    GlobalOptions().logCrossLine = config.logCrossLine;

    /// 设置全局 [ModalWindows] 组件配置信息
    if (config.modalWindowsOptions != null) {
      GlobalOptions().modalWindowsOptions = config.modalWindowsOptions!;
    }

    /// 全局 [DialogOptions] 配置信息
    if (config.generalDialogOptions != null) {
      GlobalOptions().dialogOptions = config.generalDialogOptions!;
    }

    /// 全局 [BottomSheetOptions] 配置信息
    if (config.bottomSheetOptions != null) {
      GlobalOptions().bottomSheetOptions = config.bottomSheetOptions!;
    }

    /// 全局 [WheelOptions] 配置信息
    if (config.wheelOptions != null) {
      GlobalOptions().wheelOptions = config.wheelOptions!;
    }

    /// 全局 [LoadingOptions] 配置信息
    final loading = config.loadingBuilder?.call(const BasicLoading());
    GlobalOptions().loadingOptions = LoadingOptions(
        custom: loading,
        style: LoadingStyle.circular,
        options: const ModalWindowsOptions(absorbing: true)
            .merge(config.loadingModalWindowsOptions));

    /// 设置页面转场样式
    /// Set the page transition style
    GlobalOptions().pushStyle = config.pushStyle;

    /// 图片或者文件缓存地址
    final cachePath = _config.cachePath;
    if (cachePath == null) {
      final appPath = await Curiosity().native.appPath;
      if (appPath != null) {
        if (isAndroid) {
          currentCacheDir = '${appPath.externalCacheDir!}/';
        } else if (isIOS) {
          currentCacheDir = appPath.temporaryDirectory;
        } else if (isMacOS) {
          currentCacheDir = appPath.temporaryDirectory;
        }
      }
    } else {
      currentCacheDir = cachePath;
    }
  }
}