import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  final TextEditingController key = TextEditingController(text: 'demo_key');
  final TextEditingController value = TextEditingController(text: 'demo_value');
  String result = '';

  Future<void> run(String name, Future<void> Function() callback) async {
    await callback();
    setState(() => result = '$name 执行完成\n当前 keys: ${BasePreferences().keys.join(', ')}');
  }

  @override
  void dispose() {
    key.dispose();
    value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: '本地存储',
    children: [
      DemoSection(
        title: 'BasePreferences',
        description: '基于 shared_preferences 的统一 key-value 存储封装。',
        children: [
          BaseTextField(
            controller: key,
            hintText: 'key',
            margin: const EdgeInsets.only(bottom: 8),
            enableClearIcon: true,
          ),
          BaseTextField(
            controller: value,
            hintText: 'value',
            margin: const EdgeInsets.only(bottom: 8),
            enableClearIcon: true,
          ),
          DemoResult(text: result),
          const SizedBox(height: 6),
          DemoButton(
            text: 'setString / getString',
            onTap: () => run('setString', () async {
              await BasePreferences().setString(key.text, value.text);
              setState(() => result = 'getString: ${BasePreferences().getString(key.text)}');
            }),
          ),
          DemoButton(
            text: 'setInt / getInt',
            onTap: () => run('setInt', () async {
              await BasePreferences().setInt(key.text, 42);
              setState(() => result = 'getInt: ${BasePreferences().getInt(key.text)}');
            }),
          ),
          DemoButton(
            text: 'setBool / getBool',
            onTap: () => run('setBool', () async {
              await BasePreferences().setBool(key.text, true);
              setState(() => result = 'getBool: ${BasePreferences().getBool(key.text)}');
            }),
          ),
          DemoButton(
            text: 'setDouble / getDouble',
            onTap: () => run('setDouble', () async {
              await BasePreferences().setDouble(key.text, 3.14);
              setState(() => result = 'getDouble: ${BasePreferences().getDouble(key.text)}');
            }),
          ),
          DemoButton(
            text: 'setStringList / getStringList',
            onTap: () => run('setStringList', () async {
              await BasePreferences().setStringList(key.text, ['a', 'b', 'c']);
              setState(() => result = 'getStringList: ${BasePreferences().getStringList(key.text)}');
            }),
          ),
          DemoButton(
            text: 'setMap / getMap',
            onTap: () => run('setMap', () async {
              await BasePreferences().setMap(key.text, {'name': 'Universally', 'version': 12});
              setState(() => result = 'getMap: ${BasePreferences().getMap(key.text)}');
            }),
          ),
          DemoButton(
            text: 'setEncodeList / getDecodeList',
            onTap: () => run('setEncodeList', () async {
              await BasePreferences().setEncodeList(key.text, [
                {'a': 1},
                {'b': 2},
              ]);
              setState(() => result = 'getDecodeList: ${BasePreferences().getDecodeList(key.text)}');
            }),
          ),
          DemoButton(
            text: 'get / keys / reload',
            onTap: () => run('get', () async {
              setState(
                () => result =
                    'get: ${BasePreferences().get(key.text)}\nreload: ${BasePreferences().reload()}\nkeys: ${BasePreferences().keys.join(', ')}',
              );
            }),
          ),
          DemoButton(
            text: 'remove',
            onTap: () => run('remove', () async {
              await BasePreferences().remove(key.text);
            }),
          ),
          DemoButton(
            text: 'clear',
            onTap: () => run('clear', () async {
              await BasePreferences().clear();
            }),
          ),
        ],
      ),
    ],
  );
}
