import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class GifPage extends StatefulWidget {
  const GifPage({super.key});

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  bool loop = true;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Gif 动图',
      children: [
        DemoSection(
          title: '循环与单次播放',
          description: 'autostart 控制是否自动播放，once 只播放一次，loop 循环播放。',
          children: [
            Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                _GifItem(
                  label: 'Autostart.loop',
                  child: Gif(
                    image: const AssetImage('assets/gif.gif'),
                    width: 96,
                    height: 96,
                    autostart: Autostart.loop,
                  ),
                ),
                _GifItem(
                  label: 'Autostart.once / fps: 12',
                  child: Gif(
                    image: const AssetImage('assets/gif1.gif'),
                    width: 96,
                    height: 96,
                    autostart: Autostart.once,
                    fps: 12,
                  ),
                ),
                _GifItem(
                  label: 'Autostart.no',
                  child: Gif(image: const AssetImage('assets/gif.gif'), width: 96, height: 96, autostart: Autostart.no),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '动态切换 autostart',
          description: 'autostart 变化后组件会重新构建并应用新的播放策略。',
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextMedium('循环播放'),
                BaseFlSwitch(value: loop, onChanged: (bool value) => setState(() => loop = value)),
              ],
            ),
            const SizedBox(height: 6),
            Gif(
              image: const AssetImage('assets/gif.gif'),
              width: 96,
              height: 96,
              autostart: loop ? Autostart.loop : Autostart.once,
            ),
          ],
        ),
      ],
    );
  }
}

class _GifItem extends StatelessWidget {
  const _GifItem({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      child,
      const SizedBox(height: 6),
      TextSmall(label, color: context.theme.hintColor),
    ],
  );
}
