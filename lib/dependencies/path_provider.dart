import 'dart:io' show Directory;

import 'package:path_provider/path_provider.dart' as path;

class PathProvider {
  factory PathProvider() => _singleton ??= PathProvider._();

  PathProvider._();

  static PathProvider? _singleton;

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory> getTemporaryDirectory() => path.getTemporaryDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory> getApplicationSupportDirectory() =>
      path.getApplicationSupportDirectory();

  ///	iOS	macOS
  Future<Directory> getLibraryDirectory() => path.getLibraryDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory> getApplicationDocumentsDirectory() =>
      path.getApplicationDocumentsDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory> getApplicationCacheDirectory() =>
      path.getApplicationCacheDirectory();

  /// Android
  Future<Directory?> getExternalStorageDirectory() =>
      path.getExternalStorageDirectory();

  /// Android
  Future<List<Directory>?> getExternalCacheDirectories() =>
      path.getExternalCacheDirectories();

  /// Android
  Future<List<Directory>?> getExternalStorageDirectories() =>
      path.getExternalStorageDirectories();

  /// iOS	Linux	macOS	Windows
  Future<Directory?> getDownloadsDirectory() => path.getDownloadsDirectory();
}
