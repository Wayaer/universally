import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '隐私协议',
      children: [
        DemoSection(
          title: 'UserPrivacyCheckbox',
          description: '登录页常用的隐私协议勾选框，协议文字可点击。',
          children: [
            UserPrivacyCheckbox(
              value: checked,
              onChanged: (bool? value) => setState(() => checked = value ?? false),
              onUserAgreementTap: () => showToast('打开用户协议'),
              onPrivacyPolicyTap: () => showToast('打开隐私政策'),
            ),
          ],
        ),
        DemoSection(
          title: 'UserPrivacyCheckDialog',
          description: '二次确认弹窗，取消放弃登录，确认同意协议。',
          children: [
            DemoButton(
              text: '显示隐私确认弹窗',
              onTap: () async {
                final result = await UserPrivacyCheckDialog(
                  confirmText: '同意',
                  onConsentTap: () => showToast('已同意'),
                  onUserAgreementTap: () => showToast('打开用户协议'),
                  onPrivacyPolicyTap: () => showToast('打开隐私政策'),
                ).show(false);
                showToast('返回：$result');
              },
            ),
          ],
        ),
        DemoSection(
          title: 'UserPrivacyDialog',
          description: '首次启动隐私政策弹窗，可通过 onConsentTap / onUserAgreementTap / onPrivacyPolicyTap 自定义行为。',
          children: [const DemoResult(text: 'UserPrivacyDialog 的取消按钮默认退出应用，示例中不直接展示，可在接入项目时按需调用。')],
        ),
      ],
    );
  }
}
