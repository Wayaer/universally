import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class StatePage extends StatefulWidget {
  const StatePage({super.key});

  @override
  State<StatePage> createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  bool xSwitch = true;
  bool materialSwitch = false;
  bool cupertinoSwitch = true;
  bool? checkbox = true;
  double slider = 0.4;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '开关 / 复选 / 滑块',
      children: [
        DemoSection(
          title: 'Switch 开关',
          description: 'ChangedBuilder 系列组件支持同步 onChanged、异步 onWaitChanged 与生命周期回调。',
          children: [
            _StateRow(
              label: 'BaseFlSwitch',
              description: 'Material 3 开关',
              child: BaseFlSwitch(value: xSwitch, onChanged: (bool value) => setState(() => xSwitch = value)),
            ),
            const SizedBox(height: 16),
            _StateRow(
              label: 'BaseSwitch',
              description: '经典 Material 开关',
              child: BaseSwitch(
                value: materialSwitch,
                onChanged: (bool value) => setState(() => materialSwitch = value),
              ),
            ),
            const SizedBox(height: 16),
            _StateRow(
              label: 'BaseCupertinoSwitch',
              description: 'iOS 风格开关',
              child: BaseCupertinoSwitch(
                value: cupertinoSwitch,
                onChanged: (bool value) => setState(() => cupertinoSwitch = value),
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'BaseCheckbox 复选框',
          description: 'value 为 null 时显示三态中的中间状态。',
          children: [
            _StateRow(
              label: 'BaseCheckbox',
              description: '当前值：$checkbox',
              child: BaseCheckbox(value: checkbox, onChanged: (bool? value) => setState(() => checkbox = value)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DemoButton(text: '设为 true', onTap: () => setState(() => checkbox = true)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DemoButton(text: '设为 false', onTap: () => setState(() => checkbox = false)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DemoButton(text: '设为 null', onTap: () => setState(() => checkbox = null)),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'BaseSlider 滑块',
          description: '拖动滑块查看实时数值。',
          children: [
            TextMedium('当前值：${slider.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            BaseSlider(value: slider, onChanged: (double value) => setState(() => slider = value)),
          ],
        ),
        DemoSection(
          title: 'CleanCache 缓存',
          description: '统计并清理缓存目录。',
          children: [
            _StateRow(
              label: '缓存大小',
              description: '点击右侧图标清理',
              child: CleanCache(color: context.theme.primaryColor),
            ),
          ],
        ),
        DemoSection(
          title: 'PushSwitchState 推送开关',
          description: '读写本地推送开关状态。',
          children: [_StateRow(label: '消息推送', description: '本地持久化', child: PushSwitchState())],
        ),
      ],
    );
  }
}

class _StateRow extends StatelessWidget {
  const _StateRow({required this.label, required this.child, this.description});

  final String label;
  final String? description;
  final Widget child;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMedium(label),
            if (description != null) ...[
              const SizedBox(height: 4),
              TextSmall(description!, color: context.theme.hintColor),
            ],
          ],
        ),
      ),
      const SizedBox(width: 12),
      child,
    ],
  );
}
