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
    BHP().box().path.log();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        isScroll: true,
        padding: const EdgeInsets.all(12),
        appBarTitleText: 'BHP Demo',
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
            Button(
                text: 'setString',
                onTap: () {
                  BHP().setString('String Key', 'String value').then((value) {
                    text = 'call setString() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            Button(
                text: 'getString',
                onTap: () {
                  final value = BHP().getString('String Key');
                  text = 'call getString() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Button(
                text: 'setBool',
                onTap: () {
                  BHP().setBool('bool Key', true).then((value) {
                    text = 'call setBool() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            Button(
                text: 'getBool',
                onTap: () {
                  final value = BHP().getBool('bool Key');
                  text = 'call getBool() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Button(
                text: 'setDouble',
                onTap: () {
                  BHP().setDouble('double Key', 2.33).then((value) {
                    text = 'call setDouble() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            Button(
                text: 'getDouble',
                onTap: () {
                  final value = BHP().getDouble('double Key');
                  text = 'call getDouble() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Button(
                text: 'setInt',
                onTap: () {
                  BHP().setInt('int Key', 233).then((value) {
                    text = 'call setInt() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            Button(
                text: 'getInt',
                onTap: () {
                  final value = BHP().getInt('int Key');
                  text = 'call getInt() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Button(
                text: 'setMap',
                onTap: () {
                  BHP().setMap('map Key', {'1': 'value1', '2': 'value2'}).then(
                      (value) {
                    text = 'call setMap() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            Button(
                text: 'getMap',
                onTap: () {
                  final value = BHP().getMap('map Key');
                  text = 'call getMap() $value';
                  setState(() {});
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Button(
                text: 'setStringList',
                onTap: () {
                  BHP().setStringList('list<String> Key', ['1', '2', '3']).then(
                      (value) {
                    text = 'call setStringList() $value';
                    setState(() {});
                  });
                }),
            const SizedBox(width: 20),
            Button(
                text: 'getStringList',
                onTap: () {
                  final value = BHP().getStringList('list<String> Key');
                  text = 'call getStringList() $value';
                  setState(() {});
                }),
          ]),
        ]);
  }
}
