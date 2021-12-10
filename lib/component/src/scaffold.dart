import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_waya/flutter_waya.dart';
import 'package:universally/universally.dart';

class BaseScaffold extends ExtendedScaffold {
  BaseScaffold(
      {Key? key,
      Widget? child,

      /// [children].length > 0 [child] invalid
      List<Widget>? children,

      /// [children].length > 0 && [isStack]=false invalid;
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,

      /// [children].length > 0 && [isStack]=false invalid;
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,

      /// [children].length > 0 && [isStack]=false invalid;
      Axis direction = Axis.vertical,
      bool isScroll = false,
      bool isStack = false,
      bool? resizeToAvoidBottomInset,
      bool? appPaddingStatusBar,
      Widget? title,
      String? appBarTitle,
      Widget? appBarRightWidget,
      Color? appBarBackgroundColor,
      Widget? appBarLeftWidget,
      EdgeInsetsGeometry? padding,
      Widget? bottomNavigationBar,
      Widget? endDrawer,
      Color? backgroundColor,
      Widget? floatingActionButton,
      FloatingActionButtonAnimator? floatingActionButtonAnimator,
      FloatingActionButtonLocation? floatingActionButtonLocation,
      VoidCallback? onRefresh,
      VoidCallback? onLoading,
      bool? onWillPopOverlayClose,
      WillPopCallback? onWillPop,
      double? elevation,
      bool? titleCenter,
      Decoration? decoration,
      bool isMaybePop = false,
      bool useSingleChildScrollView = true,
      PreferredSizeWidget? appBarBottom})
      : super(
            key: key,
            useSingleChildScrollView: useSingleChildScrollView,
            onWillPop: onWillPop,
            onWillPopOverlayClose: onWillPopOverlayClose ?? false,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            direction: direction,
            endDrawer: endDrawer,
            padding: padding,
            isScroll: isScroll,
            isStack: isStack,
            decoration: decoration,
            backgroundColor: backgroundColor ?? UCS.background,
            bottomNavigationBar: bottomNavigationBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
            refreshConfig: (onRefresh != null || onLoading != null)
                ? RefreshConfig(
                    footer: pullUpFooter,
                    header: pullDownHeader,
                    onLoading:
                        onLoading == null ? null : () async => onLoading.call(),
                    onRefresh:
                        onRefresh == null ? null : () async => onRefresh.call())
                : null,
            body: child,
            children: children,
            appBar: title == null &&
                    appBarTitle == null &&
                    appBarBottom == null &&
                    appBarRightWidget == null
                ? null
                : CustomAppBar(
                    isMaybePop: isMaybePop,
                    bottom: appBarBottom,
                    text: appBarTitle,
                    title: title,
                    elevation: elevation,
                    right: appBarRightWidget,
                    backgroundColor: appBarBackgroundColor,
                    leading: appBarLeftWidget));
}

class CustomAppBar extends AppBar {
  CustomAppBar(
      {Key? key,
      String? text,
      Widget? title,
      Widget? right,
      List<Widget>? actions,
      bool isMaybePop = false,
      double? elevation,
      Widget? leading,
      Color? backgroundColor,
      PreferredSizeWidget? bottom})
      : super(
            key: key,
            title: title ?? TextLarge(text),
            centerTitle: true,
            leading: leading ?? BackIcon(isMaybePop: isMaybePop),
            iconTheme: const IconThemeData.fallback(),
            elevation: elevation ?? 0.4,
            actions: actions ??
                <Widget>[
                  if (right != null)
                    Container(
                        width: 100,
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(right: 16),
                        child: right)
                ],
            systemOverlayStyle: const SystemUiOverlayStyleDark(),
            bottom: bottom,
            backgroundColor: backgroundColor ?? UCS.white);
}

class BackIcon extends IconButton {
  const BackIcon(
      {Key? key,
      VoidCallback? onPressed,
      bool isMaybePop = false,
      Color color = UCS.black})
      : super(
            color: color,
            key: key,
            icon: const Icon(UIS.androidBack),
            onPressed: onPressed ?? (isMaybePop ? maybePop : pop),
            padding: EdgeInsets.zero);
}
