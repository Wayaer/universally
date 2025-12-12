import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

class TextFieldPendant extends DecoratorPendant<TextEditingController> {
  const TextFieldPendant({
    super.child,
    super.positioned = DecoratorPendantPosition.inner,
    super.maintainSize = false,
    super.needValue,
    super.needFocus,
    super.needEditing,
  });

  const TextFieldPendant.builder({
    super.builder,
    super.positioned = DecoratorPendantPosition.inner,
    super.maintainSize = false,
    super.needValue,
    super.needFocus,
    super.needEditing,
  }) : super.builder();
}

extension ExtensionWidgetTextFieldPendant on Widget {
  TextFieldPendant toTextFieldPendant({
    DecoratorPendantPosition positioned = DecoratorPendantPosition.outer,
    bool maintainSize = false,
    bool? needFocus,
    bool? needEditing,
    DecoratorPendantValueCallback<TextEditingController?>? needValue,
  }) => TextFieldPendant(
    child: this,
    maintainSize: maintainSize,
    positioned: positioned,
    needValue: needValue,
    needEditing: needEditing,
    needFocus: needFocus,
  );

  TextFieldPendant toTextFieldPendantBuilder({
    DecoratorPendantPosition positioned = DecoratorPendantPosition.outer,
    bool maintainSize = false,
    bool? needFocus,
    bool? needEditing,
    DecoratorPendantValueCallback<TextEditingController?>? needValue,
  }) => TextFieldPendant.builder(
    builder: (DecoratorBoxStatus<TextEditingController> status) => this,
    maintainSize: maintainSize,
    positioned: positioned,
    needValue: needValue,
    needEditing: needEditing,
    needFocus: needFocus,
  );
}

