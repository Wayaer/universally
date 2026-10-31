import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final TextEditingController controller = TextEditingController(text: '初始内容');
  final TextEditingController clearController = TextEditingController(text: '可清除内容');
  final TextEditingController passwordController = TextEditingController(text: '123456');
  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchTextController = TextEditingController();
  final TextEditingController smsController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String log = '';

  @override
  void dispose() {
    controller.dispose();
    clearController.dispose();
    passwordController.dispose();
    searchController.dispose();
    searchTextController.dispose();
    smsController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'TextField 输入框',
      children: [
        DemoSection(
          title: '基础用法',
          description: 'BaseTextField 完整封装 TextField，默认宽度 100%、内容内边距 6、圆角 4。',
          children: [
            BaseTextField(
              hintText: '请输入内容',
              controller: controller,
              onChanged: (String value) => setState(() => log = 'onChanged: $value'),
              onSubmitted: (String value) => setState(() => log = 'onSubmitted: $value'),
            ),
            const SizedBox(height: 6),
            TextSmall(log),
          ],
        ),
        DemoSection(
          title: '附加能力',
          description: '清除按钮、密码可见性、搜索按钮、搜索文字与发送验证码。',
          children: [
            BaseTextField(
              hintText: '带清除按钮',
              enableClearIcon: true,
              controller: clearController,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: '密码输入',
              obscureText: true,
              controller: passwordController,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: '搜索图标',
              enableSearchIcon: true,
              controller: searchController,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: '搜索文字',
              searchText: TextMedium('搜索', color: context.theme.primaryColor),
              searchTextTap: (String value) => showToast('搜索：$value'),
              controller: searchTextController,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: '验证码',
              controller: smsController,
              sendVerificationCodeTap: () async => true,
              sendVerificationCodeDuration: const Duration(seconds: 30),
              sendVerificationCodeTextBuilder: (FlSendState state, int i) => TextSmall(switch (state) {
                FlSendState.none => '发送验证码',
                FlSendState.sending => '发送中',
                FlSendState.resend => '重新发送',
                FlSendState.countDown => '$i s',
              }, color: context.theme.primaryColor),
            ),
          ],
        ),
        DemoSection(
          title: '前后缀与头尾',
          description: 'TextFieldPendant 可限制显示位置，并按焦点、编辑状态或值决定是否显示。',
          children: [
            BaseTextField(
              hintText: '前缀 + 后缀',
              prefixes: [const Icon(Icons.person).toTextFieldPendant(positioned: FlDecoratorPendantPosition.inner)],
              suffixes: [
                const TextMedium('元').toTextFieldPendant(needEditing: true),
                IconButton(
                  onPressed: () => showToast('后缀按钮'),
                  icon: const Icon(Icons.info_outline),
                ).toTextFieldPendant(),
              ],
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: 'header / footer',
              headers: [const TextSmall('header').toTextFieldPendant()],
              footers: [const TextSmall('footer').toTextFieldPendant()],
            ),
          ],
        ),
        DemoSection(
          title: '边框与样式',
          description: 'FlBorderType.outline / underline / none，支持圆角、边框颜色与聚焦边框颜色。',
          children: [
            BaseTextField(
              hintText: 'outline',
              borderType: FlBorderType.outline,
              borderRadius: BorderRadius.circular(20),
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: 'underline',
              borderType: FlBorderType.underline,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: 'none',
              borderType: FlBorderType.none,
              fillColor: context.theme.colorScheme.surfaceContainerHighest,
              focusedBorderSide: BorderSide(color: context.theme.primaryColor),
              margin: const EdgeInsets.only(bottom: 10),
            ),
            const BaseTextField(hintText: '禁用状态', enabled: false),
          ],
        ),
        DemoSection(
          title: '输入限制',
          description: 'FlTextInputLimitFormatter 内置常用正则与键盘类型，也可传入自定义 inputFormatters。',
          children: [
            BaseTextField(
              hintText: '仅数字',
              inputLimitFormatter: FlTextInputLimitFormatter.number,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: '小数',
              inputLimitFormatter: FlTextInputLimitFormatter.decimal,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: '邮箱',
              inputLimitFormatter: FlTextInputLimitFormatter.email,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            BaseTextField(
              hintText: '最多 6 位',
              maxLength: 6,
              maxLengthUseInputFormatters: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
        DemoSection(
          title: '多行与事件',
          description: 'maxLines / minLines / expands、onTapWith / onSubmittedWith / onEditingCompleteWith。',
          children: [
            BaseTextField(
              hintText: '多行输入',
              maxLines: 3,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              margin: const EdgeInsets.only(bottom: 10),
              onSubmittedWith: (TextEditingController controller, FocusNode focusNode) {
                showToast('onSubmittedWith: ${controller.text}');
              },
            ),
            BaseTextField(
              hintText: '点击与编辑完成回调',
              onTapWith: (TextEditingController controller, FocusNode focusNode) => setLog('onTapWith'),
              onEditingCompleteWith: (TextEditingController controller, FocusNode focusNode) =>
                  setLog('onEditingCompleteWith'),
              onSubmittedWith: (TextEditingController controller, FocusNode focusNode) => setLog('onSubmittedWith'),
            ),
          ],
        ),
        DemoSection(
          title: '自定义 decoration',
          description: '通过 decoration 覆盖 InputDecoration，BaseTextField 会自动补齐 noneBorder。',
          children: [
            BaseTextField(
              hintText: '自定义 label 与 helper',
              decoration: const InputDecoration(labelText: 'label', helperText: 'helper', prefixText: '￥ '),
              focusNode: focusNode,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }

  void setLog(String value) => setState(() => log = value);
}
