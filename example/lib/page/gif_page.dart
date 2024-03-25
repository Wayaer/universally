import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class GifPage extends StatefulWidget {
  const GifPage({super.key});

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> with TickerProviderStateMixin {
  late AnimationController assetController;
  late AnimationController networkController;

  @override
  void initState() {
    super.initState();
    assetController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    networkController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'GIF Image',
        children: [
          TextLarge('NetworkImage'),
          Gif(
              autostart: Autostart.loop,
              controller: networkController,
              useCache: false,
              image: const NetworkImage(
                  'http://qiniu.sczhongda88.com/kger/xdgif.gif')),
          TextLarge('AssetImage'),
          Gif(
              autostart: Autostart.loop,
              controller: assetController,
              image: const AssetImage('assets/gif.gif')),
          const SizedBox(height: 30),
        ]);
  }

  @override
  void dispose() {
    assetController.dispose();
    networkController.dispose();
    super.dispose();
  }
}