class BaseTextField extends StatefulWidget {
  static Widget defaultTextFieldContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    if (defaultTargetPlatform == TargetPlatform.iOS && SystemContextMenu.isSupported(context)) {
      return SystemContextMenu.editableText(editableTextState: editableTextState);
    }
    return AdaptiveTextSelectionToolbar.editableText(editableTextState: editableTextState);
  }

  const BaseTextField({
    super.key,
    this.value,
    this.controller,
    this.searchText,
    this.searchTextTap,
    this.searchTextPosition = DecoratorPendantPosition.outer,
    this.sendVerificationCodeTap,
    this.sendVerificationCodeTextBuilder,
    this.sendVerificationCodePosition = DecoratorPendantPosition.outer,
    this.sendVerificationCodeDuration = const Duration(seconds: 60),
    this.obscureText,
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
    this.heroTag,
    this.disposeController = true,
    this.hasFocusedChangeBorder = true,
    this.fillColor,
    this.headers = const [],
    this.footers = const [],
    this.suffixes = const [],
    this.prefixes = const [],
    this.constraints,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.borderType = BorderType.outline,
    this.borderSide,
    this.focusedBorderSide,
    this.contentPadding = const EdgeInsets.all(6),
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
    this.maxLengthUseInputFormatters = true,
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
    this.stylusHandwritingEnabled = EditableText.defaultStylusHandwritingEnabled,
    this.enableIMEPersonalizedLearning = true,
    this.inputLimitFormatter = TextInputLimitFormatter.text,
    this.keyboardType,
    this.contextMenuBuilder = defaultTextFieldContextMenuBuilder,
    this.magnifierConfiguration,
    this.onTapOutside,
    this.spellCheckConfiguration,
    this.contentInsertionConfiguration,
    this.undoController,
    this.cursorColor,
    this.mouseCursor,
    this.buildCounter,
    this.canRequestFocus = true,
    this.ignorePointers,
    this.onAppPrivateCommand,
    this.onTapAlwaysCalled = false,
    this.statesController,
    this.interval = 8,
    this.cursorErrorColor,
    this.groupId = EditableText,
    this.onTapUpOutside,
    this.decoration,
  });

  /// ***** 附加功能 *****
  /// 初始化默认的文本
  final String? value;

  /// [searchText] [searchIcon] [clearIcon] [enableEye]
  final double interval;

  /// **** 搜索文字 ****
  /// 添加 搜索文字 点击事件
  final ValueCallback<String>? searchTextTap;
  final Widget? searchText;
  final DecoratorPendantPosition searchTextPosition;

  /// **** 发送验证码 ****
  /// 添加 发送验证码 点击事件
  final SendVerificationCodeValueCallback? sendVerificationCodeTap;
  final ValueTwoCallbackT<Widget, SendState, int>? sendVerificationCodeTextBuilder;
  final DecoratorPendantPosition sendVerificationCodePosition;

  /// 验证码等待时间
  final Duration sendVerificationCodeDuration;

  /// **** 密码可见性 ****
  /// 是否显示密码可见性
  final bool? obscureText;

  final ValueCallbackTV<Widget, bool>? eyeIconBuilder;

  /// **** 清除Icon显示 ****
  final bool enableClearIcon;
  final Widget? clearIcon;

  /// **** 输入框前的搜索Icon ****
  final bool enableSearchIcon;
  final Widget? searchIcon;

  /// [child] 头部
  final List<TextFieldPendant> headers;

  /// [child] 尾部
  final List<TextFieldPendant> footers;

  /// [child] 后缀
  final List<TextFieldPendant> suffixes;

  /// [child]  前缀
  final List<TextFieldPendant> prefixes;

  /// 添加hero
  final String? heroTag;

  /// 头部和底部 添加组件
  final BoxConstraints? constraints;

  /// 边框样式
  final BorderRadius? borderRadius;
  final BorderType borderType;
  final bool hasFocusedChangeBorder;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;

  /// 整个组件的padding 包含[header]、[footer]
  final EdgeInsetsGeometry? padding;

  /// 整个组件的margin 包含[header]、[footer]
  final EdgeInsetsGeometry? margin;

  /// 宽度
  final double width;

  /// 高度
  final double? height;

  /// dispose 时调用 controller 的 dispose
  final bool disposeController;

  /// ***** [TextField] *****
  final EdgeInsetsGeometry contentPadding;

  /// InputDecoration
  final InputDecoration? decoration;

  final TextEditingController? controller;

  /// 是否可输入
  final bool enabled;

  /// 最长输入的字符串
  final int? maxLength;

  /// 是否使用 [InputFormatters] 限制输入长度
  final bool maxLengthUseInputFormatters;

  final MaxLengthEnforcement? maxLengthEnforcement;

  /// 输入文字样式
  final TextStyle? style;

  /// 提示文字样式
  final TextStyle? hintStyle;

  /// 提示文字
  final String? hintText;

  /// 按回车时调用 先调用此方法  然后调用onSubmitted方法
  final Callback? onEditingComplete;
  final ValueTwoCallback<TextEditingController, FocusNode>? onEditingCompleteWith;

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
  final MouseCursor? mouseCursor;

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

  /// 设置[inputLimitFormatter]可同时开启 [keyboardType]和[inputFormatters]
  final TextInputLimitFormatter inputLimitFormatter;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final TextDirection? textDirection;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// 隐藏输入内容时显示的字符串
  final String obscuringCharacter;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius cursorRadius;
  final bool cursorOpacityAnimates;

  /// The color of the cursor when the [InputDecorator] is showing an error.
  ///
  /// If this is null it will default to [TextStyle.color] of
  /// [InputDecoration.errorStyle]. If that is null, it will use
  /// [ColorScheme.error] of [ThemeData.colorScheme].
  final Color? cursorErrorColor;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.material.textfield.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.stylusHandwritingEnabled}
  final bool stylusHandwritingEnabled;

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
  /// This setting is only honored on iOS devices.
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
  final InputCounterWidgetBuilder? buildCounter;
  final bool canRequestFocus;
  final bool? ignorePointers;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final bool onTapAlwaysCalled;
  final WidgetStatesController? statesController;

  /// {@macro flutter.widgets.editableText.groupId}
  final Object groupId;

  /// {@macro flutter.widgets.editableText.onTapUpOutside}
  final TapRegionUpCallback? onTapUpOutside;

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  late TextEditingController controller;
  ValueNotifier<bool>? obscureTextNotifier;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    if (widget.obscureText != null) {
      obscureTextNotifier = ValueNotifier(widget.obscureText!);
    }
    if (widget.value != null) controller.text = widget.value!;
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Universal(
      heroTag: widget.heroTag,
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: buildDecoratorBox,
    );
  }

  Widget get buildDecoratorBox {
    /// 后缀
    final suffixes = [
      if (widget.enableClearIcon)
        TextFieldPendant(needEditing: true, positioned: DecoratorPendantPosition.inner, child: buildClearIcon),
      if (obscureTextNotifier != null)
        TextFieldPendant(needEditing: true, positioned: DecoratorPendantPosition.inner, child: buildEyeIcon),
      if (widget.sendVerificationCodeTap != null)
        TextFieldPendant(positioned: widget.sendVerificationCodePosition, child: buildSendSMS),
      if (widget.searchTextTap != null) TextFieldPendant(positioned: widget.searchTextPosition, child: buildSearchText),
      ...widget.suffixes,
    ];

    /// 前缀
    final prefixes = [
      if (widget.enableSearchIcon) TextFieldPendant(positioned: DecoratorPendantPosition.inner, child: buildSearchIcon),
      ...widget.prefixes,
    ];

    /// headers
    final headers = widget.headers;

    /// footers
    final footers = widget.footers;

    /// 未获取焦点后的 borderSide
    final borderSide =
        widget.borderSide ??
        context.theme.inputDecorationTheme.enabledBorder?.borderSide ??
        context.theme.inputDecorationTheme.border?.borderSide;

    /// 获取焦点后的 borderSide
    final focusedBorderSide =
        widget.focusedBorderSide ??
        context.theme.inputDecorationTheme.focusedBorder?.borderSide ??
        context.theme.inputDecorationTheme.border?.borderSide;
    bool useListenable =
        widget.hasFocusedChangeBorder ||
        suffixes.where((e) => e.needChangedState).isNotEmpty ||
        prefixes.where((e) => e.needChangedState).isNotEmpty ||
        headers.where((e) => e.needChangedState).isNotEmpty ||
        footers.where((e) => e.needChangedState).isNotEmpty;
    return DecoratorBox<TextEditingController>(
      listenable: useListenable ? Listenable.merge([focusNode, controller]) : null,
      decoration: (Widget child, DecoratorBoxStatus<TextEditingController> status) => Universal(
        constraints: widget.constraints,
        padding: widget.padding,
        borderRadius: widget.borderRadius,
        isClipRRect: widget.borderRadius != null,
        decoration: BoxDecoration(
          border: widget.borderType.toBorder(
            status.hasFocus && widget.hasFocusedChangeBorder ? focusedBorderSide ?? borderSide : borderSide,
          ),
          color: widget.fillColor,
        ),
        child: child,
      ),
      headers: headers,
      footers: footers,
      suffixes: suffixes,
      prefixes: prefixes,
      onFocus: () => focusNode.hasFocus,
      onEditing: () => controller.text.isNotEmpty,
      onValue: () => controller,
      child: obscureTextNotifier != null
          ? ValueListenableBuilder(
              valueListenable: obscureTextNotifier!,
              builder: (BuildContext context, bool value, Widget? child) => buildTextField,
            )
          : buildTextField,
    );
  }

  Widget get buildTextField => TextField(
    controller: controller,
    focusNode: focusNode,
    decoration: InputDecoration(
      contentPadding: widget.contentPadding,
      isDense: true,
      hintText: widget.hintText,
      hintStyle: hintStyle,
    ).noneBorder.merge(widget.decoration),
    style: style,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    keyboardAppearance: widget.keyboardAppearance,
    textInputAction: widget.textInputAction,
    textCapitalization: widget.textCapitalization,
    enabled: widget.enabled,
    autofocus: widget.autoFocus,
    obscureText: obscureText,
    obscuringCharacter: widget.obscuringCharacter,
    maxLines: maxLines,
    minLines: minLines,
    maxLengthEnforcement: widget.maxLengthEnforcement,
    maxLength: maxLength,
    onChanged: widget.onChanged,
    textAlign: textAlign,
    onTap: onTap,
    onSubmitted: onSubmitted,
    onEditingComplete: onEditingComplete,
    showCursor: widget.showCursor,
    cursorColor: widget.cursorColor ?? context.theme.primaryColor,
    mouseCursor: widget.mouseCursor,
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
    stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
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
    contextMenuBuilder: widget.contextMenuBuilder,
    magnifierConfiguration: widget.magnifierConfiguration,
    onTapOutside: widget.onTapOutside,
    spellCheckConfiguration: widget.spellCheckConfiguration,
    contentInsertionConfiguration: widget.contentInsertionConfiguration,
    undoController: widget.undoController,
    buildCounter: widget.buildCounter,
    canRequestFocus: widget.canRequestFocus,
    ignorePointers: widget.ignorePointers,
    onAppPrivateCommand: widget.onAppPrivateCommand,
    onTapAlwaysCalled: widget.onTapAlwaysCalled,
    statesController: widget.statesController,
    cursorErrorColor: widget.cursorErrorColor,
    groupId: widget.groupId,
    onTapUpOutside: widget.onTapUpOutside,
  );

  ValueChanged<String>? get onSubmitted => widget.onSubmitted == null && widget.onSubmittedWith == null
      ? null
      : (String value) {
          widget.onSubmitted?.call(value);
          widget.onSubmittedWith?.call(controller, focusNode);
        };

  VoidCallback? get onEditingComplete => widget.onEditingComplete == null && widget.onEditingCompleteWith == null
      ? null
      : () {
          widget.onEditingComplete?.call();
          widget.onEditingCompleteWith?.call(controller, focusNode);
        };

  GestureTapCallback? get onTap => widget.onTap == null && widget.onTapWith == null
      ? null
      : () {
          widget.onTap?.call();
          widget.onTapWith?.call(controller, focusNode);
        };

  StrutStyle? get strutStyle => widget.strutStyle ?? Universally.get.config.textField?.strutStyle;

  TextStyle get hintStyle => const TStyle(
    fontSize: 13,
  ).merge(context.theme.inputDecorationTheme.hintStyle ?? context.theme.textTheme.bodySmall).merge(widget.hintStyle);

  TextStyle get style => const TStyle()
      .merge(Universally.get.config.textField?.style ?? context.theme.textTheme.bodyMedium)
      .merge(widget.style);

  int? get maxLength {
    if (widget.maxLengthUseInputFormatters) return null;
    return widget.maxLength;
  }

  List<TextInputFormatter> get inputFormatters {
    final list = widget.inputLimitFormatter.toTextInputFormatter();
    if (widget.inputFormatters != null) {
      list.addAll(widget.inputFormatters!);
    }
    if (widget.maxLengthUseInputFormatters && widget.maxLength != null) {
      list.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }
    return list;
  }

  TextInputType get keyboardType => widget.keyboardType ?? widget.inputLimitFormatter.toKeyboardType();

  int? get minLines => obscureText ? 1 : widget.minLines;

  int? get maxLines => obscureText ? 1 : widget.maxLines;

  bool get obscureText => obscureTextNotifier?.value == true;

  TextAlign get textAlign {
    TextAlign align = widget.textAlign;
    if (widget.maxLines != null && widget.maxLines! > 1) {
      align = TextAlign.start;
    }
    return align;
  }

  /// 搜索
  Widget get buildSearchText {
    bool isLeft =
        (Universally.get.config.textField?.searchTextPosition ?? widget.searchTextPosition) !=
        DecoratorPendantPosition.inner;
    final current = widget.searchText ?? Universally.get.config.textField?.searchText ?? const TextMedium('搜索');
    return Universal(
      padding: EdgeInsets.only(left: isLeft ? widget.interval : 0, right: isLeft ? 0 : widget.interval),
      onTap: () => widget.searchTextTap?.call(controller.text),
      alignment: Alignment.center,
      child: current,
    );
  }

  /// 发送验证码
  Widget get buildSendSMS {
    bool isLeft =
        (Universally.get.config.textField?.sendVerificationCodePosition ?? widget.sendVerificationCodePosition) !=
        DecoratorPendantPosition.inner;
    return SendVerificationCode(
      margin: EdgeInsets.only(left: isLeft ? widget.interval : 0, right: isLeft ? 0 : widget.interval),
      value: widget.sendVerificationCodeDuration,
      builder: (SendState state, int i) {
        final current =
            (widget.sendVerificationCodeTextBuilder ??
                    Universally.get.config.textField?.sendVerificationCodeTextBuilder)
                ?.call(state, i);
        if (current != null) return current;
        switch (state) {
          case SendState.none:
            return TextMedium('发送验证码', color: context.theme.primaryColor);
          case SendState.sending:
            return TextMedium('发送中', color: context.theme.primaryColor);
          case SendState.resend:
            return TextMedium('重新发送', color: context.theme.primaryColor);
          case SendState.countDown:
            return TextMedium('$i s', color: context.theme.primaryColor);
        }
      },
      onSendTap: widget.sendVerificationCodeTap,
    );
  }

  /// 搜索文字
  Widget get buildSearchIcon {
    final current =
        widget.searchIcon ??
        Universally.get.config.textField?.searchIcon ??
        Icon(UIS.search, size: 20, color: context.theme.textTheme.bodyMedium?.color);
    return Padding(
      padding: EdgeInsets.only(left: widget.interval),
      child: current,
    );
  }

  /// 清除
  Widget get buildClearIcon {
    final current =
        widget.clearIcon ??
        Universally.get.config.textField?.clearIcon ??
        Icon(UIS.clear, size: 18, color: context.theme.textTheme.bodyMedium?.color);
    return Universal(
      onTap: () {
        controller.clear();
        if (widget.onChanged != null) widget.onChanged!('');
      },
      padding: EdgeInsets.only(right: widget.interval),
      child: current,
    );
  }

  /// 眼睛
  Widget get buildEyeIcon => Universal(
    padding: EdgeInsets.only(right: widget.interval),
    onTap: () {
      if (obscureTextNotifier == null) return;
      obscureTextNotifier!.value = !obscureTextNotifier!.value;
    },
    child: ValueListenableBuilder(
      valueListenable: obscureTextNotifier!,
      builder: (BuildContext context, bool value, Widget? child) {
        return (widget.eyeIconBuilder ?? Universally.get.config.textField?.eyeIconBuilder)?.call(value) ??
            Icon(value ? UIS.eyeClose : UIS.eyeOpen, color: context.theme.textTheme.bodyMedium?.color, size: 20);
      },
    ),
  );

  @override
  void didUpdateWidget(covariant BaseTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    obscureTextNotifier?.dispose();
    super.dispose();
    if (widget.disposeController) controller.dispose();
  }
}

