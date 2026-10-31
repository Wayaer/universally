import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class IconPage extends StatelessWidget {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlIcon 图标',
      children: [
        DemoSection(
          title: 'IconData / SVG / 图片',
          description: 'FlIcon 同时支持 IconData、SVG 路径与图片路径。',
          children: [
            Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                _IconItem(
                  label: 'IconData',
                  child: FlIcon(Icons.thumb_up, size: 36, color: context.theme.primaryColor),
                ),
                _IconItem(label: 'SVG', child: FlIcon('assets/universally.svg', size: 36)),
                _IconItem(label: '图片', child: FlIcon('assets/0.webp', size: 36)),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '尺寸与颜色',
          description: 'size 控制尺寸，color 会应用到 IconData 与 SVG。',
          children: [
            Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FlIcon(UIS.eyeOpen, size: 20),
                FlIcon(UIS.eyeOpen, size: 28, color: Colors.orange),
                FlIcon(UIS.eyeOpen, size: 36, color: Colors.blue),
                FlIcon(UIS.eyeOpen, size: 44, color: context.theme.primaryColor),
              ],
            ),
          ],
        ),
        DemoSection(
          title: 'UIS 内置图标',
          description: 'UIS 内置常用 IconData，可直接用于 Icon 或 FlIcon。',
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 16,
              children: [
                Icon(UIS.empty, size: 30),
                Icon(UIS.eyeOpen, size: 30),
                Icon(UIS.eyeClose, size: 30),
                Icon(UIS.settingApi, size: 30),
                Icon(UIS.back, size: 30),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _IconItem extends StatelessWidget {
  const _IconItem({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      child,
      const SizedBox(height: 8),
      TextSmall(label, color: context.theme.hintColor),
    ],
  );
}
