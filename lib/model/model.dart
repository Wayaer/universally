import 'package:flutter_waya/flutter_waya.dart';

/// 基础解析数据model
class BaseModel {
  BaseModel({
    this.data,
    this.expand,
    this.original,
    required this.code,
    this.statusCode,
    required this.msg,
    this.statusMessage,
  });

  BaseModel.fromJson(Map<String, dynamic>? json, ResponseModel response) {
    statusCode = response.statusCode;
    statusMessage = response.statusMessage;
    code = response.statusCode.toString();
    msg = response.statusMessage ?? '';
    original = response;
    data = response.data;
    expand = response.extra;
    if (json != null) {
      code =
          '${(json['code'] ?? json['status'] ?? json['statusCode'] ?? json['errcode'] ?? response.statusCode)}';
      msg =
          '${((json['msg'] ?? json['errorMessage'] ?? json['statusMessage'] ?? json['errmsg'])) ?? response.statusMessage}';
      data = json['data'] ?? json['result'] ?? response.data;
      expand = json['expand'] ?? response.extra;
    } else {
      statusCode = 404;
      statusMessage = '服务器异常';
      code = '404';
      msg = '服务器异常';
      data = '';
      expand = '';
    }
  }

  /// 网络请求返回的 statusCode
  int? statusCode;

  /// 网络请求返回的 statusMessage
  String? statusMessage;

  /// 网络请求返回的原始数据
  ResponseModel? original;

  /// 后台定义的 code
  late String code;

  /// 后台定义的 msg
  late String msg;

  /// 后台返回数据
  dynamic data;

  /// 后台返回的扩展数据
  dynamic expand;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'data': data,
        'statusCode': statusCode,
        'statusMessage': statusMessage,
        'msg': msg,
        'code': code,
        'expand': expand,
      };
}
