import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

typedef ValueCallbackHeader = Map<String, String> Function(String url);
typedef ValueCallbackError = bool Function();

class InterceptorError {
  InterceptorError(this.errorCode, this.callback);

  late String errorCode;

  /// 返回 false 不继续后面的解析操作
  /// 返回 true 继续执行后面的解析操作
  late ValueCallbackError callback;
}

typedef BasicDioErrorIntercept = List<InterceptorError> Function(
    String url, dynamic tag);

class BasicDioOptions extends ExtendedDioOptions {
  BasicDioOptions(
      {

      /// 接收超时时间
      int receiveTimeout = 5000,

      /// 连接超时时间
      int connectTimeout = 5000,

      /// 发送超时时间
      int sendTimeout = 5000,
      this.downloadResponseType = ResponseType.bytes,
      this.downloadContentType,
      this.uploadContentType,
      this.header,
      this.errorIntercept,
      this.forbidPrintUrl = const []})
      : super(
            receiveTimeout: receiveTimeout,
            connectTimeout: connectTimeout,
            sendTimeout: sendTimeout) {
    downloadContentType ??= httpContentType[1];
    uploadContentType ??= httpContentType[1];
  }

  /// header设置
  ValueCallbackHeader? header;

  /// 错误拦截;
  BasicDioErrorIntercept? errorIntercept;

  /// 不打印 返回 data 的url
  List<String> forbidPrintUrl;

  /// 下载的ContentType;
  String? downloadContentType;

  /// 下载文件时的请求类型
  ResponseType downloadResponseType;

  /// 上传的Type
  String? uploadContentType;
}

class BasicDio {
  factory BasicDio() => _singleton ??= BasicDio._();

  BasicDio._();

  static BasicDio? _singleton;

  late ExtendedDio dio;

  ValueCallbackHeader? _header;

  BasicDioErrorIntercept? _errorIntercept;

  bool hasLoading = false;

  BasicDio initialize([BasicDioOptions? options]) {
    var dioOptions = options ??= BasicDioOptions();
    _header = dioOptions.header;
    _errorIntercept = dioOptions.errorIntercept;
    dioOptions.logTs = hasLogTs;
    dioOptions.interceptors = isRelease
        ? []
        : [
            LoggerInterceptor<dynamic>(
                forbidPrintUrl: dioOptions.forbidPrintUrl)
          ];
    dio = ExtendedDio().initialize(options: dioOptions);
    return this;
  }

  Future<BasicModel> get(
    String url, {
    dynamic tag,
    Map<String, dynamic>? params,
    bool loading = true,
    Options? options,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.get(url,
        options: _initBasicOptions(options, url), params: params);
    return _response(res, tag);
  }

  Future<BasicModel> post(String url,
      {Map<String, dynamic>? params,
      dynamic data,
      dynamic tag,
      bool loading = true,
      Options? options,
      ProgressCallback? onSendProgress}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.post(url,
        options: _initBasicOptions(options, url),
        params: params,
        data: jsonEncode(data));
    return _response(res, tag);
  }

  Future<BasicModel> put(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool loading = true,
    Options? options,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.put(url,
        options: _initBasicOptions(options, url),
        params: params,
        data: jsonEncode(data));
    return _response(res, tag);
  }

  Future<BasicModel> delete(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool loading = true,
    bool isJson = true,
    Options? options,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.delete(url,
        options: _initBasicOptions(options, url),
        params: params,
        data: isJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  /// 文件上传
  /// File upload
  Future<BasicModel> upload(
    String url,
    dynamic data, {
    ProgressCallback? onSendProgress,
    bool loading = true,
    Options? options,
    dynamic tag,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.post(url,
        data: data,
        options:
            _initBasicOptions(options, url).copyWith(receiveTimeout: 30000),
        onSendProgress: onSendProgress);
    return _response(res, tag);
  }

  /// 文件下载
  /// File download
  Future<BasicModel> download(
    String url,
    String savePath, {
    bool loading = true,
    dynamic tag,
    Options? options,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    dynamic data,
    Map<String, dynamic>? params,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.download(url, savePath,
        onReceiveProgress: onReceiveProgress,
        options: _initBasicOptions(options, url),
        data: data,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        cancelToken: cancelToken);
    return _response(res, tag);
  }

  void _addLoading(bool? loading) {
    hasLoading = loading ?? false;
    if (hasLoading) showLoading();
  }

  Future<void> _removeLoading() async {
    await 200.milliseconds.delayed(() {});
    if (hasLoading) {
      closeLoading();
    }
  }

  bool get hasNetWork {
    var network = GlobalConfig().hasNetwork ?? true;
    if (!network) {
      _removeLoading();
      1.seconds.delayed(_sendRefreshStatus);
    }
    return !network;
  }

  BasicModel get notNetWorkModel =>
      BasicModel(data: null, code: '500', msg: '无法连接服务器');

  void _sendRefreshStatus() {
    if (pullDown) {
      pullDown = false;
      sendRefreshType(EasyRefreshType.refreshSuccess);
    }
    if (pullUp) {
      pullUp = false;
      sendRefreshType(EasyRefreshType.loadingSuccess);
    }
  }

  Options _initBasicOptions(Options? options, String url) {
    options ??= Options();
    final Map<String, dynamic> _headers = <String, dynamic>{};
    if (_header != null) _headers.addAll(_header!(url));
    options.headers = _headers;
    return options;
  }

  BasicModel _response(ResponseModel res, dynamic tag) {
    _removeLoading();
    _sendRefreshStatus();
    BasicModel baseModel = BasicModel(
        code: '${res.statusCode}',
        msg: res.statusMessage ?? notNetWorkModel.msg,
        statusCode: res.statusCode,
        statusMessage: res.statusMessage,
        data: res.data,
        original: res);
    dynamic data = baseModel.data;
    if (data is ResponseBody) {
      return baseModel = BasicModel(
          code: '${data.statusCode}',
          msg: notNetWorkModel.msg,
          statusCode: data.statusCode,
          statusMessage: data.statusMessage,
          data: 'This is response stream',
          original: res);
    } else if (data != null && data is String && data.contains('"')) {
      try {
        data = jsonDecode(data);
      } catch (e) {
        debugPrint('$e');
      }
      baseModel = BasicModel.fromJson(data, res);
    } else if (data is Map) {
      baseModel = BasicModel.fromJson(data as Map<String, dynamic>?, res);
    }
    var _errorIntercepts = _errorIntercept?.call(res.realUri.toString(), tag);
    if (_errorIntercepts?.isNotEmpty ?? false) {
      bool pass = true;
      for (var element in _errorIntercepts!) {
        if (baseModel.code == element.errorCode) {
          pass = element.callback();
          if (!pass) break;
        }
      }
      if (!pass) return baseModel;
    }
    return baseModel;
  }
}

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
        'expand': expand
      };
}
