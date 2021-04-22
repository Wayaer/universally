import 'package:universally/universally.dart';

/// 打开网页
Future<bool> openUrl(String url) async {
  if (await canLaunch(url)) {
    launch(url);
    return true;
  } else {
    log('Could not launch $url');
    return false;
  }
}

/// 打开 AppStore 指定id app
Future<bool> openAppStore(int id) async {
  final String url = 'itms-apps://itunes.apple.com/us/app/$id';
  if (await canLaunch(url)) {
    launch(url);
    return true;
  } else {
    log('Could not launch $url');
    return false;
  }
}
