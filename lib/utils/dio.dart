import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
      this.errorIntercept = const [],
      this.forbidPrintUrl = const []})
      : super(
            receiveTimeout: receiveTimeout,
            connectTimeout: connectTimeout,
            sendTimeout: sendTimeout);

  /// header设置
  ValueCallbackHeader? header;

  /// 错误拦截
  List<InterceptorError> errorIntercept;

  /// 不打印 返回 data 的url
  List<String> forbidPrintUrl;
}

class BaseDio {
  factory BaseDio() => _singleton ??= BaseDio._();

  BaseDio._();

  static BaseDio? _singleton;

  late BaseOptions _baseOptions;

  late ExtendedDio _dio;

  ExtendedOverlayEntry? _loading;

  ValueCallbackHeader? _header;

  List<InterceptorError> _errorIntercept = [];

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
    _dio = ExtendedDio().initialize(dioOptions);
    return this;
  }

  Future<BaseModel> get(
    String url, {
    Map<String, dynamic>? params,
    bool loading = true,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res =
        await _dio.getHttp(url, options: _baseOptions, params: params);
    return _response(res);
  }

  Future<BaseModel> post(String url,
      {Map<String, dynamic>? params,
      dynamic data,
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
    final ResponseModel res = await _dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.post,
        params: params,
        data: jsonEncode(data));
    return _response(res);
  }

  Future<BaseModel> put(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    bool loading = true,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await _dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.put,
        params: params,
        data: jsonEncode(data));
    return _response(res);
  }

  Future<BaseModel> delete(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    bool loading = true,
    bool isJson = true,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await _dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.delete,
        params: params,
        data: isJson ? jsonEncode(data) : data);
    return _response(res);
  }

  /// 文件上传
  /// File upload
  Future<BaseModel> upload(
    String url,
    dynamic data, {
    ProgressCallback? onSendProgress,
    bool loading = true,
    CancelToken? cancelToken,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await _dio.upload<dynamic>(url,
        data: data,
        options: _baseOptions,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken);
    return _response(res);
  }

  /// 文件下载
  /// File download
  Future<ResponseModel> download(String url, String savePath,
      {ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      BaseOptions? options}) {
    assert(_singleton != null, '请先调用 initialize');
    return _dio.download(url, savePath,
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

  BaseModel _response(ResponseModel res) {
    _removeLoading();
    _sendRefreshStatus();
    if (_errorIntercept.isNotEmpty) {
      bool pass = true;
      for (var element in _errorIntercept) {
        if (res.statusCode != null &&
            res.statusCode.toString() == element.errorCode) {
          pass = element.callback();
          if (!pass) break;
        }
      }
      if (!pass) return BaseModel(code: '${res.statusCode}', msg: 'error');
    }
    BaseModel baseModel =
        BaseModel(code: '${res.statusCode}', msg: '${res.statusMessage}');
    dynamic data = res.data;
    if (data != null && data is String && data.contains('"')) {
      try {
        data = jsonDecode(data);
      } catch (e) {
        debugPrint('$e');
      }
      baseModel = BaseModel.fromJson(data, response: res);
    } else if (data is Map) {
      baseModel =
          BaseModel.fromJson(data as Map<String, dynamic>?, response: res);
    } else {
      baseModel = BaseModel.fromJson(data, response: res);
    }
    return baseModel;
  }
}
