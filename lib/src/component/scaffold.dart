import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

/// ExtendedScaffold
class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.body,
    this.child,

    /// [children].length > 0 [child] invalid
    this.children,

    /// [children].length > 0 && [isStack]=false invalid;
    this.mainAxisAlignment = MainAxisAlignment.start,

    /// [children].length > 0 && [isStack]=false invalid;
    this.crossAxisAlignment = CrossAxisAlignment.center,

    /// [children].length > 0 && [isStack]=false invalid;
    this.direction = Axis.vertical,
    this.safeLeft = false,
    this.safeTop = false,
    this.safeRight = false,
    this.safeBottom = false,
    this.isScroll = false,
    this.isStack = false,
    this.padding,
    this.decoration,
    this.useSingleChildScrollView = true,
    this.useListView = false,
    this.margin,
    this.refreshConfig,

    /// ****** [Refreshed] ****** ///
    this.onRefresh,
    this.onLoading,
    this.clipBehavior,
    this.scrollBehavior,
    this.physics,

    /// ****** [PopScope] ****** ///
    this.onPopInvoked,
    this.isCloseOverlay = false,
    this.enableDoubleClickExit = false,
    this.doubleClickExitPrompt = '再次点击返回键退出',

    /// ****** [Scaffold] ****** ///
    ///	默认 false，为 true 时，body 延伸到底部控件
    this.extendBody = false,

    /// 默认 false，为 true 时，body 会置顶到 appbar 后，如appbar 为半透明色，可以有毛玻璃效果
    this.extendBodyBehindAppBar = false,

    /// 是否在屏幕顶部显示Appbar, 默认为 true，Appbar 是否向上延伸到状态栏，如电池电量，时间那一栏
    this.primary = true,
    this.floatingActionButton,

    /// 悬浮按钮
    this.floatingActionButtonLocation,

    /// 悬浮按钮位置
    this.floatingActionButtonAnimator,

    /// 显示在底部导航条上方的一组按钮
    this.persistentFooterButtons,

    /// 左侧菜单
    this.drawer,

    /// 左侧侧滑栏是否可以滑动
    this.drawerEnableOpenDragGesture = true,
    this.onDrawerChanged,

    /// 右侧菜单
    this.endDrawer,

    /// 右侧侧滑栏是否可以滑动
    this.endDrawerEnableOpenDragGesture = true,
    this.onEndDrawerChanged,

    /// 底部导航条
    this.bottomNavigationBar,

    /// 一个持久停留在body下方，底部控件上方的控件
    this.bottomSheet,

    /// 类似于 Android 中的 android:windowSoftInputMode=”adjustResize”，
    /// 控制界面内容 body 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，
    /// 重新布局避免被键盘盖住内容。默认值为 true。
    this.resizeToAvoidBottomInset,

    /// 侧滑栏拉出来时，用来遮盖主页面的颜色
    this.drawerScrimColor,
    this.drawerDragStartBehavior = DragStartBehavior.start,

    /// 侧滑栏拉出来的宽度
    this.drawerEdgeDragWidth,
    this.backgroundColor,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.restorationId,

    /// ****** [AppBar] ****** ///
    this.appBar,
    this.appBarHeight,
    this.elevation,
    this.appBarTitle,
    this.appBarTitleText,
    this.appBarActions,
    this.appBarLeading,
    this.leadingWidth,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.appBarPrimary = true,
    this.appBarBottom,
    this.appBarIconTheme,
    this.systemOverlayStyle,
    this.centerTitle = true,
    this.actionsIconTheme,
    this.automaticallyImplyLeading = true,
    this.excludeHeaderSemantics = true,
    this.bottomOpacity = 1.0,
    this.appBarFlexibleSpace,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.shape,
    this.surfaceTintColor,
    this.titleSpacing,
    this.titleTextStyle,
    this.toolbarHeight,
    this.toolbarOpacity = 1.0,
    this.toolbarTextStyle,
    this.forceMaterialTransparency = false,
    this.onPopInvokedWithResult,
  });

  /// [body] > [child] > [children]
  final Widget? body;

  /// child
  final Widget? child;

  /// 相当于给[child] 套用 [Column]、[Row]、[Stack]
  final List<Widget>? children;

  /// [children].length > 0 && [isStack]=false 有效;
  final MainAxisAlignment mainAxisAlignment;

  /// [children].length > 0 && [isStack]=false 有效;
  final CrossAxisAlignment crossAxisAlignment;

  /// [children].length > 0 && [isStack]=false 有效;
  final Axis direction;

  /// [children].length > 0有效;
  /// 添加 [Stack]组件
  final bool isStack;

  /// 是否添加滚动组件
  final bool isScroll;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;

  /// true 点击android实体返回按键先关闭Overlay【toast loading ...】但不pop 当前页面
  /// false 点击android实体返回按键先关闭Overlay【toast loading ...】并pop 当前页面
  final bool isCloseOverlay;
  final PopInvokedWithOverlayCallback? onPopInvoked;
  final PopInvokedWithResultAndOverlayCallback<dynamic>? onPopInvokedWithResult;
  final bool enableDoubleClickExit;
  final String doubleClickExitPrompt;

  /// ****** 刷新组件相关 ******  ///
  final RefreshConfig? refreshConfig;
  final ScrollBehavior? scrollBehavior;
  final ScrollPhysics? physics;

  final bool useSingleChildScrollView;
  final bool useListView;

  /// 在不设置AppBar的时候 修改状态栏颜色
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// appBar
  final PreferredSizeWidget? appBar;

  /// 限制 [appBar] 高度
  final double? appBarHeight;

  /// Scaffold相关属性
  final Color? backgroundColor;

  ///	默认 false，为 true 时， body 延伸到底部控件
  final bool extendBody;

  /// 默认 false，为 true 时，body 会置顶到 appbar 后，如appbar 为半透明色，可以有毛玻璃效果
  final bool extendBodyBehindAppBar;

  /// 悬浮按钮
  final Widget? floatingActionButton;

  /// 悬浮按钮位置
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// 悬浮按钮
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// 一个持久停留在body下方，底部控件上方的控件
  final Widget? bottomSheet;

  /// 底部导航条
  final Widget? bottomNavigationBar;

  /// 控制 drawer 的一些特性
  final DragStartBehavior drawerDragStartBehavior;

  /// 左侧菜单
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;

  /// 左侧侧滑栏是否可以滑动
  final bool drawerEnableOpenDragGesture;

  /// 右侧菜单
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;

  /// 右侧侧滑栏是否可以滑动
  final bool endDrawerEnableOpenDragGesture;

  /// 侧滑栏拉出来的宽度
  final double? drawerEdgeDragWidth;

  /// 侧滑栏拉出来时，用来遮盖主页面的颜色
  final Color? drawerScrimColor;

  /// 显示在底部导航条上方的一组按钮
  final List<Widget>? persistentFooterButtons;

  /// 默认为 true，防止一些小组件重复
  final bool? resizeToAvoidBottomInset;

  /// 是否在屏幕顶部显示Appbar, 默认为 true，Appbar 是否向上延伸到状态栏，如电池电量，时间那一栏
  final bool primary;
  final String? restorationId;
  final AlignmentDirectional persistentFooterAlignment;

  /// ****** [SafeArea] ****** ///
  final bool safeLeft;
  final bool safeTop;
  final bool safeRight;
  final bool safeBottom;

  /// ****** [AppBar] ****** ///
  final double? elevation;
  final Widget? appBarTitle;
  final String? appBarTitleText;
  final List<Widget>? appBarActions;
  final Widget? appBarLeading;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final bool appBarPrimary;
  final PreferredSizeWidget? appBarBottom;
  final IconThemeData? appBarIconTheme;
  final double? leadingWidth;
  final bool centerTitle;
  final IconThemeData? actionsIconTheme;
  final bool automaticallyImplyLeading;
  final bool excludeHeaderSemantics;
  final double bottomOpacity;
  final Widget? appBarFlexibleSpace;
  final ScrollNotificationPredicate notificationPredicate;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? surfaceTintColor;
  final double? titleSpacing;
  final TextStyle? titleTextStyle;
  final double? toolbarHeight;
  final double toolbarOpacity;
  final TextStyle? toolbarTextStyle;
  final bool forceMaterialTransparency;
  final Clip? clipBehavior;

  /// ****** [Refreshed] ****** ///
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;

  static DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    final Widget scaffold = Scaffold(
        key: key,
        primary: primary,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        extendBody: extendBody,
        drawer: drawer,
        endDrawer: endDrawer,
        onDrawerChanged: onDrawerChanged,
        onEndDrawerChanged: onEndDrawerChanged,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        persistentFooterButtons: persistentFooterButtons,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        appBar: appBar ?? buildAppBar(context),
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        restorationId: restorationId,
        body: body ?? universal,
        persistentFooterAlignment: persistentFooterAlignment);
    final hasPopScope = onPopInvoked != null ||
        isCloseOverlay ||
        enableDoubleClickExit ||
        (Universally().config.isCloseOverlay == true);
    return hasPopScope
        ? ExtendedPopScope<dynamic>(
            canPop: !hasPopScope,
            isCloseOverlay: isCloseOverlay,
            onPopInvokedWithResult:
                (bool didPop, dynamic result, bool didCloseOverlay) {
              onPopInvoked?.call(didPop, didCloseOverlay);
              onPopInvokedWithResult?.call(didPop, result, didCloseOverlay);
              if (didCloseOverlay || didPop) return;
              if (enableDoubleClickExit) {
                final now = DateTime.now();
                if (_dateTime != null &&
                    now.difference(_dateTime!).inMilliseconds < 2500) {
                  Curiosity.native.exitApp();
                } else {
                  _dateTime = now;
                  showToast(doubleClickExitPrompt,
                      options: const ToastOptions(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 1500)));
                }
              } else if (onPopInvoked == null) {
                pop();
              }
            },
            child: scaffold)
        : scaffold;
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    Widget? current = (appBarTitleText != null ||
            appBarTitle != null ||
            appBarBottom != null ||
            appBarActions != null ||
            appBarFlexibleSpace != null ||
            appBarLeading != null
        ? AppBar(
            actions: appBarActions,
            bottom: appBarBottom,
            title: appBarTitle ??
                (appBarTitleText == null ? null : Text(appBarTitleText!)),
            leading: appBarLeading,
            iconTheme: appBarIconTheme,
            backgroundColor: appBarBackgroundColor,
            primary: appBarPrimary,
            foregroundColor: appBarForegroundColor,
            flexibleSpace: appBarFlexibleSpace,
            systemOverlayStyle: systemOverlayStyle,
            elevation: elevation,
            centerTitle: centerTitle,
            actionsIconTheme: actionsIconTheme,
            automaticallyImplyLeading: automaticallyImplyLeading,
            bottomOpacity: bottomOpacity,
            excludeHeaderSemantics: excludeHeaderSemantics,
            leadingWidth: leadingWidth,
            notificationPredicate: notificationPredicate,
            scrolledUnderElevation: scrolledUnderElevation,
            shadowColor: shadowColor,
            shape: shape,
            surfaceTintColor: surfaceTintColor,
            titleSpacing: titleSpacing,
            titleTextStyle: titleTextStyle,
            toolbarHeight: toolbarHeight,
            toolbarOpacity: toolbarOpacity,
            toolbarTextStyle: toolbarTextStyle,
            forceMaterialTransparency: forceMaterialTransparency,
            clipBehavior: clipBehavior)
        : null);
    if (current == null) return null;
    return PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight ?? kToolbarHeight - 10),
        child: current);
  }

  Universal get universal => Universal(
      expand: true,
      margin: margin,
      systemOverlayStyle: systemOverlayStyle,
      useSingleChildScrollView:
          useSingleChildScrollView && refreshConfig == null,
      useListView: useListView && refreshConfig == null,
      padding: refreshConfig == null ? padding : null,
      isScroll: isScroll && refreshConfig == null,
      safeLeft: safeLeft,
      safeTop: safeTop,
      safeRight: safeRight,
      safeBottom: safeBottom,
      isStack: isStack,
      direction: direction,
      decoration: decoration,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: refreshConfig != null ? null : children,
      physics: physics,
      child: refreshConfig != null
          ? RefreshScrollView(
              padding: padding,
              scrollDirection: direction,
              physics: physics,
              refreshConfig: refreshConfig ??
                  ((onRefresh != null || onLoading != null)
                      ? RefreshConfig(
                          footer: Universally().pullUpFooter(),
                          header: Universally().pullDownHeader(),
                          onLoading: onLoading == null
                              ? null
                              : () async => onLoading!.call(),
                          onRefresh: onRefresh == null
                              ? null
                              : () async => onRefresh!.call())
                      : null),
              slivers: children?.builder((item) => item.toSliverBox) ?? [])
          : child);
}
