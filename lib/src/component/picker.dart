import 'package:flutter/cupertino.dart';
import 'package:universally/universally.dart';

class BasePickerOptions<T> extends PickerOptions<T> {
  BasePickerOptions(
      {String? title,
      super.verifyConfirm,
      super.verifyCancel,
      super.backgroundColor,
      super.contentPadding,
      super.decoration,
      super.padding,
      super.top,
      super.bottom = const BaseDivider(),
      double height = 250})
      : super(
            title: Center(child: TextLarge(title ?? '', color: UCS.mainBlack)),
            confirm: const TextNormal('确定', usePrimaryColor: true),
            cancel: const TextNormal('取消', color: UCS.black70));
}

extension ExtensionBaseCupertinoActionSheet on BaseCupertinoActionSheet {
  Future<int?> show({BottomSheetOptions? options}) => popupBottomSheet<int?>(
      options: const BottomSheetOptions(backgroundColor: UCS.transparent)
          .merge(options));
}

/// 底部有取消的单选
/// 返回数组index
class BaseCupertinoActionSheet extends StatelessWidget {
  const BaseCupertinoActionSheet(this.list,
      {super.key, this.cancel, this.cancelText = '取消'});

  final List<String> list;
  final Widget? cancel;
  final String cancelText;

  @override
  Widget build(BuildContext context) {
    final actions = list.builderEntry((entry) => CupertinoActionSheetAction(
        onPressed: () => closePopup(entry.key),
        isDefaultAction: true,
        child: TextNormal(entry.value, height: 1, color: UCS.black70)));
    actions.add(CupertinoActionSheetAction(
        onPressed: maybePop,
        isDefaultAction: true,
        child: TextNormal(cancelText, color: context.theme.primaryColor)));
    return CupertinoActionSheet(actions: actions);
  }
}
