import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'BaseImage 图片',
      children: [
        DemoSection(
          title: 'BaseImage',
          description: 'ExtendedImage 封装，支持圆角、边框、形状与手势预览。',
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ImageItem(label: '默认', child: BaseImage(const AssetImage('assets/0.webp'), width: 88, height: 88)),
                _ImageItem(
                  label: '圆角 + 边框',
                  child: BaseImage(
                    const AssetImage('assets/0.webp'),
                    width: 88,
                    height: 88,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.theme.primaryColor, width: 2),
                  ),
                ),
                _ImageItem(
                  label: '圆形',
                  child: BaseImage(const AssetImage('assets/0.webp'), width: 88, height: 88, shape: BoxShape.circle),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '填充模式',
          description: 'fit 控制图片在容器内的填充方式，contain 会完整显示图片。',
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ImageItem(
                  label: 'BoxFit.cover',
                  child: BaseImage(const AssetImage('assets/0.webp'), width: 120, height: 80, fit: BoxFit.cover),
                ),
                _ImageItem(
                  label: 'BoxFit.contain',
                  child: BaseImage(const AssetImage('assets/0.webp'), width: 120, height: 80, fit: BoxFit.contain),
                ),
                _ImageItem(
                  label: 'BoxFit.fill',
                  child: BaseImage(const AssetImage('assets/0.webp'), width: 120, height: 80, fit: BoxFit.fill),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '加载与失败占位',
          description: 'ImageLoading / ImageFailed 可作为 ExtendedImage 的加载与失败占位。',
          children: [
            Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _ImageItem(label: 'ImageLoading', child: const ImageLoading(size: 30)),
                _ImageItem(
                  label: 'ImageFailed',
                  child: ImageFailed(background: Colors.black12, failed: TextSmall('加载失败')),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ImageItem extends StatelessWidget {
  const _ImageItem({required this.label, required this.child});

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
