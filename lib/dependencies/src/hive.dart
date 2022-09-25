import 'package:hive_flutter/hive_flutter.dart';

///  Basic Hive Preferences
class BHP {
  factory BHP() => _singleton ??= BHP._();

  BHP._();

  static BHP? _singleton;

  bool _isInitialize = false;
  final String _preferences = 'preferences';

  Future<void> initialize([String? subDir]) async {
    if (!_isInitialize) {
      await Hive.initFlutter(subDir);
      await openBox();
      _isInitialize = true;
    }
  }

  Future<bool> openBox() async {
    await Hive.openBox(_preferences);
    return isOpen;
  }

  Box<E> box<E>() => Hive.box<E>(_preferences);

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

  /// get string list
  List<String>? getStringList(String key) => getObject<List<String>>(key);

  /// set string list
  Future<bool> setStringList(String key, List<String> value) =>
      setObject<List<String>>(key, value);

  /// get dynamic
  dynamic getDynamic(String key) => box().get(key);

  /// contains Key
  bool containsKey(String key) => box().containsKey(key);

  /// remove
  Future<bool> remove(String key) async {
    if (isOpen) {
      if (containsKey(key)) {
        box().delete(key);
        return containsKey(key);
      } else {
        return true;
      }
    }
    return false;
  }

  /// clear
  Future<bool> get clear async {
    if (isOpen) {
      final code = await box().clear();
      return code == 0;
    }
    return false;
  }
}
