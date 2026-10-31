import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

typedef LoadingCoreBuilder = Widget? Function(BaseLoading loading);

typedef ConsumerBuilder<T> = Widget Function(Widget child);

typedef BrightnessBuilder<T> = T Function(Brightness brightness);

class UConfig {
  UConfig({
    this.betaApi = '',
    this.releaseApi = '',
    this.pushStyle = RoutePushStyle.material,
    this.cachePath,
    this.logCrossLine = true,
    this.placeholder,
    this.imageFailed,
    this.textField,
    this.toastOptions,
    this.generalDialogOptions,
    this.modalBottomSheetOptions,
    this.modalOptions,
    this.wheelOptions,
    this.loadingOptions,
  });

  /// 保存图片和视频的缓存地址
  /// 如不设置 默认通过 [Curiosity.native.appPath] 获取
  String? cachePath;

  /// 测试版 url 包含 debug 模式
  String betaApi;

  /// 正式版 url
  String releaseApi;

  /// 全局log是否添加分割线
  bool logCrossLine;

  /// 全局路由跳转样式
  RoutePushStyle pushStyle;

  /// list 占位图
  Widget? placeholder;

  /// [BaseImage] 加载失败时显示的组件
  Widget? imageFailed;

  /// 全局设置 [BaseTextField] 部分配置
  TextFieldConfig? textField;

  /// 全局 Toast 配置信息
  ToastOptions? toastOptions;

  /// 全局 [ModalWindows] 组件配置信息
  ModalBoxOptions? modalOptions;

  /// 全局 [BottomSheetOptions] 配置信息
  ModalBottomSheetOptions? modalBottomSheetOptions;

  /// 全局 [GeneralDialogOptions] 配置信息
  GeneralDialogOptions? generalDialogOptions;

  /// 全局 [FlWheelOptions] 配置信息
  FlWheelOptions? wheelOptions;

  /// loading 样式
  LoadingOptions? loadingOptions;

  /// 复制一份配置，仅覆盖显式传入的非空字段
  UConfig copyWith({
    String? betaApi,
    String? releaseApi,
    RoutePushStyle? pushStyle,
    String? cachePath,
    bool? logCrossLine,
    Widget? placeholder,
    Widget? imageFailed,
    TextFieldConfig? textField,
    ToastOptions? toastOptions,
    GeneralDialogOptions? generalDialogOptions,
    ModalBottomSheetOptions? modalBottomSheetOptions,
    ModalBoxOptions? modalOptions,
    FlWheelOptions? wheelOptions,
    LoadingOptions? loadingOptions,
  }) => UConfig(
    betaApi: betaApi ?? this.betaApi,
    releaseApi: releaseApi ?? this.releaseApi,
    pushStyle: pushStyle ?? this.pushStyle,
    cachePath: cachePath ?? this.cachePath,
    logCrossLine: logCrossLine ?? this.logCrossLine,
    placeholder: placeholder ?? this.placeholder,
    imageFailed: imageFailed ?? this.imageFailed,
    textField: textField ?? this.textField,
    toastOptions: toastOptions ?? this.toastOptions,
    generalDialogOptions: generalDialogOptions ?? this.generalDialogOptions,
    modalBottomSheetOptions: modalBottomSheetOptions ?? this.modalBottomSheetOptions,
    modalOptions: modalOptions ?? this.modalOptions,
    wheelOptions: wheelOptions ?? this.wheelOptions,
    loadingOptions: loadingOptions ?? this.loadingOptions,
  );
}

class Universally {
  factory Universally() => _instance;

  Universally._();

  static final Universally _instance = Universally._();

  static Universally get instance => _instance;

  static Universally get get => _instance;

  /// 全局 [navigatorKey]
  GlobalKey<NavigatorState>? _navigatorKey;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey ??= GlobalKey<NavigatorState>();

  set navigatorKey(GlobalKey<NavigatorState> value) => _navigatorKey = value;

  /// 当前项目使用的 url
  String _baseApi = '';

  String get baseApi => _baseApi;

  /// 项目配置信息
  UConfig _config = UConfig();

  UConfig get config => _config;

