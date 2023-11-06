import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

class BaseTextField extends StatefulWidget {
  const BaseTextField(
      {super.key,
      this.value,
      this.controller,
      this.searchTextTap,
      this.searchTextPositioned = DecoratorPositioned.outer,
      this.sendSMSPositioned = DecoratorPositioned.outer,
      this.sendSMSTap,
      this.enableEye = false,
      this.enableClearIcon = false,
      this.enableSearchIcon = false,
      this.hintText,
      this.width = double.infinity,
      this.margin,
      this.padding,
      this.hintStyle,
      this.focusNode,
      this.header,
      this.heroTag,
      this.footer,
      this.labelText,
      this.labelStyle,
      this.disposeController = true,
      this.hasFocusChangeBorder = true,
      this.fillColor,
      this.suffix = const [],
      this.prefix = const [],
      this.borderRadius = const BorderRadius.all(Radius.circular(4)),
      this.borderType = BorderType.outline,
      this.borderSide = const BorderSide(color: UCS.lineColor, width: 1),
      this.focusBorderSide,
      this.contentPadding =
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      this.clearButtonMode = OverlayVisibilityMode.never,
      this.textInputAction = TextInputAction.done,
      this.textCapitalization = TextCapitalization.none,
      this.style,
      this.strutStyle,
      this.textAlign = TextAlign.left,
      this.textAlignVertical,
      this.textDirection,
      this.readOnly = false,
      this.showCursor,
      this.autoFocus = false,
      this.obscuringCharacter = '•',
      this.autocorrect = true,
      this.smartDashesType,
      this.smartQuotesType,
      this.enableSuggestions = true,
      this.maxLines = 1,
      this.minLines = 1,
      this.expands = false,
      this.maxLength,
      this.maxLengthEnforcement,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.inputFormatters,
      this.enabled = true,
      this.cursorWidth = 2.0,
      this.cursorHeight,
      this.cursorRadius = const Radius.circular(2.0),
      this.selectionHeightStyle = ui.BoxHeightStyle.tight,
      this.selectionWidthStyle = ui.BoxWidthStyle.tight,
      this.keyboardAppearance,
      this.scrollPadding = const EdgeInsets.all(20.0),
      this.dragStartBehavior = DragStartBehavior.start,
      this.enableInteractiveSelection,
      this.selectionControls,
      this.onTap,
      this.scrollController,
      this.scrollPhysics,
      this.autofillHints = const [],
      this.clipBehavior = Clip.hardEdge,
      this.restorationId,
      this.scribbleEnabled = true,
      this.enableIMEPersonalizedLearning = true,
      this.textInputType = TextInputLimitFormatter.text,
      this.contextMenuBuilder,
      this.magnifierConfiguration,
      this.onTapOutside,
      this.spellCheckConfiguration});

  /// ***** 附加功能 *****
  /// 初始化默认的文本
  final String? value;

  /// 添加 搜索文字 点击事件
  final ValueCallback<String>? searchTextTap;
  final DecoratorPositioned searchTextPositioned;

  /// 添加 发送验证码 点击事件
  final SendSMSValueCallback? sendSMSTap;
  final DecoratorPositioned sendSMSPositioned;

  /// 开启 显示和隐藏 eye
  final bool enableEye;

  /// 开启 清除 icon
  final bool enableClearIcon;

  /// 开启 搜索 icon
  final bool enableSearchIcon;

  /// 后缀
  final List<DecoratorEntry> suffix;

  /// 前缀
  final List<DecoratorEntry> prefix;

  /// 添加hero
  final String? heroTag;

  /// 头部和底部 添加组件
  final Widget? header;
  final Widget? footer;

  /// 边框样式
  final BorderRadius? borderRadius;
  final BorderType borderType;
  final bool hasFocusChangeBorder;
  final BorderSide borderSide;
  final BorderSide? focusBorderSide;

  /// 整个组件的padding 包含[header]、[footer]
  final EdgeInsetsGeometry? padding;

  /// 整个组件的margin 包含[header]、[footer]
  final EdgeInsetsGeometry? margin;

  /// 宽度
  final double width;

  final String? labelText;
  final TextStyle? labelStyle;

  /// dispose 时调用 controller 的 dispose
  final bool disposeController;

  /// ***** [TextField] *****
  final EdgeInsetsGeometry contentPadding;

