import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class OverlayPage extends StatefulWidget {
  const OverlayPage({super.key});

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  FlOverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '底部弹层与 Overlay',
      children: [
        DemoSection(
          title: 'ModalBottomSheet',
          description: '通过 popupModalBottomSheet 打开任意 Widget，背景与文字颜色取自当前主题，保证可读性。',
          children: [
            DemoButton(
              text: '自定义 ModalBottomSheet',
              onTap: () =>
                  Universal(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextLarge('ModalBottomSheet', color: context.theme.colorScheme.onSurface),
                        const SizedBox(height: 12),
                        TextMedium('通过 popupModalBottomSheet 打开', color: context.theme.colorScheme.onSurface),
                        const SizedBox(height: 20),
                        UButton(text: '关闭', onTap: () => Navigator.of(context).pop()),
                      ],
                    ),
                  ).popupModalBottomSheet(
                    options: ModalBottomSheetOptions(
                      backgroundColor: context.theme.colorScheme.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                    ),
                  ),
            ),
          ],
        ),
        DemoSection(
          title: 'Overlay',
          description: 'Widget.showOverlay 可将任意组件插入 Overlay，并返回 FlOverlayEntry。',
          children: [
            DemoButton(
              text: '显示 Overlay',
              onTap: () {
                overlayEntry?.remove();
                overlayEntry = Universal(
                  alignment: Alignment.center,
                  color: Colors.black54,
                  child: Universal(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextMedium('Overlay 内容，点击关闭', color: context.theme.colorScheme.onSurface),
                  ),
                  onTap: () {
                    overlayEntry?.remove();
                    overlayEntry = null;
                  },
                ).showOverlay(isCached: false);
              },
            ),
            DemoButton(
              text: '移除 Overlay',
              onTap: () {
                overlayEntry?.remove();
                overlayEntry = null;
              },
            ),
          ],
        ),
      ],
    );
  }
}
