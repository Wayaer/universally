import 'package:flutter/material.dart';

class AutomaticKeepAliveWrapper extends StatefulWidget {
  const AutomaticKeepAliveWrapper(this.child, {super.key});

  final Widget child;

  @override
  State<AutomaticKeepAliveWrapper> createState() =>
      _AutomaticKeepAliveWrapperState();
}

class _AutomaticKeepAliveWrapperState extends State<AutomaticKeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
