import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PickerPage extends StatefulWidget {
  const PickerPage({super.key});

  @override
  State<PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  final List<String> items = ['北京', '上海', '广州', '深圳', '杭州', '成都'];
  int wheelIndex = 2;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '列表选择器',
      children: [
        DemoSection(
          title: 'FlListWheel',
          description: '通用滚轮组件，支持 Material / Cupertino 全局样式与单次覆盖。',
          children: [
            Universal(
              height: 180,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlListWheel.count(
                children: items.map((String item) => Center(child: TextMedium(item))).toList(),
                onSelectedItemChanged: (int index) => setState(() => wheelIndex = index),
              ),
            ),
            const SizedBox(height: 10),
            TextSmall('当前选中：${items[wheelIndex]}'),
          ],
        ),
        DemoSection(
          title: 'FlSingleListWheelPicker',
          description: '单列滚轮选择器，show() 返回选中下标。',
          children: [
            DemoButton(
              text: '单列滚轮选择',
              onTap: () async {
                final int? result = await FlSingleListWheelPicker(
                  initialIndex: wheelIndex,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) => Center(child: TextMedium(items[index])),
                  options: BasePickerOptions<int>(titleText: '选择城市'),
                ).show();
                if (result != null) setState(() => wheelIndex = result);
                showToast('选择下标：$result');
              },
            ),
          ],
        ),
        DemoSection(
          title: 'FlSingleListPicker',
          description: '基于 ListView 的列表选择器，支持单选与多选。',
          children: [
            DemoButton(
              text: '列表单选',
              onTap: () async {
                final List<int>? result = await FlSingleListPicker(
                  itemCount: items.length,
                  initialIndex: [wheelIndex],
                  singleListPickerOptions: const FlSingleListPickerOptions(
                    allowedMultipleChoice: false,
                    isCustomGestureTap: true,
                  ),
                  options: BasePickerOptions<List<int>>(titleText: '列表单选'),
                  itemBuilder: (BuildContext context, int index, bool selected, change) => ListTile(
                    title: TextMedium(items[index]),
                    trailing: selected ? const Icon(Icons.check, color: Colors.green) : null,
                    onTap: () => change(index),
                  ),
                ).show();
                showToast('选择：$result');
              },
            ),
            DemoButton(
              text: '列表多选',
              onTap: () async {
                final List<int>? result = await FlSingleListPicker(
                  itemCount: items.length,
                  initialIndex: const [0, 2],
                  singleListPickerOptions: const FlSingleListPickerOptions(isCustomGestureTap: true),
                  options: BasePickerOptions<List<int>>(titleText: '列表多选'),
                  itemBuilder: (BuildContext context, int index, bool selected, change) => ListTile(
                    title: TextMedium(items[index]),
                    trailing: selected ? const Icon(Icons.check, color: Colors.green) : null,
                    onTap: () => change(index),
                  ),
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
