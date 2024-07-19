import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

class BaseTextField extends StatefulWidget {
  const BaseTextField({
    super.key,
    this.useTextField = false,
    this.value,
    this.controller,
    this.searchText,
    this.searchTextTap,
    this.searchTextPosition = DecoratedPendantPosition.outer,
    this.sendVerificationCodeTap,
    this.sendVerificationCodeTextBuilder,
    this.sendVerificationCodePosition = DecoratedPendantPosition.outer,
    this.sendVerificationCodeDuration = const Duration(seconds: 60),
    this.enableEye = false,
    this.eyeIconBuilder,
    this.enableClearIcon = false,
    this.clearIcon,
    this.enableSearchIcon = false,
    this.searchIcon,
    this.hintText,
    this.width = double.infinity,
    this.height,
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
    this.constraints,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.borderType = BorderType.outline,
    this.borderSide = const BorderSide(color: UCS.lineColor, width: 1),
    this.focusBorderSide,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
    this.maxLines,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onEditingCompleteWith,
    this.onSubmitted,
    this.onSubmittedWith,
    this.onTap,
    this.onTapWith,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorOpacityAnimates = true,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const [],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.textInputType = TextInputLimitFormatter.text,
    this.keyboardType,
    this.contextMenuBuilder,
    this.magnifierConfiguration,
    this.onTapOutside,
    this.spellCheckConfiguration,
    this.contentInsertionConfiguration,
    this.undoController,
    this.cursorColor,
  });

  /// 使用 [TextField] 实现
  final bool useTextField;

  /// ***** 附加功能 *****
  /// 初始化默认的文本
  final String? value;

  /// 添加 搜索文字 点击事件
  final ValueCallback<String>? searchTextTap;
  final Widget? searchText;
  final DecoratedPendantPosition searchTextPosition;

  /// 添加 发送验证码 点击事件
  final SendVerificationCodeValueCallback? sendVerificationCodeTap;
  final ValueTwoCallbackT<Widget, SendState, int>?
      sendVerificationCodeTextBuilder;
  final DecoratedPendantPosition sendVerificationCodePosition;

  /// 验证码等待时间
  final Duration sendVerificationCodeDuration;

  /// 开启 显示和隐藏 eye
  final bool enableEye;

  final ValueCallbackTV<Widget, bool>? eyeIconBuilder;

  /// 开启 清除 icon
  final bool enableClearIcon;
  final Widget? clearIcon;

  /// 开启 搜索 icon
  final bool enableSearchIcon;
  final Widget? searchIcon;

  /// 后缀
  final List<DecoratedPendant> suffix;

  /// 前缀
  final List<DecoratedPendant> prefix;

  /// 添加hero
  final String? heroTag;

  /// 头部和底部 添加组件
  final Widget? header;
  final Widget? footer;
  final BoxConstraints? constraints;

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

  /// 高度
  final double? height;

  final String? labelText;
  final TextStyle? labelStyle;

  /// dispose 时调用 controller 的 dispose
  final bool disposeController;

  /// ***** [TextField] *****
  final EdgeInsetsGeometry contentPadding;

  final TextEditingController? controller;

  /// 是否可输入
  final bool enabled;

  /// 最长输入的字符串
  final int? maxLength;

  /// 输入文字样式
  final TextStyle? style;

  /// 提示文字样式
  final TextStyle? hintStyle;

  /// 提示文字
  final String? hintText;

  /// 按回车时调用 先调用此方法  然后调用onSubmitted方法
  final Callback? onEditingComplete;
  final ValueTwoCallback<TextEditingController, FocusNode>?
      onEditingCompleteWith;

  /// 提交
  final ValueChanged<String>? onSubmitted;
  final ValueTwoCallback<TextEditingController, FocusNode>? onSubmittedWith;

  /// 输入框点击数事件
  final GestureTapCallback? onTap;
  final ValueTwoCallback<TextEditingController, FocusNode>? onTapWith;

  /// 输入框变化监听
  final ValueChanged<String>? onChanged;

  /// 输入框填充色
  final Color? fillColor;

  /// 光标颜色
  final Color? cursorColor;

  /// 默认为 1
  final int? maxLines;
  final int? minLines;

  /// 是否自动获取焦点 默认false
  final bool autoFocus;

  /// 焦点管理
  final FocusNode? focusNode;

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

