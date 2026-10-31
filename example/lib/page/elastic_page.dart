import 'package:app/utils/demo.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class ElasticPage extends StatelessWidget {
  const ElasticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'FlElasticBuilder 弹性按压',
      children: [
        DemoSection(
          title: '按压反馈',
          description: '按下 elasticUp、抬起 elasticDown，点击时触发 elastic。',
          children: [
            Center(
              child: FlElasticBuilder(
                withOpacity: true,
                builder: (BuildContext context, Function elasticUp, Function elastic, Function elasticDown) =>
                    GestureDetector(
                      onTap: () => elastic(),
                      onTapDown: (_) => elasticUp(),
                      onTapUp: (_) => elasticDown(),
                      child: Universal(
                        width: 160,
                        height: 52,
                        color: context.theme.primaryColor,
                        borderRadius: BorderRadius.circular(26),
                        alignment: Alignment.center,
                        child: const TextMedium('按住试试', color: Colors.white),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
