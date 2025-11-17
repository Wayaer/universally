import 'package:universally/universally.dart';

class TaskDetail {
  TaskDetail({required this.id, required this.onExecute});

  /// 任务 id
  final String id;

  /// 任务执行方法
  final CallbackFuture onExecute;
}

class TaskQueue {
  factory TaskQueue() => instance;

  TaskQueue._();

  static TaskQueue? _singleton;

  static TaskQueue get instance => _singleton ??= TaskQueue._();

  /// 队列
  final List<TaskDetail> _queue = [];

  /// 是否正在处理
  bool _isProcessing = false;

  /// 是否再执行任务
  bool get isProcessing => _isProcessing;

  /// 添加任务到队列
  void add(TaskDetail task) {
    bool exists = _queue.where((e) => e.id == task.id).isNotEmpty;
    if (!exists) _queue.add(task);
    _processQueue();
  }

  /// 移除任务
  void remove(String id) {
    _queue.removeWhere((e) => e.id == id);
  }

  /// 处理队列中的任务
  Future<void> _processQueue() async {
    if (_isProcessing) return;
    _isProcessing = true;
    while (_queue.isNotEmpty) {
      TaskDetail task = _queue.first;
      await task.onExecute();
      _queue.remove(task);
    }
    _isProcessing = false;
  }
}
