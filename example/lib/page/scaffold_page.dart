import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'BaseScaffold',
      children: [
        DemoSection(
          title: 'BaseScaffold',
          description: '支持 AppBar、Drawer、EndDrawer、FAB、底部导航、persistentFooterButtons、SafeArea 与双击退出。',
          children: [
            DemoButton(text: '完整 Scaffold 示例', icon: Icons.dashboard, onTap: () => push(const _ScaffoldDemoPage())),
          ],
        ),
        DemoSection(
          title: '常用参数',
          description: 'DemoScaffold 本身也是 BaseScaffold 的轻量封装，所有示例页都基于它构建。',
          children: const [
            TextSmall('appBarTitleText：标题'),
            SizedBox(height: 8),
            TextSmall('isScroll：内容是否整页滚动'),
            SizedBox(height: 8),
            TextSmall('padding：内容内边距'),
            SizedBox(height: 8),
            TextSmall('appBarActions：右上角操作按钮'),
          ],
        ),
      ],
    );
  }
}

class _ScaffoldDemoPage extends StatefulWidget {
  const _ScaffoldDemoPage();

  @override
  State<_ScaffoldDemoPage> createState() => _ScaffoldDemoPageState();
}

class _ScaffoldDemoPageState extends State<_ScaffoldDemoPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'BaseScaffold',
      appBarLeading: IconButton(onPressed: maybePop, icon: const Icon(Icons.arrow_back)),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: TextLarge('Drawer')),
            ListTile(title: TextMedium('菜单一')),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: TextLarge('EndDrawer')),
            ListTile(title: TextMedium('菜单二')),
          ],
        ),
      ),
      appBarActions: [
        Builder(
          builder: (BuildContext context) =>
              IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu)),
        ),
        Builder(
          builder: (BuildContext context) =>
              IconButton(onPressed: () => Scaffold.of(context).openEndDrawer(), icon: const Icon(Icons.more_horiz)),
        ),
      ],
      appBarBottom: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Center(child: TextMedium('appBarBottom')),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => showToast('FAB'), child: const Icon(Icons.add)),
      persistentFooterButtons: [TextMedium('persistentFooterButtons')],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (int index) => setState(() => selected = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.settings), label: '设置'),
        ],
      ),
      safeTop: true,
      safeBottom: true,
      isScroll: true,
      padding: const EdgeInsets.all(12),
      children: [
        DemoSection(
          title: 'SafeArea + 滚动',
          children: [
            const TextMedium('safeTop / safeBottom / isScroll / padding'),
            const SizedBox(height: 6),
            TextSmall('Drawer、EndDrawer、FAB、底部导航与 persistentFooterButtons 均可直接配置。' * 3),
          ],
        ),
      ],
    );
  }
}
