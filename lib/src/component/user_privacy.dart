import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

extension ExtensionAlertWithUserPrivacy on UserPrivacyDialog {
  Future<void> show() async {
    final result = BasePreferences().getBool(UConst.isPrivacy);
    if (result ?? false) {
      onConsentTap?.call();
    } else {
      await popupDialog(
          options: const DialogOptions(fromStyle: PopupFromStyle.fromCenter));
    }
  }
}

class UserPrivacyDialog extends StatefulWidget {
  const UserPrivacyDialog(
      {super.key,
      required this.name,
      this.onUserAgreementTap,
      this.onPrivacyPolicyTap,
      required this.onConsentTap,
      this.options,
      this.agree = '同意',
      this.exit = '暂不使用',
      this.title = '个人隐私保护指引',
      this.content,
      this.textColor,
      this.highlightColor});

  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final GestureTapCallback? onConsentTap;
  final ModalBoxOptions? options;

  final Color? textColor;
  final Color? highlightColor;
  final String name;
  final String agree;
  final String exit;
  final String title;
  final Widget? content;

  @override
  State<UserPrivacyDialog> createState() => _UserPrivacyDialogState();
}

class _UserPrivacyDialogState extends State<UserPrivacyDialog> {
  final userAgreementTap = TapGestureRecognizer();
  final privacyPolicyTap = TapGestureRecognizer();

  @override
  Widget build(BuildContext context) => ConfirmCancelActionDialog(
          options: FlExtended().modalOptions.merge(widget.options),
          hasDivider: false,
          titleText: widget.title,
          content: Column(children: [
            widget.content ??
                RText(textAlign: TextAlign.start, texts: [
                  '欢迎您使用${widget.name}客户端!\n为了更好地为您提供相关服务，我们会根据您使用服务的具体功能需要，收集必要的用户信息。您可通过阅读',
                  '《用户协议》',
                  '和',
                  '《隐私政策》',
                  '了解我们收集、使用、存储个人信息的情况，以及对您个人隐私的保护措施。${widget.name}客户端深知个人信息对您的重要性，我们将以最高标准遵守法律法规要求，尽全力保护您的个人信息安全。\n\n如您同意，请点击“同意”开始接受'
                ], styles: [
                  const TStyle(height: 1.4)
                      .merge(context.theme.textTheme.bodyMedium)
                      .copyWith(color: widget.textColor),
                  TStyle(height: 1.4, color: context.theme.primaryColor)
                      .copyWith(color: widget.highlightColor),
                  const TStyle(height: 1.4)
                      .merge(context.theme.textTheme.bodyMedium)
                      .copyWith(color: widget.textColor),
                  TStyle(height: 1.4, color: context.theme.primaryColor)
                      .copyWith(color: widget.highlightColor),
                  const TStyle(height: 1.4)
                      .merge(context.theme.textTheme.bodyMedium)
                      .copyWith(color: widget.textColor),
                ], recognizers: [
                  null,
                  userAgreementTap..onTap = widget.onUserAgreementTap,
                  null,
                  privacyPolicyTap..onTap = widget.onPrivacyPolicyTap,
                  null,
                ]),
          ]),
          autoClose: false,
          actions: [
            Universal(
                height: 40,
                margin: const EdgeInsets.only(right: 0.5),
                alignment: Alignment.center,
                expanded: true,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(8))),
                onTap: Curiosity.native.exitApp,
                child: TextMedium(widget.exit,
                    style: context.theme.textTheme.titleSmall)),
            Universal(
                height: 40,
                expanded: true,
                margin: const EdgeInsets.only(left: 0.5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(6))),
                onTap: () {
                  pop();
                  BasePreferences().setBool(UConst.isPrivacy, true);
                  widget.onConsentTap?.call();
                },
                child: TextMedium(widget.agree,
                    color: UCS.white,
                    style: context.theme.textTheme.titleSmall)),
          ]);

  @override
  void dispose() {
    super.dispose();
    userAgreementTap.dispose();
    privacyPolicyTap.dispose();
  }
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
          activeColor: mainColor ?? context.theme.primaryColor,
          shape: shape,
          onChanged: onChanged),
      RText(maxLines: 2, textAlign: TextAlign.start, texts: texts, styles: [
        TStyle(color: color, fontSize: fontSize),
        TStyle(
            color: mainColor ?? context.theme.primaryColor, fontSize: fontSize),
        TStyle(color: color, fontSize: fontSize),
        TStyle(
            color: mainColor ?? context.theme.primaryColor, fontSize: fontSize),
      ], recognizers: [
        null,
        TapGestureRecognizer()..onTap = onUserAgreementTap,
        null,
        TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
      ]).expanded
    ]);
  }
}
