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
    this.margin,
    this.refreshConfig,

    /// ****** [Refreshed] ****** ///
    this.onRefresh,
    this.onLoading,

    /// ****** [PopScope] ****** ///
    this.onPopInvoked,
    this.isCloseOverlay = false,
    this.enableDoubleClickExit = false,
    this.doubleClickExitPrompt = '再次点击返回键退出',

    /// ****** [Scaffold] ****** ///
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.primary = true,
    this.restorationId,
    this.floatingActionButton,

    /// 悬浮按钮
    this.floatingActionButtonLocation,

    /// 悬浮按钮位置
    this.floatingActionButtonAnimator,

    /// 悬浮按钮动画
    this.persistentFooterButtons,

    /// 固定在下方显示的按钮，比如对话框下方的确定、取消按钮
    this.drawer,

    /// 侧滑菜单左
    this.endDrawer,

    /// 侧滑菜单右
    this.bottomNavigationBar,

    /// 底部导航
    this.bottomSheet,

    /// 类似于 Android 中的 android:windowSoftInputMode=”adjustResize”，
    /// 控制界面内容 body 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，
    /// 重新布局避免被键盘盖住内容。默认值为 true。
    this.resizeToAvoidBottomInset,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.drawerScrimColor,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.backgroundColor,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,

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
    this.flexibleSpace,
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
    this.clipBehavior,
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
  final bool enableDoubleClickExit;
  final String doubleClickExitPrompt;

  /// ****** 刷新组件相关 ******  ///
  final RefreshConfig? refreshConfig;

  final bool useSingleChildScrollView;

  /// 在不设置AppBar的时候 修改状态栏颜色
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// 限制 [appBar] 高度
  final double? appBarHeight;

  /// Scaffold相关属性
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final DragStartBehavior drawerDragStartBehavior;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final double? drawerEdgeDragWidth;
  final Color? drawerScrimColor;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final List<Widget>? persistentFooterButtons;
  final bool? resizeToAvoidBottomInset;
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
  final Widget? flexibleSpace;
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
        ? ExtendedPopScope(
            canPop: !hasPopScope,
            isCloseOverlay: isCloseOverlay,
            onPopInvoked: (bool didPop, didCloseOverlay) {
              onPopInvoked?.call(didPop, didCloseOverlay);
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
            flexibleSpace != null ||
            appBarLeading != null
        ? AppBar(
            actions: appBarActions,
            bottom: appBarBottom,
            title: appBarTitle ??
                (appBarTitleText == null ? null : Text(appBarTitleText!)),
            elevation: elevation,
            leading: appBarLeading,
            systemOverlayStyle: systemOverlayStyle,
            backgroundColor: appBarBackgroundColor,
            centerTitle: centerTitle,
            iconTheme: appBarIconTheme,
            actionsIconTheme: actionsIconTheme,
            automaticallyImplyLeading: automaticallyImplyLeading,
            bottomOpacity: bottomOpacity,
            excludeHeaderSemantics: excludeHeaderSemantics,
            flexibleSpace: flexibleSpace,
            leadingWidth: leadingWidth,
            notificationPredicate: notificationPredicate,
            primary: appBarPrimary,
            scrolledUnderElevation: scrolledUnderElevation,
            shadowColor: shadowColor,
            foregroundColor: appBarForegroundColor,
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
      refreshConfig: (onRefresh != null || onLoading != null)
          ? RefreshConfig(
              footer: Universally().config.pullUpFooter,
              header: Universally().config.pullDownHeader,
              onLoading:
                  onLoading == null ? null : () async => onLoading!.call(),
              onRefresh:
                  onRefresh == null ? null : () async => onRefresh!.call())
          : null,
      margin: margin,
      systemOverlayStyle: systemOverlayStyle,
      useSingleChildScrollView: useSingleChildScrollView,
      padding: padding,
      isScroll: isScroll,
      safeLeft: safeLeft,
      safeTop: safeTop,
      safeRight: safeRight,
      safeBottom: safeBottom,
      isStack: isStack,
      direction: direction,
      decoration: decoration,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
      child: child);
}

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({
    super.key,
    required this.itemBuilder,
    this.backgroundColor,
    this.spacing = 4,
    this.automaticKeepAlive = false,
    this.onChanged,
    this.unifiedButtonCategory,
    this.style,
  });

  final ValueCallbackTV<List<Widget>, BuildContext> itemBuilder;

  final Color? backgroundColor;

  final ValueCallback<int>? onChanged;
  final double spacing;

  /// 保持子widget 状态
  final bool automaticKeepAlive;

  /// 为组件添加水波纹效果
  final UnifiedButtonCategory? unifiedButtonCategory;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) => Universal(
      direction: Axis.horizontal,
      decoration: BoxDecoration(
          color: backgroundColor,
          border:
              Border(top: BorderSide(color: UCS.lineColor.withOpacity(0.2)))),
      height: context.padding.bottom + kToolbarHeight,
      padding: EdgeInsets.only(bottom: context.padding.bottom),
      children: itemBuilder(context).builderEntry((item) {
        final current = Universal(
            expanded: true,
            style: style,
            onTap: () => onChanged?.call(item.key),
            unifiedButtonCategory: unifiedButtonCategory,
            padding: EdgeInsets.all(spacing),
            height: double.infinity,
            child: item.value);
        return automaticKeepAlive
            ? AutomaticKeepAliveWrapper(current)
            : current;
      }));
}
