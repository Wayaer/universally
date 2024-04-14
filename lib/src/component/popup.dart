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
                      TextNormal(text ?? '',
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
                    TextNormal(confirmText ?? '确定',
                        fontSize: 16, color: Universally().mainColor)),
          ]));
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
              TextNormal(cancelText,
                      textAlign: TextAlign.center,
                      color: Universally().mainColor)
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
                child: TextNormal(item.value),
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
  Widget build(BuildContext context) => ModalBox(
      options: ModalBoxOptions(onModalTap: () {}),
      child: CupertinoAlertDialog(
          title: title ?? _Title(text: titleText ?? '提示'),
          content: content ??
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: contentText ?? TextNormal(text ?? '', maxLines: 5))));
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
      {super.key,
      this.size = 50,
      this.style = SpinKitStyle.fadingCircle,
      this.color,
      this.itemBuilder,
      this.duration = const Duration(milliseconds: 1200),
      this.controller});

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
      color: color ?? Universally().mainColor);
}
