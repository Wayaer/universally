// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter_waya/flutter_waya.dart' hide Lock;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:synchronized/synchronized.dart';
//
// /// SharedPreferences
// class SP {
//   factory SP() => _singleton ??= SP._();
//
//   SP._();
//
//   static SP? _singleton;
//
//   static final Lock _lock = Lock();
//
//   static SharedPreferences? _prefs;
//
//   ///Sp is initialized.
//   bool get isInitialized => _prefs != null;
//
//   /// get Sp.
//   SharedPreferences? get getSP => _prefs;
//
//   Future<void> getInstance() async {
//     if (_prefs == null) {
//       await _lock.synchronized(() async {
//         // keep local instance till it is fully initialized.
//         // 保持本地实例直到完全初始化。
//         _prefs = await SharedPreferences.getInstance();
//       });
//     }
//   }
//
//   /// set object.
//   Future<bool>? setObject(String key, Object value) =>
//       _prefs?.setString(key, json.encode(value));
//
//   /// get obj.
//   T? getObj<T>(String key, T Function(Map<dynamic, dynamic> v) f,
//       {T? defValue}) {
//     final Map<dynamic, dynamic>? map = getObject(key);
//     return map == null ? defValue : f(map);
//   }
//
//   /// get object.
//   Map<dynamic, dynamic>? getObject(String key) {
//     final String? data = _prefs?.getString(key);
//     return (data == null || data.isEmpty)
//         ? null
//         : json.decode(data) as Map<dynamic, dynamic>;
//   }
//
//   /// set object list.
//   Future<bool>? setObjectList(String key, List<Object> list) {
//     final List<String> dataList =
//         list.builder((Object value) => json.encode(value));
//     return _prefs?.setStringList(key, dataList);
//   }
//
//   /// get obj list.
//   List<T> getObjList<T>(String key, T Function(Map<dynamic, dynamic> v) f) {
//     final List<Map<dynamic, dynamic>>? dataList = getObjectList(key);
//     final List<T>? list =
//         dataList?.builder((Map<dynamic, dynamic> value) => f(value));
//     return list ?? <T>[];
//   }
//
//   /// get object list.
//   List<Map<dynamic, dynamic>>? getObjectList(String key) {
//     final List<String>? dataLis = _prefs?.getStringList(key);
//     return dataLis?.builder(
//         (String value) => json.decode(value) as Map<dynamic, dynamic>);
//   }
//
//   /// get string.
//   String? getString(String key) => _prefs?.getString(key);
//
//   /// set string.
//   Future<bool>? setString(String key, String value) =>
//       _prefs?.setString(key, value);
//
//   /// get bool.
//   bool? getBool(String key) => _prefs?.getBool(key);
//
//   /// set bool.
//   Future<bool>? setBool(String key, bool value) => _prefs?.setBool(key, value);
//
//   /// get int.
//   int? getInt(String key) => _prefs?.getInt(key);
//
//   /// set int.
//   Future<bool>? setInt(String key, int value) => _prefs?.setInt(key, value);
//
//   /// get double.
//   double? getDouble(String key) => _prefs?.getDouble(key);
//
//   /// set double.
//   Future<bool>? setDouble(String key, double value) =>
//       _prefs?.setDouble(key, value);
//
//   /// get string list.
//   List<String> getStringList(String key) =>
//       _prefs?.getStringList(key) ?? <String>[];
//
//   /// set string list.
//   Future<bool>? setStringList(String key, List<String> value) =>
//       _prefs?.setStringList(key, value);
//
//   /// get dynamic.
//   dynamic getDynamic(String key) => _prefs?.get(key);
//
//   /// have key.
//   bool? haveKey(String key) => _prefs?.getKeys().contains(key);
//
//   /// contains Key.
//   bool? containsKey(String key) => _prefs?.containsKey(key);
//
//   /// get keys.
//   Set<String>? get getKeys => _prefs?.getKeys();
//
//   /// remove.
//   Future<bool>? remove(String key) => _prefs?.remove(key);
//
//   /// clear.
//   Future<bool>? get clear => _prefs?.clear();
//
//   /// Fetches the latest values from the host platform.
//   Future<void>? get reload => _prefs?.reload();
// }