  /// 设置[textInputType]可同时开启 [keyboardType]和[inputFormatters]
  final TextInputLimitFormatter textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

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
  final bool cursorOpacityAnimates;

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
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final UndoHistoryController? undoController;

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
    List<DecoratedPendant> suffixes = [
      if (widget.enableClearIcon)
        DecoratedPendant(
            mode: OverlayVisibilityMode.editing,
            positioned: DecoratedPendantPosition.inner,
            widget: buildClearIcon),
      if (widget.enableEye)
        DecoratedPendant(
            mode: OverlayVisibilityMode.editing,
            positioned: DecoratedPendantPosition.inner,
            widget: buildEyeIcon),
      if (widget.sendVerificationCodeTap != null)
        DecoratedPendant(
            positioned: widget.sendVerificationCodePosition,
            widget: buildSendSMS),
      if (widget.searchTextTap != null)
        DecoratedPendant(
            positioned: widget.searchTextPosition, widget: buildSearchText),
      ...widget.suffix
    ];

    /// 前缀
    List<DecoratedPendant> prefixes = [
      if (widget.enableSearchIcon)
        DecoratedPendant(
            positioned: DecoratedPendantPosition.inner,
            widget: buildSearchIcon),
      if (widget.prefix.isNotEmpty) ...widget.prefix
    ];

    /// 处理后缀
    List<DecoratedPendant> innerEditSuffixes =
        suffixes.where(innerPendant).toList();

    suffixes.removeWhere(innerPendant);

    /// 处理前缀
    List<DecoratedPendant> innerEditPrefixes =
        prefixes.where(innerPendant).toList();

    prefixes.removeWhere(innerPendant);

