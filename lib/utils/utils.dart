import 'dart:convert';

import 'package:universally/universally.dart';

/// nullPass = true   data 为null  返回true
bool resultSuccessFail(BasicModel data, {String? text, bool nullPass = false}) {
  if (data.code == UConstant.successCode && (nullPass || data.data != null)) {
    if (text != null) showToast(text);
    return true;
  } else {
    if (data.code == '401') {
      showToast('登录失效,请重新登录');
      return false;
    }
    if (data.msg != 'success' && data.msg != 'OK') {
      showToast(data.msg);
    }
    return false;
  }
}

void logJson(dynamic data) {
  try {
    var json = jsonEncode(data is BasicModel ? data.toMap() : data);
    log(json);
  } catch (e) {
    log(e);
  }
}
