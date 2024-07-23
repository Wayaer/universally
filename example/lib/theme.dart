import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.deepPurpleAccent,
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent)),
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: Colors.deepPurpleAccent,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0))),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.deepPurpleAccent,
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent)),
  ),
  tabBarTheme: const TabBarTheme(
      labelColor: Colors.deepPurpleAccent,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0))),
);
