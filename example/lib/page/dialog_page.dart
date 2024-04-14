import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'Dialog',
        children: [
          Button(
              onTap: () {
                const ConfirmAndCancelActionDialog(
                        titleText: 'Title',
                        contentText: 'Content',
                        cancelText: 'Cancel',
                        confirmText: 'Confirm',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'ConfirmAndCancelActionDialog'),
          Button(
              onTap: () {
                const ConfirmAndCancelActionDialog.cupertino(
                        titleText: 'Title',
                        contentText: 'Content',
                        cancelText: 'Cancel',
                        confirmText: 'Confirm',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'ConfirmAndCancelActionDialog.cupertino'),
        ]);
  }
}
