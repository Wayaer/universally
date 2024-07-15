import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class OverlayPage extends StatelessWidget {
  const OverlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        isCloseOverlay: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'Overlay',
        children: [
          Button(onTap: showLoading, text: 'showLoading'),
          Button(
              onTap: () {
                showToast('showToast');
              },
              text: 'showToast'),
        ]);
  }
}
