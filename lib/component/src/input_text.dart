import 'package:flutter/cupertino.dart';
import 'package:universally/universally.dart';

class InputText extends StatefulWidget {
  const InputText(
      {this.controller,
      super.key,
      Color? fillColor,
      this.hintText,
      this.enabled = true,
      this.width = UConstant.longWidth,
      this.onChanged,
      this.margin,
      this.maxLength,
      this.padding,
      this.hintStyle,
      this.lineColor = UCS.lineColor,
      this.maxLines,
      this.minLines,
      this.inputTextType = InputTextType.text,
      this.prefix,
      this.extraPrefix,
      this.suffix,
      this.borderType = BorderType.none,
      this.sendSMSTap,
      this.clearEnabled = false,
      this.eyeEnabled = false,
      this.searchEnabled = false,
      this.focusNode,
      this.header,
      this.onTap,
      this.textAlign = TextAlign.left,
      this.inputStyle,
      this.autoFocus,
      this.onEditingComplete,
      this.heroTag,
      this.searchTextTap,
      this.extraSuffix,
      this.footer,
      this.borderRadius,
      this.decoration,
      this.labelText,
      this.labelStyle,
      this.leftRetainSpacing = true,
      this.rightRetainSpacing = true,
      this.hasFocusChangeLineColor = true,
      this.disposeController = true,
      this.extraSearchText = true,
      this.extraSendSMS = true,
      this.contentPadding = EdgeInsets.zero,
      this.textInputAction = TextInputAction.done,
      this.onSubmitted,
      this.textCapitalization = TextCapitalization.none,
      this.value})
      : fillColor = fillColor ?? UCS.transparent;

  /// 是否可输入
  final bool? enabled;

  /// 显示眼睛
  final bool eyeEnabled;

  /// 显示清除按钮
  final bool clearEnabled;

  /// 显示 输入框前面的搜索icon 只做显示
  final bool searchEnabled;

  /// 启动 搜索功能
  final ValueCallback<String>? searchTextTap;

  /// 是否放在输入框外部
  final bool extraSearchText;

  /// 启用 发送验证码功能
  final SendSMSValueCallback? sendSMSTap;

  /// 是否放在输入框外部
  final bool extraSendSMS;

  /// 添加hero
  final String? heroTag;

  /// 初始化默认的文本
  final String? value;

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

  /// 头部和底部 添加组件
  final Widget? header;
  final Widget? footer;

  final String? labelText;
  final TextStyle? labelStyle;

  /// 前缀 在边框内部
  final Widget? prefix;

  /// 前缀 在边框外部
  final Widget? extraPrefix;

  /// 后缀 在边框内部
  final Widget? suffix;

  /// 后缀 在边框外部
  final Widget? extraSuffix;

  /// 边框样式
  final BorderType borderType;

  /// 整个组件的padding 包含[header]、[footer]
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry contentPadding;

  /// 整个组件的margin 包含[header]、[footer]
  final EdgeInsetsGeometry? margin;

  /// 输入框变化监听
  final ValueChanged<String>? onChanged;

  /// 边框颜色
  final Color lineColor;

  /// 输入框填充色
  final Color? fillColor;

  final TextEditingController? controller;

  /// 默认为1
  final int? maxLines;
  final int? minLines;

  /// 输入的类型
  final InputTextType inputTextType;

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

  /// 输入框 圆角
  final BorderRadiusGeometry? borderRadius;

  /// 整个组件装饰器，包含[header]、[footer]、[extraPrefix]、[extraSuffix]
  final Decoration? decoration;

  /// 左右2边是否保留间距 默认 true
  /// 左右两遍必须要有组件
  final bool leftRetainSpacing;
  final bool rightRetainSpacing;

  final bool hasFocusChangeLineColor;
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

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late TextEditingController controller;
  FocusNode? focusNode;
  late Color borderColor;
  bool eye = true;

  @override
  void initState() {
    super.initState();
    borderColor = widget.lineColor;
    controller = widget.controller ?? TextEditingController();
    if (widget.value != null) controller.text = widget.value!;
    focusNode = widget.focusNode;
    if (widget.hasFocusChangeLineColor) {
      focusNode ??= FocusNode();
      focusNode!.addListener(focusNodeListener);
    }
  }

  void focusNodeListener() {
    if (focusNode!.hasFocus) borderColor = GlobalConfig().currentColor;
    if (!focusNode!.hasFocus) borderColor = widget.lineColor;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    focusNode?.removeListener(focusNodeListener);
    focusNode?.dispose();
    if (widget.disposeController) controller.dispose();
  }

