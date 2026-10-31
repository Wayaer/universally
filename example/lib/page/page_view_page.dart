import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({super.key});

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  final FlPageViewController controller = FlPageViewController();
  int pageIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'BasePageView 轮播',
      children: [
        DemoSection(
          title: '自动轮播 + 指示器',
          description: 'FlPageView 支持自动轮播、无限循环、手势暂停与多种指示器样式。',
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  BasePageView(
                    controller: controller,
                    disposeController: false,
                    itemCount: 4,
                    autoPlay: true,
                    onPageChanged: (int index) => setState(() => pageIndex = index),
                    itemBuilder: (BuildContext context, int index) => Universal(
                      color: Colors.primaries[index % Colors.primaries.length].withValues(alpha: 0.5),
                      alignment: Alignment.center,
                      child: TextLarge('第 $index 页'),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Center(
                      child: BaseIndicator(
                        count: 4,
                        index: pageIndex,
                        position: pageIndex.toDouble(),
                        activeColor: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        DemoSection(
          title: '手动切换',
          description: '通过 GlobalKey 或 controller 切换到指定页。',
          children: [
            TextSmall('当前页：$pageIndex'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DemoButton(
                    text: '上一页',
                    onTap: () {
                      final int index = (pageIndex - 1 + 4) % 4;
                      controller.jump(index);
                      setState(() => pageIndex = index);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DemoButton(
                    text: '下一页',
                    onTap: () {
                      final int index = (pageIndex + 1) % 4;
                      controller.jump(index);
                      setState(() => pageIndex = index);
                    },
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
