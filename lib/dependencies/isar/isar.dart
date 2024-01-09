import 'package:universally/universally.dart';

abstract class IsarCore {
  Isar? _isar;

  Isar? get isar => _isar;

  static Future<void> initialize({bool download = false}) async {
    await Isar.initializeIsarCore(download: download);
  }

  Future<void> open(
    List<CollectionSchema<dynamic>> schemas, {
    String? directory,
    String name = Isar.defaultName,
    int maxSizeMiB = Isar.defaultMaxSizeMiB,
    bool relaxedDurability = true,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) async {
    if (directory == null) {
      final documentsDir =
          await PathProvider().getApplicationDocumentsDirectory();
      directory = documentsDir.absolute.path;
    }
    _isar = await Isar.open(schemas,
        directory: directory,
        name: name,
        maxSizeMiB: maxSizeMiB,
        relaxedDurability: relaxedDurability,
        compactOnLaunch: compactOnLaunch,
        inspector: inspector);
  }
}
