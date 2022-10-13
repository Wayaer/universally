import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({
    super.key,
    this.value,
    this.controller,
    this.searchTextTap,
    this.sendSMSTap,
    this.onChanged,
    this.enableEye = false,
    this.enableClearIcon = false,
    this.enableSearchIcon = false,
    this.toolbarOptions = const ToolbarOptions(
        copy: true, cut: true, paste: true, selectAll: true),
    this.externalSearchText = true,
    this.externalSendSMS = true,
    this.hintText,
    this.enabled = true,
    this.width = UConstant.longWidth,
    this.margin,
    this.maxLength,
    this.padding,
    this.hintStyle,
    this.lineColor = UCS.lineColor,
    this.maxLines,
    this.minLines,
    this.focusNode,
    this.header,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.inputStyle,
    this.autoFocus,
    this.onEditingComplete,
    this.heroTag,
    this.footer,
    this.labelText,
    this.labelStyle,
    this.disposeController = true,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.keyboardAppearance,
    this.fillColor,
    this.borderStyle,
    this.suffixes = const [],
    this.prefixes = const [],
    this.decoration,
  });

  /// ***** 附加功能 *****
  /// 初始化默认的文本
  final String? value;

  /// 添加 搜索文字 点击事件
  final ValueCallback<String>? searchTextTap;

  /// 使 searchText 至边框外部
  final bool externalSearchText;

  /// 添加 发送验证码 点击事件
  final SendSMSValueCallback? sendSMSTap;

  /// 使 sendSMS 至边框外部
  final bool externalSendSMS;

  /// 开启 显示和隐藏 eye
  final bool enableEye;

  /// 开启 清除 icon
  final bool enableClearIcon;

  /// 开启 搜索 icon
  final bool enableSearchIcon;

  /// 后缀
  final List<AccessoryEntry> suffixes;

  /// 前缀
  final List<AccessoryEntry> prefixes;

  /// 添加hero
  final String? heroTag;

  /// 头部和底部 添加组件
  final Widget? header;
  final Widget? footer;

  /// 整个组件装饰器，包含[header]、[footer]、[extraPrefix]、[extraSuffix]
  final Decoration? decoration;

  /// ***** [TextField] *****
  final TextEditingController? controller;
  final ToolbarOptions? toolbarOptions;

  /// 是否可输入
  final bool? enabled;

  /// 宽度
  final double width;

  /// 最长输入的字符串
  final int? maxLength;

  /// 输入文字样式
  final TextStyle? inputStyle;

  /// 提示文字样式
  final TextStyle? hintStyle;

  /// 提示文字
  final String? hintText;

  final String? labelText;
  final TextStyle? labelStyle;

  /// 边框样式
  final InputBorderStyle? borderStyle;

  /// 整个组件的padding 包含[header]、[footer]
  final EdgeInsetsGeometry? padding;

  /// 整个组件的margin 包含[header]、[footer]
  final EdgeInsetsGeometry? margin;

  // final EdgeInsetsGeometry contentPadding;

  /// 输入框变化监听
  final ValueChanged<String>? onChanged;

  /// 边框颜色
  final Color lineColor;

  /// 输入框填充色
  final Color? fillColor;

  /// 默认为1
  final int? maxLines;
  final int? minLines;

  /// 是否自动获取焦点 默认false
  final bool? autoFocus;

  /// 焦点管理
  final FocusNode? focusNode;

  /// 输入框点击数事件
  final GestureTapCallback? onTap;

  /// 输入框文字对齐方式
  final TextAlign? textAlign;

  /// 按回车时调用 先调用此方法  然后调用onSubmitted方法
  final ValueCallback<TextEditingController>? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  final bool disposeController;

  ///       设置键盘上enter键的显示内容
  ///       textInputAction: TextInputAction.search, ///  搜索
  ///       textInputAction: TextInputAction.none,///  默认回车符号
  ///       textInputAction: TextInputAction.done,///  安卓显示 回车符号
  ///       textInputAction: TextInputAction.go,///  开始
  ///       textInputAction: TextInputAction.next,///  下一步
  ///       textInputAction: TextInputAction.send,///  发送
  ///       textInputAction: TextInputAction.continueAction,///  android  不支持
  ///       textInputAction: TextInputAction.emergencyCall,///  android  不支持
  ///       textInputAction: TextInputAction.newline,///  安卓显示 回车符号
  ///       textInputAction: TextInputAction.route,///  android  不支持
  ///       textInputAction: TextInputAction.join,///  android  不支持
  ///       textInputAction: TextInputAction.previous,///  安卓显示 回车符号
  ///       textInputAction: TextInputAction.unspecified,///  安卓显示 回车符号
  final TextInputAction textInputAction;

  ///  TextCapitalization.characters,  ///  输入时键盘的英文都是大写
  ///  TextCapitalization.none,  ///  键盘英文默认显示小写
  ///  TextCapitalization.sentences, ///  在输入每个句子的第一个字母时，键盘大写形式，输入后续字母时键盘小写形式
  ///  TextCapitalization.words,///  在输入每个单词的第一个字母时，键盘大写形式，输入其他字母时键盘小写形式
  final TextCapitalization textCapitalization;

  final List<TextInputFormatter>? inputFormatters;

  final Brightness? keyboardAppearance;

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
    /// 后缀
    final List<AccessoryEntry> suffixes = List.from(widget.suffixes);

    if (widget.enableClearIcon) {
      suffixes.add(
          AccessoryEntry(mode: AccessoryMode.editing, widget: buildClearIcon));
    }
    if (widget.enableEye) {
      suffixes.add(
          AccessoryEntry(mode: AccessoryMode.editing, widget: buildEyeIcon));
    }
    if (widget.sendSMSTap != null) {
      suffixes.add(AccessoryEntry(
          mode: widget.externalSendSMS
              ? AccessoryMode.outer
              : AccessoryMode.inner,
          widget: buildSendSMS));
    }
    if (widget.searchTextTap != null) {
      suffixes.add(AccessoryEntry(
          mode: widget.externalSearchText
              ? AccessoryMode.outer
              : AccessoryMode.inner,
          widget: buildSearchText));
    }

    /// 前缀
    List<AccessoryEntry> prefixes = List.from(widget.prefixes);
    if (widget.enableSearchIcon) {
      // prefixes.add(
      //     AccessoryEntry(mode: AccessoryMode.inner, widget: buildSearchIcon));
    }
    Widget textField = ExtendedTextField(
        suffixes: suffixes,
        prefixes: prefixes,
        hideCounter: true,
        decorator: WidgetDecoratorStyle(
            // padding: widget.contentPadding,
            ),
        decoration: InputDecoration(
            constraints: BoxConstraints(minHeight: 30),
            fillColor: widget.fillColor,
            isDense: true,
            // isCollapsed: true,
            filled: widget.fillColor != null,
            contentPadding: EdgeInsets.only(bottom: 5),
            enabledBorder: inputBorderStyle(UCS.lineColor),
            focusedErrorBorder: inputBorderStyle(GlobalConfig().currentColor),
            focusedBorder: inputBorderStyle(GlobalConfig().currentColor),
            disabledBorder: inputBorderStyle(UCS.background),
            border: inputBorderStyle(UCS.lineColor),
            hintText: widget.hintText,
            hintStyle: TStyle(
                    color: GlobalConfig().config.textColor?.smallColor,
                    height: 1.1,
                    fontSize: 13)
                .merge(widget.hintStyle)),
        builder: (TextInputType keyboardType,
            List<TextInputFormatter> inputFormatters,
            InputDecoration? decoration) {
          return TextFormField(
            style: TStyle(
                    color: GlobalConfig().config.textColor?.defaultColor,
                    height: 1.1)
                .merge(widget.inputStyle),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: decoration,
            keyboardAppearance: widget.keyboardAppearance,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            enabled: widget.enabled,
            autofocus: widget.autoFocus ?? false,
            maxLines: _maxLines,
            minLines: widget.minLines ?? 1,
            controller: controller,
            cursorColor: GlobalConfig().currentColor,
            // cursorHeight: isAndroid ? 16 : 12,
            obscureText: widget.enableEye && eye,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            textAlign: _textAlign,
            onTap: widget.onTap,
            // onSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEditingComplete == null
                ? null
                : () => widget.onEditingComplete!.call(controller),
          ).color(UCS.lineColor);
        });

    return Universal(
        margin: widget.margin,
        decoration: widget.decoration,
        width: widget.width,
        child: textField);
  }

  TextAlign get _textAlign {
    TextAlign align = widget.textAlign ?? TextAlign.left;
    if (_maxLines > 1) align = TextAlign.start;
    return align;
  }

  int get _maxLines {
    final int max = widget.maxLines ?? 1;
    final int min = widget.minLines ?? 1;
    if (min > max) return min;
    return max;
  }

  InputBorder inputBorderStyle(Color color) => ExtendedTextField.toInputBorder(
      (widget.borderStyle ?? InputBorderStyle()).copyWith(color: color));

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

  @override
  void didUpdateWidget(covariant BasicTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.disposeController) controller.dispose();
  }
}
