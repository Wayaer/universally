import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class MultiPickerPage extends StatelessWidget {
  const MultiPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['北京', '上海', '广州', '深圳', '杭州', '成都'];
    return DemoScaffold(
      title: '多列与自定义选择器',
      children: [
        DemoSection(
          title: 'FlMultiListWheelPicker',
          description: '多列滚轮选择，各列互不联动。',
          children: [
            DemoButton(
              text: '多列滚轮',
              onTap: () async {
                final List<int>? result = await FlMultiListWheelPicker(
                  items: [
                    FlPickerItem(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) => Center(child: TextMedium(items[index])),
                    ),
                    FlPickerItem(
                      itemCount: 24,
                      itemBuilder: (BuildContext context, int index) => Center(child: TextMedium('${index + 1} 时')),
                    ),
                  ],
                  options: BasePickerOptions<List<int>>(titleText: '多列选择'),
                ).show();
                showToast('选择下标：$result');
              },
            ),
          ],
        ),
        DemoSection(
          title: 'FlMultiListWheelLinkagePicker',
          description: '多列联动滚轮，选择父级后自动刷新子级。',
          children: [
            DemoButton(
              text: '联动滚轮',
              onTap: () async {
                final List<int>? result = await FlMultiListWheelLinkagePicker<String>(
                  items: [
                    FlPickerLinkageItem<String>(
                      value: '浙江',
                      child: const TextMedium('浙江'),
                      children: [
                        FlPickerLinkageItem<String>(value: '杭州', child: const TextMedium('杭州')),
                        FlPickerLinkageItem<String>(value: '宁波', child: const TextMedium('宁波')),
                      ],
                    ),
                    FlPickerLinkageItem<String>(
                      value: '广东',
                      child: const TextMedium('广东'),
                      children: [
                        FlPickerLinkageItem<String>(value: '广州', child: const TextMedium('广州')),
                        FlPickerLinkageItem<String>(value: '深圳', child: const TextMedium('深圳')),
                      ],
                    ),
                  ],
                  options: BasePickerOptions<List<int>>(titleText: '省市区联动'),
                ).show();
                showToast('选择路径：$result');
              },
            ),
          ],
        ),
        DemoSection(
          title: 'FlCustomPicker',
          description: '在底部选择器中嵌入任意内容，confirmTap 返回自定义结果。',
          children: [
            DemoButton(
              text: '自定义内容选择器',
              onTap: () async {
                final String? result = await FlCustomPicker<String>(
                  options: BasePickerOptions<String>(titleText: '自定义内容'),
                  confirmTap: () => 'custom',
                  content: const SizedBox(height: 120, child: Center(child: TextMedium('任意内容'))),
                ).show();
                showToast('返回：$result');
              },
            ),
          ],
        ),
      ],
    );
  }
}
