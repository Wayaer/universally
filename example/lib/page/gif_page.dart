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
    assetController = AnimationController(vsync: this);
    networkController = AnimationController(vsync: this);
    addPostFrameCallback((_) {
      assetController.repeat(
          min: 0, max: 1, period: const Duration(seconds: 1));
      networkController.repeat(period: const Duration(milliseconds: 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'GIF Image',
        children: [
          if (!isWeb) ...[
            TextLarge('NetworkImage'),
            Gif(
                autostart: Autostart.loop,
                controller: networkController,
                useCache: false,
                image: const NetworkImage(
                    'http://qiniu.sczhongda88.com/kger/xdgif.gif')),
          ],
          TextLarge('AssetImage'),
          Gif(
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
