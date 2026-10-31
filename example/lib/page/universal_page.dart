import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class UniversalPage extends StatelessWidget {
  const UniversalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Universal 布局容器',
      children: [
        DemoSection(
          title: '基础容器',
          description: 'Universal 统一封装 Container、Row、Column、Stack、Wrap，并支持点击、圆角、裁剪、滚动与 Expanded。',
          children: [
            Universal(
              direction: Axis.horizontal,
              spacing: 8,
              children: [
                Universal(
                  width: 60,
                  height: 60,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const TextMedium('A', color: Colors.white),
                ),
                Universal(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: const TextMedium('B', color: Colors.white),
                ),
                Universal(
                  width: 60,
                  height: 60,
                  isOval: true,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const TextMedium('C', color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'Wrap 自动换行',
          description: '设置 isWrap 后自动换行，spacing 控制主轴间距，runSpacing 控制换行间距。',
          children: [
            Universal(
              isWrap: true,
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                10,
                (int index) => Universal(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextSmall('标签 $index'),
                ),
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'Stack 层叠',
          description: '设置 isStack 后直接使用 Stack 布局，子组件可配合 Positioned 定位。',
          children: [
            Universal(
              height: 120,
              decoration: BoxDecoration(
                color: context.theme.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              isStack: true,
              children: [
                Positioned(left: 12, top: 12, child: TextSmall('Positioned(left: 12, top: 12)')),
                Universal(alignment: Alignment.center, child: const TextMedium('Stack 居中内容')),
                Positioned(right: 12, bottom: 12, child: TextSmall('Positioned(right: 12, bottom: 12)')),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '点击与圆角裁剪',
          description: 'onTap 让任意容器拥有点击能力，borderRadius 会自动裁剪子组件。',
          children: [
            Universal(
              onTap: () => showToast('Universal 点击事件'),
              padding: const EdgeInsets.all(14),
              borderRadius: BorderRadius.circular(8),
              color: context.theme.primaryColor.withValues(alpha: 0.08),
              alignment: Alignment.center,
              child: const TextMedium('可点击 + 圆角裁剪'),
            ),
            const SizedBox(height: 6),
            Universal(
              onTap: () => showToast('圆形点击'),
              width: 80,
              height: 80,
              isOval: true,
              color: context.theme.primaryColor,
              alignment: Alignment.center,
              child: const TextSmall('圆形', color: Colors.white),
            ),
          ],
        ),
        DemoSection(
          title: 'Expanded 与滚动',
          description: 'isExpanded 在 Row / Column 中自动包裹 Expanded，isScroll 让容器内容可滚动。',
          children: [
            Universal(
              direction: Axis.horizontal,
              spacing: 8,
              height: 56,
              children: [
                Universal(
                  expanded: true,
                  color: Colors.teal.withValues(alpha: 0.15),
                  alignment: Alignment.center,
                  child: const TextSmall('isExpanded: true'),
                ),
                Universal(
                  expanded: true,
                  color: Colors.orange.withValues(alpha: 0.15),
                  alignment: Alignment.center,
                  child: const TextSmall('isExpanded: true'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Universal(
              height: 140,
              isScroll: true,
              children: List.generate(
                12,
                (int index) => Universal(
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 8),
                  color: context.theme.colorScheme.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: TextSmall('可滚动内容 $index'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
