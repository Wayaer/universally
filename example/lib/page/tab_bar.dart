import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseTabBarPage extends StatefulWidget {
  const BaseTabBarPage({super.key});

  @override
  State<BaseTabBarPage> createState() => _BaseTabBarPageState();
}

class _BaseTabBarPageState extends State<BaseTabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  List<int> tabs = 10.generate((index) => index);

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isScroll: true,
      padding: const EdgeInsets.all(12),
      appBarTitleText: 'BaseTabBar',
      children: [
        const Partition('BaseTabBar', marginTop: 0),
        BaseTabBar(
          controller: controller,
          isScrollable: true,
          tabs: tabs.builder((index) => Tab(text: '$index')),
        ),
        20.heightBox,
        const Partition('BaseTabBar.fill'),
        BaseTabBar.fill(
          isScrollable: true,
          controller: controller,
          list: tabs.builder((index) => '$index'),
        ),
        20.heightBox,
        const Partition('CustomTabBar TabBar'),
        CustomTabBar(
          itemBuilder: (int selected, int index) {
            return Universal(
              children: [
                Text('$index'),
                if (selected == index) const Icon(Icons.arrow_drop_down),
              ],
            );
          },
          builder: (List<Widget> tabs) => TabBar(
            tabAlignment: TabAlignment.start,
            indicator: const BoxDecoration(border: null),
            isScrollable: true,
            controller: controller,
            tabs: tabs,
          ),
          controller: controller,
        ),
        20.heightBox,
        const Partition('CustomTabBar BaseTabBar.fill'),
        CustomTabBar(
          itemBuilder: (int selected, int index) {
            return Universal(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                Text('$index'),
                if (selected == index) const Icon(Icons.arrow_drop_down),
              ],
            );
          },
          builder: (List<Widget> tabs) => BaseTabBar.fill(
            isScrollable: true,
            controller: controller,
            tabs: tabs,
          ),
          controller: controller,
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
