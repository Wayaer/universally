import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

extension ExtensionConfirmAndCancelActionDialog
    on ConfirmAndCancelActionDialog {
  Future<T?> bottomSheet<T>({BottomSheetOptions? options}) =>
      popupBottomSheet<T>(
          options: const BottomSheetOptions(backgroundColor: Colors.transparent)
              .merge(options));

  Future<T?> show<T>({DialogOptions? options}) => popupDialog<T>(
      options: const DialogOptions(barrierLabel: '').merge(options));
}

/// 弹出带 确定 和 取消 的按钮 点击 确定 或 取消 自动关闭
/// Pop up the button with OK and cancel click OK or cancel to automatically close
class ConfirmAndCancelActionDialog extends StatelessWidget {
  const ConfirmAndCancelActionDialog({
    super.key,
    this.confirm,
    this.confirmText = '确定',
    this.onConfirmTap,
    this.cancel,
    this.cancelText = '取消',
    this.onCancelTap,
    this.contentText,
    this.content,
    this.titleText,
    this.title,
    this.autoClose = true,
    this.hasDivider = true,
    this.options,
    this.actions,
  }) : _isCupertino = false;

  const ConfirmAndCancelActionDialog.cupertino({
    super.key,
    this.confirm,
    this.confirmText = '确定',
    this.onConfirmTap,
    this.cancel,
    this.cancelText = '取消',
    this.onCancelTap,
    this.contentText,
    this.content,
    this.titleText,
    this.title,
    this.autoClose = true,
    this.actions,
  })  : options = null,
        hasDivider = false,
        _isCupertino = true;

  /// confirm
  final String? confirmText;
  final GestureTapCallback? onConfirmTap;
  final Widget? confirm;

  /// cancel
  final String? cancelText;
  final Widget? cancel;
  final GestureTapCallback? onCancelTap;

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

  final bool _isCupertino;

  /// 是否显示线
  final bool hasDivider;

  @override
  Widget build(BuildContext context) =>
      _isCupertino ? buildCupertinoActionDialog : buildActionDialog;

  Widget get buildActionDialog => ActionDialog(
      title: title != null || titleText != null
          ? Container(
              alignment: Alignment.center,
              height: 45,
              child: title ?? TextLarge(titleText, maxLines: 10))
          : null,
      content: buildContent,
      dividerColor: hasDivider ? UCS.lineColor : null,
      dividerThickness: 1,
      actions: buildActions,
      options: FlExtended().modalOptions.merge(options).copyWith(
          borderRadius: BorderRadius.circular(6), foregroundColor: UCS.white),
      actionsMaxHeight: 40);

  Widget get buildContent => Container(
      padding: const EdgeInsets.all(10),
      child: content ?? TextNormal(contentText, maxLines: 0));

  Widget get buildCupertinoActionDialog => CupertinoAlertDialog(
      title: title ?? TextLarge(titleText, maxLines: 10),
      content: buildContent,
      actions: buildActions);

  List<Widget> get buildActions =>
      actions ??
      [
        Universal(
            height: 40,
            expanded: !_isCupertino,
            onTap: () {
              if (autoClose) pop();
              if (onCancelTap != null) onCancelTap!();
            },
            alignment: Alignment.center,
            child: cancel ?? TextNormal(cancelText)),
        Universal(
            height: 40,
            expanded: !_isCupertino,
            alignment: Alignment.center,
            onTap: () {
              if (autoClose) pop();
              if (onConfirmTap != null) onConfirmTap!();
            },
            child: confirm ?? TextNormal(confirmText))
      ];
}
