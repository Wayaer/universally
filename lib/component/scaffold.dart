import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

/// ExtendedScaffold
class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
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

    /// ****** [WillPopScope] ****** ///
    this.onWillPop,
    this.isCloseOverlay = false,
    this.isRootPage = false,

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
    this.appBarAction,
    this.appBarActions,
    this.appBarLeading,
    this.leadingWidth,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.appBarPrimary = true,
    this.appBarBottom,
    this.appBarIconTheme,
    this.isMaybePop = false,
    this.enableLeading = true,
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
  });

  final bool isRootPage;
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

  /// 返回按键监听
  final WillPopCallback? onWillPop;

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
  final Widget? appBar;
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
  final Widget? appBarAction;
  final List<Widget>? appBarActions;
  final Widget? appBarLeading;
  final double? leadingWidth;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final bool appBarPrimary;
  final PreferredSizeWidget? appBarBottom;
  final IconThemeData? appBarIconTheme;
  final bool isMaybePop;
  final bool enableLeading;
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
        appBar: buildAppBar(context),
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        restorationId: restorationId,
        body: universal,
        persistentFooterAlignment: persistentFooterAlignment);
    return onWillPop != null || isCloseOverlay || isRootPage
        ? ExtendedWillPopScope(
            onWillPop: () async {
              bool result = await onWillPop?.call() ?? true;
              if (result == false) return result;
              if (isRootPage) {
                result = false;
                final now = DateTime.now();
                if (_dateTime != null &&
                    now.difference(_dateTime!).inMilliseconds < 2500) {
                  Curiosity().native.exitApp();
                } else {
                  _dateTime = now;
                  showToast('再次点击返回键退出',
                      options: const ToastOptions(
                          duration: Duration(milliseconds: 1500)));
                }
              }
              return result;
            },
            isCloseOverlay: isCloseOverlay,
            child: scaffold)
        : scaffold;
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    Widget? current = appBar ??
        (appBarTitleText != null ||
                appBarTitle != null ||
                appBarBottom != null ||
                appBarActions != null ||
                appBarLeading != null ||
                appBarAction != null
            ? BaseAppBar(
                enableLeading: enableLeading,
                actions: appBarActions,
                isMaybePop: isMaybePop,
                bottom: appBarBottom,
                titleText: appBarTitleText,
                title: appBarTitle,
                elevation: elevation,
                action: appBarAction,
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
                toolbarTextStyle: toolbarTextStyle)
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
              footer: Global().config.pullUpFooter,
              header: Global().config.pullDownHeader,
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

class BaseAppBar extends AppBar {
  BaseAppBar({
    super.key,
    String? titleText = '',
    Widget? title,
    Widget? action,
    List<Widget>? actions,
    bool isMaybePop = false,
    Widget? leading,
    bool enableLeading = true,
    super.elevation,
    super.backgroundColor,
    super.iconTheme,
    super.systemOverlayStyle,
    super.centerTitle = true,
    super.bottom,
    super.actionsIconTheme,
    super.automaticallyImplyLeading,
    super.bottomOpacity = 1.0,
    super.excludeHeaderSemantics = true,
    super.flexibleSpace,
    super.leadingWidth,
    super.notificationPredicate = defaultScrollNotificationPredicate,
    super.primary = true,
    super.scrolledUnderElevation,
    super.shadowColor,
    super.foregroundColor,
    super.shape,
    super.surfaceTintColor,
    super.titleSpacing,
    super.titleTextStyle,
    super.toolbarHeight,
    super.toolbarOpacity = 1.0,
    super.toolbarTextStyle,
  }) : super(
            title: title ?? (titleText == null ? null : TextLarge(titleText)),
            leading: enableLeading
                ? leading ?? BackIcon(isMaybePop: isMaybePop)
                : const SizedBox(),
            actions: [
              if (actions != null && actions.isNotEmpty) ...actions,
              if (action != null)
                Universal(
                    margin: const EdgeInsets.only(right: 12), child: action)
            ]);
}

class BackIcon extends IconButton {
  const BackIcon(
      {super.key,
      VoidCallback? onPressed,
      bool isMaybePop = false,
      super.icon = const Icon(UIS.androidBack),
      super.padding = EdgeInsets.zero,
      super.color})
      : super(onPressed: onPressed ?? (isMaybePop ? maybePop : pop));
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
