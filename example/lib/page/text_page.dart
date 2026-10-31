import 'package:app/utils/demo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Text 文本',
      children: [
        DemoSection(
          title: 'BaseText / TextLarge / TextMedium / TextSmall',
          description: '统一文本组件，支持 TextFontSize、usePrimaryColor、TStyle 属性透传与富文本。',
          children: [
            TextLarge('TextLarge 默认字号'),
            const SizedBox(height: 6),
            TextMedium('TextMedium 默认字号'),
            const SizedBox(height: 6),
            TextSmall('TextSmall 默认字号'),
            const SizedBox(height: 6),
            TextLarge('使用主色', usePrimaryColor: true),
            const SizedBox(height: 6),
            TextMedium('指定颜色与字重', color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 20),
            const SizedBox(height: 6),
            TextMedium('删除线 + 下划线', decoration: TextDecoration.lineThrough, decorationColor: Colors.red),
            const SizedBox(height: 6),
            TextMedium('两行省略示例：${'Universally 组件库提供统一的文本样式与富文本能力。' * 3}', maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            TextMedium(
              '渐变文字',
              foreground: Paint()
                ..shader = const LinearGradient(colors: [Colors.purple, Colors.cyan])
                    .createShader(const Rect.fromLTWH(0, 0, 200, 40)),
            ),
          ],
        ),
        DemoSection(
          title: '富文本',
          description: 'BaseText.rich / BaseText.richSpans 与 TextSpan、WidgetSpan、手势识别。',
          children: [
            BaseText.rich(
              TextSpan(
                children: [
                  const TextSpan(text: '普通文本 '),
                  TextSpan(
                    text: '可点击文本',
                    style: const TStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () => showToast('点击了富文本'),
                  ),
                  const TextSpan(text: ' 与 WidgetSpan：'),
                  const WidgetSpan(child: Icon(Icons.star, size: 16, color: Colors.amber)),
                ],
              ),
            ),
            const SizedBox(height: 6),
            BaseText.richSpans([
              const TextSpan(text: 'richSpans 第一段 '),
              TextSpan(
                text: '第二段',
                style: TStyle(color: context.theme.primaryColor, fontWeight: FontWeight.bold),
              ),
            ]),
          ],
        ),
        DemoSection(
          title: 'TStyle',
          description: 'TStyle 继承 TextStyle，并提供 smallest / small / medium / large / extraLarge 预设。',
          children: [
            TextMedium('TStyle.smallest', style: TStyle.smallest),
            TextMedium('TStyle.small', style: TStyle.small),
            TextMedium('TStyle.medium', style: TStyle.medium),
            TextMedium('TStyle.large', style: TStyle.large),
            TextMedium('TStyle.extraLarge', style: TStyle.extraLarge),
          ],
        ),
        DemoSection(
          title: 'RowTextLayoutBuilder',
          description: '左右两段文本按可用宽度自动收缩，适合标题 + 状态、名称 + 数值等布局。',
          children: [
            RowTextLayoutBuilder(
              leading: const [TextSpan(text: '这是一个很长的标题，会根据空间自动收缩')],
              trailing: const [TextSpan(text: '右侧状态文本')],
              spacing: 8,
              builder: (leading, leadingBuilder, trailing, trailingBuilder) => Row(
                children: [
                  leadingBuilder(BaseText.rich(TextSpan(children: leading))),
                  const SizedBox(width: 8),
                  trailingBuilder(BaseText.rich(TextSpan(children: trailing))),
                ],
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'TextBoxPage',
          description: 'TextBoxPage 用于展示可复制长文本，点击文本自动复制到剪贴板。',
          children: [
            DemoButton(
              text: '打开 TextBoxPage',
              icon: Icons.copy,
              onTap: () =>
                  push(const TextBoxPage(text: 'Universally 是一个 Flutter 常用组件与插件依赖库。', appBarTitleText: 'TextBoxPage')),
            ),
          ],
        ),
      ],
    );
  }
}
