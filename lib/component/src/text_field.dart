import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

enum OverlayPendantMode {
  /// 编辑时显示
  editing,

  /// [TextField] 内部的 [InputDecoration]
  /// 在 [TextField] 内部
  inner,

  /// 在 [WidgetPendant] 内部
  /// 在 [TextField] 外部
  outer,

  /// 在 [WidgetPendant] 外部  最外面
  outermost,
}

class BasicTextField extends StatefulWidget {
  const BasicTextField({
    Key? key,
    this.value,
    this.controller,
    this.searchTextTap,
    this.sendSMSTap,
    this.onChanged,
    this.enableEye = false,
    this.enableClearIcon = false,
    this.enableSearchIcon = false,
    this.searchTextMode = OverlayPendantMode.outer,
    this.searchIconMode = OverlayPendantMode.inner,
    this.sendSMSMode = OverlayPendantMode.inner,
    this.eyeIconMode = OverlayPendantMode.editing,
    this.clearIconMode = OverlayPendantMode.editing,
    this.toolbarOptions = const ToolbarOptions(
        copy: true, cut: true, paste: true, selectAll: true),
  }) : super(key: key);

  /// ***** 附加功能 *****
  /// 初始化默认的文本
  final String? value;

  /// 添加 搜索文字 点击事件
  final ValueCallback<String>? searchTextTap;

  /// 添加 搜索文字 位置 [OverlayPendantMode.outer]
  final OverlayPendantMode searchTextMode;

  /// 添加 发送验证码 点击事件
  final SendSMSValueCallback? sendSMSTap;

  /// 添加 发送验证码 位置 [OverlayPendantMode.inner]
  final OverlayPendantMode sendSMSMode;

  /// 输入框变化监听
  final ValueChanged<String>? onChanged;

  /// 开启 显示和隐藏 eye
  final bool enableEye;

  /// 显示和隐藏 eye 位置 [OverlayPendantMode.editing]
  final OverlayPendantMode eyeIconMode;

  /// 开启 清除 icon
  final bool enableClearIcon;

  /// 清除 icon 位置 [OverlayPendantMode.editing]
  final OverlayPendantMode clearIconMode;

  /// 开启 搜索 icon
  final bool enableSearchIcon;

  /// 搜索 icon 位置 [OverlayPendantMode.inner]
  final OverlayPendantMode searchIconMode;

  /// ***** [WidgetPendant] *****

  /// ***** [TextField] *****
  final TextEditingController? controller;
  final ToolbarOptions? toolbarOptions;

  /// ***** [InputDecoration] *****
  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  late TextEditingController controller;
  bool eye = true;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    if (widget.value != null) controller.text = widget.value!;
  }

  @override
  Widget build(BuildContext context) {
    Widget current = buildTextField;
    current = buildWidgetPendant(current);
    return current;
  }

  Widget get buildTextField => ColoredBox(
        color: Colors.blueGrey.withOpacity(0.2),
        child: TextField(
            controller: controller,
            maxLength: 10,
            maxLines: 1,
            minLines: 1,
            cursorWidth: 4,
            cursorRadius: Radius.circular(4),
            toolbarOptions: widget.toolbarOptions,
            decoration: InputDecoration(
              counterText: '',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              suffix: buildSuffix(OverlayPendantMode.editing),
              suffixIcon: buildSuffix(OverlayPendantMode.inner),
              suffixIconConstraints: const BoxConstraints(minWidth: 80),
              prefix: buildPrefix(OverlayPendantMode.editing),
              prefixIcon: buildPrefix(OverlayPendantMode.inner),
            )),
      );

  Widget buildWidgetPendant(Widget current) => WidgetPendant(
        suffix: buildSuffix(OverlayPendantMode.outer),
        prefix: buildPrefix(OverlayPendantMode.outer),
        extraSuffix: buildSuffix(OverlayPendantMode.outermost),
        extraPrefix: buildPrefix(OverlayPendantMode.outermost),
        child: current,
      );

  /// 后缀
  Widget? buildSuffix(OverlayPendantMode mode) {
    List<Widget> children = [];
    if (widget.clearIconMode == mode && widget.enableClearIcon) {
      children.add(buildClearIcon);
    }
    if (widget.eyeIconMode == mode && widget.enableEye) {
      children.add(buildEyeIcon);
    }
    if (widget.sendSMSMode == mode && widget.sendSMSTap != null) {
      children.add(buildSendSMS);
    }
    if (widget.searchTextMode == mode && widget.searchTextTap != null) {
      children.add(buildSearchText);
    }
    return children.isEmpty
        ? null
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }

  /// Editing 前缀
  Widget? buildPrefix(OverlayPendantMode mode) {
    List<Widget> children = [];
    if (widget.searchIconMode == mode && widget.enableSearchIcon) {
      children.add(buildSearchIcon);
    }
    return children.isEmpty
        ? null
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }

  Widget get buildSearchText => Universal(
      onTap: () => widget.searchTextTap?.call(controller.text),
      alignment: Alignment.center,
      child: TextDefault('搜索'));

  Widget get buildSendSMS => SendSMS(
      duration: const Duration(seconds: 60),
      stateBuilder: (SendState state, int i) {
        switch (state) {
          case SendState.none:
            return TextDefault('发送验证码', color: GlobalConfig().currentColor);
          case SendState.sending:
            return TextDefault('发送中', color: GlobalConfig().currentColor);
          case SendState.resend:
            return TextDefault('重新发送', color: GlobalConfig().currentColor);
          case SendState.countDown:
            return TextDefault('$i s', color: GlobalConfig().currentColor);
        }
      },
      onTap: widget.sendSMSTap);

  Widget get buildSearchIcon => Icon(UIS.search,
      size: 20, color: GlobalConfig().config.textColor?.smallColor);

  Widget get buildClearIcon => IconBox(
      size: 18,
      padding: EdgeInsets.only(right: widget.enableEye ? 10 : 0),
      icon: UIS.clear,
      color: GlobalConfig().config.textColor?.defaultColor,
      onTap: () {
        controller.clear();
        if (widget.onChanged != null) widget.onChanged!('');
      });

  Widget get buildEyeIcon => Universal(
      enabled: widget.enableEye,
      onTap: () => setState(() {
            eye = !eye;
          }),
      child: SVGAsset(eye ? UAS.eyeClose : UAS.eyeOpen,
          color: GlobalConfig().config.textColor?.defaultColor,
          size: 20,
          package: 'universally'));
}
