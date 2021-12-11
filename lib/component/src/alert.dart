import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 弹出消息 提示 仅 带确认按钮
/// A message is displayed with a confirm button only
Future<dynamic>? showAlertMessage({
  String? text,
  String? sureText,
  String? titleText,
  GestureTapCallback? sureTap,
  Widget? contentText,
  Widget? content,
  Widget? title,
  Widget? sure,
}) =>
    showDialogPopup<dynamic>(
        widget: AlertMessage(
            text: text ?? '',
            sureText: sureText,
            contentText: contentText,
            titleText: titleText,
            sureTap: sureTap,
            content: content,
            title: title,
            sure: sure));

/// 弹出带确定的按钮 点击确定自动关闭
/// Pop up the button with "OK" and click "OK" to automatically close
class AlertMessage extends StatelessWidget {
  const AlertMessage({
    Key? key,
    this.text,
    this.sureTap,
    this.contentText,
    this.sure,
    this.title,
    this.content,
    this.sureText,
    this.titleText,
  }) : super(key: key);

  final String? text;
  final String? sureText;
  final String? titleText;
  final Widget? contentText;
  final Widget? content;
  final Widget? title;
  final GestureTapCallback? sureTap;
  final Widget? sure;

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
                  text: sureText ?? '确定',
                  height: 45,
                  child: sure,
                  alignment: Alignment.center,
                  textStyle: TStyle(color: currentColor),
                  onTap: () {
                    pop();
                    if (sureTap != null) sureTap!();
                  }),
            ]),
      );
}

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
Future<dynamic>? showAlertSureCancel({
  String? text,
  String? sureText,
  String? cancelText,
  String? titleText,
  GestureTapCallback? sureTap,
  GestureTapCallback? cancelTap,
  bool autoClose = true,
  Widget? title,
  Widget? contentText,
  Widget? content,
  Widget? cancel,
  Widget? sure,
}) =>
    showDialogPopup<dynamic>(
        widget: AlertSureAndCancel(
            text: text,
            sureText: sureText,
            cancelText: cancelText,
            titleText: titleText,
            contentText: contentText,
            sureTap: sureTap,
            cancelTap: cancelTap,
            title: title,
            cancel: cancel,
            sure: sure,
            autoClose: autoClose,
            content: content),
        options: const GeneralDialogOptions(barrierLabel: ''));

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
class AlertSureAndCancel extends StatelessWidget {
  const AlertSureAndCancel({
    Key? key,
    this.text,
    this.contentText,
    this.sureTap,
    this.cancelTap,
    this.cancel,
    this.sure,
    this.title,
    this.content,
    this.autoClose = true,
    this.sureText,
    this.cancelText,
    this.titleText,
  }) : super(key: key);

  final String? text;
  final String? sureText;
  final String? cancelText;
  final String? titleText;
  final Widget? contentText;
  final Widget? title;
  final Widget? content;
  final GestureTapCallback? sureTap;
  final GestureTapCallback? cancelTap;
  final Widget? cancel;
  final Widget? sure;

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
                  child: contentText ??
                      TextDefault(text ?? '',
                          maxLines: 5, color: Colors.black87)),
          actions: <Widget>[
            SimpleButton(
                text: cancelText ?? '取消',
                height: 45,
                child: cancel,
                onTap: () {
                  if (autoClose) pop();
                  if (cancelTap != null) cancelTap!();
                },
                alignment: Alignment.center,
                textStyle: TStyle(color: Colors.black87)),
            SimpleButton(
                text: sureText ?? '确定',
                height: 45,
                child: sure,
                alignment: Alignment.center,
                textStyle: TStyle(color: currentColor),
                onTap: () {
                  if (autoClose) pop();
                  if (sureTap != null) sureTap!();
                })
          ]);
}

ExtendedOverlayEntry? alertOnlyMessage(String? text, {bool autoOff = true}) =>
    showOverlay(AlertOnlyMessage(text: text), autoOff: autoOff);

/// 只弹出提示 没有按钮  不能关闭
/// Only pop-up prompt, no button, can not be closed
class AlertOnlyMessage extends StatelessWidget {
  const AlertOnlyMessage(
      {Key? key,
      this.text,
      this.titleText,
      this.contentText,
      this.content,
      this.title})
      : super(key: key);
  final String? text;
  final String? titleText;
  final Widget? contentText;
  final Widget? content;
  final Widget? title;

  @override
  Widget build(BuildContext context) => PopupModalWindows(
      options: ModalWindowsOptions(onTap: () {}),
      child: CupertinoAlertDialog(
          title: title ?? _Title(text: titleText ?? '提示'),
          content: content ??
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: contentText ??
                      TextDefault(text ?? '',
                          maxLines: 5, color: Colors.black87))));
}

class _Title extends TextDefault {
  _Title({Key? key, String? text})
      : super(text ?? '提示', fontSize: 18, color: Colors.black87, key: key);
}

ExtendedOverlayEntry? alertLoading() => showLoading(
    options: ModalWindowsOptions(onTap: () {}), custom: const BaseLoading());
