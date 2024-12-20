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

/// text builder
typedef WidgetTextBuilder = Widget Function(Widget? text);

/// actions builder
typedef WidgetActionsBuilder = List<Widget> Function(List<Widget> actions);

/// tap result
typedef ConfirmTapResult = dynamic Function();

/// tap value callback result
typedef ConfirmTapValueCallbackResult<T> = dynamic Function(T value);

/// 弹出带确定的按钮 点击确定自动关闭
/// Pop up the button with "OK" and click "OK" to automatically close
class ConfirmActionDialog extends StatelessWidget {
  const ConfirmActionDialog({
    super.key,
    this.confirm,
    this.confirmText = '确定',
    this.onConfirmTap,
    this.confirmTapPop = true,
    this.confirmTapPopResult,
    this.contentText,
    this.content,
    this.titleText,
    this.title,
    this.dividerThickness = 0.4,
    this.dividerColor,
    this.options,
    this.actions,
    this.resizeToAvoidBottomInset = true,
    this.constraints,
  }) : isCupertino = false;

  const ConfirmActionDialog.cupertino({
    super.key,
    this.confirm,
    this.confirmText = '确定',
    this.onConfirmTap,
    this.confirmTapPop = true,
    this.confirmTapPopResult,
    this.contentText,
    this.content,
    this.titleText,
    this.title,
    this.actions,
  })  : options = null,
        dividerColor = null,
        constraints = null,
        resizeToAvoidBottomInset = true,
        dividerThickness = 1,
        isCupertino = true;

  /// confirm
  final String? confirmText;
  final ConfirmTapResult? onConfirmTap;
  final WidgetTextBuilder? confirm;

  ///  [onConfirmTap] 没有返回值的时候 返回的 result
  final dynamic confirmTapPopResult;

  /// [onConfirmTap] 是否 pop
  final bool confirmTapPop;

  /// title
  final String? titleText;
  final WidgetTextBuilder? title;

  /// content
  final String? contentText;
  final WidgetTextBuilder? content;

  /// 底层modal配置
  final ModalBoxOptions? options;

  /// actions
  final WidgetActionsBuilder? actions;

  /// divider color
  final Color? dividerColor;

  /// dividerThickness
  final double dividerThickness;

  /// use cupertino style
  final bool isCupertino;

  /// resize ToAvoid Bottom Inset
  final bool resizeToAvoidBottomInset;

  /// BoxConstraints
  final BoxConstraints? constraints;

  Widget get buildContent {
    Widget? current;
    if (contentText != null) current = TextMedium(contentText);
    if (content != null) current = content!(current);
    return Universal(
        margin: isCupertino
            ? const EdgeInsets.only(top: 10)
            : const EdgeInsets.fromLTRB(16, 2, 16, 20),
        child: current);
  }

  @override
  Widget build(BuildContext context) => isCupertino
      ? buildCupertinoActionDialog(context)
      : buildActionDialog(context);

  Widget buildActionDialog(BuildContext context) {
    Widget? current;
    if (titleText != null) {
      current = TextLarge(titleText,
          maxLines: 10, style: context.theme.textTheme.titleLarge);
    }
    if (title != null) current = title!(current);
    if (current != null) {
      current = Container(
          alignment: Alignment.center,
          height: 45,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: current);
    }
    return ActionDialog(
        title: current,
        content: buildContent,
        dividerColor: dividerColor ?? CupertinoColors.separator,
        dividerThickness: dividerThickness,
        actions: buildActions(context),
        constraints:
            constraints ?? BoxConstraints(maxWidth: context.width - 60),
        options: FlExtended().modalOptions.merge(options).copyWith(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            borderRadius: BorderRadius.circular(6)),
        actionsMaxHeight: 40);
  }

  Widget buildCupertinoActionDialog(BuildContext context) {
    Widget? current;
    if (titleText != null) {
      current = TextLarge(titleText,
          maxLines: 10, style: context.theme.textTheme.titleLarge);
    }
    if (title != null) current = title!(current);
    return CupertinoAlertDialog(
        title: current, content: buildContent, actions: buildActions(context));
  }

  List<Widget> buildActions(BuildContext context) {
    final actions = [buildConfirm(context)];
    return this.actions?.call(actions) ?? actions;
  }

