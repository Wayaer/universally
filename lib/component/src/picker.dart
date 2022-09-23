import 'package:flutter/cupertino.dart';
import 'package:universally/universally.dart';

class CurrentPickerOptions<T> extends PickerOptions<T> {
  CurrentPickerOptions(
      {String? title,
      super.confirmTap,
      super.cancelTap,
      super.backgroundColor,
      double height = 250})
      : super(
            title: Center(child: TextLarge(title ?? '', color: UCS.mainBlack)),
            confirm: TextDefault('确定', color: GlobalConfig().currentColor),
            cancel: TextDefault('取消', color: UCS.mainBlack.withOpacity(0.6)),
            bottom: const CustomDivider());
}

/// 省市区选择器
Future<String?> pickerArea(
        {String? defaultProvince,
        String? defaultCity,
        String? defaultDistrict}) =>
    showAreaPicker<String?>(
        defaultProvince: defaultProvince,
        defaultCity: defaultCity,
        defaultDistrict: defaultDistrict,
        options: CurrentPickerOptions(title: '选择地区'));

/// 日期选择器
Future<String?> pickerDateTime(
    {DateTime? startDate,
    DateTime? defaultDate,
    DateTime? endDate,
    int? dateTimeType,
    ValueCallback<String>? confirmTap}) async {
  DateTimePickerUnit unit;
  switch (dateTimeType) {
    case 1: //时分
      unit = const DateTimePickerUnit(hour: '时', minute: '分');
      break;
    case 2: //年月日
      unit = const DateTimePickerUnit(year: '年', month: '月', day: '日');
      break;
    case 3: //年月
      unit = const DateTimePickerUnit(year: '年', month: '月');
      break;
    case 4: //年月日时分秒
      unit = const DateTimePickerUnit(
          year: '年', month: '月', day: '日', hour: '时', minute: '分', second: '秒');
      break;
    default:
      unit = const DateTimePickerUnit.yhm(
          year: '年', month: '月', day: '日', hour: '时', minute: '分');
      break;
  }
  String dateTimeToString(DateTime dateTime) {
    switch (dateTimeType) {
      case 1:
        return dateTime.format(DateTimeDist.hourMinute);
      case 2:
        return dateTime.format(DateTimeDist.yearDay);
      case 3:
        return dateTime.format(DateTimeDist.yearMonth);
      case 4:
        return dateTime.format(DateTimeDist.yearSecond);
      default:
        return dateTime.format(DateTimeDist.yearMinute);
    }
  }

  final date = await showDateTimePicker<DateTime?>(
      options: CurrentPickerOptions(
          confirmTap: (DateTime? dateTime) {
            if (confirmTap != null && dateTime != null) {
              confirmTap(dateTimeToString(dateTime));
            }
            return true;
          },
          title: '选择时间'),
      wheelOptions: const PickerWheelOptions(isCupertino: false),
      unit: unit,
      dual: true,
      startDate: startDate,
      defaultDate: defaultDate,
      endDate: endDate);
  return date == null ? null : dateTimeToString(date);
}

/// 多条数据列表选择器
Future<int?> pickerMultipleChoice<T>(String title,
        {required int itemCount, required IndexedWidgetBuilder itemBuilder}) =>
    showSingleColumnPicker<int?>(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(top: 2),
            child: itemBuilder(context, index)),
        wheelOptions: const PickerWheelOptions(
            useMagnifier: true,
            magnification: 1.2,
            diameterRatio: 1.2,
            isCupertino: true),
        options: CurrentPickerOptions<int>(title: title));

Future<T?> pickerCustom<T>(
  Widget content, {
  String title = '',
  PickerTapConfirmCallback<T>? confirmTap,
  PickerTapCancelCallback<T?>? cancelTap,
  PickerSubjectTapCallback<T>? customConfirmTap,
  PickerSubjectTapCallback<T?>? customCancelTap,
  Color? backgroundColor,
  BottomSheetOptions? bottomSheetOptions,
  double height = 250,
}) =>
    showCustomPicker<T?>(
        bottomSheetOptions: bottomSheetOptions,
        confirmTap: customConfirmTap,
        cancelTap: customCancelTap,
        options: CurrentPickerOptions<T>(
            cancelTap: cancelTap,
            confirmTap: confirmTap,
            title: title,
            height: height,
            backgroundColor: backgroundColor),
        content: content);

/// 底部有取消的单选
/// 返回数组index
Future<int?> pickerSingleChoice(List<String> list,
        {BottomSheetOptions? options}) =>
    showBottomPopup<int?>(
        options: options ??
            const BottomSheetOptions(backgroundColor: UCS.transparent),
        widget: AlertSingleChoice(list));

/// 带取消的单选
class AlertSingleChoice extends StatelessWidget {
  const AlertSingleChoice(this.list, {super.key});

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
