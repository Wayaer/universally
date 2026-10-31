import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ActionSheetPage extends StatelessWidget {
  const ActionSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'ActionSheet',
      children: [
        DemoSection(
          title: 'BaseCupertinoActionSheet',
          description: '底部弹出的单选操作表，show() 返回选中下标。',
          children: [
            DemoButton(
              text: '显示 ActionSheet',
              onTap: () async {
                final int? result = await BaseCupertinoActionSheet(const ['选项一', '选项二', '选项三']).show();
                showToast('选择：$result');
              },
            ),
          ],
        ),
      ],
    );
  }
}
