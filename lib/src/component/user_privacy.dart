import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

extension ExtensionUserPrivacyDialog on UserPrivacyDialog {
  Future<bool> show() async {
    final result = BasePreferences().getBool(UConst.isPrivacy);
    if (result == true) {
      onConsentTap?.call();
      return true;
    } else {
      final result = await popupDialog(
          options: const DialogOptions(fromStyle: PopupFromStyle.fromCenter));
      return result == true;
    }
  }
}

class UserPrivacyDialog extends StatelessWidget {
  const UserPrivacyDialog(
      {super.key,
      required this.name,
      this.onConsentTap,
      this.onUserAgreementTap,
      this.onPrivacyPolicyTap,
      this.options,
      this.confirmText = '同意',
      this.cancelText = '暂不使用',
      this.titleText = '个人隐私保护指引',
      this.content,
      this.textColor,
      this.highlightColor});

  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final GestureTapCallback? onConsentTap;
  final ModalBoxOptions? options;

  final Color? textColor;
  final Color? highlightColor;

  /// name
  final String name;

  /// confirmText
  final String confirmText;

  /// cancelText
  final String cancelText;

  /// title
  final String titleText;

  /// content
  final Widget? content;

  @override
  Widget build(BuildContext context) => ConfirmCancelActionDialog(
          options: FlExtended().modalOptions.merge(options),
          dividerThickness: 0,
          titleText: titleText,
          content: Column(children: [
            content ??
                _RTextWithRecognizers(
                    textAlign: TextAlign.start,
                    texts: [
                      '欢迎您使用$name客户端!\n为了更好地为您提供相关服务，我们会根据您使用服务的具体功能需要，收集必要的用户信息。您可通过阅读',
                      '《用户协议》',
                      '和',
                      '《隐私政策》',
                      '了解我们收集、使用、存储个人信息的情况，以及对您个人隐私的保护措施。$name客户端深知个人信息对您的重要性，我们将以最高标准遵守法律法规要求，尽全力保护您的个人信息安全。\n\n如您同意，请点击“同意”开始接受'
                    ],
                    style: const TStyle(height: 1.4)
                        .merge(context.theme.textTheme.bodyMedium)
                        .copyWith(color: textColor),
                    styles: [
                      null,
                      TStyle(height: 1.4, color: context.theme.primaryColor)
                          .copyWith(color: highlightColor),
                      null,
                      TStyle(height: 1.4, color: context.theme.primaryColor)
                          .copyWith(color: highlightColor),
                      null,
                    ],
                    recognizers: [
                      null,
                      TapGestureRecognizer()..onTap = onUserAgreementTap,
                      null,
                      TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
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
                child: TextMedium(cancelText,
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
                  BasePreferences().setBool(UConst.isPrivacy, true);
                  onConsentTap?.call();
                  pop(true);
                },
                child: TextMedium(confirmText,
                    color: UCS.white,
                    style: context.theme.textTheme.titleSmall)),
          ]);
}

extension ExtensionUserPrivacyCheckDialog on UserPrivacyCheckDialog {
  Future<bool> show(bool isCheck) async {
    if (isCheck) {
      return true;
    } else {
      final result = await popupDialog(
          options: const DialogOptions(fromStyle: PopupFromStyle.fromCenter));
      if (result == true) return true;
    }
    return false;
  }
}

class UserPrivacyCheckDialog extends StatelessWidget {
  const UserPrivacyCheckDialog(
      {super.key,
      this.onConsentTap,
      this.onUserAgreementTap,
      this.onPrivacyPolicyTap,
      this.options,
      this.confirmText = '同意并继续',
      this.cancelText = '放弃登录',
      this.titleText = '温馨提示',
      this.contentTexts = const ['请阅读并同意\n', '《用户协议》', '和', '《隐私政策》'],
      this.textColor,
      this.highlightColor,
      this.dividerColor});

  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final GestureTapCallback? onConsentTap;
  final ModalBoxOptions? options;

  /// color
  final Color? textColor;
  final Color? highlightColor;

  /// confirmText
  final String confirmText;

  /// cancelText
  final String cancelText;

  /// title
  final String titleText;

  /// content text
  final List<String> contentTexts;

  /// divider color
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) => ConfirmCancelActionDialog(
      options: options,
      titleText: titleText,
      confirm: TextMedium(confirmText,
          color: highlightColor ?? context.theme.primaryColor),
      cancel: TextMedium(cancelText),
      autoClose: false,
      onCancelTap: pop,
      dividerColor: dividerColor,
      onConfirmTap: () {
        onConsentTap?.call();
        pop(true);
      },
      constraints: BoxConstraints(maxWidth: 280),
      content: _RTextWithRecognizers(
          texts: contentTexts,
          style: const TStyle(height: 1.4)
              .merge(context.theme.textTheme.bodyMedium)
              .copyWith(color: textColor),
          styles: [
            null,
            TStyle(height: 1.4, color: context.theme.primaryColor)
                .copyWith(color: highlightColor),
            null,
            TStyle(height: 1.4, color: context.theme.primaryColor)
                .copyWith(color: highlightColor),
          ],
          recognizers: [
            null,
            TapGestureRecognizer()..onTap = onUserAgreementTap,
            null,
            TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
          ]));
}

class UserPrivacyCheckbox extends StatelessWidget {
  const UserPrivacyCheckbox(
      {super.key,
      required this.value,
      this.onChanged,
      this.onUserAgreementTap,
      this.onPrivacyPolicyTap,
      this.shape,
      this.textColor,
      this.fontSize = 12,
      this.texts = const ['我已阅读并同意', '《用户协议》', '和', '《隐私政策》'],
      this.highlightColor})
      : assert(texts.length == 4);

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final OutlinedBorder? shape;

