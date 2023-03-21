import 'package:flutter/cupertino.dart';
import 'package:universally/universally.dart';

class BasicPickerOptions<T> extends PickerOptions<T> {
  BasicPickerOptions(
      {String? title,
      super.verifyConfirm,
      super.verifyCancel,
      super.backgroundColor,
      super.contentPadding,
      super.decoration,
      super.padding,
      super.top,
      super.bottom = const CustomDivider(),
      double height = 250})
      : super(
            title: Center(child: TextLarge(title ?? '', color: UCS.mainBlack)),
            confirm: TextDefault('确定', color: GlobalConfig().currentColor),
            cancel: TextDefault('取消', color: UCS.mainBlack.withOpacity(0.6)));
}

/// 底部有取消的单选
/// 返回数组index
Future<int?> pickerActionSheet(List<String> list,
        {BottomSheetOptions? options}) =>
    BasicCupertinoActionSheet(list).popupBottomSheet<int?>(
        options: const BottomSheetOptions(backgroundColor: UCS.transparent)
            .merge(options));

/// 带取消的单选
class BasicCupertinoActionSheet extends StatelessWidget {
  const BasicCupertinoActionSheet(this.list, {super.key});

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    final actions = list.builderEntry((entry) => CupertinoActionSheetAction(
        onPressed: () => closePopup(entry.key),
        isDefaultAction: true,
        child: TextDefault(entry.value, height: 1, color: UCS.black70)));
    actions.add(CupertinoActionSheetAction(
        onPressed: maybePop,
        isDefaultAction: true,
        child: TextDefault('取消', color: GlobalConfig().currentColor)));
    return CupertinoActionSheet(actions: actions);
  }
}
