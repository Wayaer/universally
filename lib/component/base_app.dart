import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:universally/universally.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({
    super.key,
    this.providers = const [],
    required this.home,
    required this.title,
    this.consumer,
    this.initState,
    this.dispose,
    this.inactive,
    this.paused,
    this.detached,
    this.resumed,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.scaffoldMessengerKey,
    this.navigatorKey,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.onGenerateTitle,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.color,
    this.debugShowCheckedModeBanner = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowMaterialGrid = false,
    this.routes = const <String, WidgetBuilder>{},
    this.navigatorObservers = const <NavigatorObserver>[],
    this.localizationsDelegates = const <LocalizationsDelegate<dynamic>>[
      DefaultCupertinoLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    this.locale = const Locale('zh'),
    this.supportedLocales = const <Locale>[
      Locale('zh', 'CH'),
      Locale('en', 'US')
    ],
    this.scrollBehavior,
    this.shortcuts,
    this.actions,
    this.onGenerateInitialRoutes,
    this.restorationScopeId,
    this.hidden,
  });

  final List<SingleChildWidget> providers;

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

  final VoidCallback? hidden;

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// 导航键
  final GlobalKey<NavigatorState>? navigatorKey;

  /// 主页
  final Widget? home;

  /// 初始路由
  final String? initialRoute;

  /// 生成路由
  final RouteFactory? onGenerateRoute;

  /// 未知路由
  final RouteFactory? onUnknownRoute;

  /// 建造者
  final TransitionBuilder? builder;

  /// 区域分辨回调
  final LocaleListResolutionCallback? localeListResolutionCallback;

  final LocaleResolutionCallback? localeResolutionCallback;

  /// 生成标题
  final GenerateAppTitle? onGenerateTitle;

  /// Material主题
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;

  /// 颜色
  final Color? color;

  /// 路由
  final Map<String, WidgetBuilder> routes;

  /// 导航观察器
  final List<NavigatorObserver> navigatorObservers;

  /// 本地化委托
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  /// 标题
  final String title;

  final ThemeMode themeMode;

  /// 地点
  final Locale? locale;

  /// 支持区域
  final Iterable<Locale> supportedLocales;

  /// 显示性能叠加
  final bool showPerformanceOverlay;

  /// 棋盘格光栅缓存图像
  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  /// 显示语义调试器
  final bool showSemanticsDebugger;

  final bool debugShowCheckedModeBanner;

  final bool debugShowMaterialGrid;

  final ScrollBehavior? scrollBehavior;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final String? restorationScopeId;

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> with WidgetsBindingObserver {
  @override
  void initState() {
    if (widget.navigatorKey != null) {
      GlobalWayUI().navigatorKey = widget.navigatorKey!;
    }
    DebuggerInterceptorHelper().navigatorKey = GlobalWayUI().navigatorKey;
    if (widget.scaffoldMessengerKey != null) {
      GlobalWayUI().scaffoldMessengerKey = widget.scaffoldMessengerKey!;
    }
    super.initState();
    addObserver(this);
    addPostFrameCallback((_) async {
      widget.initState?.call(context);
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
      case AppLifecycleState.hidden:
        widget.hidden?.call();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
        title: widget.title,
        builder: (_, __) {
          Widget current =
              (widget.builder?.call(_, __)) ?? __ ?? const SizedBox();
          current = MediaQuery(
              data:
                  context.mediaQuery.copyWith(textScaler: TextScaler.noScaling),
              child: current);
          return current;
        },
        navigatorKey: GlobalWayUI().navigatorKey,
        scaffoldMessengerKey: GlobalWayUI().scaffoldMessengerKey,
        routes: widget.routes,
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
        onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
        onUnknownRoute: widget.onUnknownRoute,
        navigatorObservers: widget.navigatorObservers,
        onGenerateTitle: widget.onGenerateTitle,
        color: widget.color,
        theme: widget.theme,
        darkTheme: widget.darkTheme,
        highContrastTheme: widget.highContrastTheme,
        highContrastDarkTheme: widget.highContrastDarkTheme,
        themeMode: widget.themeMode,
        locale: widget.locale,
        localizationsDelegates: widget.localizationsDelegates,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        localeResolutionCallback: widget.localeResolutionCallback,
        supportedLocales: widget.supportedLocales,
        debugShowMaterialGrid: widget.debugShowMaterialGrid,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        shortcuts: widget.shortcuts,
        actions: widget.actions,
        restorationScopeId: widget.restorationScopeId,
        scrollBehavior: widget.scrollBehavior,
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
    ConnectivityPlus().dispose();
    removeObserver(this);
    super.dispose();
    widget.dispose?.call();
  }
}