  @override
  void didUpdateWidget(covariant InputText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) controller.text = widget.value ?? '';
  }

  @override
  Widget build(BuildContext context) => Universal(
      margin: widget.margin,
      padding: widget.padding,
      decoration: widget.decoration,
      width: widget.width,
      child: textInputBox);

  Widget get textInputBox {
    final List<Widget> extraSuffix = [];
    if (widget.sendSMSTap != null && widget.extraSendSMS) {
      extraSuffix.add(sendSMSWidget());
    }
    if (widget.searchTextTap != null && widget.extraSearchText) {
      extraSuffix.add(searchTextWidget());
    }
    if (widget.extraSuffix != null) extraSuffix.add(widget.extraSuffix!);

    final List<Widget> extraPrefix = [];
    if (widget.searchEnabled) extraPrefix.add(searchWidget());
    if (widget.extraPrefix != null) extraPrefix.add(widget.extraPrefix!);
    Widget current = textInputWidget();

    Widget? header;
    if (widget.labelText != null) {
      header = Row(children: <Widget>[
        BasicText(widget.labelText, style: widget.labelStyle)
      ]);
    }

    final EdgeInsetsGeometry extraPadding = EdgeInsets.only(
        left: extraPrefix.isNotEmpty && widget.leftRetainSpacing ? 12 : 0,
        right: extraSuffix.isNotEmpty && widget.rightRetainSpacing ? 12 : 0);

    final EdgeInsetsGeometry padding = EdgeInsets.only(
        top: 6,
        bottom: 6,
        left: widget.prefix != null && widget.leftRetainSpacing ? 10 : 0,
        right: (widget.clearEnabled ||
                    widget.eyeEnabled ||
                    widget.sendSMSTap != null ||
                    widget.suffix != null) &&
                widget.rightRetainSpacing
            ? 10
            : 0);
    current = WidgetPendant(
        header: widget.header ?? header,
        footer: widget.footer,
        fillColor: widget.fillColor,
        borderColor: borderColor,
        borderRadius: widget.borderRadius,
        padding: padding,
        borderType: widget.borderType,
        extraPadding: extraPadding.add(widget.contentPadding),
        extraPrefix: extraPrefix.isEmpty
            ? null
            : extraPrefix.length > 1
                ? Row(mainAxisSize: MainAxisSize.min, children: extraPrefix)
                : extraPrefix[0],
        extraSuffix: extraSuffix.isEmpty
            ? null
            : extraSuffix.length > 1
                ? Row(mainAxisSize: MainAxisSize.min, children: extraSuffix)
                : extraSuffix[0],
        child: current);
    if (widget.heroTag != null) {
      current = Hero(tag: widget.heroTag!, child: current);
    }
    return current;
  }

  Widget textInputWidget() {
    final List<Widget> suffix = [];
    OverlayVisibilityMode suffixMode = OverlayVisibilityMode.editing;
    if (widget.clearEnabled) suffix.add(clearWidget());
    if (widget.eyeEnabled) suffix.add(eyeWidget());

    if (!widget.extraSendSMS && widget.sendSMSTap != null) {
      suffix.add(sendSMSWidget());
      suffixMode = OverlayVisibilityMode.always;
    }

    if (!widget.extraSearchText && widget.searchTextTap != null) {
      suffix.add(searchTextWidget());
      suffixMode = OverlayVisibilityMode.always;
    }

    if (widget.suffix != null) suffix.add(widget.suffix!);
    final List<Widget> prefix = [];
    if (widget.prefix != null) prefix.add(widget.prefix!);

    return CupertinoTextField.borderless(
        suffixMode: suffixMode,
        suffix: suffix.isEmpty
            ? null
            : suffix.length > 1
                ? Row(mainAxisSize: MainAxisSize.min, children: suffix)
                : suffix[0],
        prefixMode: OverlayVisibilityMode.always,
        prefix: prefix.isEmpty
            ? null
            : prefix.length > 1
                ? Row(mainAxisSize: MainAxisSize.min, children: prefix)
                : prefix[0],
        placeholder: widget.hintText,
        placeholderStyle:
            const TStyle(color: UCS.smallTextColor, height: 1.1, fontSize: 13)
                .merge(widget.hintStyle),
        style: const TStyle(color: UCS.defaultTextColor, height: 1.1)
            .merge(widget.inputStyle),
        inputFormatters:
            inputTextTypeToTextInputFormatter(widget.inputTextType),
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        enabled: widget.enabled,
        autofocus: widget.autoFocus ?? false,
        focusNode: focusNode,
        maxLines: _maxLines,
        minLines: widget.minLines ?? 1,
        controller: controller,
        cursorColor: GlobalConfig().currentColor,
        cursorHeight: isAndroid ? 16 : 12,
        obscureText: widget.eyeEnabled && eye,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        textAlign: _textAlign,
        onTap: widget.onTap,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete == null
            ? null
            : () => widget.onEditingComplete!.call(controller));
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

  Widget searchTextWidget() => Universal(
      onTap: () => widget.searchTextTap?.call(controller.text),
      alignment: Alignment.center,
      child: TextDefault('搜索'));

  Widget sendSMSWidget() => SendSMS(
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

  Widget searchWidget() =>
      const Icon(UIS.search, size: 20, color: UCS.smallTextColor);

  Widget clearWidget() => IconBox(
      size: 18,
      padding: EdgeInsets.only(right: widget.eyeEnabled ? 10 : 0),
      icon: UIS.clear,
      color: UCS.defaultTextColor,
      onTap: () {
        controller.clear();
        if (widget.onChanged != null) widget.onChanged!('');
      });

  Widget eyeWidget() => Universal(
      enabled: widget.eyeEnabled,
      onTap: () => setState(() {
            eye = !eye;
          }),
      child: SVGAsset(eye ? UAS.eyeClose : UAS.eyeOpen,
          color: UCS.defaultTextColor, size: 20, package: 'universally'));
}