  /// 设置app 一些默认参数
  Future<void> setConfig(
    UConfig config, {
    bool? enableBeta,
    String? channel,

    /// desktop
    WindowOptions? windowOptions,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (isDesktop && !isWeb) {
      final window = WindowManager.instance.getCurrent();
      if (window != null) {
        if (windowOptions != null) _applyWindowOptions(window, windowOptions);
        window.show();
        window.focus();
      }
    }
    _config = config;

    const env = String.fromEnvironment(UConst.channel);
    if (env.isNotEmptyOrNull) {
      currentChannel = env;
      isBeta = currentChannel == UConst.beta;
    }
    if (enableBeta != null) isBeta = enableBeta;
    if (channel != null) currentChannel = channel;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    /// 初始化本地储存
    await BasePreferences().init();

    final bool isRelease = BasePreferences().getBool(UConst.isRelease) ?? false;
    if (isBeta && !isRelease) {
      _baseApi = _config.betaApi;
      final String? localApi = BasePreferences().getString(UConst.localApi);
      if (localApi != null && localApi.length > 5) _baseApi = localApi;
      isDebugger = BasePreferences().getBool(UConst.isDebugger) ?? true;
    } else {
      isBeta = false;
      _baseApi = _config.releaseApi;
    }

    /// 设置toast
    /// Set the toast
    /// 以默认 [ToastOptions.extended] 为基底合并，避免传入部分配置时丢失默认背景色等样式
    if (_config.toastOptions != null) {
      FlExtended().toastOptions = const ToastOptions.extended().merge(_config.toastOptions);
    }

    /// 设置全局 [ModalBox] 组件配置信息
    if (_config.modalOptions != null) {
      FlExtended().modalOptions = _config.modalOptions!;
    }

    /// 全局 [DialogOptions] 配置信息
    if (_config.generalDialogOptions != null) {
      FlExtended().generalDialogOptions = _config.generalDialogOptions!;
    }

    /// 全局 [BottomSheetOptions] 配置信息
    if (_config.modalBottomSheetOptions != null) {
      FlExtended().modalBottomSheetOptions = _config.modalBottomSheetOptions!;
    }

    /// 全局 [FlWheelOptions] 配置信息
    if (_config.wheelOptions != null) {
      FlListWheel.wheelOptions = _config.wheelOptions!;
    }

    /// 全局 [LoadingOptions] 配置信息
    if (_config.loadingOptions != null) {
      FlExtended().loadingOptions = const LoadingOptions(elevation: 2, absorbing: true).merge(_config.loadingOptions!);
    }

    /// 设置全局log 是否显示 分割线
    FlExtended().logCrossLine = _config.logCrossLine;

    /// 设置页面转场样式
    /// Set the page transition style
    FlExtended().pushStyle = _config.pushStyle;

    /// list wheel
    FlListWheel.presenter = FlBottomSheetPickerPresenter(context: () => navigatorKey.currentContext!);

    /// 默认刷新组件配置
    EasyRefresh.defaultHeaderBuilder = pullDownHeader;
    EasyRefresh.defaultFooterBuilder = pullUpFooter;
  }

  /// 窗口显示前应用桌面窗口参数
  void _applyWindowOptions(Window window, WindowOptions options) {
    final titleBarStyle = options.titleBarStyle;
    if (titleBarStyle != null) {
      window.titleBarStyle = titleBarStyle;
      window.isWindowControlButtonsVisible = options.windowButtonVisibility ?? true;
    }
    if (window.isFullScreen) window.isFullScreen = false;
    if (window.isMaximized) window.unmaximize();
    if (window.isMinimized) window.restore();

    final size = options.size;
    if (size != null) window.setSize(size.toNative(), false);
    if (options.center == true) window.center();

    final minimumSize = options.minimumSize;
    if (minimumSize != null) window.minimumSize = minimumSize.toNative();
    final maximumSize = options.maximumSize;
    if (maximumSize != null) window.maximumSize = maximumSize.toNative();

    final alwaysOnTop = options.alwaysOnTop;
    if (alwaysOnTop != null) window.isAlwaysOnTop = alwaysOnTop;
    final fullScreen = options.fullScreen;
    if (fullScreen != null) window.isFullScreen = fullScreen;

    final backgroundColor = options.backgroundColor;
    if (backgroundColor != null) window.backgroundColor = backgroundColor.toNative();
    final skipTaskbar = options.skipTaskbar;
    if (skipTaskbar != null) window.isVisibleInTaskbar = !skipTaskbar;
    final title = options.title;
    if (title != null) window.title = title;
  }

  /// 当前项目 全局使用的 刷新Header
  CallbackT<Header> pullDownHeader = () => const ClassicHeader(
    dragText: '请尽情拉我',
    armedText: '可以松开我了',
    readyText: '我要开始刷新了',
    processingText: '我在拼命刷新中',
    processedText: '我已经刷新完成了',
    failedText: '我刷新失败了唉',
    noMoreText: '没有更多了',
    showMessage: false,
  );

  /// 当前项目 全局使用的 刷新Footer
  CallbackT<Footer> pullUpFooter = () => const ClassicFooter(
    dragText: '请尽情拉我',
    armedText: '可以松开我了',
    readyText: '我要准备加载了',
    processingText: '我在拼命加载中',
    processedText: '我已经加载完成了',
    failedText: '我加载失败了唉',
    noMoreText: '没有更多了哦',
    showMessage: false,
  );

  /// 获取主题
  ThemeData? getTheme({BuildContext? context}) {
    final mContext = context ?? Universally.get.navigatorKey.currentContext;
    if (mContext == null) return null;
    return mContext.theme;
  }
}
