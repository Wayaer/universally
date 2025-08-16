import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class OverlayPage extends StatelessWidget {
  const OverlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isScroll: true,
      padding: const EdgeInsets.all(12),
      appBarTitleText: 'Overlay',
      canPop: false,
      canHideOverlay: true,
      onPopInvokedWithResult: (bool didPop, dynamic result, bool didCloseOverlay) {
        log(
          'OverlayPage onPopInvokedWithResult didPop=$didPop result=$result didCloseOverlay=$didCloseOverlay',
        );
        if (didCloseOverlay || didPop) return;
        pop();
      },
      spacing: 12,
      children: [
        TextMedium('如果当前页面有 Overlay 组件，点击返回键时，会先关闭 Overlay 组件，然后再关闭当前页面'),
        const Button(onTap: showLoading, text: 'showLoading'),
        Button(
          onTap: () {
            showToast('showToast');
          },
          text: 'showToast',
        ),
      ],
    );
  }
}
