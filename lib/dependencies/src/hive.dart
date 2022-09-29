import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveBox {
  bool isInitialize = false;
  String? _name;
  bool _lazy = false;
  bool _isOpen = false;

  Future<void> initialize(String name,
      {String? subDir, bool lazy = false}) async {
    if (!isInitialize) {
      _name = name;
      _lazy = lazy;
      await Hive.initFlutter(subDir);
      isInitialize = true;
      if (lazy) {
        await openLazyBox();
      } else {
        await openBox();
      }
    }
  }

  Future<Box> openBox() async {
    assert(_name != null && isInitialize, '请先初始化');
    final box = await Hive.openBox(_name!);
    _isOpen = true;
    return box;
  }

  Future<LazyBox> openLazyBox() async {
    assert(_name != null && isInitialize, '请先初始化');
    final box = Hive.openLazyBox(_name!);
    _isOpen = true;
    return box;
  }

  Box<E> box<E>() {
    assert(_name != null && isInitialize, '请先初始化');
    assert(!_lazy, '这是个 lazyBox');
    if (!_isOpen) openBox();
    return Hive.box<E>(_name!);
  }

  LazyBox<E> lazyBox<E>() {
    assert(_name != null && isInitialize, '请先初始化');
    assert(_lazy, '这不是个 lazyBox');
    if (!_isOpen) openLazyBox();
    return Hive.lazyBox<E>(_name!);
  }

  String get name => box().name;

  bool get lazy => box().lazy;

  String? get path => box().path;

  bool get isOpen => box().isOpen && _isOpen;

  bool get isEmpty => box().isEmpty;

  bool get isNotEmpty => box().isNotEmpty;

  Iterable<dynamic> get keys => box().keys;

  /// Saves the [value] with an auto-increment key.
  Future<int> add<T>(T value) => box().add(value);

  /// Saves all the [values] with auto-increment keys.
  Future<Iterable<int>> addAll<T>(Iterable<T> values) => box().addAll(values);

  Future<void> put(dynamic key, dynamic value) => box().put(key, value);

  Future<void> putAll(Map entries) => box().putAll(entries);

  Future<void> putAt(int index, dynamic value) => box().putAt(index, value);

  Future<void> compact() => box().compact();

  Future<void> close() {
    _isOpen = false;
    return box().close();
  }

  /// all values
  List get values => box().values.toList();

  /// startKey -  endKey
  List valuesBetween({dynamic startKey, dynamic endKey}) =>
      box().valuesBetween(startKey: startKey, endKey: endKey).toList();

  /// get dynamic
  dynamic get(dynamic key) => box().get(key);

  /// getAt
  dynamic getAt(int index) => box().getAt(index);

  /// contains Key
  bool containsKey(dynamic key) => box().containsKey(key);

  /// remove
  Future<bool> remove(dynamic key) async {
    if (containsKey(key)) {
      box().delete(key);
      return !containsKey(key);
    } else {
      return true;
    }
  }

  /// deleteAll
  Future<void> deleteAll(Iterable<dynamic> keys) => box().deleteAll(keys);

  /// clear
  Future<int> clear() => box().clear();

  /// get objet
  T? getObject<T>(dynamic key) {
    dynamic value;
    if (containsKey(key)) {
      final v = box().get(key);
      if (v is T) value = v;
    }
    return value;
  }

  /// set object
  Future<bool> setObject<T>(dynamic key, T value) async {
    if (!isOpen) await openBox();
    await box().put(key, value);
    return containsKey(key);
  }

  /// get string
  String? getString(dynamic key) => getObject<String>(key);

  /// set string
  Future<bool> setString(dynamic key, String value) =>
      setObject<String>(key, value);

  /// get bool
  bool? getBool(dynamic key) => getObject<bool>(key);

  /// set bool
  Future<bool> setBool(dynamic key, bool value) => setObject<bool>(key, value);

  /// get int
  int? getInt(dynamic key) => getObject<int>(key);

  /// set int
  Future<bool> setInt(dynamic key, int value) => setObject<int>(key, value);

  /// get double
  double? getDouble(dynamic key) => getObject<double>(key);

  /// set double
  Future<bool> setDouble(dynamic key, double value) =>
      setObject<double>(key, value);

  /// get map
  Map? getMap(dynamic key) => getObject<Map>(key);

  /// set map
  Future<bool> setMap(dynamic key, Map value) => setObject<Map>(key, value);

  /// get map and decode  常用于多层map嵌套
  Map<String, dynamic>? getDecodeMap(dynamic key) {
    final json = getObject<String>(key);
    if (json != null) return jsonDecode(json);
    return null;
  }

  /// set map and encode  常用于多层map嵌套
  Future<bool> setEncodeMap(dynamic key, Map<String, dynamic> value) =>
      setObject<String>(key, jsonEncode(value));

  /// get string list
  List<String> getStringList(dynamic key) => getObject<List<String>>(key) ?? [];

  /// set string list
  Future<bool> setStringList(dynamic key, List<String> value) =>
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
