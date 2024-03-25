import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'Alert',
        children: [
          Button(
              onTap: () {
                showDoubleChooseAlert(
                    title: 'title', left: 'left', right: 'right');
              },
              text: 'showDoubleChooseAlert'),
          Button(onTap: showLoading, text: 'showLoading'),
          Button(
              onTap: () {
                showToast('showToast');
              },
              text: 'showToast'),
        ]);
  }
}
