import 'dart:io' show Directory;

import 'package:path_provider/path_provider.dart' as path;
import 'package:universally/universally.dart';

class PathProvider {
  factory PathProvider() => _singleton ??= PathProvider._();

  PathProvider._();

  static PathProvider? _singleton;

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory?> getTemporaryDirectory() async =>
      isWeb ? null : await path.getTemporaryDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory?> getApplicationSupportDirectory() async =>
      isWeb ? null : await path.getApplicationSupportDirectory();

  /// Android	iOS	Linux	macOS	Windows
  /// Android for [getExternalStorageDirectory()]
  Future<Directory?> getExternalDirectory() async {
    if (isWeb) return null;
    if (isAndroid) return await getExternalStorageDirectory();
    return await getLibraryDirectory();
  }

  ///	iOS	macOS
  Future<Directory?> getLibraryDirectory() async =>
      isWeb ? null : await path.getLibraryDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory?> getApplicationDocumentsDirectory() async =>
      isWeb ? null : await path.getApplicationDocumentsDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory?> getApplicationCacheDirectory() async =>
      isWeb ? null : await path.getApplicationCacheDirectory();

  /// Android	iOS	Linux	macOS	Windows
  /// Android for [getExternalCacheDirectories()]
  Future<Directory?> getExternalApplicationCacheDirectory() async {
    if (isWeb) return null;
    if (isAndroid) return (await getExternalCacheDirectories())?.firstOrNull;
    return await path.getApplicationCacheDirectory();
  }

  /// Android iOS	Linux	macOS	Windows
  Future<Directory?> getDownloadsDirectory() async =>
      isWeb ? null : await path.getDownloadsDirectory();

  /// Android
  Future<Directory?> getExternalStorageDirectory() async =>
      isWeb || !isAndroid ? null : await path.getExternalStorageDirectory();

  /// Android
  Future<List<Directory>?> getExternalCacheDirectories() async =>
      isWeb || !isAndroid ? null : await path.getExternalCacheDirectories();

  /// Android
  Future<List<Directory>?> getExternalStorageDirectories({
    StorageDirectory? type,
  }) async =>
      isWeb || !isAndroid
          ? null
          : await path.getExternalStorageDirectories(type: type);
}
