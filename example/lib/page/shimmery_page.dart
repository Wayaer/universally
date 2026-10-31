import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ShimmeryPage extends StatefulWidget {
  const ShimmeryPage({super.key});

  @override
  State<ShimmeryPage> createState() => _ShimmeryPageState();
}

class _ShimmeryPageState extends State<ShimmeryPage> {
  bool enabled = true;

  Color get blockColor => context.theme.colorScheme.surfaceContainerHighest;

  Color get baseColor => context.theme.colorScheme.surface;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '骨架屏 FlShimmery',
      children: [
        DemoSection(
          title: '基础用法',
          description: 'FlShimmery 会为 child 叠加一层扫光动画，child 使用与页面有对比度的颜色即可清晰可见。',
          children: [
            Universal(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(8)),
              child: FlShimmery(
                enabled: enabled,
                child: Row(
                  children: [
                    Universal(width: 64, height: 64, color: blockColor, borderRadius: BorderRadius.circular(8)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Universal(
                            width: double.infinity,
                            height: 16,
                            color: blockColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          const SizedBox(height: 10),
                          Universal(width: 160, height: 16, color: blockColor, borderRadius: BorderRadius.circular(4)),
                          const SizedBox(height: 10),
                          Universal(width: 100, height: 16, color: blockColor, borderRadius: BorderRadius.circular(4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextMedium('启用动画'),
                BaseFlSwitch(value: enabled, onChanged: (bool value) => setState(() => enabled = value)),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '卡片骨架',
          description: '常见列表卡片骨架：头像、标题、两行正文与底部标签。',
          children: [
            Universal(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(10)),
              child: FlShimmery(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Universal(width: 44, height: 44, isOval: true, color: blockColor),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Universal(
                              width: 120,
                              height: 16,
                              color: blockColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            const SizedBox(height: 8),
                            Universal(width: 80, height: 12, color: blockColor, borderRadius: BorderRadius.circular(4)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Universal(
                      width: double.infinity,
                      height: 12,
                      color: blockColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Universal(
                      width: double.infinity,
                      height: 12,
                      color: blockColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Universal(width: 180, height: 12, color: blockColor, borderRadius: BorderRadius.circular(4)),
                    const SizedBox(height: 14),
                    Row(
                      children: List.generate(
                        3,
                        (int index) => Universal(
                          width: 56,
                          height: 20,
                          margin: const EdgeInsets.only(right: 8),
                          color: blockColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        DemoSection(
          title: '自定义扫光颜色',
          description: 'colors 支持自定义渐变，颜色数量至少为 2。',
          children: [
            FlShimmery(
              colors: const [
                Colors.transparent,
                Color.from(alpha: 0.10, red: 1, green: 1, blue: 1),
                Color.from(alpha: 0.35, red: 1, green: 1, blue: 1),
                Colors.transparent,
              ],
              duration: const Duration(seconds: 2),
              child: Universal(
                width: double.infinity,
                height: 72,
                color: blockColor,
                borderRadius: BorderRadius.circular(8),
                alignment: Alignment.center,
                child: TextMedium('自定义扫光', color: context.theme.hintColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
