import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final UConfig config = Universally().config;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'App 与全局配置',
      appBarActions: [SwitchApiButton()],
      children: [
        DemoSection(
          title: 'UConfig',
          description: 'Universally().setConfig 可配置 API、转场样式、Toast、Dialog、BottomSheet、滚轮与 Loading 的全局参数。',
          children: [
            DemoResult(
              text: [
                'betaApi: ${config.betaApi}',
                'releaseApi: ${config.releaseApi}',
                '当前 baseApi: ${Universally().baseApi}',
                'pushStyle: ${config.pushStyle}',
                'logCrossLine: ${config.logCrossLine}',
                'toastOptions: ${config.toastOptions != null}',
                'generalDialogOptions: ${config.generalDialogOptions != null}',
                'modalBottomSheetOptions: ${config.modalBottomSheetOptions != null}',
                'wheelOptions: ${config.wheelOptions != null}',
                'loadingOptions: ${config.loadingOptions != null}',
              ].join('\n'),
            ),
          ],
        ),
        DemoSection(
          title: '主题',
          description: 'Universally().getTheme 可在任意位置读取当前 ThemeData。',
          children: [
            DemoButton(
              text: '读取当前主题',
              icon: Icons.color_lens,
              onTap: () {
                final ThemeData? theme = Universally().getTheme(context: context);
                showToast('primaryColor: ${theme?.colorScheme.primary}');
              },
            ),
          ],
        ),
        DemoSection(
          title: '桌面窗口尺寸',
          description: 'WindowsSize 提供常用手机与平板尺寸，可用于 setConfig 的 WindowOptions。',
          children: WindowsSize.values
              .map(
                (size) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [TextSmall(size.name), TextSmall('${size.value.width} x ${size.value.height}')],
                ),
              )
              .toList(),
        ),
        DemoSection(
          title: '系统设置',
          description: 'MacOSSettingUrl / IOSSettingUrl 提供系统设置跳转地址。',
          children: [
            DemoButton(
              text: '打开系统设置（macOS）',
              icon: Icons.settings,
              onTap: isMacOS ? () => UrlLauncher().openUrl(MacOSSettingUrl.securityPrivacy.value) : null,
            ),
            DemoButton(
              text: '打开应用设置（iOS）',
              icon: Icons.app_settings_alt,
              onTap: isIOS ? () => UrlLauncher().openUrl(IOSSettingUrl.app.url) : null,
            ),
          ],
        ),
        DemoSection(
          title: '应用生命周期',
          description: 'BaseMaterialApp / BaseCupertinoApp / BaseWidgetsApp 均基于 BaseApp，可监听 resumed、paused、inactive、hidden、detached。',
          children: [
            SizedBox(
              height: 160,
              child: AnimatedBuilder(
                animation: DemoLog.instance,
                builder: (BuildContext context, Widget? child) => BaseList.count(
                  placeholder: const BasePlaceholder(padding: EdgeInsets.all(10)),
                  children: DemoLog.instance.logs
                      .map((log) => Padding(padding: const EdgeInsets.only(bottom: 6), child: TextSmall(log)))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 6),
            DemoButton(text: '清空日志', icon: Icons.clear, onTap: DemoLog.instance.clear),
          ],
        ),
      ],
    );
  }
}