class TextFieldConfig {
  const TextFieldConfig({
    this.style,
    this.strutStyle,
    this.searchText,
    this.searchTextPosition,
    this.sendVerificationCodeTextBuilder,
    this.sendVerificationCodePosition,
    this.eyeIconBuilder,
    this.clearIcon,
    this.searchIcon,
  });

  /// 搜索文字
  final Widget? searchText;
  final DecoratorPendantPosition? searchTextPosition;

  /// 发送验证码
  final ValueTwoCallbackT<Widget, SendState, int>? sendVerificationCodeTextBuilder;

  /// 发送验证码位置
  final DecoratorPendantPosition? sendVerificationCodePosition;

  /// 显示和隐藏 eye
  final ValueCallbackTV<Widget, bool>? eyeIconBuilder;

  /// 清除 icon
  final Widget? clearIcon;

  /// 搜索 icon
  final Widget? searchIcon;

  /// 输入文字样式
  final TextStyle? style;

  /// strutStyle
  final StrutStyle? strutStyle;
}

extension ExtensionDecoratorPendant on DecoratorPendant<TextEditingController> {
  /// 获取是否需要改变状态
  bool get needChangedState => needFocus != null || needEditing != null || needValue != null;
}

extension ExtensionTextInputDecoration on InputDecoration {
  InputDecoration merge(InputDecoration? decoration) => copyWith(
    isDense: decoration?.isDense ?? isDense,
    contentPadding: decoration?.contentPadding ?? contentPadding,
    border: decoration?.border ?? border,
    enabledBorder: decoration?.enabledBorder ?? enabledBorder,
    focusedBorder: decoration?.focusedBorder ?? focusedBorder,
    disabledBorder: decoration?.disabledBorder ?? disabledBorder,
    errorBorder: decoration?.errorBorder ?? errorBorder,
    focusedErrorBorder: decoration?.focusedErrorBorder ?? focusedErrorBorder,
    suffixIcon: decoration?.suffixIcon ?? suffixIcon,
    suffixIconConstraints: decoration?.suffixIconConstraints ?? suffixIconConstraints,
    suffixIconColor: decoration?.suffixIconColor ?? suffixIconColor,
    prefixIcon: decoration?.prefixIcon ?? prefixIcon,
    prefixIconConstraints: decoration?.prefixIconConstraints ?? prefixIconConstraints,
    prefixIconColor: decoration?.prefixIconColor ?? prefixIconColor,
    helperStyle: decoration?.helperStyle ?? helperStyle,
    helperMaxLines: decoration?.helperMaxLines ?? helperMaxLines,
    errorStyle: decoration?.errorStyle ?? errorStyle,
    errorMaxLines: decoration?.errorMaxLines ?? errorMaxLines,
    floatingLabelStyle: decoration?.floatingLabelStyle ?? floatingLabelStyle,
    floatingLabelBehavior: decoration?.floatingLabelBehavior ?? floatingLabelBehavior,
    floatingLabelAlignment: decoration?.floatingLabelAlignment ?? floatingLabelAlignment,
    hintStyle: decoration?.hintStyle ?? hintStyle,
    hintMaxLines: decoration?.hintMaxLines ?? hintMaxLines,
    hintFadeDuration: decoration?.hintFadeDuration ?? hintFadeDuration,
    hintTextDirection: decoration?.hintTextDirection ?? hintTextDirection,
    hintText: decoration?.hintText ?? hintText,
    helperText: decoration?.helperText ?? helperText,
    errorText: decoration?.errorText ?? errorText,
    labelText: decoration?.labelText ?? labelText,
    labelStyle: decoration?.labelStyle ?? labelStyle,
    counterText: decoration?.counterText ?? counterText,
    counterStyle: decoration?.counterStyle ?? counterStyle,
    counter: decoration?.counter ?? counter,
    filled: decoration?.filled ?? filled,
    fillColor: decoration?.fillColor ?? fillColor,
    prefixText: decoration?.prefixText ?? prefixText,
    prefixStyle: decoration?.prefixStyle ?? prefixStyle,
    suffixText: decoration?.suffixText ?? suffixText,
    suffixStyle: decoration?.suffixStyle ?? suffixStyle,
    prefix: decoration?.prefix ?? prefix,
    suffix: decoration?.suffix ?? suffix,
    isCollapsed: decoration?.isCollapsed ?? isCollapsed,
    alignLabelWithHint: decoration?.alignLabelWithHint ?? alignLabelWithHint,
    constraints: decoration?.constraints ?? constraints,
    enabled: decoration?.enabled ?? enabled,
    focusColor: decoration?.focusColor ?? focusColor,
    helper: decoration?.helper ?? helper,
    hoverColor: decoration?.hoverColor ?? hoverColor,
    icon: decoration?.icon ?? icon,
    iconColor: decoration?.iconColor ?? iconColor,
    label: decoration?.label ?? label,
    error: decoration?.error ?? error,
  );
}
