import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ProgressIndicatorPage extends StatefulWidget {
  const ProgressIndicatorPage({super.key});

  @override
  State<ProgressIndicatorPage> createState() => _ProgressIndicatorPageState();
}

class _ProgressIndicatorPageState extends State<ProgressIndicatorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<Color?>? animationColor;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: 10.seconds);
    animationColor =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBarTitleText: 'BaseProgressIndicator',
        padding: const EdgeInsets.all(20),
        children: [
          const Partition('BaseProgressIndicator.linear', marginTop: 0),
          BaseProgressIndicator.linear(
              height: 10,
              borderRadius: BorderRadius.circular(10),
              listenable: controller,
              backgroundColor: Colors.amber),
          const Partition('BaseProgressIndicator.circular'),
          BaseProgressIndicator.circular(
              strokeWidth: 4,
              strokeCap: StrokeCap.round,
              listenable: controller,
              backgroundColor: Colors.amber),
          const Partition('BaseProgressIndicator.refresh'),
          BaseProgressIndicator.refresh(
              elevation: 0,
              indicatorMargin: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              listenable: controller,
              backgroundColor: Colors.amber),
        ]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
