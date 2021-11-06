/// 基础解析数据model
class BaseModel {
  BaseModel({
    this.data,
    this.expand,
    required this.code,
    required this.msg,
  });

  BaseModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      code = (json['code'] ?? json['status'] ?? json['statusCode']).toString();
      if (code == 'null') code = '404';
      msg = ((json['msg'] ?? json['errorMessage'] ?? json['statusMessage'])
              as String?) ??
          (code == '200' ? '' : '服务器异常');
      data = json['data'] ?? json['result'];
      expand = json['expand'] ?? '';
    } else {
      code = '404';
      msg = '服务器异常';
      data = '';
      expand = '';
    }
  }

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
