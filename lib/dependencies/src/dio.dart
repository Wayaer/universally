import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

/// FormData ContentType
const String kContentTypeWithFormData = 'multipart/form-data';

/// TextXml ContentType
const String kContentTypeWithTextXml = 'text/xml';

/// 扩展所有的 header
typedef ValueCallbackHeader = Map<String, String>? Function(String url);

/// 扩展所有的 params
typedef ValueCallbackParams = Map<String, dynamic>? Function(
    String url, Map<String, dynamic>? params);

/// 扩展所有的 uri
typedef ValueCallbackUri = Uri Function(Uri uri);

/// 扩展所有的 data
typedef ValueCallbackData<T> = T Function(String url, T params);

/// 扩展所有的 uri data
typedef ValueCallbackUriData<T> = T Function(Uri uri, T params);

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
  BasicDioOptions({
    /// 接收超时时间
    super.receiveTimeout = const Duration(seconds: 5),

    /// 连接超时时间
    super.connectTimeout = const Duration(seconds: 5),

    /// 发送超时时间
    super.sendTimeout = const Duration(seconds: 5),
    this.downloadResponseType = ResponseType.bytes,
    this.downloadContentType,
    this.uploadContentType,
    this.extraHeader,
    this.extraData,
    this.extraUriData,
    this.extraParams,
    this.extraUri,
    this.errorIntercept,
    this.filteredUrls = const [],
    super.method,
    super.baseUrl = '',
    super.queryParameters,
    super.extra,
    super.headers,
    super.responseType = ResponseType.json,
    super.contentType,
    super.validateStatus,
    super.receiveDataWhenStatusError,
    super.followRedirects,
    super.maxRedirects,
    super.requestEncoder,
    super.responseDecoder,
    super.listFormat,
    this.codeKeys = const ['code', 'status', 'statusCode', 'errcode'],
    this.msgKeys = const ['msg', 'errorMessage', 'statusMessage', 'errmsg'],
    this.dataKeys = const ['data', 'result'],
    this.extensionKeys = const ['extension'],
    this.hideMsg = const ['success', 'OK'],
    this.successCode = const ['200'],
    this.showLoading = true,
    this.pullHideLoading = true,
  }) {
    downloadContentType ??= kContentTypeWithFormData;
    uploadContentType ??= kContentTypeWithFormData;
  }

  /// header设置
  ValueCallbackHeader? extraHeader;

  /// 扩展所有的 data 参数
  ValueCallbackData? extraData;

  /// 扩展所有的 uri Data
  ValueCallbackUriData? extraUriData;

  /// 扩展所有的 params
  ValueCallbackParams? extraParams;

  /// 扩展所有的 uri
  ValueCallbackUri? extraUri;

  /// 错误拦截;
  BasicDioErrorIntercept? errorIntercept;

  /// 不打印 返回 data 的url
  List<String> filteredUrls;

  /// 下载的ContentType;
  String? downloadContentType;

  /// 下载文件时的请求类型
  ResponseType downloadResponseType;

  /// 上传的Type
  String? uploadContentType;

  /// BasicModel 后台返回状态码
  List<String> codeKeys;

  /// BasicModel 后台返回message
  List<String> msgKeys;

  /// BasicModel 后台返回具体数据
  List<String> dataKeys;

  /// BasicModel 后台返回扩展数据
  List<String> extensionKeys;

  /// 后台返回成功的状态码
  /// 主要用于 网络请求返回 判断方法[resultSuccessFail]
  List<String> successCode;

  /// 后台返回 message 隐藏 toast
  /// 主要用于 网络请求返回 判断方法[resultSuccessFail]
  List<String> hideMsg;

  /// 全局控制显示loading
  bool showLoading;

  /// [showLoading] 为 true 时 刷新组件 下拉或上拉 隐藏loading，默认为true
  bool pullHideLoading;
}

class BasicDio {
  factory BasicDio() => _singleton ??= BasicDio._();

  BasicDio._();

  static BasicDio? _singleton;

  late ExtendedDio dio;

  bool hasLoading = false;

  BasicDioOptions basicDioOptions = BasicDioOptions();

  BasicDio initialize([BasicDioOptions? options]) {
    if (options != null) basicDioOptions = options;
    basicDioOptions.interceptors = [
      if (isDebugger) DebuggerInterceptor(),
      if (isDebug)
        LoggerInterceptor<dynamic>(filteredUrls: options?.filteredUrls ?? [])
    ];
    dio = ExtendedDio().initialize(options: basicDioOptions);
    return this;
  }

