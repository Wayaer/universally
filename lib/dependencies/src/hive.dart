import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveBox {
  bool isInitialize = false;
  String? name;

  Future<void> initialize(String name, {String? subDir}) async {
    if (!isInitialize) {
      this.name = name;
      await Hive.initFlutter(subDir);
      await Hive.openBox(name);
      isInitialize = true;
    }
  }

  Box<E> box<E>() {
    assert(name != null && isInitialize, '请先初始化');
    return Hive.box<E>(name!);
  }

  bool get isOpen => box().isOpen;

  /// get objet
  T? getObject<T>(String key) {
    if (containsKey(key)) {
      final value = box().get(key);
      if (value is T) return value;
    }
    return null;
  }

  /// set object
  Future<bool> setObject<T>(String key, T value) async {
    await box().put(key, value);
    return containsKey(key);
  }

  Future<void> compact() async {
    await box().compact();
  }

  Future<void> close() async {
    await box().close();
  }

  /// get dynamic
  dynamic getDynamic(String key) => box().get(key);

  /// contains Key
  bool containsKey(String key) => box().containsKey(key);

  /// remove
  Future<bool> remove(String key) async {
    if (isOpen) {
      if (containsKey(key)) {
        box().delete(key);
        return !containsKey(key);
      } else {
        return true;
      }
    }
    return false;
  }

  Future<void> deleteAll(Iterable<dynamic> keys) async {
    await box().deleteAll(keys);
  }

  /// clear
  Future<bool> get clear async {
    if (isOpen) {
      final code = await box().clear();
      return code == 0;
    }
    return false;
  }

  /// get string
  String? getString(String key) => getObject<String>(key);

  /// set string
  Future<bool> setString(String key, String value) =>
      setObject<String>(key, value);

  /// get bool
  bool? getBool(String key) => getObject<bool>(key);

  /// set bool
  Future<bool> setBool(String key, bool value) => setObject<bool>(key, value);

  /// get int
  int? getInt(String key) => getObject<int>(key);

  /// set int
  Future<bool> setInt(String key, int value) => setObject<int>(key, value);

  /// get double
  double? getDouble(String key) => getObject<double>(key);

  /// set double
  Future<bool> setDouble(String key, double value) =>
      setObject<double>(key, value);

  /// get map
  Map? getMap(String key) => getObject<Map>(key);

  /// set map
  Future<bool> setMap(String key, Map value) => setObject<Map>(key, value);

  /// get map and decode  常用于多层map嵌套
  Map<String, dynamic>? getDecodeMap(String key) {
    final json = getObject<String>(key);
    if (json != null) return jsonDecode(json);
    return null;
  }

  /// set map and encode  常用于多层map嵌套
  Future<bool> setEncodeMap(String key, Map<String, dynamic> value) =>
      setObject<String>(key, jsonEncode(value));

  /// get string list
  List<String> getStringList(String key) => getObject<List<String>>(key) ?? [];

  /// set string list
  Future<bool> setStringList(String key, List<String> value) =>
      setObject<List<String>>(key, value);
}

/// Preferences 配置信息存储
class BHP extends HiveBox {
  factory BHP() => _singleton ??= BHP._();

  BHP._();

  static BHP? _singleton;

  Future<bool> init() async {
    await super.initialize('preferences');
    await UrlCache().init();
    return isInitialize;
  }
}

/// 接口数据缓存
class UrlCache extends HiveBox {
  factory UrlCache() => _singleton ??= UrlCache._();

  UrlCache._();

  static UrlCache? _singleton;

  Future<bool> init() async {
    await super.initialize('url_data');
    return isInitialize;
  }
}
