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
  BasicDioErrorIntercept? errorIntercept;

  /// 不打印 返回 data 的url
  List<String> forbidPrintUrl;
}

class BasicDio {
  factory BasicDio() => _singleton ??= BasicDio._();

  BasicDio._();

  static BasicDio? _singleton;

  late BaseOptions _baseOptions;

  late ExtendedDio dio;

  ExtendedOverlayEntry? _loading;

  ValueCallbackHeader? _header;

  BasicDioErrorIntercept? _errorIntercept;

  BasicDio initialize([BasicDioOptions? options]) {
    var dioOptions = options ??= BasicDioOptions();
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

  Future<BasicModel> get(
    String url, {
    dynamic tag,
    Map<String, dynamic>? params,
    bool loading = true,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    _initBasicOptions(url);
    final ResponseModel res =
        await dio.getHttp(url, options: _baseOptions, params: params);
    return _response(res, tag);
  }

  Future<BasicModel> post(String url,
      {Map<String, dynamic>? params,
      dynamic data,
      dynamic tag,
      bool loading = true,
      BaseOptions? options,
      bool useOriginal = false,
      ProgressCallback? onSendProgress}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    if (options != null) {
      _baseOptions = options;
    } else {
      _initBasicOptions(url);
    }
    final ResponseModel res = await dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.post,
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
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    _initBasicOptions(url);
    final ResponseModel res = await dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.put,
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
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    _initBasicOptions(url);
    final ResponseModel res = await dio.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.delete,
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
    dynamic tag,
    CancelToken? cancelToken,
    bool useOriginal = false,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    _initBasicOptions(url);
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
      BaseOptions? options}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) {
      return ResponseModel(
          requestOptions: RequestOptions(path: url), statusMessage: '无网络链接');
    }
    return await dio.download(url, savePath,
        onReceiveProgress: onReceiveProgress, options: options);
  }

  void _addLoading(bool? loading) {
    if ((loading ?? false) && _loading == null) _loading = alertLoading();
  }

  bool get hasNetWork {
    _removeLoading();
    1.5.seconds.delayed(_sendRefreshStatus);
    var network = GlobalConfig().hasNetwork ?? true;
    return !network;
  }

  BasicModel get notNetWorkModel =>
      BasicModel(data: null, code: '500', msg: '无法连接服务器');

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

  void _initBasicOptions(String url) {
    final Map<String, String> _headers = <String, String>{
      'Content-Type': 'application/json;charset=UTF-8'
    };
    if (_header != null) _headers.addAll(_header!(url));
    _baseOptions.headers = _headers;
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
    if (data != null && data is String && data.contains('"')) {
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
