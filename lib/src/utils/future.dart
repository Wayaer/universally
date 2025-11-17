import 'dart:async';

import 'package:async/async.dart';
import 'package:synchronized/synchronized.dart';

/// 全局的 Future 任务取消管理类
class FutureCancelable {
  factory FutureCancelable() => instance;

  FutureCancelable._();

  static FutureCancelable? _singleton;

  static FutureCancelable get instance => _singleton ??= FutureCancelable._();

  /// 全局的 Future 任务取消映射
  final Map<Object, CancelableOperation> _cancelableOpMap = {};

  /// 获取指定 id 的 Future 任务取消操作
  CancelableOperation? get(Object id) => _cancelableOpMap[id];

  /// 运行最新的 Future 任务，取消之前的任务
  Future<T> runLatest<T>(Object id, Future<T> future, {FutureOr Function()? onCancel}) async {
    await _cancelableOpMap[id]?.cancel();
    final cancelableOperation = CancelableOperation.fromFuture(future, onCancel: onCancel);
    _cancelableOpMap[id] = cancelableOperation;
    try {
      return await cancelableOperation.value;
    } finally {
      /// 仅移除当前任务（若仍在映射中）
      if (_cancelableOpMap[id] == cancelableOperation) {
        _cancelableOpMap.remove(id);
      }
    }
  }
}

extension FutureCancelableExtension<T> on Future<T> {
  /// 取消指定 id 的 Future 任务
  Future<T> runLatest(Object id) {
    return FutureCancelable.instance.runLatest(id, this);
  }
}

/// 全局的 Future 任务lock管理类
class FutureLock {
  factory FutureLock() => instance;

  FutureLock._();

  static FutureLock? _singleton;

  static FutureLock get instance => _singleton ??= FutureLock._();

  /// 全局的 Future 任务lock映射
  final Map<Object, Lock> _lockMap = {};

  /// 获取指定 id 的 Future 任务取消操作
  Lock? get(Object id) => _lockMap[id];

  /// 运行指定 id 的 Future 任务，等待锁释放后执行
  Future<T> runLock<T>(Object id, FutureOr<T> computation, {Duration? timeout}) async {
    final lock = _lockMap.putIfAbsent(id, () => Lock());
    return await lock.synchronized(() async => await computation, timeout: timeout);
  }

  /// 判断指定 id 的锁是否被占用
  bool isLocked(Object id) {
    final lock = _lockMap[id];
    return lock?.locked ?? false;
  }

  /// 移除指定 id 的锁（谨慎使用，确保该 id 后续无任务）
  void remove(Object id) {
    _lockMap.remove(id);
  }
}

extension FutureLockExtension<T> on FutureOr<T> {
  /// 运行指定 id 的 Future 任务，等待锁释放后执行
  Future<T> runLock(Object id, {Duration? timeout}) {
    return FutureLock.instance.runLock(id, this, timeout: timeout);
  }
}
