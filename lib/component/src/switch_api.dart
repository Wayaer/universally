import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SwitchApiButton extends StatelessWidget {
  const SwitchApiButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) => IconBox(
      icon: UIS.settingApi,
      color: color ?? GlobalConfig().currentColor,
      visible: isBeta,
      size: 18,
      onTap: () => push(_SwitchApiPage()),
      title: TextDefault('切换API', color: color ?? GlobalConfig().currentColor));
}

class _SwitchApiPage extends StatefulWidget {
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
    final defaultUrl = isBeta
        ? GlobalConfig().config.betaUrl
        : GlobalConfig().config.releaseUrl;
    return BasicScaffold(
        isScroll: true,
        safeBottom: true,
        padding: const EdgeInsets.all(12),
        appBarTitle: '切换服务器',
        children: [
          TextVeryLarge('*本功能为测试版专用', color: GlobalConfig().currentColor),
          const SizedBox(height: 6),
          Universal(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextDefault('默认服务器地址为：'),
            showUrl(defaultUrl),
            TextDefault('当前服务器地址为：'),
            showUrl(GlobalConfig().currentBasicUrl),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextDefault('使用https：'),
              BasicSwitch(
                  value: isHttps,
                  activeColor: GlobalConfig().currentColor,
                  onChanged: (bool? value) {
                    isHttps = !isHttps;
                    setState(() {});
                  })
            ]),
          ]),
          InputText(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              borderType: BorderType.outline,
              prefix: Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: TextDefault(httpStr)),
              maxLength: 30,
              controller: ip,
              hintText: '请输入IP地址'),
          InputText(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              borderType: BorderType.outline,
              prefix: Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: TextDefault('端口: ')),
              maxLength: 10,
              controller: port,
              hintText: '请输入端口'),
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
              }),
          UButton(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              text: '重置为默认服务器并重启APP',
              onTap: () => saveApi(defaultUrl)),
          UButton(
              width: double.infinity,
              text: '切换正式服务器并重启APP',
              onTap: () => saveApi(GlobalConfig().config.releaseUrl)),
          const USpacing(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextDefault('始终使用正式服务器').expandedNull,
            BasicSwitch(
                value: isRelease,
                activeColor: GlobalConfig().currentColor,
                onChanged: (bool? value) {
                  isRelease = !isRelease;
                  setState(() {});
                })
          ]),
          TextDefault('*开启此开关后，切换正式服后将无法使用切换API功能，其本质与正式包一样，请确认后再开启',
              maxLines: 3, color: GlobalConfig().currentColor),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextDefault('开启接口请求日志打印：'),
            BasicSwitch(
                value: hasLogTs,
                activeColor: GlobalConfig().currentColor,
                onChanged: (bool? value) async {
                  hasLogTs = !hasLogTs;
                  setState(() {});
                  await BHP().setBool(UConstant.hasLogTs, hasLogTs);
                  await showToast('修改成功,请重新打开APP');
                  Curiosity().native.exitApp();
                })
          ]),
          const USpacing(),
          Row(children: [
            TextDefault('正式服IP：', maxLines: 2, height: 1.5),
          ]),
          showUrl(GlobalConfig().config.releaseUrl),
          const USpacing(),
        ]);
  }

  Future<void> saveApi(String api) async {
    context.focusNode();
    if (isRelease) {
      await BHP().setBool(UConstant.isRelease, isRelease);
    } else {
      await BHP().setString(UConstant.localApi, api);
    }
    await showToast('修改成功,请重新打开APP');
    Curiosity().native.exitApp();
  }

  Widget showUrl(String url) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          boxShadow: getBoxShadow(color: UCS.background, num: 3),
          color: UCS.white,
          borderRadius: BorderRadius.circular(8)),
      child: TextDefault(url, maxLines: 3, height: 1.5));
}
