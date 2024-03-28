import 'dart:async';
import 'dart:convert';

import 'package:universally/universally.dart';

/// FormData ContentType
const String kContentTypeWithFormData = 'multipart/form-data';

/// TextXml ContentType
const String kContentTypeWithTextXml = 'text/xml';

/// 扩展所有的 header
typedef ValueCallbackHeader = Map<String, String>? Function(String url);

/// 扩展所有的 params
typedef ValueCallbackParams = Map<String, dynamic>? Function(
    String path, Map<String, dynamic>? params);

/// 扩展所有的 uri
typedef ValueCallbackUri = Uri Function(Uri uri);

/// 扩展所有的 data
typedef ValueCallbackData<T> = T Function(String path, T params);

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

typedef BaseDioErrorIntercept = List<InterceptorError> Function(
    String path, dynamic tag);

enum BaseDioState {
  /// 无网络
  noNotwork,
}

typedef BaseDioBuildBaseModelState = BaseModel Function(BaseDioState state);

class BaseDioOptions extends BaseOptions {
  BaseDioOptions({
    /// 接收超时时间
    super.receiveTimeout = const Duration(seconds: 5),

    /// 连接超时时间
    super.connectTimeout = const Duration(seconds: 5),

    /// 发送超时时间
    super.sendTimeout = const Duration(seconds: 5),
    this.extraHeader,
    this.extraData,
    this.extraUriData,
    this.extraParams,
    this.extraUri,
    this.errorIntercept,
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
    this.hideCode = const ['0'],
    this.successCode = const ['200'],
    this.enableLoading = true,
    this.enablePullHideLoading = true,
    this.enableCheckNetwork = true,
    this.buildBaseModelState,
  });

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
  BaseDioErrorIntercept? errorIntercept;

  /// BaseModel 后台返回状态码
  List<String> codeKeys;

  /// BaseModel 后台返回message
  List<String> msgKeys;

  /// BaseModel 后台返回具体数据
  List<String> dataKeys;

  /// BaseModel 后台返回扩展数据
  List<String> extensionKeys;

  /// 后台返回成功的状态码
  /// 主要用于 网络请求返回 判断方法[resultSuccessFail]
  List<String> successCode;

  /// 后台返回 message 隐藏 toast
  /// 主要用于 网络请求返回 判断方法[resultSuccessFail]
  List<String> hideMsg;

  /// 后台返回 code 隐藏 toast
  /// 主要用于 网络请求返回 判断方法[resultSuccessFail]
  List<String> hideCode;

  /// 全局是否启用loading
  bool enableLoading;

  /// 刷新组件 下拉或上拉 隐藏loading，默认为true
  bool enablePullHideLoading;

  /// 构建默认 [BaseModel]
  BaseDioBuildBaseModelState? buildBaseModelState;

  /// 使用 [ConnectivityPlus] 校验网络状态
  bool enableCheckNetwork;
}

class BaseDio {
  factory BaseDio() => _singleton ??= BaseDio._();

  BaseDio._();

  static BaseDio? _singleton;

  late ExtendedDio dio;
  late ExtendedDio dioDownload;

  BaseDioOptions baseDioOptions = BaseDioOptions();

  BaseDio initialize({
    BaseDioOptions? options,
    BaseDioOptions? downloadOptions,
    List<InterceptorsWrapper> interceptors = const [],
  }) {
    if (options != null) baseDioOptions = options;
    dio = ExtendedDio(baseDioOptions)..interceptors.addAll(interceptors);
    dioDownload = ExtendedDio(downloadOptions)
      ..interceptors.addAll(interceptors);
    return this;
  }

