import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:universally/universally.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({
    super.key,
    required this.builder,
    this.scaffoldMessengerKey,
    this.navigatorKey,
    this.initState,
    this.didChangeDependencies,
    this.didPopRoute,
    this.didPushRouteInformation,
    this.didChangeMetrics,
    this.didChangeTextScaleFactor,
    this.didChangePlatformBrightness,
    this.didChangeLocales,
    this.didChangeAppLifecycleState,
    this.didRequestAppExit,
    this.didHaveMemoryPressure,
    this.didChangeAccessibilityFeatures,
    this.didUpdateWidget,
    this.deactivate,
    this.dispose,
    this.onInactive,
    this.onPaused,
    this.onDetached,
    this.onResumed,
    this.onHidden,
  });

  /// initState
  final ValueCallback<BuildContext>? initState;

  /// didChangeDependencies
  final ValueCallback<BuildContext>? didChangeDependencies;

  /// didPopRoute
  final ValueCallbackFutureTV<bool, BuildContext>? didPopRoute;

  /// didPushRouteInformation
  final ValueTwoCallbackFutureT<bool, BuildContext, RouteInformation>?
      didPushRouteInformation;

  /// didChangeMetrics
  final ValueCallback<BuildContext>? didChangeMetrics;

  /// didChangeTextScaleFactor
  final ValueCallback<BuildContext>? didChangeTextScaleFactor;

  /// didChangePlatformBrightness
  final ValueCallback<BuildContext>? didChangePlatformBrightness;

  /// didChangeLocales
  final ValueTwoCallback<BuildContext, List<Locale>?>? didChangeLocales;

  /// didChangeAppLifecycleState
  final ValueTwoCallback<BuildContext, AppLifecycleState>?
      didChangeAppLifecycleState;

  /// didRequestAppExit
  final ValueCallbackFutureTV<AppExitResponse, BuildContext>? didRequestAppExit;

  /// didHaveMemoryPressure
  final ValueCallback<BuildContext>? didHaveMemoryPressure;

  /// didChangeAccessibilityFeatures
  final ValueCallback<BuildContext>? didChangeAccessibilityFeatures;

  /// didUpdateWidget
  final ValueTwoCallback<BuildContext, BaseApp>? didUpdateWidget;

  /// deactivate
  final ValueCallback<BuildContext>? deactivate;

  /// dispose
  final ValueCallback<BuildContext>? dispose;

  /// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。前台
  /// Applications in this state should assume that they may pause at any time. The front desk
  final ValueCallback<BuildContext>? onInactive;

  /// 应用程序不可见，后台  切换后台
  /// Application not visible, background switch background
  final ValueCallback<BuildContext>? onPaused;

  /// 应用程序可见，前台  从后台切换前台
  /// Application visibility, foreground from background to foreground
  final ValueCallback<BuildContext>? onDetached;

  /// resumed
  final ValueCallback<BuildContext>? onResumed;

  /// hidden
  final ValueCallback<BuildContext>? onHidden;

  /// set scaffoldMessengerKey
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// set navigatorKey
  final GlobalKey<NavigatorState>? navigatorKey;

  /// builder
  final WidgetBuilder builder;

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> with WidgetsBindingObserver {
  @override
  void initState() {
    if (widget.navigatorKey != null) {
      GlobalWayUI().navigatorKey = widget.navigatorKey!;
    }
    DebuggerInterceptorHelper().navigatorKey =
        widget.navigatorKey ?? GlobalWayUI().navigatorKey;
    if (widget.scaffoldMessengerKey != null) {
      GlobalWayUI().scaffoldMessengerKey = widget.scaffoldMessengerKey!;
    }
    super.initState();
    addObserver(this);
    widget.initState?.call(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(context);
  }

  @override
  Future<bool> didPopRoute() {
    return widget.didPopRoute?.call(context) ?? super.didPopRoute();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return widget.didPushRouteInformation?.call(context, routeInformation) ??
        super.didPushRouteInformation(routeInformation);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    widget.didChangeMetrics?.call(context);
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    widget.didChangeTextScaleFactor?.call(context);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    widget.didChangePlatformBrightness?.call(context);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    widget.didChangeLocales?.call(context, locales);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.didChangeAppLifecycleState?.call(context, state);
    switch (state) {
      case AppLifecycleState.inactive:
        widget.onInactive?.call(context);
        break;
      case AppLifecycleState.paused:
        widget.onPaused?.call(context);
        break;
      case AppLifecycleState.resumed:
        widget.onResumed?.call(context);
        break;
      case AppLifecycleState.detached:
        widget.onDetached?.call(context);
        break;
      case AppLifecycleState.hidden:
        widget.onHidden?.call(context);
        break;
    }
  }

  @override
  Future<AppExitResponse> didRequestAppExit() {
    return widget.didRequestAppExit?.call(context) ?? super.didRequestAppExit();
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    widget.didHaveMemoryPressure?.call(context);
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    widget.didChangeAccessibilityFeatures?.call(context);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);

  @override
  void didUpdateWidget(covariant BaseApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.didUpdateWidget?.call(context, oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.deactivate?.call(context);
  }

  @override
  void dispose() {
    ConnectivityPlus().dispose();
    removeObserver(this);
    super.dispose();
    widget.dispose?.call(context);
  }
}

class BaseMultiProvider extends StatelessWidget {
  const BaseMultiProvider(
      {super.key,
      this.providers = const [],
      this.consumer,
      required this.child,
      this.builder});

  /// multi provider
  final List<SingleChildWidget> providers;

  /// consumer
  final ConsumerBuilder? consumer;

  /// child
  final Widget child;

  /// [MultiProvider] builder
  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    if (providers.isNotEmpty) {
      return MultiProvider(
          builder: builder,
          providers: providers,
          child: consumer?.call(child) ?? child);
    }
    return child;
  }
}
