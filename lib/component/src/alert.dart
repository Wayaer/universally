import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 弹出消息 提示 仅 带确认按钮
Future<dynamic>? showAlertMessage({
  String? text,
  GestureTapCallback? sureTap,
  Widget? content,
  Widget? title,
  Widget? sure,
}) =>
    showDialogPopup<dynamic>(
        widget: AlertMessage(
            text: text ?? '',
            sureTap: sureTap,
            content: content,
            title: title,
            sure: sure));

/// 弹出带确定的按钮 点击确定自动关闭
class AlertMessage extends StatelessWidget {
  const AlertMessage({
    Key? key,
    this.text,
    this.sureTap,
    this.contentText,
    this.sure,
    this.title,
    this.content,
  }) : super(key: key);

  final String? text;
  final Widget? contentText;
  final Widget? content;
  final Widget? title;
  final GestureTapCallback? sureTap;
  final Widget? sure;

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black.withOpacity(0.5),
        child: CupertinoAlertDialog(
            title: title ?? const _Title(text: '提示'),
            content: content ??
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: contentText ??
                        TextDefault(text ?? '',
                            maxLines: 5, color: Colors.black87)),
            actions: <Widget>[
              SimpleButton(
                  text: '确定',
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
Future<dynamic>? showAlertSureCancel({
  String? text,
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
            contentText: contentText,
            sureTap: sureTap,
            cancelTap: cancelTap,
            title: title,
            cancel: cancel,
            sure: sure,
            autoClose: autoClose,
            content: content),
        options: GeneralDialogOptions(barrierLabel: ''));

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
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
  }) : super(key: key);

  final String? text;
  final Widget? contentText;
  final Widget? title;
  final Widget? content;
  final GestureTapCallback? sureTap;
  final GestureTapCallback? cancelTap;
  final Widget? cancel;
  final Widget? sure;

  /// 是否自动关闭 默认为true
  final bool autoClose;

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
          title: title ?? const _Title(text: '提示'),
          content: content ??
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: contentText ??
                      TextDefault(text ?? '',
                          maxLines: 5, color: Colors.black87)),
          actions: <Widget>[
            SimpleButton(
                text: '取消',
                height: 45,
                child: cancel,
                onTap: () {
                  if (autoClose) pop();
                  if (cancelTap != null) cancelTap!();
                },
                alignment: Alignment.center,
                textStyle: TStyle(color: Colors.black87)),
            SimpleButton(
                text: '确定',
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
    showOverlay(AlertOnlyMessage(text: TextDefault(text, maxLines: 3)),
        autoOff: autoOff);

/// 只弹出提示 没有按钮  不能关闭
class AlertOnlyMessage extends StatelessWidget {
  const AlertOnlyMessage(
      {Key? key, this.str, this.text, this.content, this.title})
      : super(key: key);
  final String? str;
  final Widget? text;
  final Widget? content;
  final Widget? title;

  @override
  Widget build(BuildContext context) => PopupOptions(
      onTap: () {},
      child: CupertinoAlertDialog(
          title: title ?? const _Title(text: '提示'),
          content: content ??
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: text ??
                      TextDefault(str ?? '',
                          maxLines: 5, color: Colors.black87))));
}

class _Title extends StatelessWidget {
  const _Title({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) =>
      TextDefault(text ?? '提示', fontSize: 18, color: Colors.black87);
}

ExtendedOverlayEntry? alertLoading() =>
    showLoading(onTap: () {}, custom: const BaseLoading());
