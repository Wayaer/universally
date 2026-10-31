import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class StylePage extends StatelessWidget {
  const StylePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color panel = context.theme.colorScheme.surfaceContainerHighest;
    return DemoScaffold(
      title: '颜色 / 阴影 / 形状',
      children: [
        DemoSection(
          title: 'UCS 颜色常量',
          description: 'UCS 提供常用中性色，避免在每个页面重复定义。',
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 16,
              children: [
                _ColorItem(label: 'black', color: UCS.black),
                _ColorItem(label: 'mainBlack', color: UCS.mainBlack),
                _ColorItem(label: 'background', color: UCS.background),
                _ColorItem(label: 'white', color: UCS.white, bordered: true),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'UStyle 阴影',
          description: 'UStyle.getBaseBoxShadow 返回统一的卡片阴影。',
          children: [
            Universal(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: UStyle.getBaseBoxShadow(),
              ),
              alignment: Alignment.center,
              child: const TextMedium('UStyle.getBaseBoxShadow'),
            ),
            const SizedBox(height: 16),
            Universal(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: UStyle.getBoxShadow(blurRadius: 12, spreadRadius: 2, offset: const Offset(0, 4)),
              ),
              alignment: Alignment.center,
              child: const TextMedium('UStyle.getBoxShadow(blurRadius: 12)'),
            ),
          ],
        ),
        DemoSection(
          title: 'BubbleShape 气泡尖角',
          description: 'BubbleShape 是顶部带尖角的 ShapeBorder，适合做气泡、Tooltip、PopupMenu 的容器形状。',
          children: [
            Universal(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(12)),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 32,
                runSpacing: 24,
                children: [
                  _BubbleDemo(
                    label: '主色 + 无描边',
                    color: context.theme.primaryColor,
                    textColor: Colors.white,
                    side: BorderSide.none,
                  ),
                  _BubbleDemo(
                    label: '表面色 + 描边',
                    color: context.theme.colorScheme.surface,
                    textColor: context.theme.colorScheme.onSurface,
                    side: BorderSide(color: context.theme.dividerColor, width: 2),
                  ),
                  _BubbleDemo(
                    label: '圆角 12',
                    color: context.theme.colorScheme.secondaryContainer,
                    textColor: context.theme.colorScheme.onSecondaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    side: BorderSide.none,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BubbleDemo extends StatelessWidget {
  const _BubbleDemo({
    required this.label,
    required this.color,
    required this.textColor,
    required this.side,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  final String label;
  final Color color;
  final Color textColor;
  final BorderSide side;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 180,
        height: 64,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: color,
          shape: BubbleShape(side: side, borderRadius: borderRadius),
        ),
        child: TextMedium(label, color: textColor),
      ),
      const SizedBox(height: 8),
      TextSmall('BubbleShape', color: context.theme.hintColor),
    ],
  );
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({required this.label, required this.color, this.bordered = false});

  final String label;
  final Color color;
  final bool bordered;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Universal(
        width: 56,
        height: 56,
        color: color,
        borderRadius: BorderRadius.circular(10),
        decoration: bordered
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.theme.dividerColor),
              )
            : null,
      ),
      const SizedBox(height: 8),
      TextSmall(label, color: context.theme.hintColor),
    ],
  );
}
