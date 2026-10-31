import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TabPagePage extends StatefulWidget {
  const TabPagePage({super.key});

  @override
  State<TabPagePage> createState() => _TabPagePageState();
}

class _TabPagePageState extends State<TabPagePage> {
  final TabPageController tabPageController = TabPageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'TabBar 与 TabPage',
      children: [
        DemoSection(
          title: 'BaseTabBar',
          description: 'BaseTabBar 封装 TabBar，快速创建等分 Tab。',
          children: [
            SizedBox(
              height: 260,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    BaseTabBar.fill(list: const ['Tab 1', 'Tab 2', 'Tab 3']),
                    const SizedBox(
                      height: 200,
                      child: TabBarView(
                        children: [
                          Center(child: TextMedium('TabBarView 1')),
                          Center(child: TextMedium('TabBarView 2')),
                          Center(child: TextMedium('TabBarView 3')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'TabPage',
          description: 'TabPageBar 与 TabPage 提供自定义 Tab 与页面切换，可通过 controller 控制。',
          children: [
            SizedBox(
              height: 300,
              child: Column(
                children: [
                  TabPageBar(
                    controller: tabPageController,
                    onChanged: (int index) => setState(() => pageIndex = index),
                    itemBuilder: (BuildContext context) => List.generate(
                      3,
                      (int index) => Center(
                        child: TextMedium(
                          '页面 $index',
                          color: pageIndex == index ? context.theme.primaryColor : context.theme.hintColor,
                        ),
                      ),
                    ),
                  ),
                  TabPage.builder(
                    controller: tabPageController,
                    onPageChanged: (int index) => setState(() => pageIndex = index),
                    children: const [
                      Center(child: TextLarge('TabPage 1')),
                      Center(child: TextLarge('TabPage 2')),
                      Center(child: TextLarge('TabPage 3')),
                    ],
                  ).expanded,
                ],
              ),
            ),
            const SizedBox(height: 16),
            DemoButton(
              text: 'animateToPageIndex(2)',
              icon: Icons.switch_left,
              onTap: () => tabPageController.animateToPageIndex(2),
            ),
          ],
        ),
        DemoSection(
          title: 'CustomTabBar',
          description: 'CustomTabBar 允许完全自定义 Tab 与布局。',
          children: [
            SizedBox(
              height: 220,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Builder(
                      builder: (BuildContext context) => CustomTabBar(
                        controller: DefaultTabController.of(context),
                        itemBuilder: (int selected, int index) => Center(
                          child: TextMedium(
                            '自定义 $index',
                            color: selected == index ? context.theme.primaryColor : context.theme.hintColor,
                          ),
                        ),
                        builder: (List<Widget> children) => Row(children: children),
                      ),
                    ),
                    const SizedBox(
                      height: 160,
                      child: TabBarView(
                        children: [
                          Center(child: TextMedium('CustomTabBar 1')),
                          Center(child: TextMedium('CustomTabBar 2')),
                          Center(child: TextMedium('CustomTabBar 3')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
