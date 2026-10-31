import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 示例页统一脚手架
class DemoScaffold extends StatelessWidget {
  const DemoScaffold({
    super.key,
    required this.title,
    this.children = const [],
    this.appBarActions,
    this.isScroll = true,
    this.padding = const EdgeInsets.all(12),
  });

  final String title;
  final List<Widget> children;
  final List<Widget>? appBarActions;
  final bool isScroll;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => BaseScaffold(
    appBarTitleText: title,
    appBarActions: appBarActions,
    isScroll: isScroll,
    padding: padding,
    children: children,
  );
}

/// 示例分组
class DemoSection extends StatelessWidget {
  const DemoSection({super.key, required this.title, this.description, this.children = const []});

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Universal(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: context.theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(10),
    ),
    children: [
      TextLarge(title, fontWeight: FontWeight.bold),
      if (description != null) ...[
        const SizedBox(height: 4),
        TextSmall(description!, color: context.theme.hintColor, height: 1.4),
      ],
      const SizedBox(height: 10),
      ...children,
    ],
  );
}

/// 示例按钮
class DemoButton extends StatelessWidget {
  const DemoButton({
    super.key,
    required this.text,
    this.description,
    this.icon,
    this.onTap,
    this.category = FlButtonCategory.elevated,
  });

  final String text;
  final String? description;
  final IconData? icon;
  final GestureTapCallback? onTap;
  final FlButtonCategory category;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: icon == null
              ? FlButton(category: category, onPressed: onTap, child: Text(text))
              : FlButton.icon(category: category, icon: Icon(icon), onPressed: onTap, child: Text(text)),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 2),
            child: TextSmall(description!, color: context.theme.hintColor, height: 1.3),
          ),
      ],
    ),
  );
}

/// 结果展示
class DemoResult extends StatelessWidget {
  const DemoResult({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: context.theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: context.theme.dividerColor),
    ),
    child: TextSmall(text.isEmpty ? '暂无结果' : text, maxLines: 12, height: 1.4),
  );
}

/// 简单的日志收集
class DemoLog extends ChangeNotifier {
  static final DemoLog instance = DemoLog();

  final List<String> _logs = [];

  List<String> get logs => List.unmodifiable(_logs);

  void add(String value) {
    final String text = '${DateTime.now().toImeString()}\n$value';
    _logs.insert(0, text);
    if (_logs.length > 30) _logs.removeLast();
    notifyListeners();
  }

  void clear() {
    _logs.clear();
    notifyListeners();
  }
}

extension _DateTimeFormat on DateTime {
  String toImeString() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
}
