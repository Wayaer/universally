import 'dart:async';

import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class UtilsPage extends StatefulWidget {
  const UtilsPage({super.key});

  @override
  State<UtilsPage> createState() => _UtilsPageState();
}

class _UtilsPageState extends State<UtilsPage> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '工具与扩展',
      children: [
        DemoSection(
          title: 'FutureCancelable',
          description: '同一 id 只保留最新任务，之前未完成的任务会被取消。',
          children: [
            DemoButton(
              text: 'runLatest 模拟取消',
              onTap: () async {
                setState(() => result = '开始任务 1');
                final value = await 2.seconds.delayed().then((_) => '任务 1 完成').runLatest('demo');
                setState(() => result = value);
              },
            ),
            DemoResult(text: result),
          ],
        ),
        DemoSection(
          title: 'FutureLock',
          description: '同一 id 的任务串行执行，可判断锁状态与移除锁。',
          children: [
            DemoButton(
              text: 'runLock 串行任务',
              onTap: () async {
                final values = await Future.wait([
                  Future(() async {
                    return await Future(() => '任务 A').runLock('lock');
                  }),
                  Future(() async {
                    return await 1.seconds.delayed().then((_) => '任务 B').runLock('lock');
                  }),
                ]);
                setState(() => result = values.join(' / '));
              },
            ),
            DemoButton(text: '查看锁状态', onTap: () => showToast('isLocked: ${FutureLock.instance.isLocked('lock')}')),
          ],
        ),
        DemoSection(
          title: 'TaskQueue',
          description: '按加入顺序执行任务，相同 id 不会重复入队。',
          children: [
            DemoButton(
              text: '添加 3 个任务',
              onTap: () {
                for (int i = 0; i < 3; i++) {
                  TaskQueue().add(
                    TaskDetail(
                      id: 'task$i',
                      onExecute: () async {
                        await 500.milliseconds.delayed();
                        log('执行任务 $i');
                      },
                    ),
                  );
                }
                showToast('已加入任务队列');
              },
            ),
            DemoButton(text: '查看是否处理中', onTap: () => showToast('isProcessing: ${TaskQueue().isProcessing}')),
          ],
        ),
        DemoSection(
          title: 'CancelableOperation',
          description: '基于 package:async 的 CancelableOperation，可随时取消任务。',
          children: [
            DemoButton(
              text: '创建并取消任务',
              onTap: () async {
                final operation = 2.seconds.delayed().toCancelableOperation(onCancel: () => log('已取消'));
                await 500.milliseconds.delayed();
                await operation.cancel();
                setState(() => result = '任务已取消');
              },
            ),
            DemoResult(text: result),
          ],
        ),
        DemoSection(
          title: 'BaseFutureBuilder / BaseStreamBuilder',
          description: '局部异步加载，内置等待、失败与空数据占位。',
          children: [
            SizedBox(
              height: 100,
              child: BaseFutureBuilder<String>(
                future: () => 1.seconds.delayed().then((_) => 'FutureBuilder 数据'),
                onDone: (BuildContext context, String value, Function() reset) => Center(child: TextMedium(value)),
              ),
            ),
            SizedBox(
              height: 100,
              child: BaseStreamBuilder<int>(
                stream: Stream<int>.periodic(const Duration(seconds: 1), (int index) => index).take(3),
                onDone: (BuildContext context, int? value) => Center(child: TextMedium('Stream: $value')),
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'Decimal 扩展',
          description: 'String / int / BigInt 可直接转换为 Decimal，避免浮点精度问题。',
          children: [
            TextMedium('"0.1".parseDecimal + "0.2".parseDecimal = ${'0.1'.parseDecimal + '0.2'.parseDecimal}'),
            TextMedium('10.parseDecimal = ${(10).parseDecimal}'),
            TextMedium('BigInt.from(100).parseDecimal = ${BigInt.from(100).parseDecimal}'),
          ],
        ),
        DemoSection(
          title: 'Path 扩展',
          description: 'String 上直接调用 path 包能力。',
          children: [
            TextSmall('/Users/demo/universally.zip'.basename),
            TextSmall('/Users/demo/universally.zip'.withoutExtension),
            TextSmall('/Users/demo/universally.zip'.extension()),
            TextSmall(['a', 'b', 'c'].joinAll),
            TextSmall('/Users/demo/universally.zip'.dirname),
          ],
        ),
        DemoSection(
          title: 'Widget 扩展',
          description: 'interceptNotificationListener 可拦截任意 Notification。',
          children: [
            Universal(
              height: 60,
              color: context.theme.primaryColor.withValues(alpha: 0.1),
              alignment: Alignment.center,
              child: const TextMedium('点击通知监听区域'),
            ).interceptNotificationListener<Notification>(
              onNotification: (Notification notification) {
                log('Notification: ${notification.runtimeType}');
                return true;
              },
            ),
          ],
        ),
      ],
    );
  }
}
