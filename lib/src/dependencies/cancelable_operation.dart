import 'dart:async';
import 'package:async/async.dart';

extension CancelableOperationExtensionWithFuture<T> on Future<T> {
  CancelableOperation<T> toCancelableOperation({FutureOr Function()? onCancel}) =>
      CancelableOperation<T>.fromFuture(this, onCancel: onCancel);
}

extension CancelableOperationExtensionWithT<T> on T {
  CancelableOperation<T> toCancelableOperation() => CancelableOperation<T>.fromValue(this);
}

extension CancelableOperationExtensionWithStreamSubscription on StreamSubscription<void> {
  CancelableOperation<void> toCancelableOperation() => CancelableOperation.fromSubscription(this);
}

mixin CancelableOperationsMixin {
  final List<CancelableOperation> _cancelableOperations = [];

  List<CancelableOperation> get cancelableOperations => _cancelableOperations;

  CancelableOperation<T> addCancelableOperation<T>(CancelableOperation<T> cancelableOperation) {
    _cancelableOperations.add(cancelableOperation);
    return cancelableOperation;
  }

  void cancelOperation(CancelableOperation cancelableOperation) {
    if (!cancelableOperation.isCanceled) {
      cancelableOperation.cancel();
      _cancelableOperations.remove(cancelableOperation);
    }
  }

  void cancelAllOperation() {
    for (var cancelableOperation in _cancelableOperations) {
      if (!cancelableOperation.isCanceled) {
        cancelableOperation.cancel();
      }
    }
    _cancelableOperations.clear();
  }
}
