import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class HivePreferencesPage extends StatefulWidget {
  const HivePreferencesPage({super.key});

  @override
  State<HivePreferencesPage> createState() => _HivePreferencesPageState();
}

class _HivePreferencesPageState extends State<HivePreferencesPage> {
  String text = '';

  @override
  void initState() {
    super.initState();
    BasePreferences().box().path.log();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isScroll: true,
      padding: const EdgeInsets.all(12),
      appBarTitleText: 'BasePreferences Demo',
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(4),
          ),
          width: double.infinity,
          child: BText(text),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'setString',
              onTap: () {
                BasePreferences().setString('String Key', 'String value').then((
                  value,
                ) {
                  text = 'call setString() $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getString',
              onTap: () {
                final value = BasePreferences().getString('String Key');
                text = 'call getString() $value';
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'setBool',
              onTap: () {
                BasePreferences().setBool('bool Key', true).then((value) {
                  text = 'call setBool() $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getBool',
              onTap: () {
                final value = BasePreferences().getBool('bool Key');
                text = 'call getBool() $value';
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'setDouble',
              onTap: () {
                BasePreferences().setDouble('double Key', 2.33).then((value) {
                  text = 'call setDouble() $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getDouble',
              onTap: () {
                final value = BasePreferences().getDouble('double Key');
                text = 'call getDouble() $value';
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'setInt',
              onTap: () {
                BasePreferences().setInt('int Key', 233).then((value) {
                  text = 'call setInt() $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getInt',
              onTap: () {
                final value = BasePreferences().getInt('int Key');
                text = 'call getInt() $value';
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'setMap',
              onTap: () {
                BasePreferences()
                    .setMap('map Key', {'1': 'value1', '2': 'value2'})
                    .then((value) {
                      text = 'call setMap() $value';
                      setState(() {});
                    });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getMap',
              onTap: () {
                final value = BasePreferences().getMap('map Key');
                text = 'call getMap() $value';
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'setStringList',
              onTap: () {
                BasePreferences()
                    .setStringList('list<String> Key', ['1', '2', '3'])
                    .then((value) {
                      text = 'call setStringList() $value';
                      setState(() {});
                    });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getStringList',
              onTap: () {
                final value = BasePreferences().getStringList(
                  'list<String> Key',
                );
                text = 'call getStringList() $value';
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
}
