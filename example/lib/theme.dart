import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.deepPurpleAccent,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent, brightness: Brightness.dark),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: Colors.deepPurpleAccent,
    indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0)),
  ),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.deepPurpleAccent,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: Colors.deepPurpleAccent,
    indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0)),
  ),
);
