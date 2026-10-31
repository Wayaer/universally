import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class AnimationCounterPage extends StatefulWidget {
  const AnimationCounterPage({super.key});

  @override
  State<AnimationCounterPage> createState() => _AnimationCounterPageState();
}

class _AnimationCounterPageState extends State<AnimationCounterPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlAnimationCounter 数字滚动',
      children: [
        DemoSection(
          title: '向上滚动',
          description: '数字变化时向上滚动切换。',
          children: [
            Center(
              child: FlAnimationCounter.up(value: '$counter', builder: (String value) => TextLarge(value)),
            ),
          ],
        ),
        DemoSection(
          title: '向下滚动 / 按位滚动',
          description: 'FlCounterStyle.all 会按位分别滚动每一位数字。',
          children: [
            Center(
              child: FlAnimationCounter.down(
                value: '$counter',
                style: FlCounterStyle.all,
                builder: (String value) => TextLarge(value),
              ),
            ),
            const SizedBox(height: 20),
            DemoButton(text: '数字 +1', icon: Icons.add, onTap: () => setState(() => counter++)),
          ],
        ),
      ],
    );
  }
}
