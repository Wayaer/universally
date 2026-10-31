import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final ValueNotifier<double> progress = ValueNotifier<double>(0.3);

  @override
  void dispose() {
    progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '进度条',
      children: [
        DemoSection(
          title: 'BaseProgressIndicator.linear',
          description: '线性进度条，支持 value、height 与 borderRadius。',
          children: [
            const TextSmall('value: 0.4'),
            const SizedBox(height: 10),
            const BaseProgressIndicator.linear(value: 0.4),
            const SizedBox(height: 24),
            const TextSmall('value: 0.7 / height: 8 / 圆角'),
            const SizedBox(height: 10),
            const BaseProgressIndicator.linear(
              value: 0.7,
              height: 8,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ],
        ),
        DemoSection(
          title: 'BaseProgressIndicator.circular / refresh',
          description: '环形进度与下拉刷新样式。',
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                BaseProgressIndicator.circular(value: 0.4, width: 60, height: 60),
                BaseProgressIndicator.refresh(width: 60, height: 60),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'BaseProgressIndicatorListenable',
          description: '绑定 ValueListenable 自动刷新进度。',
          children: [
            BaseProgressIndicatorListenable.linear(listenable: progress, disposeNotifier: false),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => progress.value = (progress.value - 0.1).clamp(0, 1),
                  icon: const Icon(Icons.remove),
                ),
                TextMedium('${(progress.value * 100).round()}%'),
                IconButton(
                  onPressed: () => progress.value = (progress.value + 0.1).clamp(0, 1),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'FlLinearProgress',
          description: '支持动画、循环、渐变、描边端点与 onChanged 回调。',
          children: [
            const TextSmall('progressColor / percent: 0.6'),
            const SizedBox(height: 10),
            FlLinearProgress(progressColor: context.theme.primaryColor, percent: 0.6, height: 8),
            const SizedBox(height: 24),
            const TextSmall('gradient / strokeCap: round / animation'),
            const SizedBox(height: 10),
            FlLinearProgress.gradient(
              linearGradient: const LinearGradient(colors: [Colors.purple, Colors.cyan]),
              percent: 0.8,
              height: 8,
              strokeCap: StrokeCap.round,
              animation: true,
            ),
            const SizedBox(height: 24),
            const TextSmall('repeat: true'),
            const SizedBox(height: 10),
            const FlLinearProgress(progressColor: Colors.orange, percent: 0.5, repeat: true, height: 6),
          ],
        ),
      ],
    );
  }
}
