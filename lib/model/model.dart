import 'package:flutter_waya/flutter_waya.dart';

/// 基础解析数据model
class BasicModel {
  BasicModel({
    this.data,
    this.expand,
    this.original,
    required this.code,
    this.statusCode,
    required this.msg,
    this.statusMessage,
  });

  BasicModel.fromJson(Map<String, dynamic>? json, ResponseModel response) {
    statusCode = response.statusCode;
    statusMessage = response.statusMessage;
    code = statusCode.toString();
    msg = statusMessage ?? '服务器异常';
    original = response;
    if (json != null) {
      code =
          '${(json['code'] ?? json['status'] ?? json['statusCode'] ?? json['errcode'] ?? response.statusCode)}';
      msg =
          '${((json['msg'] ?? json['errorMessage'] ?? json['statusMessage'] ?? json['errmsg'])) ?? response.statusMessage}';
      data = json['data'] ?? json['result'];
      expand = json['expand'];
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
