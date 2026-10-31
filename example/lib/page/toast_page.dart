import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Toast 与 Loading',
      children: [
        DemoSection(
          title: 'Toast',
          description: 'showToast 支持图标、动画、时长、点击回调与全局 ToastOptions。',
          children: [
            DemoButton(text: '普通 Toast', onTap: () => showToast('普通 Toast')),
            DemoButton(
              text: '成功 Toast',
              onTap: () => showToast('操作成功', iconStyle: ToastIconStyle.success),
            ),
            DemoButton(
              text: '失败 Toast',
              onTap: () => showToast('操作失败', iconStyle: ToastIconStyle.fail),
            ),
            DemoButton(
              text: '警示 Toast',
              onTap: () => showToast('请注意', iconStyle: ToastIconStyle.warning),
            ),
            DemoButton(
              text: '自定义 ToastOptions',
              onTap: () => showToast(
                '自定义样式',
                options: const ToastOptions(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.amber,
                  alignment: Alignment.topCenter,
                  duration: Duration(seconds: 2),
                ),
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'Loading',
          description: 'showLoading / hideLoading 打开与关闭全局 Loading 浮层。',
          children: [
            DemoButton(
              text: '显示 Loading 1.5 秒',
              onTap: () async {
                showLoading();
                await 1.5.seconds.delayed();
                hideLoading();
              },
            ),
          ],
        ),
      ],
    );
  }
}
