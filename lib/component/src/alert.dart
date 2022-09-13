import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
    super.key,
    this.text,
    this.sureTap,
    this.contentText,
    this.sure,
    this.title,
    this.content,
    this.sureText,
    this.titleText,
  });

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
                alignment: Alignment.center,
                textStyle: TStyle(color: GlobalConfig().currentColor),
                onTap: () {
                  pop();
                  if (sureTap != null) sureTap!();
                },
                child: sure),
          ]));
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
    super.key,
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
  });

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
                onTap: () {
                  if (autoClose) pop();
                  if (cancelTap != null) cancelTap!();
                },
                alignment: Alignment.center,
                textStyle: const TStyle(color: Colors.black87),
                child: cancel),
            SimpleButton(
                text: sureText ?? '确定',
                height: 45,
                alignment: Alignment.center,
                textStyle: TStyle(color: GlobalConfig().currentColor),
                onTap: () {
                  if (autoClose) pop();
                  if (sureTap != null) sureTap!();
                },
                child: sure)
          ]);
}

/// 带取消的 弹窗 单列选择
Future<int?>? showAlertCountSelect(
        {required List<String> list, int? defaultIndex}) =>
    showBottomPopup<int?>(
        options: const BottomSheetOptions(backgroundColor: Colors.transparent),
        widget: AlertCountSelect(
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
                ))));

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
    showOverlay(AlertOnlyMessage(text: text), autoOff: autoOff);

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

Future<bool?> showDoubleChooseAlert({
  required String title,
  required String left,
  required String right,
  GestureTapCallback? rightTap,
  GestureTapCallback? leftTap,
  Widget? center,

  /// 底层modal配置
  ModalWindowsOptions? modelOptions,
}) async {
  final content = Universal(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.all(20),
      children: [
        TextLarge(title, maxLines: 10),
        const SizedBox(height: 30),
        if (center != null) center.marginOnly(bottom: 15)
      ]);
  final value = await showDoubleChooseWindows(
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
          child: TextDefault(left)),
      right: Universal(
          height: 40,
          onTap: rightTap,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: UCS.lineColor, width: 1),
            left: BorderSide(color: UCS.lineColor, width: 0.5),
          )),
          child: TextDefault(right, color: GlobalConfig().currentColor)),
      modelOptions: modelOptions,
      decoration: BoxDecoration(
          color: UCS.white, borderRadius: BorderRadius.circular(6)));
  return value ?? false;
}

/// showBottomPopup 移除背景色 关闭滑动手势
Future<T?> showBasicBottomPopup<T>(
        {Widget? widget,
        bool isScrollControlled = false,
        BottomSheetOptions? options}) =>
    showBottomPopup<T>(
        options: options ??
            BottomSheetOptions(
                backgroundColor: UCS.transparent,
                enableDrag: false,
                isScrollControlled: isScrollControlled),
        widget: widget);

class _Title extends TextDefault {
  _Title({String? text})
      : super(text ?? '提示', fontSize: 18, color: Colors.black87);
}

/// loading
class BasicLoading extends SpinKit {
  BasicLoading({super.key, SpinKitStyle? style, super.size = 50})
      : super(style ?? GlobalConfig().config.loadingStyle,
            color: GlobalConfig().currentColor);
}

void showUserPrivacyAlert({
  required String title,
  required GestureTapCallback onUserAgreementTap,
  required GestureTapCallback onPrivacyPolicyTap,
  required GestureTapCallback onConsentTap,
}) {
  final result = SP().getBool(UConstant.privacy);
  if (result ?? false) {
    onConsentTap.call();
  } else {
    showDoubleChooseWindows(
        modelOptions:
            GlobalOptions().modalWindowsOptions.copyWith(color: UCS.black50),
        decoration: BoxDecoration(
            color: UCS.white, borderRadius: BorderRadius.circular(4)),
        content: _UserPrivacyAlert(
            onUserAgreementTap: onUserAgreementTap,
            onPrivacyPolicyTap: onPrivacyPolicyTap,
            title: title),
        right: SimpleButton(
            height: 40,
            margin: const EdgeInsets.only(left: 0.5),
            alignment: Alignment.center,
            textStyle: const TStyle(color: UCS.white),
            text: '同意',
            color: GlobalConfig().currentColor,
            onTap: () {
              pop();
              SP().setBool(UConstant.privacy, true);
              onConsentTap.call();
            }),
        left: SimpleButton(
            text: '取消',
            height: 40,
            margin: const EdgeInsets.only(right: 0.5),
            alignment: Alignment.center,
            textStyle: const TStyle(color: UCS.black70),
            color: UCS.background,
            onTap: Curiosity().native.exitApp));
  }
}

class _UserPrivacyAlert extends StatelessWidget {
  const _UserPrivacyAlert(
      {this.onUserAgreementTap, this.onPrivacyPolicyTap, required this.title});

  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Universal(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: '欢迎您使用$title软件及服务，您应当阅读并遵守',
                style: const TStyle(fontSize: 16, color: UCS.mainBlack)),
            TextSpan(
                text: '《用户协议》',
                style: TStyle(fontSize: 16, color: GlobalConfig().currentColor),
                recognizer: TapGestureRecognizer()..onTap = onUserAgreementTap),
            const TextSpan(
                text: '以及', style: TStyle(fontSize: 16, color: UCS.mainBlack)),
            TextSpan(
                text: '《隐私政策》',
                style: TStyle(fontSize: 16, color: GlobalConfig().currentColor),
                recognizer: TapGestureRecognizer()..onTap = onPrivacyPolicyTap),
            const TextSpan(
                text:
                    '。请您务必审慎阅读、充分理解各条款内容，除非您已充分阅读、完全理解并接受本协议所有条款，否则您无权下载、安装或使用本软件相关服务。',
                style: TStyle(fontSize: 16, color: UCS.mainBlack))
          ]))
        ]);
  }
}
