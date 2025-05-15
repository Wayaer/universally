import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

abstract class _UserPrivacyStatelessWidget extends StatelessWidget {
  const _UserPrivacyStatelessWidget({
    super.key,
    this.onUserAgreementTap,
    this.onPrivacyPolicyTap,
    this.onConsentTap,
    this.options,
    this.textColor,
    this.highlightColor,
    this.confirmText = '同意并继续',
    required this.cancelText,
    required this.titleText,
  });

  final GestureTapCallback? onUserAgreementTap;
  final GestureTapCallback? onPrivacyPolicyTap;
  final GestureTapCallback? onConsentTap;
  final ModalBoxOptions? options;

  final Color? textColor;
  final Color? highlightColor;

  /// confirmText
  final String confirmText;

  /// cancelText
  final String cancelText;

  /// title
  final String titleText;
}

extension ExtensionUserPrivacyDialog on UserPrivacyDialog {
  Future<bool> show() async {
    final result = BasePreferences().getBool(UConst.isPrivacy);
    if (result == true) {
      onConsentTap?.call();
      return true;
    } else {
      final result = await popupDialog(
        options: const DialogOptions(
          fromStyle: PopupFromStyle.fromCenter,
          barrierDismissible: false,
        ),
      );
      return result == true;
    }
  }
}

class UserPrivacyDialog extends _UserPrivacyStatelessWidget {
  const UserPrivacyDialog({
    super.key,
    super.options,
    super.onConsentTap,
    super.onUserAgreementTap,
    super.onPrivacyPolicyTap,
    super.confirmText,
    super.cancelText = '暂不使用',
    super.titleText = '个人隐私保护指引',
    super.textColor,
    super.highlightColor,
    required this.name,
    this.content,
  });

  /// name
  final String name;

  /// content
  final Widget? content;

  @override
  Widget build(BuildContext context) => ConfirmCancelActionDialog(
    options: FlExtended().modalOptions.merge(options),
    dividerThickness: 0,
    titleText: titleText,
    content:
        (_) => Column(
          children: [
            content ??
                _RTextWithRecognizers(
                  textAlign: TextAlign.start,
                  texts: [
                    '欢迎您使用$name客户端!\n为了更好地为您提供相关服务，我们会根据您使用服务的具体功能需要，收集必要的用户信息。您可通过阅读',
                    '《用户协议》',
                    '和',
                    '《隐私政策》',
                    '了解我们收集、使用、存储个人信息的情况，以及对您个人隐私的保护措施。$name客户端深知个人信息对您的重要性，我们将以最高标准遵守法律法规要求，尽全力保护您的个人信息安全。\n\n如您同意，请点击“同意”开始接受',
                  ],
                  style: const TStyle(height: 1.4)
                      .merge(context.theme.textTheme.bodyMedium)
                      .copyWith(color: textColor),
                  styles: [
                    null,
                    TStyle(
                      height: 1.4,
                      color: context.theme.primaryColor,
                    ).copyWith(color: highlightColor),
                    null,
                    TStyle(
                      height: 1.4,
                      color: context.theme.primaryColor,
                    ).copyWith(color: highlightColor),
                    null,
                  ],
                  recognizers: [
                    null,
                    TapGestureRecognizer()..onTap = onUserAgreementTap,
                    null,
                    TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
                    null,
                  ],
                ),
          ],
        ),
    onCancelTap: Curiosity.native.exitApp,
    onConfirmTap: () {
      BasePreferences().setBool(UConst.isPrivacy, true);
      onConsentTap?.call();
      return true;
    },
    cancel:
        (_) => Universal(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.theme.textTheme.bodyMedium?.color?.withValues(
              alpha: 0.05,
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
          ),
          child: TextMedium(
            cancelText,
            style: context.theme.textTheme.bodyMedium,
          ),
        ),
    confirm:
        (_) => Universal(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(6),
            ),
          ),
          child: TextMedium(confirmText, color: UCS.white),
        ),
  );
}

