import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
import 'package:flutter_waya/flutter_waya.dart' hide Lock;

/// SharedPreferences
class Sp {
  Sp._();

  static Sp? _singleton;
  static SharedPreferences? _prefs;
  static final Lock _lock = Lock();

  static Future<Sp?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          final Sp singleton = Sp._();
          await singleton._init;
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  Future<void> get _init async =>
      _prefs = await SharedPreferences.getInstance();

  /// put object.
  static Future<bool>? putObject(String key, Object value) {
    return _prefs?.setString(key, json.encode(value));
  }

  /// get obj.
  static T? getObj<T>(String key, T f(Map<dynamic, dynamic> v), {T? defValue}) {
    final Map<dynamic, dynamic>? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  /// get object.
  static Map<dynamic, dynamic>? getObject(String key) {
    final String? _data = _prefs?.getString(key);
    return (_data == null || _data.isEmpty)
        ? null
        : json.decode(_data) as Map<dynamic, dynamic>;
  }

  /// put object list.
  static Future<bool>? putObjectList(String key, List<Object> list) {
    final List<String> _dataList =
        list.builder((Object value) => json.encode(value));
    return _prefs?.setStringList(key, _dataList);
  }

  /// get obj list.
  static List<T>? getObjList<T>(String key, T f(Map<dynamic, dynamic> v),
      {List<T>? defValue}) {
    final List<Map<dynamic, dynamic>>? dataList = getObjectList(key);
    final List<T>? list =
        dataList?.builder((Map<dynamic, dynamic> value) => f(value));
    return list ?? defValue ?? <T>[];
  }

  /// get object list.
  static List<Map<dynamic, dynamic>>? getObjectList(String key) {
    final List<String>? dataLis = _prefs?.getStringList(key);
    return dataLis?.builder(
        (String value) => json.decode(value) as Map<dynamic, dynamic>);
  }

  /// get string.
  static String? getString(String key, {String? defValue = ''}) =>
      _prefs?.getString(key) ?? defValue;

  /// put string.
  static Future<bool>? putString(String key, String value) =>
      _prefs?.setString(key, value);

  /// get bool.
  static bool? getBool(String key, {bool? defValue = false}) =>
      _prefs?.getBool(key) ?? defValue;

  /// put bool.
  static Future<bool>? putBool(String key, bool value) =>
      _prefs?.setBool(key, value);

  /// get int.
  static int? getInt(String key, {int? defValue = 0}) =>
      _prefs?.getInt(key) ?? defValue;

  /// put int.
  static Future<bool>? putInt(String key, int value) =>
      _prefs?.setInt(key, value);

  /// get double.
  static double? getDouble(String key, {double? defValue = 0.0}) =>
      _prefs?.getDouble(key) ?? defValue;

  /// put double.
  static Future<bool>? putDouble(String key, double value) =>
      _prefs?.setDouble(key, value);

  /// get string list.
  static List<String>? getStringList(String key, {List<String>? defValue}) =>
      _prefs?.getStringList(key) ?? defValue ?? <String>[];

  /// put string list.
  static Future<bool>? putStringList(String key, List<String> value) =>
      _prefs?.setStringList(key, value);

  /// get dynamic.
  static dynamic getDynamic(String key, {Object? defValue}) =>
      _prefs?.get(key) ?? defValue;

  /// have key.
  static bool? haveKey(String key) => _prefs?.getKeys().contains(key);

  /// contains Key.
  static bool? containsKey(String key) => _prefs?.containsKey(key);

  /// get keys.
  static Set<String>? get getKeys => _prefs?.getKeys();

  /// remove.
  static Future<bool>? remove(String key) => _prefs?.remove(key);

  /// clear.
  static Future<bool>? get clear => _prefs?.clear();

  /// Fetches the latest values from the host platform.
  static Future<void>? get reload => _prefs?.reload();

  ///Sp is initialized.
  static bool get isInitialized => _prefs != null;

  /// get Sp.
  static SharedPreferences? get getSp => _prefs;
}
