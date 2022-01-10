import 'package:flutter_waya/flutter_waya.dart';

/// 基础解析数据model
class BaseModel {
  BaseModel({
    this.data,
    this.expand,
    required this.code,
    required this.msg,
  });

  BaseModel.fromJson(Map<String, dynamic>? json, {ResponseModel? response}) {
    if (json != null) {
      original = response;
      code =
          '${(json['code'] ?? json['status'] ?? json['statusCode'] ?? json['errcode'] ?? response?.statusCode)}';
      msg =
          '${((json['msg'] ?? json['errorMessage'] ?? json['statusMessage'] ?? json['errmsg'])) ?? response?.statusMessage}';
      data = json['data'] ?? json['result'] ?? response?.data;
      expand = json['expand'] ?? response?.extra;
    } else {
      code = '404';
      msg = '服务器异常';
      data = '';
      expand = '';
    }
  }

  late ResponseModel? original;
  late String code;
  late String msg;
  dynamic data;
  dynamic expand;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'data': data,
        'msg': msg,
        'code': code,
        'expand': expand,
      };
}
