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

  ///	iOS	macOS
  Future<Directory?> getLibraryDirectory() async =>
      isWeb ? null : await path.getLibraryDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory?> getApplicationDocumentsDirectory() async =>
      isWeb ? null : await path.getApplicationDocumentsDirectory();

  /// Android	iOS	Linux	macOS	Windows
  Future<Directory?> getApplicationCacheDirectory() async =>
      isWeb ? null : await path.getApplicationCacheDirectory();

  /// Android
  Future<Directory?> getExternalStorageDirectory() async =>
      isWeb || !isAndroid ? null : await path.getExternalStorageDirectory();

  /// Android
  Future<List<Directory>?> getExternalCacheDirectories() async =>
      isWeb || !isAndroid ? null : await path.getExternalCacheDirectories();

  /// Android
  Future<List<Directory>?> getExternalStorageDirectories() async =>
      isWeb || !isAndroid ? null : await path.getExternalStorageDirectories();

  /// iOS	Linux	macOS	Windows
  Future<Directory?> getDownloadsDirectory() async =>
      isWeb ? null : await path.getDownloadsDirectory();
}