  final TextEditingController? controller;

  /// 是否可输入
  final bool? enabled;

  /// 最长输入的字符串
  final int? maxLength;

  /// 输入文字样式
  final TextStyle? style;

  /// 提示文字样式
  final TextStyle? hintStyle;

  /// 提示文字
  final String? hintText;

  /// 按回车时调用 先调用此方法  然后调用onSubmitted方法
  final ValueCallback<TextEditingController>? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  /// 输入框变化监听
  final ValueChanged<String>? onChanged;

  /// 输入框填充色
  final Color? fillColor;

  /// 默认为 1
  final int maxLines;
  final int minLines;

  /// 是否自动获取焦点 默认false
  final bool autoFocus;

  /// 焦点管理
  final FocusNode? focusNode;

  /// 输入框点击数事件
  final GestureTapCallback? onTap;

  /// 输入框文字对齐方式
  final TextAlign textAlign;

  /// 设置键盘上enter键的显示内容
  /// textInputAction: TextInputAction.search, ///  搜索
  /// textInputAction: TextInputAction.none,///  默认回车符号
  /// textInputAction: TextInputAction.done,///  安卓显示 回车符号
  /// textInputAction: TextInputAction.go,///  开始
  /// textInputAction: TextInputAction.next,///  下一步
  /// textInputAction: TextInputAction.send,///  发送
  /// textInputAction: TextInputAction.continueAction,///  android  不支持
  /// textInputAction: TextInputAction.emergencyCall,///  android  不支持
  /// textInputAction: TextInputAction.newline,///  安卓显示 回车符号
  /// textInputAction: TextInputAction.route,///  android  不支持
  /// textInputAction: TextInputAction.join,///  android  不支持
  /// textInputAction: TextInputAction.previous,///  安卓显示 回车符号
  /// textInputAction: TextInputAction.unspecified,///  安卓显示 回车符号
  final TextInputAction textInputAction;

  /// TextCapitalization.characters,  ///  输入时键盘的英文都是大写
  /// TextCapitalization.none,  ///  键盘英文默认显示小写
  /// TextCapitalization.sentences, ///  在输入每个句子的第一个字母时，键盘大写形式，输入后续字母时键盘小写形式
  /// TextCapitalization.words,///  在输入每个单词的第一个字母时，键盘大写形式，输入其他字母时键盘小写形式
  final TextCapitalization textCapitalization;

  final List<TextInputFormatter>? inputFormatters;
  final TextInputLimitFormatter textInputType;

  final TextDirection? textDirection;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// 隐藏输入内容时显示的字符串
  final String obscuringCharacter;
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius cursorRadius;

