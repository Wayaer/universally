import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

void showUserPrivacyAlert({
  required String title,
  required GestureTapCallback onUserAgreementTap,
  required GestureTapCallback onPrivacyPolicyTap,
  required GestureTapCallback onConsentTap,
  ModalWindowsOptions? options,
}) {
  final result = BHP().getBool(UConstant.privacy);
  if (result ?? false) {
    onConsentTap.call();
  } else {
    DoubleChooseWindows(
            options: GlobalOptions()
                .modalWindowsOptions
                .copyWith(color: UCS.black50)
                .merge(options),
            decoration: BoxDecoration(
                color: UCS.white, borderRadius: BorderRadius.circular(4)),
            content: _UserPrivacyAlert(
                onUserAgreementTap: onUserAgreementTap,
                onPrivacyPolicyTap: onPrivacyPolicyTap,
                title: title),
            right: SimpleButton(
                height: 40,
                margin: const EdgeInsets.only(left: 0.5),
                alignment: Alignment.center,
                textStyle: const TStyle(color: UCS.white),
                text: '同意',
                color: GlobalConfig().currentColor,
                onTap: () {
                  pop();
                  BHP().setBool(UConstant.privacy, true);
                  onConsentTap.call();
                }),
            left: SimpleButton(
                text: '取消',
                height: 40,
                margin: const EdgeInsets.only(right: 0.5),
                alignment: Alignment.center,
                textStyle: const TStyle(color: UCS.black70),
                color: UCS.background,
                onTap: Curiosity().native.exitApp))
        .show();
  }
}

class _UserPrivacyAlert extends StatelessWidget {
  const _UserPrivacyAlert(
      {this.onUserAgreementTap, this.onPrivacyPolicyTap, required this.title});

  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Universal(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: '欢迎您使用$title软件及服务，您应当阅读并遵守',
                style: const TStyle(fontSize: 16, color: UCS.mainBlack)),
            TextSpan(
                text: '《用户协议》',
                style: TStyle(fontSize: 16, color: GlobalConfig().currentColor),
                recognizer: TapGestureRecognizer()..onTap = onUserAgreementTap),
            const TextSpan(
                text: '以及', style: TStyle(fontSize: 16, color: UCS.mainBlack)),
            TextSpan(
                text: '《隐私政策》',
                style: TStyle(fontSize: 16, color: GlobalConfig().currentColor),
                recognizer: TapGestureRecognizer()..onTap = onPrivacyPolicyTap),
            const TextSpan(
                text:
                    '。请您务必审慎阅读、充分理解各条款内容，除非您已充分阅读、完全理解并接受本协议所有条款，否则您无权下载、安装或使用本软件相关服务。',
                style: TStyle(fontSize: 16, color: UCS.mainBlack))
          ]))
        ]);
  }
}

class CheckboxWithUserPrivacy extends StatelessWidget {
  const CheckboxWithUserPrivacy(
      {Key? key,
      required this.value,
      this.onChanged,
      this.onUserAgreementTap,
      this.onPrivacyPolicyTap,
      this.shape})
      : super(key: key);
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CheckboxState(
          value: value,
          activeColor: GlobalConfig().currentColor,
          shape: shape,
          onChanged: onChanged),
      RText(maxLines: 2, textAlign: TextAlign.start, texts: const [
        '我已阅读并同意',
        '《用户协议》',
        '和',
        '《隐私政策》'
      ], styles: [
        const TStyle(),
        TStyle(color: GlobalConfig().currentColor),
        const TStyle(),
        TStyle(color: GlobalConfig().currentColor),
      ], recognizers: [
        null,
        TapGestureRecognizer()..onTap = onUserAgreementTap,
        null,
        TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
      ]).expandedNull
    ]);
  }
}