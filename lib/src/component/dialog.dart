import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

extension ExtensionConfirmActionDialog on ConfirmActionDialog {
  Future<T?> bottomSheet<T>({BottomSheetOptions? options}) =>
      popupBottomSheet<T>(
          options: const BottomSheetOptions(backgroundColor: Colors.transparent)
              .merge(options));

  Future<T?> show<T>({DialogOptions? options}) => popupDialog<T>(
      options: const DialogOptions(barrierLabel: '').merge(options));
}

/// 弹出带确定的按钮 点击确定自动关闭
/// Pop up the button with "OK" and click "OK" to automatically close
class ConfirmActionDialog extends StatelessWidget {
  const ConfirmActionDialog({
    super.key,
    this.confirm,
    this.confirmText = '确定',
    this.onConfirmTap,
    this.contentText,
    this.content,
    this.titleText,
    this.title,
    this.autoClose = false,
    this.hasDivider = true,
    this.options,
    this.actions,
    this.resizeToAvoidBottomInset = true,
  }) : isCupertino = false;

  const ConfirmActionDialog.cupertino({
    super.key,
    this.confirm,
    this.confirmText = '确定',
    this.onConfirmTap,
    this.contentText,
    this.content,
    this.titleText,
    this.title,
    this.autoClose = false,
    this.actions,
  })  : hasDivider = false,
        options = null,
        resizeToAvoidBottomInset = true,
        isCupertino = true;

  /// confirm
  final String? confirmText;
  final GestureTapCallback? onConfirmTap;
  final Widget? confirm;

  /// title
  final String? titleText;
  final Widget? title;

  /// content
  final String? contentText;
  final Widget? content;

  /// 是否自动关闭 默认为true
  /// Auto disable The default value is true
  final bool autoClose;

  /// 底层modal配置
  final ModalBoxOptions? options;

  /// actions
  final List<Widget>? actions;

  /// 是否显示线
  final bool hasDivider;

  /// use cupertino style
  final bool isCupertino;

  /// resize ToAvoid Bottom Inset
  final bool resizeToAvoidBottomInset;

  Widget get buildContent => Universal(
      margin: isCupertino
          ? const EdgeInsets.only(top: 10)
          : const EdgeInsets.fromLTRB(16, 2, 16, 20),
      child: content ?? TextNormal(contentText));

  @override
  Widget build(BuildContext context) => isCupertino
      ? buildCupertinoActionDialog(context)
      : buildActionDialog(context);

  Widget buildActionDialog(BuildContext context) => ActionDialog(
      title: title != null || titleText != null
          ? Container(
              alignment: Alignment.center,
              height: 45,
              child: title ??
                  TextLarge(titleText,
                      maxLines: 10, style: context.theme.textTheme.titleMedium))
          : null,
      content: buildContent,
      dividerColor: hasDivider ? UCS.lineColor : null,
      dividerThickness: 1,
      actions: buildActions(context),
      options: FlExtended().modalOptions.merge(options).copyWith(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          borderRadius: BorderRadius.circular(6)),
      actionsMaxHeight: 40);

  Widget buildCupertinoActionDialog(BuildContext context) =>
      CupertinoAlertDialog(
          title: title ??
              TextLarge(titleText,
                  maxLines: 10, style: context.theme.textTheme.titleMedium),
          content: buildContent,
          actions: buildActions(context));

  List<Widget> buildActions(BuildContext context) =>
      actions ?? [buildConfirm(context)];

  Widget buildConfirm(BuildContext context) => Universal(
      height: 40,
      expanded: !isCupertino,
      alignment: Alignment.center,
      onTap: () {
        if (autoClose) pop();
        if (onConfirmTap != null) onConfirmTap!();
      },
      child: confirm ??
          TextNormal(
            confirmText,
            style: context.theme.textTheme.titleSmall,
            color: context.theme.primaryColor,
          ));
}

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
class ConfirmCancelActionDialog extends ConfirmActionDialog {
  const ConfirmCancelActionDialog({
    super.key,
    this.cancel,
    this.cancelText = '取消',
    this.onCancelTap,
    super.confirm,
    super.confirmText = '确定',
    super.onConfirmTap,
    super.contentText,
    super.content,
    super.titleText,
    super.title,
    super.autoClose = true,
    super.hasDivider = true,
    super.options,
    super.actions,
    super.resizeToAvoidBottomInset,
  });

