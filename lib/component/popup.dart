import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 弹出消息 提示 仅 带确认按钮
/// A message is displayed with a confirm button only
Future<dynamic>? showAlertMessage({
  String? text,
  String? confirmText,
  String? titleText,
  GestureTapCallback? confirmTap,
  Widget? contentText,
  Widget? content,
  Widget? title,
  Widget? confirm,
  DialogOptions? dialogOptions,
}) =>
    AlertMessage(
            text: text ?? '',
            confirmText: confirmText,
            contentText: contentText,
            titleText: titleText,
            confirmTap: confirmTap,
            content: content,
            title: title,
            confirm: confirm)
        .popupCupertinoDialog(options: dialogOptions);

/// 弹出带确定的按钮 点击确定自动关闭
/// Pop up the button with "OK" and click "OK" to automatically close
class AlertMessage extends StatelessWidget {
  const AlertMessage({
    super.key,
    this.text,
    this.confirmTap,
    this.contentText,
    this.confirm,
    this.title,
    this.content,
    this.confirmText,
    this.titleText,
  });

  final String? text;
  final String? confirmText;
  final String? titleText;
  final Widget? contentText;
  final Widget? content;
  final Widget? title;
  final GestureTapCallback? confirmTap;
  final Widget? confirm;

  @override
  Widget build(BuildContext context) => Container(
      color: Colors.black.withOpacity(0.5),
      child: CupertinoAlertDialog(
          title: title ?? _Title(text: titleText ?? '提示'),
          content: content ??
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: contentText ??
                      TextDefault(text ?? '',
                          maxLines: 5, color: Colors.black87)),
          actions: <Widget>[
            SimpleButton(
                height: 45,
                alignment: Alignment.center,
                onTap: () {
                  pop();
                  if (confirmTap != null) confirmTap!();
                },
                child: confirm ??
                    TextDefault(confirmText ?? '确定',
                        fontSize: 16, color: GlobalConfig().currentColor)),
          ]));
}

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
Future<dynamic>? showAlertConfirmCancel({
  String? text,
  String? confirmText,
  String? cancelText,
  String? titleText,
  GestureTapCallback? confirmTap,
  GestureTapCallback? cancelTap,
  bool autoClose = true,
  Widget? title,
  Widget? contentText,
  Widget? content,
  Widget? cancel,
  Widget? confirm,
  DialogOptions? dialogOptions,
}) =>
    AlertConfirmAndCancel(
            text: text,
            confirmText: confirmText,
            cancelText: cancelText,
            titleText: titleText,
            contentText: contentText,
            confirmTap: confirmTap,
            cancelTap: cancelTap,
            title: title,
            cancel: cancel,
            confirm: confirm,
            autoClose: autoClose,
            content: content)
        .popupDialog(
            options:
                const DialogOptions(barrierLabel: '').merge(dialogOptions));

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
class AlertConfirmAndCancel extends StatelessWidget {
  const AlertConfirmAndCancel({
    super.key,
    this.text,
    this.contentText,
    this.confirmTap,
    this.cancelTap,
    this.cancel,
    this.confirm,
    this.title,
    this.content,
    this.autoClose = true,
    this.confirmText,
    this.cancelText,
    this.titleText,
  });

  final String? text;
  final String? confirmText;
  final String? cancelText;
  final String? titleText;
  final Widget? contentText;
  final Widget? title;
  final Widget? content;
  final GestureTapCallback? confirmTap;
  final GestureTapCallback? cancelTap;
  final Widget? cancel;
  final Widget? confirm;

  /// 是否自动关闭 默认为true
  /// Auto disable The default value is true
  final bool autoClose;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
          title: title ?? _Title(text: titleText ?? '提示'),
          content: content ??
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: contentText ?? TextDefault(text ?? '', maxLines: 5)),
          actions: [
            SimpleButton(
                height: 45,
                onTap: () {
                  if (autoClose) pop();
                  if (cancelTap != null) cancelTap!();
                },
                alignment: Alignment.center,
                child: cancel ?? TextDefault(cancelText ?? '取消')),
            SimpleButton(
                height: 45,
                alignment: Alignment.center,
                onTap: () {
                  if (autoClose) pop();
                  if (confirmTap != null) confirmTap!();
                },
                child: confirm ?? TextDefault(confirmText ?? '确定'))
          ]);
}

