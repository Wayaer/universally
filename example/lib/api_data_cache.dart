import 'package:universally/dependencies/isar/isar.dart';
import 'package:universally/universally.dart';

@collection
class ApiDataModel {
  Id id = Isar.autoIncrement;

  /// api
  @Name('api')
  String? api;

  /// api data
  @Name('data')
  String? data;

  Map<String, dynamic> toMap() => {'id': id, 'api': api, 'data': data};
}

class IsarWithApiDataCache extends IsarCore {
  factory IsarWithApiDataCache() => _singleton ??= IsarWithApiDataCache._();

  IsarWithApiDataCache._();

  static IsarWithApiDataCache? _singleton;

  void init() async {
    // await open([ApiDataModel]);
  }
}