  const ConfirmCancelActionDialog.cupertino({
    super.key,
    this.cancel,
    this.cancelText = '取消',
    this.onCancelTap,
    super.confirm,
    super.confirmText = '确定',
    super.onConfirmTap,
    super.contentText,
    super.content,
    super.titleText,
    super.title,
    super.autoClose = true,
    super.actions,
  }) : super.cupertino();

  /// cancel
  final String? cancelText;
  final Widget? cancel;
  final GestureTapCallback? onCancelTap;

  @override
  List<Widget> buildActions(BuildContext context) =>
      actions ??
      [
        Universal(
            height: 40,
            expanded: !isCupertino,
            onTap: () {
              if (autoClose) pop();
              if (onCancelTap != null) onCancelTap!();
            },
            alignment: Alignment.center,
            child: cancel ??
                TextNormal(cancelText,
                    style: context.theme.textTheme.titleSmall)),
        buildConfirm(context),
      ];
}

extension ExtensionTextFieldDialog on TextFieldDialog {
  Future<dynamic> show() => popupDialog();
}

/// 弹出输入框组件  确定 和 取消
class TextFieldDialog extends StatelessWidget {
  TextFieldDialog({
    super.key,
    this.onConfirmTap,
    this.titleText = '内容',
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.hintText = '请输入内容',
    this.onCancelTap,
    this.maxLength = 30,
    this.textInputType = TextInputLimitFormatter.text,
    this.value,
    this.resizeToAvoidBottomInset = true,
  }) : isCupertino = false;

  TextFieldDialog.cupertino({
    super.key,
    this.onConfirmTap,
    this.titleText = '内容',
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.hintText = '请输入内容',
    this.onCancelTap,
    this.maxLength = 30,
    this.textInputType = TextInputLimitFormatter.text,
    this.value,
  })  : isCupertino = true,
        resizeToAvoidBottomInset = true;

  /// use cupertino style
  final bool isCupertino;
  final ValueCallback<String>? onConfirmTap;
  final GestureTapCallback? onCancelTap;

  /// resize ToAvoid Bottom Inset
  final bool resizeToAvoidBottomInset;

  final TextEditingController controller = TextEditingController();
  final String titleText;
  final String confirmText;
  final String cancelText;
  final String hintText;
  final String? value;
  final int maxLength;
  final TextInputLimitFormatter textInputType;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return ConfirmCancelActionDialog.cupertino(
          onConfirmTap: checkInput,
          autoClose: false,
          onCancelTap: onCancelTap ?? pop,
          titleText: titleText,
          confirmText: confirmText,
          cancelText: cancelText,
          content: buildTextField);
    }
    return ConfirmCancelActionDialog(
        onConfirmTap: checkInput,
        autoClose: false,
        onCancelTap: onCancelTap ?? pop,
        titleText: titleText,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        confirmText: confirmText,
        cancelText: cancelText,
        content: buildTextField);
  }

  Widget get buildTextField => Material(
      color: Colors.transparent,
      child: BaseTextField(
          textInputType: textInputType,
          value: value,
          margin: const EdgeInsets.all(16),
          hintText: hintText,
          borderType: BorderType.outline,
          padding: const EdgeInsets.symmetric(vertical: 6),
          borderRadius: BorderRadius.circular(2),
          controller: controller,
          width: double.infinity,
          hasFocusedChangeBorder: false,
          maxLength: maxLength,
          autoFocus: true));

  void checkInput() {
    if (controller.text.isEmpty) {
      showToast(hintText);
      return;
    }
    if (onConfirmTap != null) onConfirmTap!(controller.text);
  }
}
