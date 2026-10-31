import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SvgPage extends StatelessWidget {
  const SvgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'SVG 图标',
      children: [
        DemoSection(
          title: 'SVGAsset',
          description: '加载本地 SVG，可通过 color 替换整体颜色。',
          children: [
            Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                _SvgItem(label: '原始颜色', child: SVGAsset('assets/universally.svg', size: 64)),
                _SvgItem(
                  label: '主色替换',
                  child: SVGAsset('assets/universally.svg', size: 64, color: context.theme.primaryColor),
                ),
                _SvgItem(label: '指定尺寸', child: SVGAsset('assets/universally.svg', width: 96, height: 40)),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'SVGNetwork',
          description: '加载网络 SVG，可传入 placeholderBuilder 显示加载占位。',
          children: [
            Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                _SvgItem(
                  label: '网络 SVG',
                  child: SVGNetwork(
                    'https://cdn.jsdelivr.net/npm/simple-icons@13/icons/flutter.svg',
                    size: 64,
                    placeholderBuilder: (BuildContext context) => const ImageLoading(size: 20),
                  ),
                ),
                _SvgItem(
                  label: '网络 SVG + 主色',
                  child: SVGNetwork(
                    'https://cdn.jsdelivr.net/npm/simple-icons@13/icons/flutter.svg',
                    size: 64,
                    color: context.theme.primaryColor,
                    placeholderBuilder: (BuildContext context) => const ImageLoading(size: 20),
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

class _SvgItem extends StatelessWidget {
  const _SvgItem({required this.label, required this.child});

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
