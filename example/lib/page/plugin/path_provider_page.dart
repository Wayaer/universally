import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class PathProviderPage extends StatefulWidget {
  const PathProviderPage({super.key});

  @override
  State<PathProviderPage> createState() => _PathProviderPageState();
}

class _PathProviderPageState extends State<PathProviderPage> {
  final Map<String, List<String>> _directories = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDirectories();
    });
  }

  void getDirectories() async {
    final temp = await getTemporaryDirectory();
    _directories.addAll({
      'getTemporaryDirectory': [temp.path],
    });
    final appSupport = await PathProvider.instance
        .getApplicationSupportDirectory();
    if (appSupport != null) {
      _directories.addAll({
        'getApplicationSupportDirectory': [appSupport.path],
      });
    }

    final appDocuments = await PathProvider.instance
        .getApplicationDocumentsDirectory();

    if (appDocuments != null) {
      _directories.addAll({
        'getApplicationDocumentsDirectory': [appDocuments.path],
      });
    }
    final appCache = await PathProvider.instance.getApplicationCacheDirectory();
    if (appCache != null) {
      _directories.addAll({
        'getApplicationCacheDirectory': [appCache.path],
      });
    }
    final externalDocuments = await PathProvider.instance
        .getExternalStorageDirectory();
    if (externalDocuments != null) {
      _directories.addAll({
        'getExternalStorageDirectory': [externalDocuments.path],
      });
    }
    final downloads = await PathProvider.instance.getDownloadsDirectory();
    if (downloads != null) {
      _directories.addAll({
        'getDownloadsDirectory': [downloads.path],
      });
    }
    final externalCache = await PathProvider.instance
        .getExternalCacheDirectories();
    if (externalCache != null) {
      _directories.addAll({
        'getExternalCacheDirectories': externalCache.builder((e) => e.path),
      });
    }
    final externalStorage = await PathProvider.instance
        .getExternalStorageDirectories();
    if (externalStorage != null) {
      _directories.addAll({
        'getExternalStorageDirectories': externalStorage.builder((e) => e.path),
      });
    }
    for (final value in StorageDirectory.values) {
      final directories = await PathProvider.instance
          .getExternalStorageDirectories(type: value);
      if (directories != null) {
        _directories.addAll({
          'getExternalStorageDirectories $value': directories.builder(
            (e) => e.path,
          ),
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    _directories.entriesMapKVToList((k, v) {
      children.add(
        Column(
          spacing: 10,
          children: [
            TextLarge(k, maxLines: 2, textAlign: TextAlign.center),
            ...v.builder(
              (e) => TextMedium(e, maxLines: 10, textAlign: TextAlign.center),
            ),
            Divider(),
          ],
        ),
      );
    });
    return BaseScaffold(
      appBarTitleText: 'Path Provider',
      spacing: 20,
      padding: EdgeInsets.all(16),
      isScroll: true,
      children: children,
    );
  }
}
