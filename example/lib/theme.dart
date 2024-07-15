import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.red,
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: Colors.red,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.red, width: 2.0))),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.red,
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: Colors.red,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.red, width: 2.0))),
);
