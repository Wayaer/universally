import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<int> colors = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '列表',
      children: [
        DemoSection(
          title: 'BaseList',
          description:
              '基于 FlScrollListGrid，支持下拉刷新、上拉加载、分隔线、固定行高、网格与瀑布流。'
              '下方示例使用 shrinkWrap 平铺，跟随整页滚动；下拉刷新与上拉加载需在独立滚动视口中使用。',
          children: [
            BaseList(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: colors.length,
              layout: const ListGridLayout.grid(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (BuildContext context, int index) => Universal(
                color: Colors.primaries[index % Colors.primaries.length].withValues(alpha: 0.5),
                alignment: Alignment.center,
                child: TextMedium('$index'),
              ),
            ),
            const SizedBox(height: 6),
            BaseList.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                6,
                (index) => ListTile(
                  dense: true,
                  title: TextMedium('count 子项 $index'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
            const SizedBox(height: 6),
            BaseList.waterfall(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemBuilder: (BuildContext context, int index) => Universal(
                height: 60.0 + index % 3 * 30,
                color: Colors.primaries[index % Colors.primaries.length].withValues(alpha: 0.35),
                alignment: Alignment.center,
                child: TextMedium('瀑布 $index'),
              ),
            ),
            const SizedBox(height: 6),
            BaseList.custom(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              sliver: [
                SliverList.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) =>
                      ListTile(dense: true, title: TextMedium('custom sliver $index')),
                ),
              ],
            ),
          ],
        ),
        DemoSection(
          title: '滚动通知',
          description: 'interceptNotificationListener 扩展可拦截任意 Notification。',
          children: [
            SizedBox(
              height: 120,
              child:
                  BaseList.count(
                    children: List.generate(20, (index) => ListTile(dense: true, title: TextSmall('通知子项 $index'))),
                  ).interceptNotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      log('ScrollNotification: ${notification.metrics.pixels.toStringAsFixed(1)}');
                      return true;
                    },
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
