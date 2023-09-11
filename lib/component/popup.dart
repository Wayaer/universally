import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

extension ExtensionAlertMessage on AlertMessage {
  Future<T?> show<T>({DialogOptions? options}) =>
      popupCupertinoDialog<T>(options: options);
}

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
            Universal(
                height: 45,
                alignment: Alignment.center,
                onTap: () {
                  pop();
                  if (confirmTap != null) confirmTap!();
                },
                child: confirm ??
                    TextDefault(confirmText ?? '确定',
                        fontSize: 16, color: Global().mainColor)),
          ]));
}

extension ExtensionAlertConfirmCancel on AlertConfirmCancel {
  Future<T?> show<T>({DialogOptions? options}) => popupCupertinoDialog<T>(
      options: const DialogOptions(barrierLabel: '').merge(options));
}

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
class AlertConfirmCancel extends StatelessWidget {
  const AlertConfirmCancel({
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
            Universal(
                height: 45,
                onTap: () {
                  if (autoClose) pop();
                  if (cancelTap != null) cancelTap!();
                },
                alignment: Alignment.center,
                child: cancel ?? TextDefault(cancelText ?? '取消')),
            Universal(
                height: 45,
                alignment: Alignment.center,
                onTap: () {
                  if (autoClose) pop();
                  if (confirmTap != null) confirmTap!();
                },
                child: confirm ?? TextDefault(confirmText ?? '确定'))
          ]);
}

extension ExtensionAlertCountSelect on AlertCountSelect {
  Future<T?> show<T>({BottomSheetOptions? options}) => popupBottomSheet<T>(
      options: const BottomSheetOptions(backgroundColor: Colors.transparent)
          .merge(options));
}

/// 带取消的 弹窗 单列选择
class AlertCountSelect extends StatelessWidget {
  const AlertCountSelect({
    super.key,
    this.cancelText = '取消',
    this.list = const [],
    this.defaultIndex,
    this.title,
    this.message,
    this.actions,
    this.cancel,
    this.actionScrollController,
    this.messageScrollController,
  });

  final String? cancelText;
  final int? defaultIndex;
  final List<String> list;
  final Widget? title;
  final Widget? message;
  final Widget? cancel;
  final List<Widget>? actions;
  final ScrollController? actionScrollController;
  final ScrollController? messageScrollController;

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
      cancelButton: Universal(
          safeBottom: true,
          onTap: maybePop,
          child: cancel ??
              TextDefault(cancelText,
                      textAlign: TextAlign.center, color: Global().mainColor)
                  .paddingSymmetric(vertical: 12)),
      title: title,
      actionScrollController: actionScrollController,
      messageScrollController: messageScrollController,
      message: message,
      actions: actions ??
          list.builderEntry((item) => CupertinoActionSheetAction(
                onPressed: () {
                  maybePop(item.key);
                },
                isDefaultAction: defaultIndex == item.key,
                child: TextDefault(item.value),
              )));
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
                  color: Global().mainColor, fontType: FontType.semiBold)),
          options: options,
          decoration: BoxDecoration(
              color: UCS.white, borderRadius: BorderRadius.circular(6)))
      .show(options: dialogOptions);
  return value ?? false;
}

/// showBottomPopup 移除背景色 关闭滑动手势
Future<T?> showBaseBottomSheet<T>(Widget widget,
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
class BaseLoading extends StatelessWidget {
  const BaseLoading(
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
      color: color ?? Global().mainColor);
}
