import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DatePickerPage extends StatelessWidget {
  const DatePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '日期与时间选择',
      children: [
        DemoSection(
          title: 'FlDatePicker',
          description: '适合固定区间内的日期选择。',
          children: [
            DemoButton(
              text: '选择日期',
              onTap: () async {
                final DateTime? result = await FlDatePicker(
                  startDate: DateTime.now().subtract(const Duration(days: 365)),
                  endDate: DateTime.now().add(const Duration(days: 365)),
                  options: BasePickerOptions<DateTime>(titleText: '选择日期'),
                ).show();
                showToast('选择：$result');
              },
            ),
          ],
        ),
        DemoSection(
          title: 'FlDateTimePicker',
          description: '适合大跨度日期时间选择。',
          children: [
            DemoButton(
              text: '选择日期时间',
              onTap: () async {
                final DateTime? result = await FlDateTimePicker(
                  startDate: DateTime.now().subtract(const Duration(days: 3650)),
                  endDate: DateTime.now().add(const Duration(days: 3650)),
                  options: BasePickerOptions<DateTime>(titleText: '选择日期时间'),
                ).show();
                showToast('选择：$result');
              },
            ),
          ],
        ),
      ],
    );
  }
}
