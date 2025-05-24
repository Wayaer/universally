import 'dart:async';

import 'package:universally/universally.dart';

/// 返回 false 不再继续执行其他方法
/// 返回 true 继续执行其他方法
typedef ConnectivityListenCallback = Future<bool> Function(bool status, List<ConnectivityResult> result);

typedef UnavailableNetworkAlertBuilder = FlOverlayEntry? Function(bool status, List<ConnectivityResult> result);

/// 网络状态变化管理
class ConnectivityPlus {
  factory ConnectivityPlus() => _singleton ??= ConnectivityPlus._();

  ConnectivityPlus._();

  static ConnectivityPlus? _singleton;

  final connectivity = Connectivity();

  final List<ConnectivityListenCallback> _listenerList = [];

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  List<ConnectivityResult> _currentResult = [];

  /// 当前网络状态
  List<ConnectivityResult> get current => _currentResult;

  /// 网络是否可用
  bool get networkAvailability {
    bool availability = false;
    for (var element in _currentResult) {
      if (element != ConnectivityResult.none) {
        availability = true;
        continue;
      }
    }
    return availability;
  }

  /// 订阅网络监听
  Future<void> subscription({
    /// 网络不可用 时 弹出 Overlay 禁止操作
    UnavailableNetworkAlertBuilder? popupUnavailableNetwork,
  }) async {
    if (_subscription != null) return;
    'Connectivity 初始化'.log(crossLine: false);

    /// 添加模态框
    if (popupUnavailableNetwork != null) {
      _overlayCallback ??= (_, __) => showOverlayWhenUnavailableNetwork(popupUnavailableNetwork);
      _listenerList.add(_overlayCallback!);
    }
    await checkConnectivity();
    _subscription = connectivity.onConnectivityChanged.listen((List<ConnectivityResult> connectivityResult) async {
      if (_currentResult.toString() == connectivityResult.toString()) return;
      _currentResult = connectivityResult;
      'Connectivity 网络状态变化 $_currentResult'.log(crossLine: false);
      _callListenerList();
    });
  }

  /// 重新检查是否链接网络
  Future<void> checkConnectivity() async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (_currentResult.toString() == connectivityResult.toString()) return;
    _currentResult = connectivityResult;
    'Connectivity result $_currentResult'.log(crossLine: false);
    _callListenerList();
  }

  Future<void> _callListenerList() async {
    for (var element in _listenerList) {
      final value = await element.call(networkAvailability, _currentResult);
      if (!value) break;
    }
  }

  /// 添加 需要根据网络变化执行的方法
  bool addListener(ConnectivityListenCallback callback) {
    if (!_listenerList.contains(callback)) {
      _listenerList.add(callback);
    }
    return _listenerList.contains(callback);
  }

  /// 移除 需要根据网络变化执行的方案
  bool removeListener(ConnectivityListenCallback callback) => _listenerList.remove(callback);

  ConnectivityListenCallback? _overlayCallback;

  FlOverlayEntry? _connectivityOverlay;

  /// 网络不可用 时 弹出 Overlay 禁止操作
  Future<bool> showOverlayWhenUnavailableNetwork(UnavailableNetworkAlertBuilder popupUnavailableNetwork) async {
    if (!networkAvailability) {
      _connectivityOverlay ??= popupUnavailableNetwork(networkAvailability, _currentResult);
    } else {
      _connectivityOverlay?.remove();
      _connectivityOverlay = null;
    }
    return true;
  }

  void dispose() {
    _overlayCallback = null;
    _listenerList.clear();
    _subscription?.cancel();
    _subscription = null;
  }
}
