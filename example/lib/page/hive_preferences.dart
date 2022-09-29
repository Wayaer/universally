import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class HivePreferencesPage extends StatefulWidget {
  const HivePreferencesPage({Key? key}) : super(key: key);

  @override
  State<HivePreferencesPage> createState() => _HivePreferencesPageState();
}

class _HivePreferencesPageState extends State<HivePreferencesPage> {
  String text = '';

  @override
  void initState() {
    super.initState();
    log(BHP().box()?.path);
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitle: 'BHP Demo',
        children: [
          Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4)),
              width: double.infinity,
              child: BText(text)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedText(
                text: 'setString',
                onPressed: () {
                  BHP().setString('String Key', 'String value').then((value) {
                    text = 'call setString() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            ElevatedText(
                text: 'getString',
                onPressed: () {
                  final value = BHP().getString('String Key');
                  text = 'call getString() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedText(
                text: 'setBool',
                onPressed: () {
                  BHP().setBool('bool Key', true).then((value) {
                    text = 'call setBool() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            ElevatedText(
                text: 'getBool',
                onPressed: () {
                  final value = BHP().getBool('bool Key');
                  text = 'call getBool() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedText(
                text: 'setDouble',
                onPressed: () {
                  BHP().setDouble('double Key', 2.33).then((value) {
                    text = 'call setDouble() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            ElevatedText(
                text: 'getDouble',
                onPressed: () {
                  final value = BHP().getDouble('double Key');
                  text = 'call getDouble() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedText(
                text: 'setInt',
                onPressed: () {
                  BHP().setInt('int Key', 233).then((value) {
                    text = 'call setInt() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            ElevatedText(
                text: 'getInt',
                onPressed: () {
                  final value = BHP().getInt('int Key');
                  text = 'call getInt() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedText(
                text: 'setMap',
                onPressed: () {
                  BHP().setMap('map Key', {'1': 'value1', '2': 'value2'}).then(
                      (value) {
                    text = 'call setMap() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            ElevatedText(
                text: 'getMap',
                onPressed: () {
                  final value = BHP().getMap('map Key');
                  text = 'call getMap() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedText(
                text: 'setStringList',
                onPressed: () {
                  BHP().setStringList('list<String> Key', ['1', '2', '3']).then(
                      (value) {
                    text = 'call setStringList() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            ElevatedText(
                text: 'getStringList',
                onPressed: () {
                  final value = BHP().getStringList('list<String> Key');
                  text = 'call getStringList() $value';
                  setState(() {});
                }),
          ]),
        ]);
  }
}
