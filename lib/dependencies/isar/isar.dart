import 'package:universally/universally.dart';

abstract class IsarBoX {
  bool isInitialize = false;
  String? _name;
  bool _lazy = false;
  bool _isOpen = false;
  Future<void> initialize(String name,
      {String? subDir, bool lazy = false}) async {
    if (!isInitialize) {
      _name = name;
      _lazy = lazy;
      Isar.initializeIsarCore();

      isInitialize = true;
      if (lazy) {
        await openLazyBox();
      } else {
        await openBox();
      }
    }
  }


}
