import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        appBarTitleText: 'Component',
        isScroll: true,
        children: const [
          BasicError(),
          CheckboxWithUserPrivacy(value: false),
          PushSwitchState(),
        ]);
  }
}
