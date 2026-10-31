import 'dart:convert';

import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class DioPage extends StatefulWidget {
  const DioPage({super.key});

  @override
  State<DioPage> createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  BaseModel? result;
  String log = '';
  bool requesting = false;

  @override
  void initState() {
    super.initState();
    BaseDio().initialize(
      options: BaseDioOptions(
        baseUrl: 'https://httpbin.org',
        enableCheckNetwork: false,
        // 示例使用页面内的局部 Loading，避免全局 Loading 浮层拦截返回操作
        enableLoading: false,
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 8),
      ),
    );
  }

  void setResult(BaseModel model) {
    setState(() {
      result = model;
      log = jsonEncode(model.toMap());
    });
  }

  Future<void> run(Future<BaseModel> Function() request) async {
    if (requesting) return;
    setState(() => requesting = true);
    try {
      final BaseModel model = await request();
      if (mounted) setResult(model);
    } catch (error) {
      if (mounted) showToast('请求失败：$error');
    } finally {
      if (mounted) setState(() => requesting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: '网络请求',
      children: [
        DemoSection(
          title: 'BaseDioOptions',
          description: 'BaseDio 基于 FlDio，统一封装 GET / POST / PUT / DELETE / PATCH / HEAD / 上传 / 下载。',
          children: [
            DemoResult(
              text: [
                'baseUrl: ${BaseDio().baseDioOptions.baseUrl}',
                'connectTimeout: ${BaseDio().baseDioOptions.connectTimeout}',
                'receiveTimeout: ${BaseDio().baseDioOptions.receiveTimeout}',
                'successCode: ${BaseDio().baseDioOptions.successCode}',
                'codeKeys: ${BaseDio().baseDioOptions.codeKeys}',
                'msgKeys: ${BaseDio().baseDioOptions.msgKeys}',
                'dataKeys: ${BaseDio().baseDioOptions.dataKeys}',
                'enableLoading: ${BaseDio().baseDioOptions.enableLoading}',
                'enableCheckNetwork: ${BaseDio().baseDioOptions.enableCheckNetwork}',
              ].join('\n'),
            ),
          ],
        ),
        DemoSection(
          title: '请求方法',
          description: '以下请求会访问 httpbin.org，需要网络连接。请求进行中时按钮会暂时忽略重复点击。',
          children: [
            if (requesting)
              const Padding(padding: EdgeInsets.only(bottom: 12), child: LinearProgressIndicator(minHeight: 3)),
            DemoButton(
              text: 'GET',
              onTap: () => run(() => BaseDio().get('/get', params: {'page': 1})),
            ),
            DemoButton(
              text: 'POST',
              onTap: () => run(() => BaseDio().post('/post', data: {'name': 'Universally'})),
            ),
            DemoButton(
              text: 'PUT',
              onTap: () => run(() => BaseDio().put('/put', data: {'name': 'Universally'})),
            ),
            DemoButton(
              text: 'PATCH',
              onTap: () => run(() => BaseDio().patch('/patch', data: {'name': 'Universally'})),
            ),
            DemoButton(
              text: 'DELETE',
              onTap: () => run(() => BaseDio().delete('/delete', data: {'name': 'Universally'})),
            ),
            DemoButton(text: 'HEAD', onTap: () => run(() => BaseDio().head('/headers'))),
            DemoButton(
              text: 'requestUri',
              onTap: () => run(() => BaseDio().requestUri(Uri.parse('https://httpbin.org/get'))),
            ),
            DemoButton(
              text: 'upload（FormData）',
              onTap: () => run(
                () => BaseDio().upload(
                  '/post',
                  FormData.fromMap({'file': MultipartFile.fromBytes(utf8.encode('Universally'), filename: 'demo.txt')}),
                ),
              ),
            ),
            DemoButton(
              text: 'download 到临时目录',
              onTap: () async {
                if (isWeb) {
                  showToast('Web 不支持文件下载示例');
                  return;
                }
                if (requesting) return;
                setState(() => requesting = true);
                try {
                  final directory = await PathProvider().getTemporaryDirectory();
                  if (directory == null) return;
                  final BaseModel model = await BaseDio().download('/image/png', '${directory.path}/universally.png');
                  if (mounted) setResult(model);
                } catch (error) {
                  if (mounted) showToast('下载失败：$error');
                } finally {
                  if (mounted) setState(() => requesting = false);
                }
              },
            ),
          ],
        ),
        DemoSection(
          title: 'BaseModel',
          description: 'resultSuccessFail 可统一判断业务成功与否；toMap 便于日志输出。',
          children: [
            DemoButton(
              text: '判断结果',
              icon: Icons.fact_check,
              onTap: () {
                final BaseModel? model = result;
                if (model == null) {
                  showToast('请先发起请求');
                  return;
                }
                if (resultSuccessFail(model)) showToast('业务成功');
              },
            ),
            DemoResult(text: log),
          ],
        ),
      ],
    );
  }
}
