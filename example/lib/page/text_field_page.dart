import 'package:flutter/cupertino.dart';
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
              enableEye: true,
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              enableSearchIcon: true,
              onTap: () {
                showToast('请输入');
              },
              prefix: [
                const BText('prefix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              suffix: [
                const BText('suffix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
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
                const BText('prefix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              suffix: [
                const BText('suffix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              sendVerificationCodePositioned: DecoratorPositioned.inner,
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
                const BText('prefix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              suffix: [
                const BText('suffix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              borderType: BorderType.outline,
              borderRadius: BorderRadius.circular(4),
              fillColor: Colors.red.withOpacity(0.2),
              enableSearchIcon: true,
              searchTextPositioned: DecoratorPositioned.inner,
              searchTextTap: (String value) {},
              sendVerificationCodePositioned: DecoratorPositioned.inner,
              sendVerificationCodeTap: (send) async {
                await 1.seconds.delayed();
                send(true);
              }),
          const SizedBox(height: 20),
          BaseTextField(
              minLines: 3,
              maxLines: 6,
              useTextField: true,
              fillColor: Colors.grey.withOpacity(0.2),
              enableClearIcon: true,
              prefix: [
                const BText('prefix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              suffix: [
                const BText('suffix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              hintText: '请输入内容   useTextField=true'),
          const SizedBox(height: 20),
          BaseTextField(
              minLines: 3,
              maxLines: 6,
              prefix: [
                const BText('prefix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              suffix: [
                const BText('suffix')
                    .toDecoratorEntry(positioned: DecoratorPositioned.outer),
              ],
              fillColor: Colors.grey.withOpacity(0.2),
              enableClearIcon: true,
              hintText: '请输入内容   useTextField=false'),
        ]);
  }
}
