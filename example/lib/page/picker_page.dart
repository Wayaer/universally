import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PickerPage extends StatelessWidget {
  const PickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isScroll: true,
      padding: const EdgeInsets.all(12),
      appBarTitleText: 'Picker',
      children: [
        Button(
          onTap: () async {
            final list = ['第1个', '第2个', '第3个'];
            final result = await BaseCupertinoActionSheet(list).show();
            if (result == null) return;
            showToast(list[result]);
          },
          text: 'BaseCupertinoActionSheet',
        ),
        Button(
          onTap: () async {
            final result = await DateTimePicker(
              options: BasePickerOptions<DateTime>(),
            ).show();
            showToast(result.toString());
          },
          text: 'DateTimePicker',
        ),
        Button(
          onTap: () async {
            final result =
                await DatePicker(options: BasePickerOptions<DateTime>()).show();
            showToast(result.toString());
          },
          text: 'DatePicker',
        ),
        Button(
          onTap: () async {
            final result = await SingleListWheelPicker(
              options: BasePickerOptions<int>(),
              itemBuilder: (BuildContext context, int index) => Center(
                child: TextLarge(numberList[index].toString()),
              ),
              itemCount: numberList.length,
            ).show();
            showToast(result.toString());
          },
          text: 'SingleListWheelPicker',
        ),
        Button(
          onTap: () async {
            final result = await MultiListWheelPicker(
              options: BasePickerOptions<List<int>>(),
              items: multiListWheelList,
            ).show();
            showToast(result.toString());
          },
          text: 'MultiListWheelPicker',
        ),
      ],
    );
  }

  final numberList = const ['一', '二', '三', '四', '五', '六', '七', '八', '十'];

  List<PickerItem> get multiListWheelList => List.generate(
        4,
        (_) => PickerItem(
          itemCount: numberList.length,
          itemBuilder: (_, int index) =>
              Center(child: TextLarge(numberList[index])),
        ),
      );
}