/// 带取消的 弹窗 单列选择
Future<int?>? showAlertCountSelect(
        {required List<String> list,
        int? defaultIndex,
        BottomSheetOptions? bottomSheetOptions}) =>
    AlertCountSelect(
        cancelButton: Universal(
            safeBottom: true,
            onTap: maybePop,
            child: TextDefault('取消',
                    textAlign: TextAlign.center,
                    color: GlobalConfig().currentColor)
                .paddingSymmetric(vertical: 12)),
        actions: list.builderEntry((item) => CupertinoActionSheetAction(
              onPressed: () {
                maybePop(item.key);
              },
              isDefaultAction: defaultIndex == item.key,
              child: TextDefault(item.value),
            ))).popupBottomSheet<int?>(
        options: const BottomSheetOptions(backgroundColor: Colors.transparent)
            .merge(bottomSheetOptions));

/// 带取消的 弹窗 单列选择
class AlertCountSelect extends StatelessWidget {
  const AlertCountSelect(
      {super.key,
      this.title,
      this.message,
      required this.actions,
      this.cancelButton,
      this.actionScrollController,
      this.messageScrollController});

  final Widget? title;
  final Widget? message;
  final Widget? cancelButton;
  final List<Widget> actions;
  final ScrollController? actionScrollController;
  final ScrollController? messageScrollController;

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
      cancelButton: cancelButton,
      title: title,
      actionScrollController: actionScrollController,
      messageScrollController: messageScrollController,
      message: message,
      actions: actions);
}

ExtendedOverlayEntry? alertOnlyMessage(String? text, {bool autoOff = true}) =>
    AlertOnlyMessage(text: text).showOverlay(autoOff: autoOff);

/// 只弹出提示 没有按钮  不能关闭
/// Only pop-up prompt, no button, can not be closed
class AlertOnlyMessage extends StatelessWidget {
  const AlertOnlyMessage(
      {super.key,
      this.text,
      this.titleText,
      this.contentText,
      this.content,
      this.title});

  final String? text;
  final String? titleText;
  final Widget? contentText;
  final Widget? content;
  final Widget? title;

  @override
  Widget build(BuildContext context) => ModalWindows(
      options: ModalWindowsOptions(onTap: () {}),
      child: CupertinoAlertDialog(
          title: title ?? _Title(text: titleText ?? '提示'),
          content: content ??
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: contentText ?? TextDefault(text ?? '', maxLines: 5))));
}

Future<bool?> showDoubleChooseAlert({
  required String title,
  required String left,
  required String right,
  GestureTapCallback? rightTap,
  GestureTapCallback? leftTap,
  Widget? center,

  /// 底层modal配置
  ModalWindowsOptions? options,
  DialogOptions? dialogOptions,
}) async {
  final content = Universal(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.all(20),
      children: [
        TextLarge(title, maxLines: 10),
        const SizedBox(height: 30),
        if (center != null) center.marginOnly(bottom: 15)
      ]);
  final value = await DoubleChooseWindows(
          content: content,
          left: Universal(
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(color: UCS.lineColor, width: 1),
                right: BorderSide(color: UCS.lineColor, width: 0.5),
              )),
              alignment: Alignment.center,
              onTap: leftTap ?? pop,
              child: TextDefault(left, fontType: FontType.semiBold)),
          right: Universal(
              height: 40,
              onTap: rightTap,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(color: UCS.lineColor, width: 1),
                left: BorderSide(color: UCS.lineColor, width: 0.5),
              )),
              child: TextDefault(right,
                  color: GlobalConfig().currentColor,
                  fontType: FontType.semiBold)),
          options: options,
          decoration: BoxDecoration(
              color: UCS.white, borderRadius: BorderRadius.circular(6)))
      .show(options: dialogOptions);
  return value ?? false;
}

/// showBottomPopup 移除背景色 关闭滑动手势
Future<T?> showBasicBottomSheet<T>(Widget widget,
        {bool isScrollControlled = false, BottomSheetOptions? options}) =>
    widget.popupBottomSheet<T>(
        options: BottomSheetOptions(
                backgroundColor: UCS.transparent,
                enableDrag: false,
                isScrollControlled: isScrollControlled)
            .merge(options));

class _Title extends TextLarge {
  _Title({String? text}) : super(text ?? '提示', fontSize: 18);
}

/// loading
class BasicLoading extends StatelessWidget {
  const BasicLoading(
      {Key? key,
      this.size = 50,
      this.style = SpinKitStyle.fadingCircle,
      this.color,
      this.itemBuilder,
      this.duration = const Duration(milliseconds: 1200),
      this.controller})
      : super(key: key);

  final SpinKitStyle style;
  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  Widget build(BuildContext context) => SpinKit(style,
      size: size,
      itemBuilder: itemBuilder,
      controller: controller,
      duration: duration,
      color: color ?? GlobalConfig().currentColor);
}