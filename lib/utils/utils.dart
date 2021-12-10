import 'package:universally/universally.dart';

/// nullPass = true   data 为null  返回true
bool resultSuccessFail(BaseModel baseModel,
    {String? text, bool nullPass = false}) {
  if (baseModel.code == UConstant.successCode &&
      (nullPass || baseModel.data != null)) {
    if (text != null) showToast(text);
    return true;
  } else {
    if (baseModel.code == '401') {
      showToast('登录失效,请重新登录');
      return false;
    }
    if (baseModel.msg != 'success' && baseModel.msg != 'OK') {
      showToast(baseModel.msg);
    }
    return false;
  }
}
