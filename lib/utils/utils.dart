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

extension NumExtension on num {
  String toChineseNumbers({bool isWeek = false}) {
    switch (toInt()) {
      case 1:
        return '一';
      case 2:
        return '二';
      case 3:
        return '三';
      case 4:
        return '四';
      case 5:
        return '五';
      case 6:
        return '六';
      case 7:
        return isWeek ? '日' : '七';
      case 8:
        return '八';
      case 9:
        return '九';
      case 10:
        return '十';
    }

    return toString();
  }
}
