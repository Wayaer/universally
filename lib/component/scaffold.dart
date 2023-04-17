import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

class BasicScaffold extends ExtendedScaffold {
  BasicScaffold({
    super.key,
    Widget? child,

    /// [children].length > 0 [child] invalid
    super.children,

    /// [children].length > 0 && [isStack]=false invalid;
    super.mainAxisAlignment = MainAxisAlignment.start,

    /// [children].length > 0 && [isStack]=false invalid;
    super.crossAxisAlignment = CrossAxisAlignment.center,

    /// [children].length > 0 && [isStack]=false invalid;
    super.direction = Axis.vertical,
    super.safeLeft = false,
    super.safeTop = false,
    super.safeRight = false,
    super.safeBottom = false,
    super.isScroll = false,
    super.isStack = false,
    super.resizeToAvoidBottomInset = false,
    super.padding,
    super.bottomNavigationBar,
    super.endDrawer,
    super.floatingActionButton,
    super.floatingActionButtonAnimator,
    super.floatingActionButtonLocation,
    super.onWillPopOverlayClose = false,
    super.decoration,
    super.useSingleChildScrollView = true,
    super.margin,
    super.bottomSheet,
    super.drawer,
    super.drawerDragStartBehavior = DragStartBehavior.start,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture = true,
    super.drawerScrimColor,
    super.endDrawerEnableOpenDragGesture = true,
    super.onDrawerChanged,
    super.onEndDrawerChanged,
    super.extendBody = false,
    super.extendBodyBehindAppBar = false,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    super.persistentFooterButtons,
    super.primary = true,
    super.restorationId,
    Color? backgroundColor,
    bool isRootPage = false,
    WillPopCallback? onWillPop,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,

    /// [AppBar]
    super.appBarHeight,
    Widget? appBar,
    double? elevation,
    Widget? appBarTitle,
    String? appBarTitleText,
    Widget? appBarAction,
    List<Widget>? appBarActions,
    Widget? appBarLeading,
    double? leadingWidth,
    Color? appBarBackgroundColor,
    Color? appBarForegroundColor,
    bool appBarPrimary = true,
    PreferredSizeWidget? appBarBottom,
    IconThemeData? appBarIconTheme,
    bool isMaybePop = false,
    bool enableLeading = true,
    SystemUiOverlayStyle? systemOverlayStyle,
    bool centerTitle = true,
    IconThemeData? actionsIconTheme,
    bool automaticallyImplyLeading = true,
    bool excludeHeaderSemantics = true,
    double bottomOpacity = 1.0,
    Widget? flexibleSpace,
    ScrollNotificationPredicate notificationPredicate =
        defaultScrollNotificationPredicate,
    double? scrolledUnderElevation,
    Color? shadowColor,
    ShapeBorder? shape,
    Color? surfaceTintColor,
    double? titleSpacing,
    TextStyle? titleTextStyle,
    double? toolbarHeight,
    double toolbarOpacity = 1.0,
    TextStyle? toolbarTextStyle,
  }) : super(
            onWillPop: onWillPop ?? _isRootPageWithWillPop(isRootPage),
            backgroundColor:
                backgroundColor ?? GlobalConfig().config.scaffoldBackground,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    footer: GlobalConfig().config.pullUpFooter,
                    header: GlobalConfig().config.pullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            body: child,
            appBar: appBar ??
                (appBarTitleText != null ||
                        appBarTitle != null ||
                        appBarBottom != null ||
                        appBarActions != null ||
                        appBarLeading != null ||
                        appBarAction != null
                    ? BasicAppBar(
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
                    : null));

  static DateTime? _dateTime;

  static WillPopCallback? _isRootPageWithWillPop(bool isRootPage) => isRootPage
      ? () async {
          final now = DateTime.now();
          if (_dateTime != null &&
              now.difference(_dateTime!).inMilliseconds < 2500) {
            Curiosity().native.exitApp();
          } else {
            _dateTime = now;
            showToast('再次点击返回键退出',
                options:
                    const ToastOptions(duration: Duration(milliseconds: 1500)));
          }
          return false;
        }
      : null;
}

class BasicAppBar extends AppBar {
  BasicAppBar({
    super.key,
    String? titleText,
    Widget? title,
    Widget? action,
    List<Widget>? actions,
    bool isMaybePop = false,
    double? elevation,
    Widget? leading,
    Color? backgroundColor,
    bool enableLeading = true,
    IconThemeData? iconTheme,
    SystemUiOverlayStyle? systemOverlayStyle,
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
            title: title ??
                TextLarge(titleText,
                    color: GlobalConfig().config.appBarConfig?.titleColor),
            leading: enableLeading
                ? leading ?? BackIcon(isMaybePop: isMaybePop)
                : const SizedBox(),
            elevation:
                elevation ?? GlobalConfig().config.appBarConfig?.elevation,
            systemOverlayStyle: systemOverlayStyle ??
                GlobalConfig().config.appBarConfig?.systemOverlayStyle,
            iconTheme:
                iconTheme ?? GlobalConfig().config.appBarConfig?.iconTheme,
            actions: actions ??
                [
                  if (action != null)
                    Container(
                        width: 100,
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(right: 16),
                        child: action)
                ],
            backgroundColor: backgroundColor ??
                GlobalConfig().config.appBarConfig?.backgroundColor);
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