    return Universal(
        heroTag: widget.heroTag,
        width: widget.width,
        height: widget.height,
        child: FlDecoratedBoxState(
            decoration: FlBoxDecoration(
                borderType: widget.borderType,
                fillColor: widget.fillColor,
                borderRadius: widget.borderRadius,
                margin: widget.margin,
                padding: widget.padding,
                borderSide: widget.borderSide,
                constraints: widget.constraints),
            suffixes: suffixes,
            prefixes: prefixes,
            focusNode: focusNode,
            focusBorderSide: widget.hasFocusChangeBorder
                ? widget.focusBorderSide ??
                    BorderSide(color: context.theme.primaryColor)
                : null,
            child: buildEditableText(
                innerSuffix: buildInner(innerEditSuffixes),
                innerPrefix: buildInner(innerEditPrefixes))));
  }

  bool innerPendant(DecoratedPendant pendant) =>
      pendant.positioned == DecoratedPendantPosition.inner &&
      pendant.mode == OverlayVisibilityMode.editing;

  Widget buildEditableText({Widget? innerSuffix, Widget? innerPrefix}) =>
      ValueListenableBuilder(
          valueListenable: obscureText,
          builder: (_, bool value, __) => widget.useTextField
              ? buildTextField(
                  innerSuffix: innerSuffix, innerPrefix: innerPrefix)
              : buildCupertinoTextField(
                  innerSuffix: innerSuffix, innerPrefix: innerPrefix));

  Widget? buildInner(Iterable<DecoratedPendant> list) {
    if (list.isEmpty) return null;
    if (list.length == 1) return list.first.widget;
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: list.builder((entry) => entry.widget));
  }

  Widget buildTextField({Widget? innerSuffix, Widget? innerPrefix}) =>
      TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              isDense: true,
              suffix: innerSuffix,
              prefix: innerPrefix,
              hintText: widget.hintText,
              border: InputBorder.none,
              hintStyle: hintStyle),
          style: style,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          keyboardAppearance: widget.keyboardAppearance,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          enabled: widget.enabled,
          autofocus: widget.autoFocus,
          obscureText: widget.enableEye && obscureText.value,
          obscuringCharacter: widget.obscuringCharacter,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          textAlign: textAlign,
          onTap: onTap,
          onSubmitted: onSubmitted,
          showCursor: widget.showCursor,
          cursorColor: widget.cursorColor ?? context.theme.primaryColor,
          cursorHeight: widget.cursorHeight,
          cursorWidth: widget.cursorWidth,
          cursorRadius: widget.cursorRadius,
          cursorOpacityAnimates: widget.cursorOpacityAnimates,
          clipBehavior: widget.clipBehavior,
          autocorrect: widget.autocorrect,
          autofillHints: widget.autofillHints,
          dragStartBehavior: widget.dragStartBehavior,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
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
          strutStyle: strutStyle,
          textAlignVertical: widget.textAlignVertical,
          textDirection: widget.textDirection,
          contextMenuBuilder:
              widget.contextMenuBuilder ?? _defaultContextMenuBuilder,
          magnifierConfiguration: widget.magnifierConfiguration,
          onTapOutside: widget.onTapOutside,
          spellCheckConfiguration: widget.spellCheckConfiguration,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          undoController: widget.undoController);

  Widget buildCupertinoTextField({Widget? innerSuffix, Widget? innerPrefix}) =>
      CupertinoTextField.borderless(
          controller: controller,
          focusNode: focusNode,
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4)),
          suffixMode: OverlayVisibilityMode.editing,
          suffix: innerSuffix,
          prefixMode: OverlayVisibilityMode.editing,
          prefix: innerPrefix,
          placeholder: widget.hintText,
          placeholderStyle: hintStyle,
          style: style,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          keyboardAppearance: widget.keyboardAppearance,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          enabled: widget.enabled,
          autofocus: widget.autoFocus,
          obscureText: widget.enableEye && obscureText.value,
          obscuringCharacter: widget.obscuringCharacter,
          maxLines: maxLines,
          minLines: minLines,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          textAlign: textAlign,
          onTap: onTap,
          onSubmitted: onSubmitted,
          onEditingComplete: onEditingComplete,
          showCursor: widget.showCursor,
          cursorColor: widget.cursorColor ?? context.theme.primaryColor,
          cursorHeight: widget.cursorHeight,
          cursorWidth: widget.cursorWidth,
          cursorRadius: widget.cursorRadius,
          cursorOpacityAnimates: widget.cursorOpacityAnimates,
          clipBehavior: widget.clipBehavior,
          autocorrect: widget.autocorrect,
          autofillHints: widget.autofillHints,
          dragStartBehavior: widget.dragStartBehavior,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
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
          strutStyle: strutStyle,
          textAlignVertical: widget.textAlignVertical,
          textDirection: widget.textDirection,
          padding: widget.contentPadding,
          contextMenuBuilder:
              widget.contextMenuBuilder ?? _defaultContextMenuBuilder,
          magnifierConfiguration: widget.magnifierConfiguration,
          onTapOutside: widget.onTapOutside,
          spellCheckConfiguration: widget.spellCheckConfiguration,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          undoController: widget.undoController);

  ValueChanged<String>? get onSubmitted =>
      widget.onSubmitted == null && widget.onSubmittedWith == null
          ? null
          : (String value) {
              widget.onSubmitted?.call(value);
              widget.onSubmittedWith?.call(controller, focusNode);
            };

  VoidCallback? get onEditingComplete =>
      widget.onEditingComplete == null && widget.onEditingCompleteWith == null
          ? null
          : () {
              widget.onEditingComplete?.call();
              widget.onEditingCompleteWith?.call(controller, focusNode);
            };

  GestureTapCallback? get onTap =>
      widget.onTap == null && widget.onTapWith == null
          ? null
          : () {
              widget.onTap?.call();
              widget.onTapWith?.call(controller, focusNode);
            };

  Widget _defaultContextMenuBuilder(
          BuildContext context, EditableTextState editableTextState) =>
      CupertinoAdaptiveTextSelectionToolbar.buttonItems(
          buttonItems: editableTextState.contextMenuButtonItems,
          anchors: editableTextState.contextMenuAnchors);

  StrutStyle? get strutStyle =>
      widget.strutStyle ?? Universally.to.config.textField?.strutStyle;

  TextStyle get hintStyle =>
      const TStyle(fontSize: 13).merge(widget.hintStyle ??
          Universally.to.config.textField?.hintStyle ??
          context.theme.textTheme.bodySmall);

  TextStyle get style => const TStyle().merge(widget.style ??
      Universally.to.config.textField?.style ??
      context.theme.textTheme.bodyMedium);

  List<TextInputFormatter> get inputFormatters {
    final list = widget.textInputType.toTextInputFormatter();
    if (widget.inputFormatters != null) {
      list.addAll(widget.inputFormatters!);
    }
    return list;
  }

  TextInputType get keyboardType =>
      widget.keyboardType ?? widget.textInputType.toKeyboardType();

  int? get minLines =>
      (widget.enableEye && obscureText.value) ? 1 : widget.minLines;

  int? get maxLines =>
      (widget.enableEye && obscureText.value) ? 1 : widget.maxLines;

  TextAlign get textAlign {
    TextAlign align = widget.textAlign;
    if (widget.maxLines != null && widget.maxLines! > 1) {
      align = TextAlign.start;
    }
    return align;
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
    bool isLeft = (Universally.to.config.textField?.searchTextPosition ??
            widget.searchTextPosition) !=
        DecoratedPendantPosition.inner;
    final current = widget.searchText ??
        Universally.to.config.textField?.searchText ??
        const TextNormal('搜索');
    return Universal(
        margin: EdgeInsets.only(left: isLeft ? 12 : 0, right: isLeft ? 0 : 10),
        onTap: () => widget.searchTextTap?.call(controller.text),
        alignment: Alignment.center,
        child: current);
  }

  Widget get buildSendSMS {
    bool isLeft =
        (Universally.to.config.textField?.sendVerificationCodePosition ??
                widget.sendVerificationCodePosition) !=
            DecoratedPendantPosition.inner;
    return SendVerificationCode(
        margin: EdgeInsets.only(left: isLeft ? 10 : 0, right: isLeft ? 0 : 10),
        duration: widget.sendVerificationCodeDuration,
        builder: (SendState state, int i) {
          final current = (widget.sendVerificationCodeTextBuilder ??
                  Universally
                      .to.config.textField?.sendVerificationCodeTextBuilder)
              ?.call(state, i);
          if (current != null) return current;
          switch (state) {
            case SendState.none:
              return TextNormal('发送验证码', color: context.theme.primaryColor);
            case SendState.sending:
              return TextNormal('发送中', color: context.theme.primaryColor);
            case SendState.resend:
              return TextNormal('重新发送', color: context.theme.primaryColor);
            case SendState.countDown:
              return TextNormal('$i s', color: context.theme.primaryColor);
          }
        },
        onTap: widget.sendVerificationCodeTap);
  }

  Widget get buildSearchIcon {
    final current = widget.searchIcon ??
        Universally.to.config.textField?.searchIcon ??
        Icon(UIS.search,
            size: 20, color: context.theme.textTheme.bodyMedium?.color);
    return Padding(padding: const EdgeInsets.only(left: 10), child: current);
  }

  Widget get buildClearIcon {
    final current = widget.clearIcon ??
        Universally.to.config.textField?.clearIcon ??
        IconBox(
            size: 18,
            icon: UIS.clear,
            color: context.theme.textTheme.bodyMedium?.color);
    return Universal(
        onTap: () {
          controller.clear();
          if (widget.onChanged != null) widget.onChanged!('');
        },
        padding: const EdgeInsets.only(right: 10),
        child: current);
  }

  Widget get buildEyeIcon => Universal(
      margin: const EdgeInsets.only(right: 10),
      onTap: () {
        obscureText.value = !obscureText.value;
      },
      child: ValueListenableBuilder(
          valueListenable: obscureText,
          builder: (_, bool value, __) {
            return (widget.eyeIconBuilder ??
                        Universally.to.config.textField?.eyeIconBuilder)
                    ?.call(value) ??
                Icon(value ? UIS.eyeClose : UIS.eyeOpen,
                    color: context.theme.textTheme.bodyMedium?.color, size: 20);
          }));

  @override
  void didUpdateWidget(covariant BaseTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    obscureText.dispose();
    super.dispose();
    if (widget.disposeController) controller.dispose();
  }
}

class TextFieldConfig {
  const TextFieldConfig(
      {this.style,
      this.hintStyle,
      this.strutStyle,
      this.searchText,
      this.searchTextPosition,
      this.sendVerificationCodeTextBuilder,
      this.sendVerificationCodePosition,
      this.eyeIconBuilder,
      this.clearIcon,
      this.searchIcon});

  /// 搜索文字
  final Widget? searchText;
  final DecoratedPendantPosition? searchTextPosition;

  ///  发送验证码
  final ValueTwoCallbackT<Widget, SendState, int>?
      sendVerificationCodeTextBuilder;

  /// 发送验证码位置
  final DecoratedPendantPosition? sendVerificationCodePosition;

  /// 显示和隐藏 eye
  final ValueCallbackTV<Widget, bool>? eyeIconBuilder;

  /// 清除 icon
  final Widget? clearIcon;

  /// 搜索 icon
  final Widget? searchIcon;

  /// 输入文字样式
  final TextStyle? style;

  /// 提示文字样式
  final TextStyle? hintStyle;

  /// strutStyle
  final StrutStyle? strutStyle;
}
