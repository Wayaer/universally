import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class CurrentPickerOptions<T> extends PickerOptions<T> {
  CurrentPickerOptions(
      {String? title,
      PickerTapSureCallback<T>? sureTap,
      PickerTapCancelCallback<T>? cancelTap,
      Color? backgroundColor,
      double height = 250})
      : super(
            backgroundColor: backgroundColor,
            sureTap: sureTap,
            cancelTap: cancelTap,
            height: height,
            title: Center(child: TextLarge(title ?? '', color: UCS.mainBlack)),
            sure: TextDefault('确定', color: currentColor),
            cancel: TextDefault('取消', color: UCS.mainBlack.withOpacity(0.6)),
            titleBottom: const CustomDivider());
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
    ValueCallback<String>? sureTap}) async {
  DateTimePickerUnit unit;
  switch (dateTimeType) {
    case 1: //时分
      unit = DateTimePickerUnit(
          year: null,
          month: null,
          day: null,
          second: null,
          hour: '时',
          minute: ''
              '分');
      break;
    case 2: //年月日
      unit = DateTimePickerUnit(
          year: '年',
          month: '月',
          day: '日',
          hour: null,
          minute: null,
          second: null);
      break;
    case 3: //年月
      unit = DateTimePickerUnit(
          year: '年',
          month: '月',
          day: null,
          hour: null,
          minute: null,
          second: null);
      break;
    case 4: //时分秒
      unit = DateTimePickerUnit(
          year: '年', month: '月', day: '日', hour: '时', minute: '分', second: '秒');
      break;
    default:
      unit = DateTimePickerUnit(
          year: '年',
          month: '月',
          day: '日',
          hour: '时',
          minute: '分',
          second: null);
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
          sureTap: (DateTime? dateTime) {
            if (sureTap != null && dateTime != null) {
              sureTap(dateTimeToString(dateTime));
            }
            return true;
          },
          title: '选择时间'),
      wheel: PickerWheel(isCupertino: false),
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
    showMultipleChoicePicker<int?>(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(top: 2),
            child: itemBuilder(context, index)),
        wheel: PickerWheel(
            useMagnifier: true,
            magnification: 1.2,
            diameterRatio: 1.2,
            isCupertino: true),
        options: CurrentPickerOptions<int>(title: title));

Future<T?> pickerCustom<T>(
  Widget content, {
  String title = '',
  PickerTapSureCallback<T>? sureTap,
  PickerTapCancelCallback<T?>? cancelTap,
  PickerSubjectTapCallback<T>? customSureTap,
  PickerSubjectTapCallback<T?>? customCancelTap,
  Color? backgroundColor,
  BottomSheetOptions? bottomSheetOptions,
  double height = 250,
}) =>
    showCustomPicker<T?>(
        bottomSheetOptions: bottomSheetOptions,
        sureTap: customSureTap,
        cancelTap: customCancelTap,
        options: CurrentPickerOptions<T>(
            cancelTap: cancelTap,
            sureTap: sureTap,
            title: title,
            height: height,
            backgroundColor: backgroundColor),
        content: content);

/// 底部有取消的单选
/// 返回数组index
Future<int?> pickerSingleChoice(List<String> list) =>
    showBottomPopup<int?>(widget: AlertSingleChoice(list));

/// 带取消的单选
class AlertSingleChoice extends StatelessWidget {
  const AlertSingleChoice(this.list, {Key? key}) : super(key: key);

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    final actions = list.builderEntry((entry) => CupertinoActionSheetAction(
        child: TextDefault(entry.value, height: 1, color: UCS.black70),
        onPressed: () => closePopup(entry.key),
        isDefaultAction: true));
    actions.add(CupertinoActionSheetAction(
        child: TextDefault('取消', color: currentColor),
        onPressed: maybePop,
        isDefaultAction: true));
    return CupertinoActionSheet(actions: actions);
  }
}
