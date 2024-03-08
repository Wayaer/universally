import 'package:flutter/material.dart';

class BaseThemeData {
  BaseThemeData._();

  static ThemeData light({ThemeData? themeData, bool? useMaterial3}) =>
      ThemeData(
        brightness: Brightness.light,
        useMaterial3: useMaterial3,
      ).copyWith();

  static ThemeData dark({ThemeData? themeData, bool? useMaterial3}) =>
      ThemeData(
        brightness: Brightness.dark,
        useMaterial3: useMaterial3,
      ).copyWith();
}

