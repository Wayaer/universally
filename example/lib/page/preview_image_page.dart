import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PreviewImagePage extends StatelessWidget {
  const PreviewImagePage({super.key});

  void openPreview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          backgroundColor: Colors.black,
          body: PreviewImage(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) => Center(
              child: BaseImage(
                const AssetImage('assets/0.webp'),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'PreviewImage 图片预览',
      children: [
        DemoSection(
          title: '全屏预览',
          description: 'PreviewImage 是全屏预览组件，需要作为独立页面打开；点击图片进入预览后可左右切换与手势缩放。',
          children: [
            Universal(
              onTap: () => openPreview(context),
              width: double.infinity,
              height: 160,
              borderRadius: BorderRadius.circular(10),
              child: BaseImage(const AssetImage('assets/0.webp'), fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            DemoButton(text: '打开全屏预览', icon: Icons.fullscreen, onTap: () => openPreview(context)),
          ],
        ),
      ],
    );
  }
}