  Future<BaseModel> get<T>(
    String path, {
    dynamic tag,
    Map<String, dynamic>? params,
    Object? data,
    bool? loading,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    final res = await dio.get<T>(path,
        data: data,
        options: _mergeOptions(options, path),
        cancelToken: cancelToken,
        queryParameters:
            baseDioOptions.extraParams?.call(path, params) ?? params);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> getUri<T>(
    Uri uri, {
    dynamic tag,
    Object? data,
    bool? loading,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.getUri<T>(uri,
        data: data,
        cancelToken: cancelToken,
        options: _mergeOptions(options, uri.path));
    return _handleResponse(res, tag);
  }

  Future<BaseModel> post<T>(
    String path, {
    Map<String, dynamic>? params,
    Object? data,
    bool dataToJson = true,
    dynamic tag,
    bool? loading,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraData?.call(path, data) ?? data;
    final res = await dio.post<T>(path,
        options: _mergeOptions(options, path),
        queryParameters:
            baseDioOptions.extraParams?.call(path, params) ?? params,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> postUri<T>(
    Uri uri, {
    Object? data,
    bool dataToJson = true,
    dynamic tag,
    bool? loading,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.postUri<T>(uri,
        options: _mergeOptions(options, uri.path),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> put<T>(
    String path, {
    Map<String, dynamic>? params,
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraData?.call(path, data) ?? data;
    final res = await dio.put<T>(path,
        options: _mergeOptions(options, path),
        queryParameters:
            baseDioOptions.extraParams?.call(path, params) ?? params,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> putUri<T>(
    Uri uri, {
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.putUri<T>(uri,
        options: _mergeOptions(options, uri.path),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> delete<T>(
    String path, {
    Map<String, dynamic>? params,
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraData?.call(path, data) ?? data;
    final res = await dio.delete<T>(path,
        options: _mergeOptions(options, path),
        queryParameters:
            baseDioOptions.extraParams?.call(path, params) ?? params,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> deleteUri<T>(
    Uri uri, {
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.deleteUri<T>(uri,
        options: _mergeOptions(options, uri.path),
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> patch<T>(
    String path, {
    Map<String, dynamic>? params,
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraData?.call(path, data) ?? data;
    final res = await dio.patch<T>(path,
        options: _mergeOptions(options, path),
        queryParameters:
            baseDioOptions.extraParams?.call(path, params) ?? params,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> patchUri<T>(
    Uri uri, {
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.patchUri<T>(uri,
        options: _mergeOptions(options, uri.path),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> head<T>(
    String path, {
    Map<String, dynamic>? params,
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraData?.call(path, data) ?? data;
    final res = await dio.head<T>(path,
        options: _mergeOptions(options, path),
        queryParameters:
            baseDioOptions.extraParams?.call(path, params) ?? params,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> headUri<T>(
    Uri uri, {
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.headUri<T>(uri,
        options: _mergeOptions(options, uri.path),
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> request<T>(
    String path, {
    Map<String, dynamic>? params,
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraData?.call(path, data) ?? data;

    final res = await dio.request<T>(path,
        options: _mergeOptions(options, path),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        queryParameters:
            baseDioOptions.extraParams?.call(path, params) ?? params,
        cancelToken: cancelToken,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  Future<BaseModel> requestUri<T>(
    Uri uri, {
    Object? data,
    dynamic tag,
    bool? loading,
    bool dataToJson = true,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraUriData?.call(uri, data) ?? data;
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.requestUri<T>(uri,
        options: _mergeOptions(options, uri.path),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        data: dataToJson ? jsonEncode(data) : data);
    return _handleResponse(res, tag);
  }

  /// 文件上传
  /// File upload
  Future<BaseModel> upload<T>(String path, Object? data,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool? loading,
      Options? options,
      dynamic tag,
      CancelToken? cancelToken,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    final res = await dio.post<T>(path,
        data: baseDioOptions.extraData?.call(path, data) ?? data,
        options: (_mergeOptions(options, path) ?? Options())
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
    return _handleResponse(res, tag);
  }

  /// 文件上传
  /// File upload
  Future<BaseModel> uploadUri<T>(Uri uri, Object? data,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool? loading,
      Options? options,
      dynamic tag,
      CancelToken? cancelToken,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.postUri<T>(uri,
        data: baseDioOptions.extraUriData?.call(uri, data) ?? data,
        options: (_mergeOptions(options, uri.path) ?? Options())
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress);
    return _handleResponse(res, tag);
  }

  /// 文件下载
  /// File download
  Future<BaseModel> download(String path, String savePath,
      {bool? loading,
      dynamic tag,
      Options? options,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      Object? data,
      bool dataToJson = true,
      Map<String, dynamic>? params,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = baseDioOptions.extraData?.call(path, data) ?? data;
    final res = await dio.download(path, savePath,
        onReceiveProgress: onReceiveProgress,
        options: (_mergeOptions(options, path) ?? Options())
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        data: dataToJson ? jsonEncode(data) : data,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        cancelToken: cancelToken);
    return _handleResponse(res, tag);
  }

  /// 文件下载
  /// File download
  Future<BaseModel> downloadUri(Uri uri, String savePath,
      {bool? loading,
      dynamic tag,
      Options? options,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      Object? data,
      bool dataToJson = true,
      Map<String, dynamic>? params,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      Duration receiveTimeout = const Duration(seconds: 40),
      Duration sendTimeout = const Duration(seconds: 40)}) async {
    assert(_singleton != null, '请先调用 initialize');
    if (await checkNetwork) return buildBaseModel;
    _addLoading(loading);
    data = jsonEncode(baseDioOptions.extraUriData?.call(uri, data) ?? data);
    uri = baseDioOptions.extraUri?.call(uri) ?? uri;
    final res = await dio.downloadUri(uri, savePath,
        onReceiveProgress: onReceiveProgress,
        options: (_mergeOptions(options, uri.path) ?? Options())
            .copyWith(receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
        data: dataToJson ? jsonEncode(data) : data,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        cancelToken: cancelToken);
    return _handleResponse(res, tag);
  }

  ExtendedOverlayEntry? loadingEntry;

  void _addLoading(bool? loading) {
    bool enableLoading = loading ?? baseDioOptions.enableLoading;
    if (enableLoading && baseDioOptions.enablePullHideLoading) {
      enableLoading = !(pullDown || pullUp);
    }
    if (enableLoading && loadingEntry == null) loadingEntry = showLoading();
  }

  void _removeLoading() {
    200.milliseconds.delayed(() {
      loadingEntry?.removeEntry();
      loadingEntry = null;
    });
  }

  Future<bool> get checkNetwork async {
    if (baseDioOptions.enableCheckNetwork) {
      await ConnectivityPlus().checkConnectivity();
      var network = ConnectivityPlus().networkAvailability;
      if (!network) {
        _removeLoading();
        1.seconds.delayed(_sendRefreshStatus);
      }
      return !network;
    }
    return false;
  }

  BaseModel get buildBaseModel =>
      baseDioOptions.buildBaseModelState?.call(BaseDioState.noNotwork) ??
      BaseModel(data: null, code: '500', msg: '无法连接服务器');

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

  Options? _mergeOptions(Options? options, String url) {
    final extraHeader = baseDioOptions.extraHeader?.call(url);
    if (options != null || extraHeader != null) {
      options ??= Options();
      final Map<String, dynamic> headers = {};
      if (extraHeader != null) headers.addAll(extraHeader);
      if (options.headers != null) headers.addAll(options.headers!);
      return options.copyWith(headers: headers);
    }
    return null;
  }

  BaseModel _handleResponse(ExtendedResponse res, dynamic tag) {
    _removeLoading();
    _sendRefreshStatus();
    BaseModel baseModel = BaseModel(
        headers: res.headers.map,
        code: '${res.statusCode}',
        msg: buildBaseModel.msg,
        statusCode: res.statusCode,
        statusMessage: res.statusMessage,
        data: res.data,
        original: res);
    Object? data = baseModel.data;
    if (data is ResponseBody) {
      return BaseModel(
          headers: data.headers,
          code: '${data.statusCode}',
          msg: data.statusMessage ?? buildBaseModel.msg,
          statusCode: data.statusCode,
          statusMessage: data.statusMessage,
          data: res.data,
          original: res);
    } else if (data != null && data is String && data.contains('"')) {
      try {
        data = jsonDecode(data);
      } catch (e) {
        'jsonDecode catch : \n$e'.log();
      }
      if (data is Map) {
        baseModel = BaseModel.fromJson(data as Map<String, dynamic>?, res);
      }
    } else if (data is Map) {
      baseModel = BaseModel.fromJson(data as Map<String, dynamic>?, res);
    }
    var errorIntercepts =
        baseDioOptions.errorIntercept?.call(res.realUri.toString(), tag);
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
class BaseModel {
  BaseModel({
    this.data,
    this.extension,
    this.original,
    required this.code,
    this.statusCode,
    required this.msg,
    this.statusMessage,
    this.headers,
  });

  BaseModel.fromJson(Map<String, dynamic>? json, ExtendedResponse response) {
    statusCode = response.statusCode;
    statusMessage = response.statusMessage;
    code = statusCode.toString();
    msg = '服务器异常';
    original = response;
    if (json != null) {
      final dioOptions = BaseDio().baseDioOptions;
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
  ExtendedResponse? original;

  /// 后台定义的 code
  late String code;

  /// 后台定义的 msg
  late String msg;

  Map<String, List<String>>? headers;

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
bool resultSuccessFail(BaseModel data, {String? text, bool nullPass = false}) {
  if (BaseDio().baseDioOptions.successCode.contains(data.code) &&
      (nullPass || data.data != null)) {
    if (text != null) showToast(text);
    return true;
  } else {
    if (!(BaseDio().baseDioOptions.hideMsg.contains(data.msg) ||
        BaseDio().baseDioOptions.hideCode.contains(data.code))) {
      showToast(data.msg);
    }
    return false;
  }
}

void logJson(dynamic data) {
  try {
    var json = jsonEncode(data is BaseModel ? data.toMap() : data);
    json.log();
  } catch (e) {
    e.log();
  }
}