  /// 其他文字颜色
  final Color? textColor;

  /// 高亮显示的颜色
  final Color? highlightColor;
  final double fontSize;

  /// 文字内容
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      BaseCheckbox(
          value: value,
          activeColor: highlightColor ?? context.theme.primaryColor,
          shape: shape,
          onChanged: onChanged),
      _RTextWithRecognizers(
          maxLines: 2,
          textAlign: TextAlign.start,
          texts: texts,
          style: TStyle(height: 1.4, fontSize: fontSize)
              .merge(context.theme.textTheme.bodyMedium)
              .copyWith(color: textColor),
          styles: [
            null,
            TStyle(height: 1.4, color: context.theme.primaryColor)
                .copyWith(color: highlightColor),
            null,
            TStyle(height: 1.4, color: context.theme.primaryColor)
                .copyWith(color: highlightColor),
            null,
          ],
          recognizers: [
            null,
            TapGestureRecognizer()..onTap = onUserAgreementTap,
            null,
            TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
          ]).expanded
    ]);
  }
}

class _RTextWithRecognizers extends StatefulWidget {
  const _RTextWithRecognizers(
      {this.maxLines,
      this.textAlign = TextAlign.center,
      required this.texts,
      this.style,
      this.styles = const [],
      this.recognizers = const []});

  final int? maxLines;
  final TextAlign textAlign;
  final List<String> texts;
  final TextStyle? style;
  final List<TextStyle?> styles;
  final List<GestureRecognizer?> recognizers;

  @override
  State<_RTextWithRecognizers> createState() => _RTextWithRecognizersState();
}

class _RTextWithRecognizersState extends State<_RTextWithRecognizers> {
  @override
  Widget build(BuildContext context) => RText(
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      texts: widget.texts,
      style: widget.style,
      styles: widget.styles,
      recognizers: widget.recognizers);

  @override
  void dispose() {
    super.dispose();
    for (var e in widget.recognizers) {
      e?.dispose();
    }
  }
}
