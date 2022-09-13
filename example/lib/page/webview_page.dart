import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class FlWebViewPage extends StatelessWidget {
  const FlWebViewPage({super.key, this.isCalculateHeight = false});

  final bool isCalculateHeight;

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(appBarTitle: 'FlWebView', isScroll: isCalculateHeight);
  }
}
