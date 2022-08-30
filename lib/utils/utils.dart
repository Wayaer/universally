import 'dart:convert';

import 'package:universally/universally.dart';

/// nullPass = true   data 为null  返回true
bool resultSuccessFail(BasicModel data, {String? text, bool nullPass = false}) {
  if (BasicDio().basicDioOptions.successCode.contains(data.code) &&
      (nullPass || data.data != null)) {
    if (text != null) showToast(text);
    return true;
  } else {
    if (!BasicDio().basicDioOptions.hideMsg.contains(data.msg)) {
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
