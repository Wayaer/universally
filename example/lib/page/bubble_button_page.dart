import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BubbleButtonPage extends StatefulWidget {
  const BubbleButtonPage({super.key});

  @override
  State<BubbleButtonPage> createState() => _BubbleButtonPageState();
}

class _BubbleButtonPageState extends State<BubbleButtonPage> {
  bool bubbled = false;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlBubbleButton 气泡按钮',
      children: [
        DemoSection(
          title: '点击切换',
          description: 'onTap 返回下一次是否展示气泡；builder 根据当前状态构建内容。',
          children: [
            Center(
              child: FlBubbleButton(
                size: 48,
                builder: (bool value) => Icon(value ? Icons.close : Icons.add, color: Colors.white),
                onTap: (bool value) async {
                  setState(() => bubbled = value);
                  return true;
                },
              ),
            ),
            const SizedBox(height: 20),
            TextSmall('当前状态：$bubbled', textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}
