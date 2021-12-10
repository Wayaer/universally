import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/single_child_widget.dart';
import 'package:universally/dependencies/src/carousel_slider.dart';
import 'package:universally/universally.dart';

/// 放在 main 最开始的位置
Future<void> startMain({
  int toastDuration = 2,
  bool toastIgnoring = true,
  bool statusBarLight = false,
  WidgetMode widgetMode = WidgetMode.cupertino,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  ///关闭辅助触控
  window.onSemanticsEnabledChanged = () {};
  RendererBinding.instance?.setSemanticsEnabled(false);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ///初始化本地储存
  await Sp.getInstance();

  ///其他信息
  setToastDuration(Duration(seconds: toastDuration));

  ///设置toast
  setAllToastIgnoringBackground(toastIgnoring);

  ///设置页面转场样式
  setGlobalPushMode(widgetMode);
}

ExtendedOverlayEntry? _connectivityOverlay;

/// 网络状态检测
Future<StreamSubscription<ConnectivityResult>?> connectivityListen({
  required ValueTwoCallback<bool, ConnectivityResult> result,
  ValueTwoCallback<bool, ConnectivityResult>? onChanged,

  /// 添加网络切换toast 提示
  /// [alertNotNetwork] 为true 时  无网络状态不会弹toast
  bool addSwitchToast = false,

  /// 当无网络情况下，弹窗，不可做任何操作
  bool alertNotNetwork = false,

  /// [alertNotNetwork] = true 情况下 android 物理返回键是否可用
  bool willPop = false,
}) async {
  if (!isMobile) {
    result(true, ConnectivityResult.wifi);
    if (onChanged != null) onChanged(true, ConnectivityResult.wifi);
    return null;
  }
  final connectivity = Connectivity();
  final state = await connectivity.checkConnectivity();
  result(state == ConnectivityResult.mobile || state == ConnectivityResult.wifi,
      state);
  if (onChanged != null || addSwitchToast || alertNotNetwork) {
    void onChangedFun(ConnectivityResult state,
        ValueTwoCallback<bool, ConnectivityResult> onChanged) {
      onChanged(
          state == ConnectivityResult.mobile ||
              state == ConnectivityResult.wifi,
          state);
    }

    void alertNetworkState(ConnectivityResult state) {
      if (state == ConnectivityResult.none) {
        if (isAndroid && !willPop) scaffoldWillPop = false;
        _connectivityOverlay ??= alertOnlyMessage('当前无网络连接，请连接WIFI或打开移动数据网络');
      } else {
        if (isAndroid && !willPop) scaffoldWillPop = true;
        _connectivityOverlay?.removeEntry();
        _connectivityOverlay = null;
      }
    }

    void showNetworkToast(ConnectivityResult state) {
      // if (state == ConnectivityResult.mobile) {
      //   showToast('正在使用移动数据');
      // } else if (state == ConnectivityResult.wifi) {
      //   showToast('正在使用WIFI');
      // } else if (!alertNotNetwork) {
      //   showToast('当前环境无网络');
      // }
    }

    if (onChanged != null && isIOS) onChangedFun(state, onChanged);
    if (alertNotNetwork) alertNetworkState(state);
    return connectivity.onConnectivityChanged
        .listen((ConnectivityResult state) {
      if (onChanged != null) onChangedFun(state, onChanged);
      if (addSwitchToast) showNetworkToast(state);
      if (alertNotNetwork) alertNetworkState(state);
    });
  }
  return null;
}

typedef ConsumerBuilder<T> = Widget Function(Widget child);

GlobalKey<NavigatorState> globalKey = GlobalKey();

class BaseApp extends StatefulWidget {
  const BaseApp({
    Key? key,
    required this.providers,
    required this.home,
    required this.consumer,
    required this.initState,
    this.dispose,
    this.inactive,
    this.paused,
    this.detached,
    this.resumed,
    this.alertNotNetwork = false,
    this.addNetworkToast = true,
    this.title,
  }) : super(key: key);
  final List<SingleChildWidget> providers;
  final Widget home;
  final ConsumerBuilder consumer;
  final ValueTwoCallback<bool, ConnectivityResult> initState;
  final VoidCallback? dispose;

  /// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。前台
  final VoidCallback? inactive;

  /// 应用程序不可见，后台  切换后台
  final VoidCallback? paused;

  /// 应用程序可见，前台  从后台切换前台
  final VoidCallback? detached;

  /// 申请将暂时暂停
  final VoidCallback? resumed;
  final bool alertNotNetwork;
  final bool addNetworkToast;

  final String? title;

  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> with WidgetsBindingObserver {
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void initState() {
    super.initState();
    addObserver(this);
    addPostFrameCallback((duration) async {
      subscription = await connectivityListen(
          addSwitchToast: widget.addNetworkToast,
          result: widget.initState,
          alertNotNetwork: widget.alertNotNetwork);
      if (isDebug && isDesktop) {
        await 2.seconds.delayed(() {});
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
        // setStatusBarLight(false);
        break;
      case AppLifecycleState.detached:
        widget.detached?.call();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: widget.providers,
        child: widget.consumer(ExtendedWidgetsApp(
            widgetMode: WidgetMode.material,
            navigatorKey: globalKey,
            title: widget.title,
            builder: (_, Widget? child) {
              final Widget current = MediaQuery(
                  data: MediaQueryData.fromWindow(window)
                      .copyWith(textScaleFactor: 1),
                  child: child!);
              return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyleDark(), child: current);
            },
            home: widget.home)));
  }

  @override
  void dispose() {
    subscription?.cancel();
    removeObserver(this);
    super.dispose();
    widget.dispose?.call();
  }
}

/// 添加android 限制返回按键
class MainBaseScaffold extends StatelessWidget {
  const MainBaseScaffold(
      {Key? key,
      this.widgets,
      this.onPageChanged,
      this.controller,
      this.canScroll = true,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.child,
      this.backgroundColor,
      this.children})
      : super(key: key);

  /// 不为null 时 显示为主页面的 MainTabPageBuilder
  final List<Widget>? widgets;

  /// 主页面
  final ValueCallback<int>? onPageChanged;

  /// MainTabPageBuilder 控制器
  final CarouselControllerImpl? controller;

  /// MainTabPageBuilder 是否可以滚动
  final bool canScroll;

  /// BaseScaffold 属性
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? child;
  final Color? backgroundColor;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    DateTime? time;
    return BaseScaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        onWillPop: () async {
          final now = DateTime.now();
          if (time != null && now.difference(time!).inMilliseconds < 2500) {
            Curiosity().native.exitApp();
          } else {
            time = now;
            showToast('再次点击返回键退出',
                closeDuration: const Duration(milliseconds: 1500));
          }
          return false;
        },
        child: getChild,
        children: children,
        bottomNavigationBar: bottomNavigationBar);
  }

  Widget? get getChild {
    if (children != null && children!.isNotEmpty) return null;
    if (widgets != null && onPageChanged != null) {
      return MainTabPageBuilder(
          canScroll: canScroll,
          widgets: widgets!,
          controller: controller,
          onPageChanged: onPageChanged!);
    }
    return child;
  }
}

typedef MainBottomBarIconBuilder = Widget Function(int index);
typedef MainBottomBarIconCallback = void Function(int index);

class MainBottomBar extends StatelessWidget {
  const MainBottomBar(
      {Key? key,
      required this.builder,
      this.backgroundColor,
      required this.onTap,
      required this.itemCount,
      this.spacing = 4})
      : super(key: key);

  final MainBottomBarIconBuilder builder;
  final Color? backgroundColor;
  final MainBottomBarIconCallback onTap;
  final int itemCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Universal(
        direction: Axis.horizontal,
        decoration: BoxDecoration(
            color: backgroundColor,
            border:
                Border(top: BorderSide(color: UCS.lineColor.withOpacity(0.2)))),
        height: getBottomNavigationBarHeight + kToolbarHeight,
        padding: EdgeInsets.only(bottom: getBottomNavigationBarHeight),
        children: itemCount.generate((index) => Universal(
            expanded: true,
            padding: EdgeInsets.all(spacing),
            height: double.infinity,
            onTap: () => onTap(index),
            child: builder(index))));
  }
}
