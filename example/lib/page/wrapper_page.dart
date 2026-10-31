import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlWrapper 尖角容器',
      children: [
        DemoSection(
          title: '左侧尖角',
          description: '默认从左侧伸出尖角，适合聊天气泡。',
          children: [
            FlWrapper(
              color: context.theme.primaryColor,
              child: const TextMedium('左侧尖角', color: Colors.white),
            ),
          ],
        ),
        DemoSection(
          title: '底部尖角',
          description: 'FlSpineStyle.bottom + formEnd 控制尖角位置。',
          children: [
            FlWrapper(
              color: Colors.deepOrange,
              style: FlSpineStyle.bottom,
              formEnd: true,
              child: const TextMedium('底部尖角', color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
