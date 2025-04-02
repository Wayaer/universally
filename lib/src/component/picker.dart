import 'package:flutter/cupertino.dart';
import 'package:universally/universally.dart';

class BasePickerOptions<T> extends PickerOptions<T> {
  BasePickerOptions({
    String? titleText,
    super.verifyConfirm,
    super.verifyCancel,
    super.backgroundColor,
    super.background,
    super.contentPadding,
    super.titlePadding,
    super.decoration,
    super.top,
    super.bottom = const BaseDivider(),
    super.bottomNavigationBar,
    super.confirm = const TextMedium('确定', usePrimaryColor: true),
    super.cancel = const TextMedium('取消'),
    Widget? title,
  }) : super(
         title:
             title ??
             (titleText == null ? null : Center(child: TextLarge(titleText))),
       );
}

extension ExtensionBaseCupertinoActionSheet on BaseCupertinoActionSheet {
  Future<int?> show({BottomSheetOptions? options}) => popupBottomSheet<int?>(
    options: const BottomSheetOptions(
      backgroundColor: UCS.transparent,
    ).merge(options),
  );
}

/// 底部有取消的单选
/// 返回数组index
class BaseCupertinoActionSheet extends StatelessWidget {
  const BaseCupertinoActionSheet(
    this.list, {
    super.key,
    this.cancel,
    this.cancelText = '取消',
  });

  final List<String> list;
  final Widget? cancel;
  final String cancelText;

  @override
  Widget build(BuildContext context) {
    final actions = list.builderEntry(
      (entry) => CupertinoActionSheetAction(
        onPressed: () => closePopup(entry.key),
        isDefaultAction: true,
        child: TextMedium(entry.value, height: 1),
      ),
    );
    return CupertinoActionSheet(
      actions: actions,
      cancelButton: CupertinoActionSheetAction(
        onPressed: maybePop,
        isDefaultAction: true,
        child: cancel ?? TextMedium(cancelText),
      ),
    );
  }
}
