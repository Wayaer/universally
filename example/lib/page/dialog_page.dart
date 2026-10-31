import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '弹窗 Dialog',
      children: [
        DemoSection(
          title: 'ConfirmActionDialog',
          description: 'Material 与 Cupertino 两种风格的确认弹窗。',
          children: [
            DemoButton(
              text: '确认弹窗',
              onTap: () async {
                final dynamic result = await ConfirmActionDialog(
                  titleText: '提示',
                  contentText: '确定执行该操作吗？',
                  onConfirmTap: () => 'confirm',
                ).show();
                showToast('返回：$result');
              },
            ),
            DemoButton(
              text: '确认 / 取消弹窗',
              onTap: () async {
                final dynamic result = await ConfirmCancelActionDialog(
                  titleText: '提示',
                  contentText: '请选择操作',
                  onConfirmTap: () => 'confirm',
                  onCancelTap: () => 'cancel',
                ).show();
                showToast('返回：$result');
              },
            ),
            DemoButton(
              text: 'Cupertino 确认 / 取消弹窗',
              onTap: () async {
                final dynamic result = await ConfirmCancelActionDialog.cupertino(
                  titleText: 'Cupertino',
                  contentText: 'iOS 风格弹窗',
                  onConfirmTap: () => true,
                ).show();
                showToast('返回：$result');
              },
            ),
          ],
        ),
        DemoSection(
          title: 'TextFieldDialog',
          description: '带输入框的确认弹窗，支持普通与 Cupertino 风格。',
          children: [
            DemoButton(
              text: '输入框弹窗',
              onTap: () async {
                final dynamic result = await TextFieldDialog(
                  titleText: '请输入',
                  onConfirmTap: (String value) => value,
                ).show();
                showToast('输入内容：$result');
              },
            ),
            DemoButton(
              text: 'Cupertino 输入框弹窗',
              onTap: () async {
                final dynamic result = await TextFieldDialog.cupertino(
                  titleText: '请输入',
                  onConfirmTap: (String value) => value,
                ).show();
                showToast('输入内容：$result');
              },
            ),
          ],
        ),
        DemoSection(
          title: 'GeneralDialog',
          description: '任意 Widget 都可以通过 popupGeneralDialog 弹出；内容需自行限制尺寸并居中。',
          children: [
            DemoButton(
              text: '自定义 GeneralDialog',
              onTap: () => Center(
                child: Universal(
                  constraints: BoxConstraints(maxWidth: context.width - 60),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextLarge('自定义内容', color: context.theme.colorScheme.onSurface),
                      const SizedBox(height: 12),
                      TextMedium('这是任意 Widget 弹窗', color: context.theme.colorScheme.onSurface),
                      const SizedBox(height: 20),
                      Universal(
                        onTap: closePopup,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: TextMedium('关闭', color: context.theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ).popupGeneralDialog(options: const GeneralDialogOptions(barrierLabel: '', barrierDismissible: true)),
            ),
          ],
        ),
      ],
    );
  }
}