  final OverlayVisibilityMode clearButtonMode;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.material.textfield.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.scribbleEnabled}
  final bool scribbleEnabled;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.TextInputConfiguration.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro flutter.services.TextInputConfiguration.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If null, defaults to [Brightness.light].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool? enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// Controls how tall the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxHeightStyle] for details on available styles.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxWidthStyle] for details on available styles.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final TapRegionCallback? onTapOutside;
  final SpellCheckConfiguration? spellCheckConfiguration;

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  late TextEditingController controller;
  ValueNotifier<bool> obscureText = ValueNotifier(true);
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    if (widget.value != null) controller.text = widget.value!;
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    /// 后缀
    List<DecoratorEntry> suffixes = [];

    if (widget.enableClearIcon) {
      suffixes.add(DecoratorEntry(
          mode: OverlayVisibilityMode.editing,
          positioned: DecoratorPositioned.inner,
          widget: buildClearIcon));
    }
    if (widget.enableEye) {
      suffixes.add(DecoratorEntry(
          mode: OverlayVisibilityMode.editing,
          positioned: DecoratorPositioned.inner,
          widget: buildEyeIcon));
    }
    if (widget.sendSMSTap != null) {
      suffixes.add(DecoratorEntry(
          positioned: widget.sendSMSPositioned, widget: buildSendSMS));
    }
    if (widget.searchTextTap != null) {
      suffixes.add(DecoratorEntry(
          positioned: widget.searchTextPositioned, widget: buildSearchText));
    }
    if (widget.suffix.isNotEmpty) {
      suffixes.addAll(widget.suffix);
    }

    /// 前缀
    List<DecoratorEntry> prefixes = [
      if (widget.prefix.isNotEmpty) ...widget.prefix
    ];

    if (widget.enableSearchIcon) {
      prefixes.add(DecoratorEntry(
          positioned: DecoratorPositioned.inner, widget: buildSearchIcon));
    }
    List<DecoratorEntry> innerSuffixes = [];
    for (var element in suffixes) {
      if (element.mode == OverlayVisibilityMode.editing ||
          element.mode == OverlayVisibilityMode.notEditing) {
        innerSuffixes.add(element);
      }
    }
    suffixes.removeWhere((element) => innerSuffixes.contains(element));
    List<DecoratorEntry> innerPrefixes = [];
    for (var element in suffixes) {
      if (element.mode == OverlayVisibilityMode.editing ||
          element.mode == OverlayVisibilityMode.notEditing) {
        innerPrefixes.add(element);
      }
    }
    prefixes.removeWhere((element) => innerPrefixes.contains(element));
    return Universal(
        heroTag: widget.heroTag,
        width: widget.width,
        child: DecoratorBoxState(
            margin: widget.margin,
            padding: widget.padding,
            suffixes: suffixes,
            prefixes: prefixes,
            borderType: widget.borderType,
            focusNode: focusNode,
            fillColor: widget.fillColor,
            borderRadius: widget.borderRadius,
            focusBorderSide: widget.hasFocusChangeBorder
                ? widget.focusBorderSide ??
                    BorderSide(color: Global().mainColor)
                : null,
            borderSide: widget.borderSide,
            constraints: const BoxConstraints(minHeight: 35),
            child: buildTextField(
                innerSuffixes: innerSuffixes, innerPrefixes: innerPrefixes)));
  }

  GlobalKey textFieldKey = GlobalKey();

  Widget buildTextField({
    List<DecoratorEntry> innerSuffixes = const [],
    List<DecoratorEntry> innerPrefixes = const [],
  }) =>
      ValueListenableBuilder(
          valueListenable: obscureText,
          builder: (_, bool value, __) => CupertinoTextField(
                key: textFieldKey,
                controller: controller,
                focusNode: focusNode,
                suffixMode: OverlayVisibilityMode.editing,
                suffix: innerSuffixes.isEmpty
                    ? null
                    : Row(
                        children:
                            innerSuffixes.builder((entry) => entry.widget)),
                prefixMode: OverlayVisibilityMode.editing,
                prefix: innerPrefixes.isEmpty
                    ? null
                    : Row(
                        children:
                            innerPrefixes.builder((entry) => entry.widget)),
                decoration: const BoxDecoration(color: Colors.transparent),
                placeholder: widget.hintText,
                placeholderStyle: TStyle(
                        color: Global().config.textColor?.smallColor,
                        fontSize: 13)
                    .merge(widget.hintStyle),
                style: TStyle(color: Global().config.textColor?.defaultColor)
                    .merge(widget.style),
                keyboardType: widget.textInputType.toKeyboardType(),
                inputFormatters: inputFormatters,
                keyboardAppearance: widget.keyboardAppearance,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                enabled: widget.enabled,
                autofocus: widget.autoFocus,
                obscureText: widget.enableEye && value,
                obscuringCharacter: widget.obscuringCharacter,
                maxLines: _maxLines,
                minLines: widget.minLines,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                maxLength: widget.maxLength,
                onChanged: widget.onChanged,
                textAlign: _textAlign,
                onTap: widget.onTap,
                onSubmitted: widget.onSubmitted,
                onEditingComplete: widget.onEditingComplete == null
                    ? null
                    : () => widget.onEditingComplete!.call(controller),
                showCursor: widget.showCursor,
                cursorColor: Global().mainColor,
                cursorHeight: widget.cursorHeight ?? (isAndroid ? 14 : 16),
                cursorWidth: widget.cursorWidth,
                cursorRadius: widget.cursorRadius,
                clearButtonMode: widget.clearButtonMode,
                clipBehavior: widget.clipBehavior,
                autocorrect: widget.autocorrect,
                autofillHints: widget.autofillHints,
                dragStartBehavior: widget.dragStartBehavior,
                enableIMEPersonalizedLearning:
                    widget.enableIMEPersonalizedLearning,
                enableInteractiveSelection: widget.enableInteractiveSelection,
                enableSuggestions: widget.enableSuggestions,
                expands: widget.expands,
                readOnly: widget.readOnly,
                restorationId: widget.restorationId,
                scribbleEnabled: widget.scribbleEnabled,
                scrollController: widget.scrollController,
                scrollPadding: widget.scrollPadding,
                scrollPhysics: widget.scrollPhysics,
                selectionControls: widget.selectionControls,
                selectionHeightStyle: widget.selectionHeightStyle,
                selectionWidthStyle: widget.selectionWidthStyle,
                smartDashesType: widget.smartDashesType,
                smartQuotesType: widget.smartQuotesType,
                strutStyle: widget.strutStyle,
                textAlignVertical: widget.textAlignVertical,
                textDirection: widget.textDirection,
                padding: widget.contentPadding,
                contextMenuBuilder:
                    widget.contextMenuBuilder ?? _defaultContextMenuBuilder,
                magnifierConfiguration: widget.magnifierConfiguration,
                onTapOutside: widget.onTapOutside,
                spellCheckConfiguration: widget.spellCheckConfiguration,
              ));

  Widget _defaultContextMenuBuilder(
          BuildContext context, EditableTextState editableTextState) =>
      CupertinoAdaptiveTextSelectionToolbar.buttonItems(
          buttonItems: editableTextState.contextMenuButtonItems,
          anchors: editableTextState.contextMenuAnchors);

  List<TextInputFormatter> get inputFormatters {
    final list = widget.textInputType.toTextInputFormatter();
    if (widget.inputFormatters != null) {
      list.addAll(widget.inputFormatters!);
    }
    return list;
  }

  TextAlign get _textAlign {
    TextAlign align = widget.textAlign;
    if (_maxLines > 1) align = TextAlign.start;
    return align;
  }

  int get _maxLines {
    final int max = widget.maxLines;
    final int min = widget.minLines;
    if (min > max) return min;
    return max;
  }

  Widget? get buildHeader {
    List<Widget> headerRow = [];
    if (widget.labelText != null) {
      headerRow.add(BaseText(widget.labelText, style: widget.labelStyle));
    }
    if (widget.header != null) headerRow.add(widget.header!);
    if (headerRow.isNotEmpty) {
      return headerRow.length == 1 ? headerRow.first : Row(children: headerRow);
    }
    return null;
  }

  Widget get buildSearchText {
    bool left = widget.searchTextPositioned != DecoratorPositioned.inner;
    return Universal(
        margin: EdgeInsets.only(left: left ? 12 : 0, right: left ? 0 : 10),
        onTap: () => widget.searchTextTap?.call(controller.text),
        alignment: Alignment.center,
        child: TextNormal('搜索'));
  }

  Widget get buildSendSMS {
    bool left = widget.sendSMSPositioned != DecoratorPositioned.inner;
    return SendSMS(
        margin: EdgeInsets.only(left: left ? 12 : 0, right: left ? 0 : 10),
        duration: const Duration(seconds: 60),
        builder: (SendState state, int i) {
          switch (state) {
            case SendState.none:
              return TextNormal('发送验证码', color: Global().mainColor);
            case SendState.sending:
              return TextNormal('发送中', color: Global().mainColor);
            case SendState.resend:
              return TextNormal('重新发送', color: Global().mainColor);
            case SendState.countDown:
              return TextNormal('$i s', color: Global().mainColor);
          }
        },
        onTap: widget.sendSMSTap);
  }

  Widget get buildSearchIcon =>
      Icon(UIS.search, size: 20, color: Global().config.textColor?.smallColor)
          .paddingOnly(left: 10);

  Widget get buildClearIcon => IconBox(
      size: 18,
      padding: const EdgeInsets.only(right: 10),
      icon: UIS.clear,
      color: Global().config.textColor?.defaultColor,
      onTap: () {
        controller.clear();
        if (widget.onChanged != null) widget.onChanged!('');
      });

  Widget get buildEyeIcon => Universal(
      margin: const EdgeInsets.only(right: 10),
      enabled: widget.enableEye,
      onTap: () {
        obscureText.value = !obscureText.value;
        if (mounted) setState(() {});
      },
      child: Icon(obscureText.value ? WayIcons.eyeClose : WayIcons.eyeOpen,
          color: Global().config.textColor?.defaultColor, size: 20));

  @override
  void didUpdateWidget(covariant BaseTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.disposeController) controller.dispose();
  }
}
