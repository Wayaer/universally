import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SpinKitPage extends StatelessWidget {
  const SpinKitPage({super.key});

  @override
  Widget build(BuildContext context) {
    const styles = SpinKitStyle.values;
    return BaseScaffold(
        appBarTitleText: 'SpinKit',
        padding: const EdgeInsets.all(10),
        child: BaseList(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(child: SpinKit(styles[index]));
          },
          itemCount: styles.length,
        ));
  }
}