  Future<BasicModel> get(
    String url, {
    dynamic tag,
    Map<String, dynamic>? params,
    bool? loading,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.get(url,
        options: _initBasicOptions(options, url),
        cancelToken: cancelToken,
        params: basicDioOptions.extraParams?.call(url, params) ?? params);
    return _response(res, tag);
  }

  Future<BasicModel> getUri(
    Uri uri, {
    dynamic tag,
    bool? loading,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.getUri(uri,
        cancelToken: cancelToken,
        options: _initBasicOptions(options, uri.path));
    return _response(res, tag);
  }

  Future<BasicModel> post(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    bool dataToJson = true,
    dynamic tag,
    bool? loading,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraData?.call(url, data) ?? data;

    final ResponseModel res = await dio.post(url,
        options: _initBasicOptions(options, url),
        params: basicDioOptions.extraParams?.call(url, params) ?? params,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> postUri(
    Uri uri, {
    dynamic data,
    bool dataToJson = true,
    dynamic tag,
    bool? loading,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.postUri(uri,
        options: _initBasicOptions(options, uri.path),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> put(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraData?.call(url, data) ?? data;
    final ResponseModel res = await dio.put(url,
        options: _initBasicOptions(options, url),
        params: basicDioOptions.extraParams?.call(url, params) ?? params,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> putUri(
    Uri uri, {
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.putUri(uri,
        options: _initBasicOptions(options, uri.path),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> delete(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraData?.call(url, data) ?? data;
    final ResponseModel res = await dio.delete(url,
        options: _initBasicOptions(options, url),
        params: basicDioOptions.extraParams?.call(url, params) ?? params,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> deleteUri(
    Uri uri, {
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.deleteUri(uri,
        options: _initBasicOptions(options, uri.path),
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> patch(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraData?.call(url, data) ?? data;
    final ResponseModel res = await dio.patch(url,
        options: _initBasicOptions(options, url),
        params: basicDioOptions.extraParams?.call(url, params) ?? params,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> patchUri(
    Uri uri, {
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.patchUri(uri,
        options: _initBasicOptions(options, uri.path),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> head(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraData?.call(url, data) ?? data;
    final ResponseModel res = await dio.head(url,
        options: _initBasicOptions(options, url),
        params: basicDioOptions.extraParams?.call(url, params) ?? params,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> headUri(
    Uri uri, {
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.headUri(uri,
        options: _initBasicOptions(options, uri.path),
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> request(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraData?.call(url, data) ?? data;

    final ResponseModel res = await dio.request(url,
        options: _initBasicOptions(options, url),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        params: basicDioOptions.extraParams?.call(url, params) ?? params,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  Future<BasicModel> requestUri(
    Uri uri, {
    dynamic data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.requestUri(uri,
        options: _initBasicOptions(options, uri.path),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        data: dataToJson ? jsonEncode(data) : data);
    return _response(res, tag);
  }

  /// 文件上传
  /// File upload
  Future<BasicModel> upload(String url, dynamic data,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool? loading,
      Options? options,
      dynamic tag,
      CancelToken? cancelToken,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    final ResponseModel res = await dio.post(url,
        data: basicDioOptions.extraData?.call(url, data) ?? data,
        options: _initBasicOptions(options, url)
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
    return _response(res, tag);
  }

  /// 文件上传
  /// File upload
  Future<BasicModel> uploadUri(Uri uri, dynamic data,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool? loading,
      Options? options,
      dynamic tag,
      CancelToken? cancelToken,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.postUri(uri,
        data: basicDioOptions.extraUriData?.call(uri, data) ?? data,
        options: _initBasicOptions(options, uri.path)
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress);
    return _response(res, tag);
  }

  /// 文件下载
  /// File download
  Future<BasicModel> download(String url, String savePath,
      {bool? loading,
      dynamic tag,
      Options? options,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      dynamic data,
      bool dataToJson = true,
      Map<String, dynamic>? params,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = basicDioOptions.extraData?.call(url, data) ?? data;
    final ResponseModel res = await dio.download(url, savePath,
        onReceiveProgress: onReceiveProgress,
        options: _initBasicOptions(options, url)
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        data: dataToJson ? jsonEncode(data) : data,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        cancelToken: cancelToken);
    return _response(res, tag);
  }

  /// 文件下载
  /// File download
  Future<BasicModel> downloadUri(Uri uri, String savePath,
      {bool? loading,
      dynamic tag,
      Options? options,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      dynamic data,
      bool dataToJson = true,
      Map<String, dynamic>? params,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (hasNetWork) return notNetWorkModel;
    _addLoading(loading);
    data = jsonEncode(basicDioOptions.extraUriData?.call(uri, data) ?? data);
    uri = basicDioOptions.extraUri?.call(uri) ?? uri;
    final ResponseModel res = await dio.downloadUri(uri, savePath,
        onReceiveProgress: onReceiveProgress,
        options: _initBasicOptions(options, uri.path)
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        data: dataToJson ? jsonEncode(data) : data,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        cancelToken: cancelToken);
    return _response(res, tag);
  }

  void _addLoading(bool? loading) {
    hasLoading = loading ?? basicDioOptions.showLoading;
    if (hasLoading && basicDioOptions.pullHideLoading) {
      hasLoading = !(pullDown || pullUp);
    }
    if (hasLoading) showLoading();
  }

  Future<void> _removeLoading() async {
    await 200.milliseconds.delayed(() {});
    if (hasLoading) closeLoading();
  }

  bool get hasNetWork {
    var network = BasicConnectivity().networkAvailability;
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
      RefreshControllers().call(EasyRefreshType.refreshSuccess);
    }
    if (pullUp) {
      pullUp = false;
      RefreshControllers().call(EasyRefreshType.loadingSuccess);
    }
  }

  Options _initBasicOptions(Options? options, String url) {
    options ??= Options();
    final Map<String, dynamic> headers = <String, dynamic>{};
    if (basicDioOptions.extraHeader != null) {
      final extraHeader = basicDioOptions.extraHeader!(url);
      if (extraHeader != null) headers.addAll(extraHeader);
    }
    options.headers = headers;
    return options;
  }

  BasicModel _response(ResponseModel res, dynamic tag) {
    _removeLoading();
    _sendRefreshStatus();
    BasicModel baseModel = BasicModel(
        code: '${res.statusCode}',
        msg: notNetWorkModel.msg,
        statusCode: res.statusCode,
        statusMessage: res.statusMessage,
        data: res.data,
        original: res);
    dynamic data = baseModel.data;
    if (data is ResponseBody) {
      return baseModel = BasicModel(
          code: '${data.statusCode}',
          msg: data.statusMessage ?? notNetWorkModel.msg,
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
      if (data is Map) {
        baseModel = BasicModel.fromJson(data as Map<String, dynamic>?, res);
      }
    } else if (data is Map) {
      baseModel = BasicModel.fromJson(data as Map<String, dynamic>?, res);
    }
    var errorIntercepts =
        basicDioOptions.errorIntercept?.call(res.realUri.toString(), tag);
    if (errorIntercepts?.isNotEmpty ?? false) {
      bool pass = true;
      for (var element in errorIntercepts!) {
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
    this.extension,
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
    msg = '服务器异常';
    original = response;
    if (json != null) {
      final dioOptions = BasicDio().basicDioOptions;
      final codeValue = _getValue(dioOptions.codeKeys, json);
      if (codeValue != null) code = codeValue!.toString();
      final msgValue = _getValue(dioOptions.msgKeys, json);
      if (msgValue != null) msg = msgValue!.toString();
      data = _getValue(dioOptions.dataKeys, json);
      extension = _getValue(dioOptions.extensionKeys, json);
    }
  }

  dynamic _getValue(List<String> keys, Map<String, dynamic> json) {
    if (keys.isNotEmpty) {
      for (var key in keys) {
        final value = json[key];
        if (value != null) return value;
      }
    }
    return null;
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
  dynamic extension;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'data': data,
        'statusCode': statusCode,
        'statusMessage': statusMessage,
        'msg': msg,
        'code': code,
        'extension': extension,
        'original': original?.toMap()
      };
}

/// nullPass = true   data 为null  返回true
bool resultSuccessFail(BasicModel data, {String? text, bool nullPass = false}) {
  if (BasicDio().basicDioOptions.successCode.contains(data.code) &&
      (nullPass || data.data != null)) {
    if (text != null) showToast(text);
    return true;
  } else {
    if (!BasicDio().basicDioOptions.hideMsg.contains(data.msg)) {
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
