import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'TextField',
        isScroll: true,
        children: [
          const SizedBox(height: 20),
          BaseTextField(
              hintText: '请输入',
              enableClearIcon: true,
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withValues(alpha:0.2),
              enableSearchIcon: true,
              onTap: () {
                showToast('请输入');
              },
              prefixes: [
                const BText('prefix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              suffixes: [
                const BText('suffix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              searchTextTap: (String value) {},
              sendVerificationCodeTap: () async {
                await 1.seconds.delayed();
                return true;
              }),
          const SizedBox(height: 20),
          BaseTextField(
              hintText: '请输入',
              enableClearIcon: true,
              sendVerificationCodeTextBuilder: (SendState state, int i) {
                switch (state) {
                  case SendState.none:
                    return TextMedium('发送验证码',
                        color: context.theme.primaryColor);
                  case SendState.sending:
                    return TextMedium('发送中', color: context.theme.primaryColor);
                  case SendState.resend:
                    return TextMedium('重新发送',
                        color: context.theme.primaryColor);
                  case SendState.countDown:
                    return TextMedium('$i s',
                        color: context.theme.primaryColor);
                }
              },
              enableEye: true,
              prefixes: [
                const BText('prefix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              suffixes: [
                const BText('suffix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withValues(alpha:0.2),
              sendVerificationCodePosition: DecoratorPendantPosition.inner,
              enableSearchIcon: true,
              searchTextTap: (String value) {},
              sendVerificationCodeTap: () async {
                await 1.seconds.delayed();
                return true;
              }),
          const SizedBox(height: 20),
          BaseTextField(
              hintText: '请输入',
              enableClearIcon: true,
              sendVerificationCodeTextBuilder: (SendState state, int i) {
                switch (state) {
                  case SendState.none:
                    return TextMedium('发送验证码',
                        color: context.theme.primaryColor);
                  case SendState.sending:
                    return TextMedium('发送中', color: context.theme.primaryColor);
                  case SendState.resend:
                    return TextMedium('重新发送',
                        color: context.theme.primaryColor);
                  case SendState.countDown:
                    return TextMedium('$i s',
                        color: context.theme.primaryColor);
                }
              },
              prefixes: [
                const BText('prefix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              suffixes: [
                const BText('suffix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withValues(alpha:0.2),
              enableSearchIcon: true,
              searchTextPosition: DecoratorPendantPosition.inner,
              searchTextTap: (String value) {},
              sendVerificationCodePosition: DecoratorPendantPosition.inner,
              sendVerificationCodeTap: () async {
                await 1.seconds.delayed();
                return true;
              }),
          const SizedBox(height: 20),
          BaseTextField(
              minLines: 3,
              maxLines: 6,
              maxLength: 10,
              fillColor: Colors.grey.withValues(alpha:0.2),
              enableClearIcon: true,
              prefixes: [
                const BText('prefix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              suffixes: [
                const BText('suffix').toDecoratorPendant(
                    positioned: DecoratorPendantPosition.outer),
              ],
              hintText: '请输入内容   useTextField=true'),
          const SizedBox(height: 20),
          BaseTextField(
              minLines: 3,
              maxLines: 6,
              maxLength: 10,
              prefixes: [
                const BText('inner').toDecoratorPendant(
                    mode: DecoratorPendantVisibilityMode.unfocused,
                    positioned: DecoratorPendantPosition.inner),
                const BText('prefix').toDecoratorPendant(
                    mode: DecoratorPendantVisibilityMode.focused,
                    maintainSize: true,
                    positioned: DecoratorPendantPosition.outer),
              ],
              suffixes: [
                const BText('editing').toDecoratorPendant(
                    mode: DecoratorPendantVisibilityMode.focused,
                    positioned: DecoratorPendantPosition.inner),
                const BText('suffix').toDecoratorPendant(
                    mode: DecoratorPendantVisibilityMode.focused,
                    maintainSize: true,
                    positioned: DecoratorPendantPosition.outer),
              ],
              fillColor: Colors.grey.withValues(alpha:0.2),
              enableClearIcon: true,
              hintText: '请输入内容   useTextField=false'),
          const SizedBox(height: 20),
          BaseTextField(
              hasFocusedChangeBorder: false,
              enableSearchIcon: true,
              enableSuggestions: true,
              headers: const [
                DecoratorPendant(
                    widget: Row(children: [
                      BText('header'),
                    ]),
                    maintainSize: true,
                    positioned: DecoratorPendantPosition.outer),
              ],
              searchTextPosition: DecoratorPendantPosition.inner,
              searchTextTap: (String value) {},
              hintText: '请输入内容'),
        ]);
  }
}
