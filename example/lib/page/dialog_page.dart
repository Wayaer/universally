import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  static bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'Dialog',
        children: [
          Button(
              onTap: () {
                const ConfirmCancelActionDialog(
                        titleText: 'Title',
                        contentText: 'Content',
                        cancelText: 'Cancel',
                        confirmText: 'Confirm',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'ConfirmCancelActionDialog'),
          Button(
              onTap: () {
                const ConfirmCancelActionDialog.cupertino(
                        titleText: 'Title',
                        contentText: 'Content',
                        cancelText: 'Cancel',
                        confirmText: 'Confirm',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'ConfirmCancelActionDialog.cupertino'),
          Button(
              onTap: () {
                const ConfirmActionDialog(
                        titleText: 'Title',
                        contentText: 'Content',
                        confirmText: 'Confirm',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'ConfirmActionDialog'),
          Button(
              onTap: () {
                const ConfirmActionDialog.cupertino(
                        titleText: 'Title',
                        contentText: 'Content',
                        confirmText: 'Confirm',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'ConfirmActionDialog.cupertino'),
          Button(
              onTap: () {
                TextFieldDialog(
                        titleText: 'Title',
                        hintText: 'HintText',
                        confirmText: 'Confirm',
                        cancelText: 'Cancel',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'TextFieldDialog'),
          Button(
              onTap: () {
                TextFieldDialog(
                        titleText: 'Title',
                        hintText: 'HintText',
                        confirmText: 'Confirm',
                        cancelText: 'Cancel',
                        resizeToAvoidBottomInset: false,
                        onConfirmTap: pop)
                    .show();
              },
              text: 'TextFieldDialog resizeToAvoidBottomInset(false)'),
          Button(
              onTap: () {
                TextFieldDialog.cupertino(
                        titleText: 'Title',
                        hintText: 'HintText',
                        confirmText: 'Confirm',
                        cancelText: 'Cancel',
                        onConfirmTap: pop)
                    .show();
              },
              text: 'TextFieldDialog.cupertino'),
          Button(
              text: 'showUserPrivacyDialog',
              onTap: () {
                BasePreferences().setBool(UConst.isPrivacy, false);
                UserPrivacyDialog(
                        name: 'Universally',
                        onUserAgreementTap: () {},
                        onPrivacyPolicyTap: () {},
                        onConsentTap: () {})
                    .show();
              }),
          Button(
              text: 'showUserPrivacyCheckDialog',
              onTap: () {
                DialogPage.isChecked = false;
                UserPrivacyCheckDialog(
                        onUserAgreementTap: () {},
                        onPrivacyPolicyTap: () {},
                        onConsentTap: () {})
                    .show(DialogPage.isChecked)
                    .then((value) {
                  DialogPage.isChecked = value;
                  showToast(value.toString());
                });
              }),
        ]);
  }
}
