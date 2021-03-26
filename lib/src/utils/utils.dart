import 'package:universally/universally.dart';

/// 请求权限
Future<bool> requestPermission(Permission permission,
    {Function? showAlert}) async {
  final PermissionStatus status = await permission.status;
  if (status != PermissionStatus.granted) {
    final Map<Permission, PermissionStatus> statuses =
        await <Permission>[permission].request();
    if (!(statuses[permission] == PermissionStatus.granted)) {
      if (showAlert != null) {
        showAlert.call();
      } else {
        openAppSettings();
      }
    }
    return statuses[permission] == PermissionStatus.granted;
  }
  return true;
}

/// 打开网页
Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    log('Could not launch $url');
  }
}

/// 截取日期 2020-01-01
String subDate(DateTime dateTime) => dateTime.toString().substring(0, 10);

/// 截取日期 10:10:10
String subTime(DateTime dateTime) => dateTime.toString().substring(11, 19);
