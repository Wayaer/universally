import 'package:flutter/foundation.dart';

extension ExtensionTargetPlatform on TargetPlatform {
  String get value {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.macOS:
        return 'mac';
      case TargetPlatform.windows:
        return 'windows';
    }
  }
}
