import 'dart:convert';

import 'package:universally/universally.dart';

/// Preferences 配置信息存储
class BasePreferences {
  factory BasePreferences() => instance;

  BasePreferences._();

  static BasePreferences? _singleton;

  static BasePreferences get instance => _singleton ??= BasePreferences._();

  bool get _isInitialize => _sharedPreferences != null;

  SharedPreferences? _sharedPreferences;

  SharedPreferences? get sharedPreferences => _sharedPreferences;

  Future<void> init() async {
    if (_isInitialize) return;
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Set<String> get keys => _sharedPreferences?.getKeys() ?? {};

  bool reload() {
    _sharedPreferences?.reload();
    return _isInitialize;
  }

  Future<bool> put(String key, String value) async => await _sharedPreferences?.setString(key, value) ?? false;

  Future<bool> putAll(Map<String, String> entries) async {
    bool result = true;
    for (var entry in entries.entries) {
      result = await put(entry.key, entry.value);
      if (!result) break;
    }
    return result;
  }

  /// clear
  Future<bool> clear() async => _sharedPreferences?.clear() ?? false;

  /// remove
  Future<bool> remove(String key) async => _sharedPreferences?.remove(key) ?? false;

  /// get dynamic
  Object? get(String key) => _sharedPreferences?.get(key);

  int? getInt(String key) => _sharedPreferences?.getInt(key);

  /// set int
  Future<bool> setInt(String key, int value) async => await _sharedPreferences?.setInt(key, value) ?? false;

  /// get bool
  bool? getBool(String key) => _sharedPreferences?.getBool(key);

  /// set bool
  Future<bool> setBool(String key, bool value) async => await _sharedPreferences?.setBool(key, value) ?? false;

  double? getDouble(String key) => _sharedPreferences?.getDouble(key);

  /// set double
  Future<bool> setDouble(String key, double value) async => await _sharedPreferences?.setDouble(key, value) ?? false;

  /// get string
  String? getString(String key) => _sharedPreferences?.getString(key);

  /// set string
  Future<bool> setString(String key, String value) async => await _sharedPreferences?.setString(key, value) ?? false;

  /// get string list
  List<String>? getStringList(String key) => _sharedPreferences?.getStringList(key);

  /// set string list
  Future<bool> setStringList(String key, List<String> value) async =>
      await _sharedPreferences?.setStringList(key, value) ?? false;

  /// set map
  Future<bool> setMap(String key, Map value) async {
    try {
      final json = jsonEncode(value);
      return await setString(key, json);
    } catch (e) {
      log('Preferences set map error: $e');
      return false;
    }
  }

  /// get map
  Map? getMap(String key) {
    try {
      final json = getString(key);
      if (json != null) return jsonDecode(json);
    } catch (e) {
      log('Preferences get map error: $e');
    }
    return null;
  }

  /// set list and encode  常用于 list 嵌套 map
  Future<bool> setEncodeList(String key, List<dynamic> value) async {
    try {
      return await setStringList(key, value.builder((e) => jsonEncode(e)));
    } catch (e) {
      log('Preferences set encode list error: $e');
      return false;
    }
  }

  /// get list and decode  常用于 list 嵌套 map
  List? getDecodeList(String key) {
    try {
      final list = getStringList(key);
      if (list == null) return null;
      return list.map((e) => jsonDecode(e)).toList();
    } catch (e) {
      log('Preferences get decode list error: $e');
      return null;
    }
  }
}
