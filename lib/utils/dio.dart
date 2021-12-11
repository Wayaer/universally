import 'dart:async';
import 'dart:convert';

import 'package:universally/universally.dart';

typedef ValueCallbackHeader = Map<String, String> Function(String url);
typedef ValueCallbackLoginFailure = void Function();

class DioUtils {
  static late BaseOptions _baseOptions;
  static late ExtendedDio dioTools;
  static ExtendedOverlayEntry? _loading;

  /// 设置Header
  /// Set the Header
  static ValueCallbackHeader? _header;
  static ValueCallbackLoginFailure? _failure;

  static void initDioUtils({
    int receiveTimeout = 5000,
    int connectTimeout = 5000,
    int sendTimeout = 5000,
    ValueCallbackHeader? header,
    ValueCallbackLoginFailure? failure,
  }) {
    _baseOptions = BaseOptions();
    _baseOptions.receiveTimeout = receiveTimeout;
    _baseOptions.connectTimeout = connectTimeout;
    _baseOptions.sendTimeout = sendTimeout;
    _header = header;
    _failure = failure;
    dioTools = ExtendedDio.getInstance(
        options: ExtendedDioOptions(
            options: _baseOptions,
            logTs: hasLogTs,
            interceptors: isRelease ? [] : [LoggerInterceptor<dynamic>()]));
  }

  static Future<BaseModel> get(String url,
      {Map<String, dynamic>? params,
      bool loading = true,
      bool pushLogin = true}) async {
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res =
        await dioTools.getHttp(url, options: _baseOptions, params: params);
    return _response(res, pushLogin);
  }

  static Future<BaseModel> post(String url,
      {Map<String, dynamic>? params,
      dynamic data,
      bool loading = true,
      BaseOptions? options,
      ProgressCallback? onSendProgress}) async {
    _addLoading(loading);
    if (options != null) {
      _baseOptions = options;
    } else {
      _initBaseOptions(url);
    }
    final ResponseModel res = await dioTools.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.post,
        params: params,
        data: jsonEncode(data));
    return _response(res);
  }

  static Future<BaseModel> put(String url,
      {Map<String, dynamic>? params, dynamic data, bool loading = true}) async {
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await dioTools.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.put,
        params: params,
        data: jsonEncode(data));
    return _response(res);
  }

  static Future<BaseModel> delete(String url,
      {Map<String, dynamic>? params,
      dynamic data,
      bool loading = true,
      bool isJson = true}) async {
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await dioTools.getHttp(url,
        options: _baseOptions,
        httpType: HttpType.delete,
        params: params,
        data: isJson ? jsonEncode(data) : data);
    return _response(res);
  }

  /// 文件上传
  /// File upload
  static Future<BaseModel> upload(String url, dynamic data,
      {ProgressCallback? onSendProgress,
      bool loading = true,
      CancelToken? cancelToken}) async {
    _addLoading(loading);
    _initBaseOptions(url);
    final ResponseModel res = await dioTools.upload<dynamic>(url,
        data: data,
        options: _baseOptions,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken);
    return _response(res);
  }

  /// 文件下载
  /// File download
  static Future<ResponseModel> download(String url, String savePath,
          {ProgressCallback? onReceiveProgress,
          CancelToken? cancelToken,
          BaseOptions? options}) =>
      dioTools.download(url, savePath,
          onReceiveProgress: onReceiveProgress, options: options);

  static void _addLoading(bool? loading) {
    if ((loading ?? false) && _loading == null) _loading = alertLoading();
  }

  static Future<void> _removeLoading() async {
    await 500.milliseconds.delayed(() {});
    if (_loading != null) {
      _loading!.removeEntry();
      _loading = null;
    }
  }

  static void _sendRefreshStatus() {
    if (pullDown) {
      pullDown = false;
      sendRefreshType(EasyRefreshType.refreshSuccess);
    }
    if (pullUp) {
      pullUp = false;
      sendRefreshType(EasyRefreshType.loadingSuccess);
    }
  }

  static void _initBaseOptions(String url) {
    final Map<String, String> _headers = <String, String>{
      'Content-Type': 'application/json;charset=UTF-8'
    };
    if (_header != null) _headers.addAll(_header!(url));
    _baseOptions.headers = _headers;
  }

  static BaseModel _response(ResponseModel res, [bool failure = true]) {
    _removeLoading();
    _sendRefreshStatus();
    if (res.statusCode == 401 && failure) {
      showToast('登陆失效');
      _failure?.call();
      return BaseModel(code: '401', msg: '登陆失效');
    }
    BaseModel baseModel =
        BaseModel(code: UConstant.failedCode, msg: '服务器数据解析失败');

    dynamic data = res.data;
    if (data != null && data is String && data.contains('"')) {
      try {
        data = jsonDecode(res.data.toString());
      } catch (e) {
        if (res.statusMessage != null) baseModel.msg = res.statusMessage!;
        if (res.error != null) baseModel.msg = res.error.toString();
      }
    } else if (data is Map) {
      baseModel = BaseModel.fromJson(data as Map<String, dynamic>?);
    } else {
      if (res.statusMessage != null) baseModel.msg = res.statusMessage!;
      if (res.error != null) baseModel.msg = res.error.toString();
      baseModel.data = res.data;
    }
    if (baseModel.code == '401' && failure) {
      showToast('登录失效,请重新登录');
      _failure?.call();
    }
    return baseModel;
  }
}
