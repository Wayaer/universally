import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SpinKitPage extends StatelessWidget {
  const SpinKitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SpinKitStyle> styles = SpinKitStyle.values;
    return DemoScaffold(
      title: 'SpinKit 加载动画',
      children: [
        DemoSection(
          title: '全部样式',
          description: '共 ${styles.length} 种加载动画，整页一起滚动查看。',
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 18,
              children: [
                for (final SpinKitStyle style in styles)
                  SizedBox(
                    width: 84,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SpinKit(style, size: 28, color: context.theme.primaryColor),
                        const SizedBox(height: 8),
                        TextSmall(style.name, textAlign: TextAlign.center, maxLines: 2),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
