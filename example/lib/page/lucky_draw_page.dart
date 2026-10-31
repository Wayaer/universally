import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universally/universally.dart';

String _getPrizeImage(int index) => 'assets/$index.webp';

Future<void> pushLuckyDrawPage() async {
  List<LuckyPrizes> prizes = [];
  for (int i = 0; i < 10; i++) {
    final data = await rootBundle.load(_getPrizeImage(0));
    final bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo fi = await codec.getNextFrame();
    prizes.add(
      LuckyPrizes(
        backgroundColor: i.isEven ? Colors.red : Colors.green,
        textSpan: TextSpan(
          text: '$i',
          style: TStyle(color: Colors.white),
        ),
        image: fi.image,
      ),
    );
  }
  push(LuckyDrawPage(prizes: prizes));
}

class LuckyDrawPage extends StatelessWidget {
  const LuckyDrawPage({super.key, required this.prizes});

  /// 奖品
  final List<LuckyPrizes> prizes;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitleText: '幸运抽奖',
      padding: const EdgeInsets.all(10),
      children: [
        LuckyDraw(
          finalIndex: 4,
          turnDuration: [
            const Duration(milliseconds: 800),
            const Duration(milliseconds: 600),
            const Duration(milliseconds: 400),
            const Duration(milliseconds: 300),
            const Duration(milliseconds: 400),
            const Duration(milliseconds: 600),
            const Duration(milliseconds: 200),
            const Duration(milliseconds: 200),
          ],
          prizes: prizes,
        ),
      ],
    );
  }
}

class LuckyPrizes {
  LuckyPrizes({this.textSpan, this.image, this.backgroundColor});

  /// 文本
  final TextSpan? textSpan;

  /// 图片
  final ui.Image? image;

  /// 背景色
  final Color? backgroundColor;
}

class LuckyDraw extends StatefulWidget {
  const LuckyDraw({super.key, required this.prizes, required this.turnDuration, required this.finalIndex});

  /// 奖品
  final List<LuckyPrizes> prizes;

  /// 最终结果下标
  final int finalIndex;

  /// 长度为圈数 时间为每个圈的时间
  final List<Duration> turnDuration;

  @override
  State<LuckyDraw> createState() => _LuckyDrawState();
}

class _LuckyDrawState extends State<LuckyDraw> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    initAnimationController();
  }

  /// 当前旋转次数
  int currentRotationCount = 0;

  Duration getTotalDuration() {
    Duration totalDuration = Duration.zero;
    for (int i = 0; i < widget.turnDuration.length; i++) {
      totalDuration += widget.turnDuration[i];
    }
    return totalDuration;
  }

  void initAnimationController() {
    controller = AnimationController(value: 0, vsync: this, duration: getTotalDuration())
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        // if (status == AnimationStatus.completed) {
        //   currentRotationCount++;
        //   if (currentRotationCount < widget.turnDuration.length) {
        //     controller.duration = widget.turnDuration[currentRotationCount];
        //     controller.forward(from: 0.0);
        //   } else {
        //     if (controller.value == 1) controller.value = 0;
        //     final endValue =
        //         (widget.finalIndex * 2 / (widget.prizes.length * 2)) +
        //             stepValue;
        //     controller.animateTo(endValue,
        //         duration: const Duration(milliseconds: 1000));
        //   }
        // }
      });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.prizes.isEmpty) return const SizedBox();
    log('==${controller.value}');
    return Universal(
      isStack: true,
      size: const Size(240, 240),
      children: [
        AnimatedRotation(
          turns: (widget.turnDuration.length * controller.value).toDouble(),
          duration: 1.seconds,
          // duration: widget.turnDuration[currentRotationCount],
          child: CustomPaint(painter: LuckyDrawPaint(prizes: widget.prizes)),
        ).expand,
        // Transform.rotate(
        //         angle: controller.value * pi * 2,
        //         child:
        //             CustomPaint(painter: LuckyDrawPaint(prizes: widget.prizes)))
        //     .expand,
        Align(
          alignment: Alignment.center,
          child: Universal(
            onTap: () {
              currentRotationCount = 0; // 重置旋转计数器
              controller.reset();
              controller.forward();
            },
            decoration: BoxDecoration(color: context.theme.primaryColor, shape: BoxShape.circle),
            padding: EdgeInsets.all(4),
            child: Icon(Icons.ac_unit),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LuckyDrawPaint extends CustomPainter {
  LuckyDrawPaint({required this.prizes}) : super();

  List<LuckyPrizes> prizes;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double radius = min(size.width / 2, size.height / 2);
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    final int length = prizes.length; // 扇形数量
    final double angleStep = 2 * pi / length; // 每个扇形的角度
    for (int i = 0; i < prizes.length; i++) {
      double startAngle = i * angleStep - (angleStep * 1.75);
      final item = prizes[i];
      if (item.backgroundColor != null) paint.color = item.backgroundColor!;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, angleStep, true, paint);

      if (item.textSpan != null) {
        final TextPainter tp = TextPainter(
          text: item.textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        // 计算文字位置和旋转角度
        double textAngle = startAngle + angleStep / 2;
        double textX = center.dx + radius * 0.85 * cos(textAngle);
        double textY = center.dy + radius * 0.85 * sin(textAngle);
        // 使用矩阵变换来旋转文字
        canvas.save();
        canvas.translate(textX, textY);
        canvas.rotate(textAngle + pi / 2); // 加上90度使文字上边对准扇形外边
        tp.layout();
        tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
        canvas.restore();
      }

      if (item.image != null) {
        final image = item.image!;
        // 图片
        double imageAngle = startAngle + angleStep / 2;
        double p = item.textSpan == null ? 0.70 : 0.60;
        double imageX = center.dx + radius * p * cos(imageAngle);
        double imageY = center.dy + radius * p * sin(imageAngle);
        // 加载图片
        double imageSize = radius * (item.textSpan == null ? 0.38 : 0.28); // 图片大小为半径的40%
        Rect imageRect = Rect.fromCenter(center: const Offset(0, 0), width: imageSize, height: imageSize);
        canvas.save();
        canvas.translate(imageX, imageY);
        canvas.rotate(imageAngle + pi / 2); // 加上90度使图片上边对准扇形外边
        canvas.drawImageRect(
          image,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          imageRect,
          Paint(),
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
