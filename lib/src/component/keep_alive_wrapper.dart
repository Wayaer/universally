import 'package:fl_extended/fl_extended.dart';
import 'package:flutter/material.dart';

class AutomaticKeepAliveWrapper extends StatefulWidget {
  const AutomaticKeepAliveWrapper(this.child, {super.key});

  final Widget child;

  @override
  State<AutomaticKeepAliveWrapper> createState() =>
      _AutomaticKeepAliveWrapperState();
}

class _AutomaticKeepAliveWrapperState
    extends AutomaticKeepAliveWrapperState<AutomaticKeepAliveWrapper> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

abstract class AutomaticKeepAliveWrapperState<T extends StatefulWidget>
    extends ExtendedState<T> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
}