extension ExtensionUserPrivacyCheckDialog on UserPrivacyCheckDialog {
  Future<bool> show(bool isCheck) async {
    if (isCheck) {
      return true;
    } else {
      final result = await popupDialog(
        options: const DialogOptions(
          fromStyle: PopupFromStyle.fromCenter,
          barrierDismissible: false,
        ),
      );
      if (result == true) return true;
    }
    return false;
  }
}

class UserPrivacyCheckDialog extends _UserPrivacyStatelessWidget {
  const UserPrivacyCheckDialog({
    super.key,
    super.options,
    super.onConsentTap,
    super.onUserAgreementTap,
    super.onPrivacyPolicyTap,
    super.confirmText,
    super.cancelText = '放弃登录',
    super.titleText = '温馨提示',
    super.textColor,
    super.highlightColor,
    this.contentTexts = const ['请阅读并同意\n', '《用户协议》', '和', '《隐私政策》'],
    this.dividerColor,
  });

  /// content text
  final List<String> contentTexts;

  /// divider color
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) => ConfirmCancelActionDialog(
    options: options,
    titleText: titleText,
    cancelText: cancelText,
    confirm:
        (_) => TextMedium(
          confirmText,
          color: highlightColor ?? context.theme.primaryColor,
        ),
    dividerColor: dividerColor,
    onConfirmTap: () {
      onConsentTap?.call();
      return true;
    },
    constraints: BoxConstraints(maxWidth: 280),
    content:
        (_) => _RTextWithRecognizers(
          texts: contentTexts,
          style: const TStyle(height: 1.4)
              .merge(context.theme.textTheme.bodyMedium)
              .copyWith(color: textColor),
          styles: [
            null,
            TStyle(
              height: 1.4,
              color: context.theme.primaryColor,
            ).copyWith(color: highlightColor),
            null,
            TStyle(
              height: 1.4,
              color: context.theme.primaryColor,
            ).copyWith(color: highlightColor),
          ],
          recognizers: [
            null,
            TapGestureRecognizer()..onTap = onUserAgreementTap,
            null,
            TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
          ],
        ),
  );
}

class UserPrivacyCheckbox extends StatelessWidget {
  const UserPrivacyCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.onUserAgreementTap,
    this.onPrivacyPolicyTap,
    this.shape,
    this.textColor,
    this.fontSize = 12,
    this.texts = const ['我已阅读并同意', '《用户协议》', '和', '《隐私政策》'],
    this.highlightColor,
  }) : assert(texts.length == 4);

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseCheckbox(
          value: value,
          activeColor: highlightColor ?? context.theme.primaryColor,
          shape: shape,
          onChanged: onChanged,
        ),
        _RTextWithRecognizers(
          maxLines: 2,
          textAlign: TextAlign.start,
          texts: texts,
          style: TStyle(height: 1.4, fontSize: fontSize)
              .merge(context.theme.textTheme.bodyMedium)
              .copyWith(color: textColor),
          styles: [
            null,
            TStyle(
              height: 1.4,
              color: context.theme.primaryColor,
            ).copyWith(color: highlightColor),
            null,
            TStyle(
              height: 1.4,
              color: context.theme.primaryColor,
            ).copyWith(color: highlightColor),
            null,
          ],
          recognizers: [
            null,
            TapGestureRecognizer()..onTap = onUserAgreementTap,
            null,
            TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
          ],
        ).expanded,
      ],
    );
  }
}

class _RTextWithRecognizers extends StatefulWidget {
  const _RTextWithRecognizers({
    this.maxLines,
    this.textAlign = TextAlign.center,
    required this.texts,
    this.style,
    this.styles = const [],
    this.recognizers = const [],
  });

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
    recognizers: widget.recognizers,
  );

  @override
  void dispose() {
    super.dispose();
    for (var e in widget.recognizers) {
      e?.dispose();
    }
  }
}
