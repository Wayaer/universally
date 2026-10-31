import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ConnectivityPlusPage extends StatefulWidget {
  const ConnectivityPlusPage({super.key});

  @override
  State<ConnectivityPlusPage> createState() => _ConnectivityPlusPageState();
}

class _ConnectivityPlusPageState extends State<ConnectivityPlusPage> {
  String status = '';

  Future<bool> listener(bool available, List<ConnectivityResult> results) async {
    setState(() => status = '${results.builder((e) => e.name).join(', ')} / available: $available');
    return true;
  }

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() => setState(() {
    final List<ConnectivityResult> results = ConnectivityPlus().current;
    status = '${results.builder((e) => e.name).join(', ')} / available: ${ConnectivityPlus().networkAvailability}';
  });

  @override
  Widget build(BuildContext context) => DemoScaffold(
    title: '网络状态',
    children: [
      DemoSection(
        title: 'ConnectivityPlus',
        description: '封装 connectivity_plus，提供当前网络、可用状态、监听与断网蒙层。',
        children: [
          DemoResult(text: status),
          const SizedBox(height: 6),
          DemoButton(
            text: 'checkConnectivity',
            icon: Icons.refresh,
            onTap: () async {
              await ConnectivityPlus().checkConnectivity();
              update();
            },
          ),
          DemoButton(text: 'addListener', icon: Icons.add_alert, onTap: () => ConnectivityPlus().addListener(listener)),
          DemoButton(
            text: 'removeListener',
            icon: Icons.remove_circle,
            onTap: () => ConnectivityPlus().removeListener(listener),
          ),
          DemoButton(
            text: '断网蒙层',
            icon: Icons.wifi_off,
            onTap: () => ConnectivityPlus().showOverlayWhenUnavailableNetwork(
              (bool available, List<ConnectivityResult> results) => FlOverlayEntry(
                widget: Universal(
                  alignment: Alignment.center,
                  color: Colors.black54,
                  child: Universal(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: TextMedium(
                      available ? '网络已恢复' : '网络不可用\n${results.builder((e) => e.name).join(', ')}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
