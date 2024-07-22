import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              enableEye: true,
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              enableSearchIcon: true,
              onTap: () {
                showToast('请输入');
              },
              prefix: [
                const BText('prefix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              suffix: [
                const BText('suffix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              searchTextTap: (String value) {},
              sendVerificationCodeTap: (send) async {
                await 1.seconds.delayed();
                send(true);
              }),
          const SizedBox(height: 20),
          BaseTextField(
              hintText: '请输入',
              enableClearIcon: true,
              sendVerificationCodeTextBuilder: (SendState state, int i) {
                switch (state) {
                  case SendState.none:
                    return TextNormal('发送验证码',
                        color: context.theme.primaryColor);
                  case SendState.sending:
                    return TextNormal('发送中', color: context.theme.primaryColor);
                  case SendState.resend:
                    return TextNormal('重新发送',
                        color: context.theme.primaryColor);
                  case SendState.countDown:
                    return TextNormal('$i s',
                        color: context.theme.primaryColor);
                }
              },
              enableEye: true,
              prefix: [
                const BText('prefix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              suffix: [
                const BText('suffix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              sendVerificationCodePosition: DecoratedPendantPosition.inner,
              enableSearchIcon: true,
              searchTextTap: (String value) {},
              sendVerificationCodeTap: (send) async {
                await 1.seconds.delayed();
                send(true);
              }),
          const SizedBox(height: 20),
          BaseTextField(
              hintText: '请输入',
              enableClearIcon: true,
              sendVerificationCodeTextBuilder: (SendState state, int i) {
                switch (state) {
                  case SendState.none:
                    return TextNormal('发送验证码',
                        color: context.theme.primaryColor);
                  case SendState.sending:
                    return TextNormal('发送中', color: context.theme.primaryColor);
                  case SendState.resend:
                    return TextNormal('重新发送',
                        color: context.theme.primaryColor);
                  case SendState.countDown:
                    return TextNormal('$i s',
                        color: context.theme.primaryColor);
                }
              },
              enableEye: true,
              prefix: [
                const BText('prefix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              suffix: [
                const BText('suffix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              enableSearchIcon: true,
              searchTextPosition: DecoratedPendantPosition.inner,
              searchTextTap: (String value) {},
              sendVerificationCodePosition: DecoratedPendantPosition.inner,
              sendVerificationCodeTap: (send) async {
                await 1.seconds.delayed();
                send(true);
              }),
          const SizedBox(height: 20),
          BaseTextField(
              minLines: 3,
              maxLines: 6,
              useTextField: true,
              maxLengthUseInputFormatters: true,
              maxLength: 10,
              fillColor: Colors.grey.withOpacity(0.2),
              enableClearIcon: true,
              prefix: [
                const BText('prefix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              suffix: [
                const BText('suffix').toDecoratedPendant(
                    positioned: DecoratedPendantPosition.outer),
              ],
              hintText: '请输入内容   useTextField=true'),
          const SizedBox(height: 20),
          BaseTextField(
              minLines: 3,
              maxLines: 6,
              maxLength: 10,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              prefix: [
                const BText('inner').toDecoratedPendant(
                    mode: OverlayVisibilityMode.notEditing,
                    positioned: DecoratedPendantPosition.inner),
                const BText('prefix').toDecoratedPendant(
                    mode: OverlayVisibilityMode.editing,
                    maintainSize: true,
                    positioned: DecoratedPendantPosition.outer),
              ],
              suffix: [
                const BText('editing').toDecoratedPendant(
                    mode: OverlayVisibilityMode.editing,
                    positioned: DecoratedPendantPosition.inner),
                const BText('suffix').toDecoratedPendant(
                    mode: OverlayVisibilityMode.editing,
                    maintainSize: true,
                    positioned: DecoratedPendantPosition.outer),
              ],
              fillColor: Colors.grey.withOpacity(0.2),
              enableClearIcon: true,
              hintText: '请输入内容   useTextField=false'),
        ]);
  }
}