  Widget buildConfirm(BuildContext context) {
    Widget? current;
    if (confirmText != null) {
      current = TextMedium(confirmText, color: context.theme.primaryColor);
    }
    if (confirm != null) current = confirm!(current);
    return Universal(
        height: 40,
        expanded: !isCupertino,
        alignment: Alignment.center,
        onTap: () {
          final result = onConfirmTap?.call();
          if (confirmTapPop) pop(result ?? confirmTapPopResult);
        },
        child: current);
  }
}

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
class ConfirmCancelActionDialog extends ConfirmActionDialog {
  const ConfirmCancelActionDialog({
    super.key,
    this.cancel,
    this.cancelText = '取消',
    this.onCancelTap,
    this.cancelTapPop = true,
    this.cancelTapPopResult,
    super.confirm,
    super.confirmText = '确定',
    super.onConfirmTap,
    super.confirmTapPop = true,
    super.confirmTapPopResult,
    super.contentText,
    super.content,
    super.titleText,
    super.title,
    super.dividerThickness,
    super.dividerColor,
    super.options,
    super.actions,
    super.resizeToAvoidBottomInset,
    super.constraints,
  });

  const ConfirmCancelActionDialog.cupertino({
    super.key,
    this.cancel,
    this.cancelText = '取消',
    this.onCancelTap,
    this.cancelTapPop = true,
    this.cancelTapPopResult,
    super.confirm,
    super.confirmText = '确定',
    super.onConfirmTap,
    super.confirmTapPop = true,
    super.confirmTapPopResult,
    super.contentText,
    super.content,
    super.titleText,
    super.title,
    super.actions,
  }) : super.cupertino();

  /// cancel
  final String? cancelText;
  final WidgetTextBuilder? cancel;
  final ConfirmTapResult? onCancelTap;

  ///  [onCancelTap] 没有返回值的时候 返回的 result
  final dynamic cancelTapPopResult;

  /// [onCancelTap] 是否 pop
  final bool cancelTapPop;

  @override
  List<Widget> buildActions(BuildContext context) {
    final actions = [buildCancel(context), buildConfirm(context)];
    return this.actions?.call(actions) ?? actions;
  }

  Widget buildCancel(BuildContext context) {
    Widget? current;
    if (cancelText != null) {
      current = TextMedium(cancelText);
    }
    if (cancel != null) current = cancel!(current);
    return Universal(
        height: 40,
        expanded: !isCupertino,
        onTap: () {
          final result = onCancelTap?.call();
          if (cancelTapPop) pop(result ?? cancelTapPopResult);
        },
        alignment: Alignment.center,
        child: current);
  }
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
    this.maxLines,
    this.minLines,
    this.fillColor,
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
    this.maxLines,
    this.minLines,
    this.fillColor,
  })  : isCupertino = true,
        resizeToAvoidBottomInset = true;

  /// use cupertino style
  final bool isCupertino;
  final ConfirmTapValueCallbackResult<String>? onConfirmTap;

  /// cancel
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

  /// 输入框填充色
  final Color? fillColor;

  /// 默认为 1
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return ConfirmCancelActionDialog.cupertino(
          confirmText: confirmText,
          onConfirmTap: checkInput,
          cancelText: cancelText,
          onCancelTap: onCancelTap,
          titleText: titleText,
          content: (_) => buildTextField(context));
    }
    return ConfirmCancelActionDialog(
        confirmText: confirmText,
        onConfirmTap: checkInput,
        cancelText: cancelText,
        onCancelTap: onCancelTap,
        titleText: titleText,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        content: (_) => buildTextField(context));
  }

  Widget buildTextField(BuildContext context) => Material(
      color: Colors.transparent,
      child: BaseTextField(
          textInputType: textInputType,
          value: value,
          margin: const EdgeInsets.all(12),
          hintText: hintText,
          borderType: BorderType.outline,
          borderSide: BorderSide(color: context.theme.dividerColor, width: 0.5),
          controller: controller,
          width: double.infinity,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          fillColor: fillColor ?? context.theme.cardColor,
          autoFocus: true));

  dynamic checkInput() {
    if (controller.text.isEmpty) {
      showToast(hintText);
      return;
    }
    return onConfirmTap?.call(controller.text) ?? controller.text;
  }
}
