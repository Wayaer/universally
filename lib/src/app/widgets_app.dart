import 'package:flutter/cupertino.dart';
import 'package:universally/universally.dart';

class BaseWidgetsApp extends StatelessWidget {
  const BaseWidgetsApp({
    super.key,
    this.home,
    this.title = '',
    this.initState,
    this.dispose,
    this.navigatorKey,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.onGenerateTitle,
    required this.color,
    this.debugShowCheckedModeBanner = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
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
    this.shortcuts,
    this.actions,
    this.onGenerateInitialRoutes,
    this.restorationScopeId,
    this.deactivate,
    this.onInactive,
    this.onPaused,
    this.onDetached,
    this.onResumed,
    this.onHidden,
  });

  /// 组件初始化
  final ValueCallback<BuildContext>? initState;

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

  /// 颜色
  final Color color;

  /// 路由
  final Map<String, WidgetBuilder> routes;

  /// 导航观察器
  final List<NavigatorObserver> navigatorObservers;

  /// 本地化委托
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  /// 标题
  final String title;

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

  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final String? restorationScopeId;

  @override
  Widget build(BuildContext context) {
    final current = WidgetsApp(
        title: title,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
              data:
                  context.mediaQuery.copyWith(textScaler: TextScaler.noScaling),
              child:
                  builder?.call(context, child) ?? child ?? const SizedBox());
        },
        navigatorKey: FlExtended().navigatorKey,
        routes: routes,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onUnknownRoute: onUnknownRoute,
        navigatorObservers: navigatorObservers,
        onGenerateTitle: onGenerateTitle,
        color: color,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        home: home);
    return BaseApp(
        navigatorKey: navigatorKey,
        onInactive: onInactive,
        onPaused: onPaused,
        onDetached: onDetached,
        onResumed: onResumed,
        onHidden: onHidden,
        initState: initState,
        deactivate: deactivate,
        dispose: dispose,
        builder: (context) => current);
  }
}
