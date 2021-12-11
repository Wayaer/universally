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
/// Put it at the beginning of main
Future<void> startMain({
  int toastDuration = 2,
  bool toastIgnoring = true,
  bool statusBarLight = false,
  RoutePushStyle pushStyle = RoutePushStyle.cupertino,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 关闭辅助触控
  /// Turn off auxiliary touch
  window.onSemanticsEnabledChanged = () {};
  RendererBinding.instance?.setSemanticsEnabled(false);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// 初始化本地储存
  /// Initialize local storage
  await Sp.getInstance();

  /// 其他信息
  /// Other information

  /// 设置toast
  /// Set the toast
  GlobalOptions().setToastOptions(ToastOptions(
      ignoring: toastIgnoring, duration: Duration(seconds: toastDuration)));

  /// 设置页面转场样式
  /// Set the page transition style
  GlobalOptions().setGlobalPushMode(pushStyle);
}

ExtendedOverlayEntry? _connectivityOverlay;

typedef NetworkToastBuilder = void Function(ConnectivityResult result);
typedef NotNetworkBuilder = ExtendedOverlayEntry? Function(
    ConnectivityResult result);

/// 网络状态检测
/// Network status detection
Future<StreamSubscription<ConnectivityResult>?> connectivityListen({
  required ValueTwoCallback<bool, ConnectivityResult> result,
  ValueTwoCallback<bool, ConnectivityResult>? onChanged,
  bool willPop = false,

  /// Added network toggle toast prompt
  NetworkToastBuilder? showNetworkToast,

  /// 当无网络情况下，弹窗，不可做任何操作
  /// When there is no network, the popup window does not perform any operations
  NotNetworkBuilder? alertNotNetwork,
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
  if (onChanged != null ||
      showNetworkToast != null ||
      alertNotNetwork != null) {
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
        if (alertNotNetwork != null) {
          _connectivityOverlay ??= alertNotNetwork(state);
        }
      } else {
        if (isAndroid && !willPop) scaffoldWillPop = true;
        _connectivityOverlay?.removeEntry();
        _connectivityOverlay = null;
      }
    }

    if (onChanged != null && isIOS) onChangedFun(state, onChanged);
    alertNetworkState(state);
    return connectivity.onConnectivityChanged
        .listen((ConnectivityResult state) {
      if (onChanged != null) onChangedFun(state, onChanged);
      showNetworkToast?.call(state);
      alertNetworkState(state);
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
    this.title,
    this.showNetworkToast,
    this.alertNotNetwork,
  }) : super(key: key);
  final List<SingleChildWidget> providers;
  final Widget home;
  final ConsumerBuilder consumer;
  final ValueTwoCallback<bool, ConnectivityResult> initState;
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

  /// Added network toggle toast prompt
  final NetworkToastBuilder? showNetworkToast;

  /// 当无网络情况下，弹窗，不可做任何操作
  /// When there is no network, the popup window does not perform any operations
  final NotNetworkBuilder? alertNotNetwork;

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
        showNetworkToast: widget.showNetworkToast,
        alertNotNetwork: widget.alertNotNetwork,
        result: widget.initState,
      );
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
            pushStyle: RoutePushStyle.material,
            navigatorKey: globalKey,
            title: widget.title ?? '',
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
                options:
                    const ToastOptions(duration: Duration(milliseconds: 1500)));
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
