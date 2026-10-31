import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlButton 按钮',
      children: [
        DemoSection(
          title: '五种 Material 按钮',
          description: 'FlButton 统一 none / filled / filledTonal / elevated / outlined 五种类型。',
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FlButton(onPressed: () => showToast('none'), child: const Text('none')),
                FlButton(
                  category: FlButtonCategory.filled,
                  onPressed: () => showToast('filled'),
                  child: const Text('filled'),
                ),
                FlButton(
                  category: FlButtonCategory.filledTonal,
                  onPressed: () => showToast('filledTonal'),
                  child: const Text('filledTonal'),
                ),
                FlButton(
                  category: FlButtonCategory.elevated,
                  onPressed: () => showToast('elevated'),
                  child: const Text('elevated'),
                ),
                FlButton(
                  category: FlButtonCategory.outlined,
                  onPressed: () => showToast('outlined'),
                  child: const Text('outlined'),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '带图标',
          description: '使用 FlButton.icon 组合图标与文字。',
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FlButton.icon(icon: const Icon(Icons.add), onPressed: () => showToast('icon'), child: const Text('新建')),
                FlButton.icon(
                  category: FlButtonCategory.filledTonal,
                  icon: const Icon(Icons.download),
                  onPressed: () => showToast('download'),
                  child: const Text('下载'),
                ),
                FlButton.icon(
                  category: FlButtonCategory.outlined,
                  icon: const Icon(Icons.share),
                  onPressed: () => showToast('share'),
                  child: const Text('分享'),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '禁用状态',
          description: 'onPressed 为 null 时按钮自动进入禁用态。',
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                const FlButton(onPressed: null, child: Text('none')),
                const FlButton(category: FlButtonCategory.filled, onPressed: null, child: Text('filled')),
                const FlButton(category: FlButtonCategory.outlined, onPressed: null, child: Text('outlined')),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'UButton',
          description: '项目内常用按钮封装，支持 enabled、text 与 onTap。',
          children: [
            UButton(text: 'UButton', onTap: () => showToast('UButton')),
            const SizedBox(height: 12),
            UButton(text: 'UButton disabled', enabled: false),
          ],
        ),
        DemoSection(
          title: 'IconLabel',
          description: '图标 + 文字组合，可选点击回调。',
          children: [
            IconLabel(icon: Icons.home, label: const TextMedium('IconLabel'), onTap: () => showToast('IconLabel')),
            const SizedBox(height: 12),
            IconLabel(icon: Icons.favorite, label: const TextMedium('不可点击')),
          ],
        ),
      ],
    );
  }
}
