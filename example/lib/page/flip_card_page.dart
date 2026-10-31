import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class FlipCardPage extends StatelessWidget {
  const FlipCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlFlipCard 翻转卡片',
      children: [
        DemoSection(
          title: '点击翻转',
          description: '支持正反面构建与翻转结束监听。',
          children: [
            SizedBox(
              height: 160,
              child: Center(
                child: FlFlipCardStateful(
                  front: (BuildContext context, FlFlipCardController controller) => Universal(
                    width: 220,
                    height: 120,
                    color: context.theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    alignment: Alignment.center,
                    child: const TextLarge('正面', color: Colors.white),
                  ),
                  back: (BuildContext context, FlFlipCardController controller) => Universal(
                    width: 220,
                    height: 120,
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10),
                    alignment: Alignment.center,
                    child: const TextLarge('反面', color: Colors.white),
                  ),
                  onFlipEnd: (FlFlipCardState state) => showToast('翻转结束：$state'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
