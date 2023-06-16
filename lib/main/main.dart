import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/single_child_widget.dart';
import 'package:universally/universally.dart';

typedef LoadingCoreBuilder = Widget? Function(BasicLoading loading);

typedef ConsumerBuilder<T> = Widget Function(Widget child);

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();

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
    GlobalOptions().setToastOptions(config.toastOptions);

    /// 设置全局log 是否显示 分割线
    GlobalOptions().setLogCrossLine(config.logCrossLine);

    /// 设置全局 [ModalWindows] 组件配置信息
    if (config.modalWindowsOptions != null) {
      GlobalOptions().setModalWindowsOptions(config.modalWindowsOptions!);
    }

    /// 全局 [DialogOptions] 配置信息
    if (config.generalDialogOptions != null) {
      GlobalOptions().setDialogOptions(config.generalDialogOptions!);
    }

    /// 全局 [BottomSheetOptions] 配置信息
    if (config.bottomSheetOptions != null) {
      GlobalOptions().setBottomSheetOptions(config.bottomSheetOptions!);
    }

    /// 全局 [WheelOptions] 配置信息
    if (config.wheelOptions != null) {
      GlobalOptions().setWheelOptions(config.wheelOptions!);
    }

    /// 全局 [LoadingOptions] 配置信息
    final loading = config.loadingBuilder?.call(const BasicLoading());
    GlobalOptions().setLoadingOptions(LoadingOptions(
        custom: loading,
        style: LoadingStyle.circular,
        options: const ModalWindowsOptions(absorbing: true)
            .merge(config.loadingModalWindowsOptions)));

    /// 设置页面转场样式
    /// Set the page transition style
    GlobalOptions().setGlobalPushMode(config.pushStyle);

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

class BasicApp extends StatefulWidget {
  const BasicApp({
    super.key,
    this.providers = const [],
    required this.home,
    this.consumer,
    this.initState,
    this.dispose,
    this.inactive,
    this.paused,
    this.detached,
    this.resumed,
    this.title,
  });

  final List<SingleChildWidget> providers;
  final Widget home;

  /// 初始化 consumer
  final ConsumerBuilder? consumer;

  /// 组件初始化
  final ValueCallback<BuildContext>? initState;

  final VoidCallback? dispose;

  /// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。前台
  /// Applications in this state should assume that they may pause at any time. The front desk
  final VoidCallback? inactive;

  /// 应用程序不可见，后台  切换后台
  /// Application not visible, background switch background
  final VoidCallback? paused;

  /// 应用程序可见，前台  从后台切换前台
  /// Application visibility, foreground from background to foreground
  final VoidCallback? detached;

  final VoidCallback? resumed;

  final String? title;

  @override
  State<BasicApp> createState() => _BasicAppState();
}

class _BasicAppState extends State<BasicApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    addObserver(this);
    addPostFrameCallback((_) async {
      widget.initState?.call(context);
      if (isDebug && isDesktop) {
        await Curiosity().desktop.focusDesktop();
        final state = await Curiosity().desktop.setDesktopSizeTo5P8();
        log('桌面端限制宽高 $state');
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        widget.inactive?.call();
        break;
      case AppLifecycleState.paused:
        widget.paused?.call();
        break;
      case AppLifecycleState.resumed:
        widget.resumed?.call();
        break;
      case AppLifecycleState.detached:
        widget.detached?.call();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = ExtendedWidgetsApp(
        pushStyle: RoutePushStyle.material,
        navigatorKey: globalNavigatorKey,
        title: widget.title ?? '',
        builder: (_, Widget? child) {
          final Widget current = MediaQuery(
              data: context.mediaQuery.copyWith(textScaleFactor: 1),
              child: child!);
          return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyleDark(), child: current);
        },
        home: widget.home);
    if (widget.providers.isNotEmpty) {
      return MultiProvider(
          providers: widget.providers,
          child: widget.consumer?.call(app) ?? app);
    }
    return app;
  }

  @override
  void dispose() {
    BasicConnectivity().dispose();
    removeObserver(this);
    super.dispose();
    widget.dispose?.call();
  }
}

typedef MainBottomBarIconBuilder = Widget Function(int index);
typedef MainBottomBarIconCallback = void Function(int index);

class MainBottomBar extends StatelessWidget {
  const MainBottomBar(
      {super.key,
      required this.builder,
      this.backgroundColor,
      required this.onTap,
      required this.itemCount,
      this.spacing = 4});

  final MainBottomBarIconBuilder builder;
  final Color? backgroundColor;
  final MainBottomBarIconCallback onTap;
  final int itemCount;
  final double spacing;

  @override
  Widget build(BuildContext context) => Universal(
      direction: Axis.horizontal,
      decoration: BoxDecoration(
          color: backgroundColor,
          border:
              Border(top: BorderSide(color: UCS.lineColor.withOpacity(0.2)))),
      height: context.padding.bottom + kToolbarHeight,
      padding: EdgeInsets.only(bottom: context.padding.bottom),
      children: itemCount.generate((index) => Universal(
          expanded: true,
          padding: EdgeInsets.all(spacing),
          height: double.infinity,
          onTap: () => onTap(index),
          child: builder(index))));
}
