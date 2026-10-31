import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ToggleRotatePage extends StatefulWidget {
  const ToggleRotatePage({super.key});

  @override
  State<ToggleRotatePage> createState() => _ToggleRotatePageState();
}

class _ToggleRotatePageState extends State<ToggleRotatePage> {
  bool rotate = false;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlToggleRotate 旋转图标',
      children: [
        DemoSection(
          title: '点击旋转',
          description: 'isRotate 变化时执行旋转动画，turns 控制圈数。',
          children: [
            Center(
              child: GestureDetector(
                onTap: () => setState(() => rotate = !rotate),
                child: FlToggleRotate(
                  isRotate: rotate,
                  turns: 2,
                  icon: (bool value) => Icon(Icons.arrow_downward, color: context.theme.primaryColor, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextSmall('当前状态：$rotate', textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}
