import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// 局部 异步加载数据
class BaseFutureBuilder<T> extends CustomFutureBuilder<T> {
  BaseFutureBuilder({
    super.key,
    super.initial,
    required super.future,
    required super.onDone,
    super.initState,
    super.didChangeDependencies,
    super.didUpdateWidget,
    super.deactivate,
    super.dispose,
    ValueTwoCallbackT<Widget, BuildContext, Function()>? onNone,
  }) : super(
         onNone: onNone ?? (_, _) => const Center(child: BasePlaceholder()),
         onWaiting: (_) => const Center(child: BaseLoading()),
         onError: (_, _, reset) => BaseError(onTap: reset),
       );
}

/// 局部 异步加载数据
class BaseStreamBuilder<T> extends CustomStreamBuilder<T> {
  BaseStreamBuilder({
    super.key,
    super.initial,
    required super.stream,
    required super.onDone,
    super.didUpdateWidgetCallStream = false,
    super.initialCallStream = false,
    super.initState,
    super.didChangeDependencies,
    super.didUpdateWidget,
    super.deactivate,
    super.dispose,
    ValueCallbackTV<Widget, BuildContext>? onNone,
  }) : super(
         onNone: onNone ?? (_) => const Center(child: BasePlaceholder()),
         onWaiting: (_) => const Center(child: BaseLoading()),
         onError: (_, _) => const BaseError(),
       );
}
