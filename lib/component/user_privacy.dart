import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

extension ExtensionAlertWithUserPrivacy on UserPrivacyAlert {
  Future<void> show() async {
    final result = BasePreferences().getBool(UConst.privacy);
    if (result ?? false) {
      onConsentTap?.call();
    } else {
      await popupDialog(
          options: const DialogOptions(fromStyle: PopupFromStyle.fromCenter));
    }
  }
}

class UserPrivacyAlert extends StatelessWidget {
  const UserPrivacyAlert(
      {super.key,
      required this.name,
      this.onUserAgreementTap,
      this.onPrivacyPolicyTap,
      required this.onConsentTap,
      this.options,
      this.agree = '同意',
      this.exit = '暂不使用',
      this.title = '个人隐私保护指引',
      this.content});

  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final GestureTapCallback? onConsentTap;
  final ModalWindowsOptions? options;

  final String name;
  final String agree;
  final String exit;
  final String title;
  final Widget? content;

  @override
  Widget build(BuildContext context) => DoubleChooseWindows(
      options: FlExtended()
          .modalWindowsOptions
          .copyWith(color: UCS.black50)
          .merge(options),
      decoration: BoxDecoration(
          color: UCS.white, borderRadius: BorderRadius.circular(8)),
      content: Universal(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          children: [
            TextLarge(title),
            10.heightBox,
            content ??
                RText(textAlign: TextAlign.start, texts: [
                  '欢迎您使用$name客户端!\n为了更好地为您提供相关服务，我们会根据您使用服务的具体功能需要，收集必要的用户信息。您可通过说读',
                  '《用户协议》',
                  '和',
                  '《隐私政策》',
                  '了解我们收集、使用、存储个人信息的情况，以及对您个人隐私的保护措施。$name客户端深知个人信息对您的重要性，我们将以最高标准遵守法律法规要求，尽全力保护您的个人信息安全。\n\n如您同意，请点击“同意”开始接受'
                ], styles: [
                  const TStyle(height: 1.4),
                  TStyle(height: 1.4, color: Universally().mainColor),
                  const TStyle(height: 1.4),
                  TStyle(height: 1.4, color: Universally().mainColor),
                  const TStyle(height: 1.4),
                ], recognizers: [
                  null,
                  TapGestureRecognizer()..onTap = onUserAgreementTap,
                  null,
                  TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
                  null,
                ]),
          ]),
      right: Universal(
          height: 40,
          margin: const EdgeInsets.only(left: 0.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Universally().mainColor,
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(8))),
          onTap: () {
            pop();
            BasePreferences().setBool(UConst.privacy, true);
            onConsentTap?.call();
          },
          child: TextNormal(agree, color: UCS.white)),
      left: Universal(
          height: 40,
          margin: const EdgeInsets.only(right: 0.5),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: UCS.background,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))),
          onTap: Curiosity.native.exitApp,
          child: TextNormal(exit, color: UCS.black70)));
}

class UserPrivacyCheckbox extends StatelessWidget {
  const UserPrivacyCheckbox(
      {super.key,
      required this.value,
      this.onChanged,
      this.onUserAgreementTap,
      this.onPrivacyPolicyTap,
      this.shape,
      this.color = UCS.mainBlack,
      this.fontSize = 12,
      this.texts = const ['我已阅读并同意', '《用户协议》', '和', '《隐私政策》'],
      this.mainColor})
      : assert(texts.length == 4);

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final OutlinedBorder? shape;

  /// 其他文字颜色
  final Color? color;

  /// 高亮显示的颜色
  final Color? mainColor;
  final double fontSize;

  /// 文字内容
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      BaseCheckbox(
          value: value,
          activeColor: mainColor ?? Universally().mainColor,
          shape: shape,
          onChanged: onChanged),
      RText(maxLines: 2, textAlign: TextAlign.start, texts: texts, styles: [
        TStyle(color: color, fontSize: fontSize),
        TStyle(color: mainColor ?? Universally().mainColor, fontSize: fontSize),
        TStyle(color: color, fontSize: fontSize),
        TStyle(color: mainColor ?? Universally().mainColor, fontSize: fontSize),
      ], recognizers: [
        null,
        TapGestureRecognizer()..onTap = onUserAgreementTap,
        null,
        TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
      ]).expanded
    ]);
  }
}
