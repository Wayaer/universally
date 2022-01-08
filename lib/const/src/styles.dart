import 'package:flutter/material.dart';
import 'package:universally/const/const.dart';

class UStyle {
  factory UStyle() => _singleton ??= UStyle._();

  UStyle._();

  static UStyle? _singleton;

  /// 统一阴影样式
  /// Unified Shadow Style
  List<BoxShadow> getBoxShadow({Color? color}) => [
        BoxShadow(
            color: color ?? UCS.lineColor.withOpacity(0.4),
            offset: const Offset(0.0, 0.0), //阴影xy轴偏移量
            blurRadius: 3.0, //阴影模糊程度
            spreadRadius: 2.0 //阴影扩散程度
            )
      ];
}
