import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DottedLinePage extends StatelessWidget {
  const DottedLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlDottedLineBorder 虚线边框',
      children: [
        DemoSection(
          title: '虚线边框',
          description: 'FlDottedLineBorder 可作为 BoxDecoration 的 border 使用。',
          children: [
            Universal(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: FlDottedLineBorder.fromBorderSide(BorderSide(color: context.theme.primaryColor, width: 2)),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const TextMedium('虚线边框内容'),
            ),
          ],
        ),
        DemoSection(
          title: '虚线分割',
          description: '也可直接作为分隔区域的装饰。',
          children: [
            Universal(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                border: FlDottedLineBorder.fromBorderSide(BorderSide(color: context.theme.dividerColor, width: 1)),
              ),
              alignment: Alignment.center,
              child: const TextSmall('虚线装饰区域'),
            ),
          ],
        ),
      ],
    );
  }
}
