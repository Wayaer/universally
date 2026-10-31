import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '占位与加载',
      children: [
        DemoSection(
          title: 'BaseError',
          description: '错误占位，支持点击重试。',
          children: [SizedBox(height: 180, child: BaseError(onTap: () => showToast('重新加载')))],
        ),
        DemoSection(title: 'BasePlaceholder', description: '空数据占位。', children: [const BasePlaceholder()]),
        DemoSection(
          title: 'BaseLoading',
          description: '加载中指示器。',
          children: [
            TextSmall('加载中指示器', color: context.theme.hintColor),
            const SizedBox(height: 8),
            SizedBox(height: 120, child: const Center(child: BaseLoading())),
          ],
        ),
        DemoSection(
          title: 'BaseDivider',
          description: '分割线，支持 Divider 的全部参数：height、thickness、indent、endIndent、color、radius。',
          children: [
            const TextSmall('默认分割线'),
            const SizedBox(height: 8),
            const BaseDivider(),
            const SizedBox(height: 16),
            const TextSmall('自定义颜色、粗细与圆角'),
            const SizedBox(height: 8),
            BaseDivider(color: context.theme.primaryColor, height: 4, thickness: 3, radius: BorderRadius.circular(2)),
            const SizedBox(height: 16),
            const TextSmall('自定义缩进'),
            const SizedBox(height: 8),
            const BaseDivider(indent: 20, endIndent: 60),
            const SizedBox(height: 16),
            const TextSmall('BaseVerticalDivider 垂直分割线'),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const TextSmall('左'),
                  const BaseVerticalDivider(),
                  const SizedBox(width: 12),
                  const TextSmall('中'),
                  BaseVerticalDivider(color: context.theme.primaryColor, width: 4, thickness: 2),
                  const SizedBox(width: 12),
                  const TextSmall('右'),
                ],
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'SizedBox 间距',
          description: '横向与纵向间距占位，直接使用 SizedBox。',
          children: [
            Row(
              children: [
                const TextSmall('A'),
                const SizedBox(width: 24),
                const TextSmall('B'),
                const SizedBox(width: 24),
                const TextSmall('C'),
              ],
            ),
            const SizedBox(height: 20),
            const TextSmall('上方为 SizedBox(height: 20) 间距'),
          ],
        ),
      ],
    );
  }
}
