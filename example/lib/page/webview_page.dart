import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class FlWebViewPage extends StatelessWidget {
  const FlWebViewPage({Key? key, this.isCalculateHeight = false})
      : super(key: key);
  final bool isCalculateHeight;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(appBarTitle: 'FlWebView', isScroll: isCalculateHeight);
  }
}
