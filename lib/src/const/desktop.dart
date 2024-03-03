import 'package:flutter/material.dart';

enum WindowsSize {
  /// set desktop size to iphone 4.7
  iPhone4P7(Size(375, 667)),

  /// set desktop size to iphone 5.4
  iPhone5P4(Size(360, 780)),

  /// set desktop size to iphone 5.5
  iPhone5P5(Size(414, 736)),

  /// set desktop size to iphone 5.8
  iPhone5P8(Size(375, 812)),

  /// set desktop size to iphone 6.1
  iPhone6P1(Size(414, 896)),

  /// set desktop size to iphone 6.7
  iPhone6P7(Size(430, 932)),

  /// set desktop size to 7.9
  iPad7P9(Size(1024, 768)),

  /// set desktop size to ipad 10.5
  iPad10P5(Size(834, 1112)),

  /// set desktop size to ipad 11
  iPad11(Size(834, 1194)),

  /// set desktop size to ipad 11
  iPad12P9(Size(1024, 1366)),
  ;

  const WindowsSize(this.size);

  final Size size;

  Size get value => size;

  Size scaling([double p = 1]) => Size(size.width / p, size.height / p);

  Size get exchange => Size(size.height, size.width);
}
