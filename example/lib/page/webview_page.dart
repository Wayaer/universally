import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class FlWebViewPage extends StatelessWidget {
  const FlWebViewPage({Key? key, this.isCalculateHeight = false})
      : super(key: key);
  final bool isCalculateHeight;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBarTitle: 'FlWebView',
        isScroll: isCalculateHeight,
        child: BaseWebView.url(
            'http://mp.weixin.qq.com/s?__biz=Mzk0ODEwNDgwNg==&mid=100042936&idx=3&sn=e6d461e1b0e6f1f1389ffc6d27d9eb9f&chksm=436e93b174191aa744aa9ba846ac9459e096fb309b4db2f141145d3a5599e14015ce4bdc24f4#rd',
            isCalculateHeight: isCalculateHeight));
  }
}
