import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class CancelableOperationsPage extends StatefulWidget {
  const CancelableOperationsPage({super.key});

  @override
  State<CancelableOperationsPage> createState() =>
      _CancelableOperationsPageState();
}

class _CancelableOperationsPageState extends State<CancelableOperationsPage>
    with CancelableOperationsMixin {
  @override
  void initState() {
    super.initState();
    final cancelable = addCancelableOperation(future().toCancelableOperation());
    addPostFrameCallback((_) async {
      await cancelable.value;
    });
  }

  Future<void> future() async {
    for (var i = 0; i < 20; i++) {
      await 2.seconds.delayed();
      debugPrint('CancelableOperations index: $i');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: 'CancelableOperations',
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextLarge('add cancelable operation'),
        TextLarge('cancel all operation'),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    cancelAllOperation();
  }
}
