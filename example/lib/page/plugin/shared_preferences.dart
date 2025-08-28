import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  String text = '';

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
          child: FlText(text),
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
                  text = 'call setString() result: $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getString',
              onTap: () {
                final value = BasePreferences().getString('String Key');
                text = 'call getString() result: $value';
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
                  text = 'call setBool() result: $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getBool',
              onTap: () {
                final value = BasePreferences().getBool('bool Key');
                text = 'call getBool() result: $value';
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
                  text = 'call setDouble() result: $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getDouble',
              onTap: () {
                final value = BasePreferences().getDouble('double Key');
                text = 'call getDouble() result: $value';
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
                  text = 'call setInt() result: $value';
                  setState(() {});
                });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getInt',
              onTap: () {
                final value = BasePreferences().getInt('int Key');
                text = 'call getInt() result: $value';
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
                      text = 'call setMap() result: $value';
                      setState(() {});
                    });
              },
            ),
            const SizedBox(width: 20),
            Button(
              text: 'getMap',
              onTap: () {
                final value = BasePreferences().getMap('map Key');
                text = 'call getMap() result: $value';
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
                      text = 'call setStringList() result: $value';
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
                text = 'call getStringList() result: $value';
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
}
