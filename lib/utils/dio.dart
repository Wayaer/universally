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

typedef BaseDioErrorIntercept = List<InterceptorError> Function(
    String url, dynamic tag);

class BaseDioOptions extends ExtendedDioOptions {
  BaseDioOptions(
      {

      /// 接收超时时间
      int receiveTimeout = 5000,

      /// 连接超时时间
      int connectTimeout = 5000,

      /// 发送超时时间
      int sendTimeout = 5000,
      this.header,
      this.errorIntercept,
      this.forbidPrintUrl = const []})
      : super(
            receiveTimeout: receiveTimeout,
            connectTimeout: connectTimeout,
            sendTimeout: sendTimeout);

  /// header设置
  ValueCallbackHeader? header;

  /// 错误拦截;
  BaseDioErrorIntercept? errorIntercept;

  /// 不打印 返回 data 的url
  List<String> forbidPrintUrl;
}

class BaseDio {
  factory BaseDio() => _singleton ??= BaseDio._();

  BaseDio._();

  static BaseDio? _singleton;

  late BaseOptions _baseOptions;

  late ExtendedDio dio;

  ExtendedOverlayEntry? _loading;

  ValueCallbackHeader? _header;

  BaseDioErrorIntercept? _errorIntercept;

  BaseDio initialize([BaseDioOptions? options]) {
    var dioOptions = options ??= BaseDioOptions();
    _baseOptions = dioOptions;
    _header = dioOptions.header;
    _errorIntercept = dioOptions.errorIntercept;
    dioOptions.logTs = hasLogTs;
    dioOptions.interceptors = isRelease
        ? []
        : [
            LoggerInterceptor<dynamic>(
                forbidPrintUrl: dioOptions.forbidPrintUrl)
          ];
    dio = ExtendedDio().initialize(dioOptions);
    return this;
  }

  Future<BaseModel> get(
    String url, {
    dynamic tag,
    Map<String, dynamic>? params,
    bool loading = true,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res =
        await dio.getHttp(url, options: _baseOptions, params: params);
    return _response(res, tag);
  }

  Future<BaseModel> post(String url,
      {Map<String, dynamic>? params,
      dynamic data,
      dynamic tag,
      bool loading = true,
      BaseOptions? options,
      bool useOriginal = false,
      ProgressCallback? onSendProgress}) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    if (options != null) {
      _baseOptions = options;
    } else {
      _initBaseOptions(url);
    }
    final ResponseModel res = await dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.post,
        params: params,
        data: jsonEncode(data));
    return _response(res, tag);
  }

  Future<BaseModel> put(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool loading = true,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.put,
        params: params,
        data: jsonEncode(data));
    return _response(res, tag);
  }

  Future<BaseModel> delete(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool loading = true,
    bool isJson = true,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.delete,
        params: params,
        data: isJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  /// 文件上传
  /// File upload
  Future<BaseModel> upload(
    String url,
    dynamic data, {
    ProgressCallback? onSendProgress,
    bool loading = true,
    dynamic tag,
    CancelToken? cancelToken,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await dio.upload<dynamic>(url,
        data: data,
        options: _baseOptions,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken);
    return _response(res, tag);
  }

  /// 文件下载
  /// File download
  Future<ResponseModel> download(String url, String savePath,
      {ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      BaseOptions? options}) {
    assert(_singleton != null, '请先调用 initialize');
    return dio.download(url, savePath,
        onReceiveProgress: onReceiveProgress, options: options);
  }

  void _addLoading(bool? loading) {
    if ((loading ?? false) && _loading == null) _loading = alertLoading();
  }

  Future<void> _removeLoading() async {
    await 500.milliseconds.delayed(() {});
    if (_loading != null) {
      _loading!.removeEntry();
      _loading = null;
    }
  }

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

  void _initBaseOptions(String url) {
    final Map<String, String> _headers = <String, String>{
      'Content-Type': 'application/json;charset=UTF-8'
    };
    if (_header != null) _headers.addAll(_header!(url));
    _baseOptions.headers = _headers;
  }

  BaseModel _response(ResponseModel res, dynamic tag) {
    _removeLoading();
    _sendRefreshStatus();
    BaseModel baseModel = BaseModel(
        code: '${res.statusCode}',
        msg: '${res.statusMessage}',
        statusCode: res.statusCode,
        statusMessage: res.statusMessage,
        data: res.data,
        original: res);
    dynamic data = baseModel.data;
    if (data != null && data is String && data.contains('"')) {
      try {
        data = jsonDecode(data);
      } catch (e) {
        debugPrint('$e');
      }
      baseModel = BaseModel.fromJson(data, res);
    } else if (data is Map) {
      baseModel = BaseModel.fromJson(data as Map<String, dynamic>?, res);
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
