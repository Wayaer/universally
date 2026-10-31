import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ConnectivityPlusPage extends StatefulWidget {
  const ConnectivityPlusPage({super.key});

  @override
  State<ConnectivityPlusPage> createState() => _ConnectivityPlusPageState();
}

class _ConnectivityPlusPageState extends ExtendedState<ConnectivityPlusPage> {
  List<ConnectivityResult> result = [];

  @override
  void initState() {
    super.initState();
    addPostFrameCallback((_) {
      ConnectivityPlus.instance.checkConnectivity();
      ConnectivityPlus.instance.subscription();
      ConnectivityPlus.instance.addListener(listener);
    });
  }

  Future<bool> listener(bool status, List<ConnectivityResult> result) async {
    this.result = result;
    setState(() {});
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    ConnectivityPlus.instance.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'ConnectivityPlus',
      spacing: 20,
      padding: EdgeInsets.all(20),
      children: [TextLarge('当前网络状态:'), ...result.builder((e) => TextMedium('$e'))],
    );
  }
}
