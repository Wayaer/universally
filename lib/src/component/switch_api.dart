import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SwitchApiButton extends StatelessWidget {
  const SwitchApiButton({super.key, this.unifiedButtonCategory = UnifiedButtonCategory.elevated});

  final UnifiedButtonCategory? unifiedButtonCategory;

  @override
  Widget build(BuildContext context) {
    if (!(isBeta || isDebug)) return const SizedBox();
    return IconLabel(
      icon: UIS.settingApi,
      unifiedButtonCategory: unifiedButtonCategory,
      size: 14,
      onTap: () => push(const _SwitchApiPage()),
      label: Text('切换API', style: TextStyle(fontSize: 12)),
    );
  }
}

class _SwitchApiPage extends StatefulWidget {
  const _SwitchApiPage();

  @override
  _SwitchApiPageState createState() => _SwitchApiPageState();
}

class _SwitchApiPageState extends State<_SwitchApiPage> {
  TextEditingController ip = TextEditingController();
  TextEditingController port = TextEditingController();
  bool isHttps = false;
  bool isRelease = false;
  String httpStr = '';

  @override
  Widget build(BuildContext context) {
    httpStr = 'http${isHttps ? 's' : ''}://';
    final defaultUrl = isBeta ? Universally().config.betaApi : Universally().config.releaseApi;
    return BaseScaffold(
      isScroll: true,
      safeBottom: true,
      padding: const EdgeInsets.all(12),
      appBarTitleText: '切换服务器',
      children: [
        TextLarge('*本功能为测试版专用', color: context.theme.primaryColor),
        const SizedBox(height: 6),
        Universal(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextMedium('默认服务器地址为：'),
            buildApi(defaultUrl),
            const TextMedium('当前服务器地址为：'),
            buildApi(Universally().baseApi),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextMedium('使用https：'),
                XSwitch(
                  value: isHttps,
                  activeColor: context.theme.primaryColor,
                  onChanged: (bool? value) {
                    isHttps = !isHttps;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
        BaseTextField(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          borderType: BorderType.outline,
          prefixes: SizedBox(width: 50, child: TextMedium(httpStr)).toTextFieldPendant().toList,
          maxLength: 30,
          controller: ip,
          hintText: '请输入IP地址',
        ),
        BaseTextField(
          width: double.infinity,
          enableClearIcon: true,
          margin: const EdgeInsets.only(top: 10),
          borderType: BorderType.outline,
          prefixes: const SizedBox(width: 50, child: TextMedium('端口: ')).toTextFieldPendant().toList,
          maxLength: 10,
          controller: port,
          hintText: '请输入端口',
        ),
        UButton(
          width: double.infinity,
          height: 44,
          margin: const EdgeInsets.only(top: 20),
          text: '确定并重启APP',
          onTap: () {
            if (ip.text.isEmpty) {
              showToast('请输入IP地址');
              return;
            }
            if (port.text.isEmpty) {
              showToast('端口');
              return;
            }
            saveApi('$httpStr${ip.text}:${port.text}');
          },
        ),
        UButton(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10),
          text: '重置为默认服务器并重启APP',
          onTap: () => saveApi(defaultUrl),
        ),
        UButton(width: double.infinity, text: '切换正式服务器并重启APP', onTap: () => saveApi(Universally().config.releaseApi)),
        const USpacing(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextMedium('始终使用正式服务器').expanded,
            XSwitch(
              value: isRelease,
              activeColor: context.theme.primaryColor,
              onChanged: (bool? value) {
                isRelease = !isRelease;
                setState(() {});
              },
            ),
          ],
        ),
        TextMedium('*开启此开关后，切换正式服后将无法使用切换API功能，其本质与正式包一样，请确认后再开启', maxLines: 3, color: context.theme.primaryColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextMedium('开启接口请求日志打印：'),
            XSwitch(
              value: isDebugger,
              activeColor: context.theme.primaryColor,
              onChanged: (bool? value) async {
                isDebugger = !isDebugger;
                setState(() {});
                await BasePreferences().setBool(UConst.isDebugger, isDebugger);
                await showToast('修改成功,请重新打开APP');
                Curiosity.native.exitApp();
              },
            ),
          ],
        ),
        const USpacing(),
        const Row(children: [TextMedium('正式服IP：', maxLines: 2, height: 1.5)]),
        buildApi(Universally().config.releaseApi),
        const USpacing(),
      ],
    );
  }

  Future<void> saveApi(String api) async {
    context.requestFocus();
    if (isRelease) {
      await BasePreferences().setBool(UConst.isRelease, isRelease);
    } else {
      await BasePreferences().setString(UConst.localApi, api);
    }
    await showToast('修改成功,请重新打开APP');
    Curiosity.native.exitApp();
  }

  Widget buildApi(String url) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: TextMedium(url, maxLines: 3, height: 1.5),
    ),
  );
}
