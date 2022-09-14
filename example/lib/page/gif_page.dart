import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

const _gifUrl =
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201311%2F24%2F20131124231711_T3VBh.thumb.400_0.gif&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1665717603&t=fe19d276ae3f6baf6605805670a45e3b';

class GifPage extends StatefulWidget {
  const GifPage({Key? key}) : super(key: key);

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> with TickerProviderStateMixin {
  late GifController assetController;
  late GifController networkController;

  @override
  void initState() {
    super.initState();
    assetController = GifController(vsync: this);
    networkController = GifController(vsync: this);
    addPostFrameCallback((_) {
      assetController.repeat(
          min: 0, max: 1, period: const Duration(milliseconds: 10));
      networkController.repeat(
          min: 0, max: 1, period: const Duration(milliseconds: 10));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitle: 'GIF Image',
        children: [
          TextLarge('AssetImage'),
          Gif(
              controller: assetController,
              image: const AssetImage('assets/gif.gif')),
          const SizedBox(height: 30),
          TextLarge('NetworkImage'),
          Gif(
              controller: networkController,
              image: const NetworkImage(_gifUrl)),
        ]);
  }
}
