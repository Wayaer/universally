import 'package:flutter/material.dart';
import 'package:universally/const/const.dart';

class UStyle {
  ///统一阴影样式
  List<BoxShadow> getBoxShadow({Color? color}) => [
        BoxShadow(
            color: color ?? UCS.lineColor.withOpacity(0.4),
            offset: const Offset(0.0, 0.0), //阴影xy轴偏移量
            blurRadius: 3.0, //阴影模糊程度
            spreadRadius: 2.0 //阴影扩散程度
            )
      ];

  /// 车牌号软键盘
  List<BoxShadow> carNumBoxShadow() => [
        const BoxShadow(
            color: Color(0x50898A8D),
            offset: Offset(0.0, 0.0), //阴影xy轴偏移量
            blurRadius: 2.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
            )
      ];
}
