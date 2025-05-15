import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class BaseListPage extends StatefulWidget {
  const BaseListPage({super.key});

  @override
  State<BaseListPage> createState() => _BaseListPageState();
}

class _BaseListPageState extends State<BaseListPage> {
  List<Color> list = [];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'BaseList',
      child: BaseList(
        itemCount: list.length,
        placeholder: const Center(child: Text('请先下拉刷新')),
        onRefresh: (_) async {
          pullDown = true;
          await 1.seconds.delayed();
          setRefreshStatus();
          list = Colors.accents;
          setState(() {});
        },
        onLoad: (_) async {
          pullUp = true;
          await 1.seconds.delayed();
          setRefreshStatus();
          list.addAll(Colors.accents);
          setState(() {});
        },
        itemBuilder:
            (_, int index) => Container(
              height: 30,
              width: double.infinity,
              color: list[index],
            ),
      ),
    );
  }

  void setRefreshStatus() {
    if (pullDown) {
      pullDown = false;
      FlEasyRefreshControllers().last?.call(FlEasyRefreshResult.refreshSuccess);
    }
    if (pullUp) {
      pullUp = false;
      FlEasyRefreshControllers().last?.call(FlEasyRefreshResult.loadingSuccess);
    }
  }
}
