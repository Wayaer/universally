import 'dart:math';

import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class SemicirclePage extends StatelessWidget {
  const SemicirclePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['第0个', '第1个', '第2个', '第3个', '第4个'];
    final List<String> items2 = ['第0个', '第1个', '第2个', '第3个', '第4个', '第5个'];
    return BaseScaffold(
      isScroll: true,
      appBarTitleText: 'Semicircle',
      children: [
        Container(
          margin: EdgeInsets.all(40),
          child: SemicircleTurntable(
            items: items,
            onSelected: (int index) {
              log('==========$index');
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(40),
          child: SemicircleTurntable(
            items: items2,
            onSelected: (int index) {
              log('==========$index');
            },
          ),
        ),
      ],
    );
  }
}

class SemicircleTurntable extends StatefulWidget {
  const SemicircleTurntable({super.key, required this.items, required this.onSelected});

  final List<String> items;

  final ValueCallback<int> onSelected;

  @override
  State<SemicircleTurntable> createState() => _SemicircleTurntableState();
}

class _SemicircleTurntableState extends State<SemicircleTurntable> {
  double _rotation = 0.0;
  double _lastRotation = 0.0;
  double _dragStartX = 0.0;

  List<String> get items => [...widget.items, ...widget.items];

  @override
  void initState() {
    super.initState();
    // 初始化与items长度相关的参数
    _divisions = items.length;
    _anglePerDivision = circleAngle / _divisions;
    _topSectorIndex = isOdd ? (widget.items.length / 2).floor() : ((widget.items.length / 2).floor() - 1);
    _rotation += (isOdd ? 0 : (_anglePerDivision / 2));
    onSelected();
  }

  // 使用传入的items长度来定义等分角度的数量
  late int _divisions;

  // 每份的角度大小 (2π/_divisions)
  late double _anglePerDivision;

  // 查找最近的等分角度中间位置
  double _findNearestDivisionAngle(double currentAngle) {
    // 将角度归一化到0到2π范围内
    final normalizedAngle = _normalizeAngle(currentAngle);

    // 计算当前角度在哪个等分区间
    final divisionIndex = (normalizedAngle / _anglePerDivision).round();

    // 计算当前区间的起始角度和中间角度
    final startAngle = divisionIndex * _anglePerDivision;
    final middleAngle = startAngle + (isOdd ? 0 : (_anglePerDivision / 2));

    // 计算下一个区间的起始角度
    final nextStartAngle = (divisionIndex + 1) * _anglePerDivision;

    // 计算当前角度到中间角度和下一个区间起始角度的距离
    final distanceToMiddle = (normalizedAngle - middleAngle).abs();
    final distanceToNextStart = (normalizedAngle - nextStartAngle).abs();

    // 如果距离下一个区间起始角度更近，使用下一个区间的中间角度
    if (distanceToNextStart < distanceToMiddle && divisionIndex < _divisions - 1) {
      return _normalizeAngle(nextStartAngle);
    }

    // 否则使用当前区间的中间角度
    return _normalizeAngle(middleAngle);
  }

  bool get isOdd => widget.items.length.isOdd;

  // 将角度归一化到0到2π范围内
  double _normalizeAngle(double angle) {
    // 处理负角度
    while (angle < 0) {
      angle += circleAngle;
    }

    // 处理超过2π的角度
    while (angle >= circleAngle) {
      angle -= circleAngle;
    }

    return angle;
  }

  double get circleAngle => 2 * pi;

  // 原始items中的索引
  int _topSectorIndex = 0;

  // 更新正上方扇形的索引
  void _updateTopSectorIndex() {
    // 将当前旋转角度归一化到0到2π范围内
    final normalizedRotation = _normalizeAngle(_rotation);
    // 圆正上方的角度
    final topAngle = pi / 2;

    // 计算每个扇形的中间角度与圆正上方角度的距离
    double minDistance = double.infinity;
    int closestIndex = 0;

    for (int i = 0; i < _divisions; i++) {
      // 计算扇形的中间角度
      final sectorMiddleAngle = _normalizeAngle(i * _anglePerDivision + (isOdd ? 0 : (_anglePerDivision / 2)));

      // 计算扇形中间角度旋转后的实际角度
      final actualAngle = _normalizeAngle(sectorMiddleAngle + normalizedRotation);

      // 计算扇形中间角度与圆正上方角度的距离
      final distance = (actualAngle - topAngle).abs();

      // 更新最小距离和对应的索引
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }

    // 更新状态
    _topSectorIndex = closestIndex;
    onSelected();
    if (mounted) setState(() {});
  }

  int _lastTopSectorIndex = 0;

  void onSelected() {
    if (_lastTopSectorIndex == _topSectorIndex) return;
    _lastTopSectorIndex = _topSectorIndex;
    widget.onSelected(_topSectorIndex % widget.items.length);
  }

  /// 是否已经停止滑动
  bool isDragEnd = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRect(
        clipper: HalfCircleClipper(),
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            _dragStartX = details.globalPosition.dx;
            _lastRotation = _rotation;
            isDragEnd = false;
          },
          onHorizontalDragUpdate: (details) {
            // 计算滑动距离并转换为旋转角度
            final deltaX = details.globalPosition.dx - _dragStartX;
            // 每100像素的滑动对应180度旋转 (π弧度)
            _rotation = _lastRotation + deltaX / 100 * pi;
            setState(() {});
            isDragEnd = false;
          },
          onHorizontalDragEnd: (details) {
            isDragEnd = true;
            // 计算最近的等分角度
            _rotation = _findNearestDivisionAngle(_rotation);
            setState(() {});
            _updateTopSectorIndex();
          },
          child: Transform.rotate(
            angle: _rotation,
            child: CustomPaint(
              painter: _SemicircleTurntable(
                items: items.builderIV(
                  (k, v) => TextSpan(
                    text: v,
                    style: TextStyle(color: k == _topSectorIndex ? Colors.red : Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SemicircleTurntable extends CustomPainter {
  final List<TextSpan> items;

  _SemicircleTurntable({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double radius = min(size.width / 2, size.height / 2);
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    final anglePerDivision = 2 * pi / items.length;

    // 绘制每个扇形（将items重复一次，确保在完整的圆上都有内容）
    for (int i = 0; i < items.length; i++) {
      // 让第一个扇形的中心角度位于正上方
      // final double startAngle = (i * anglePerDivision) - (pi / 2) - (anglePerDivision / 2);
      // 第一个扇形从角度 0 开始，后续扇形依次递增
      // final double startAngle = i * anglePerDivision + pi + ((items.length / 2).isOdd ? 0 : anglePerDivision / 2);
      final double startAngle = i * anglePerDivision + pi;

      // 设置交替颜色
      paint.color = i.isEven ? Colors.greenAccent : Colors.amber;

      // 绘制扇形
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, anglePerDivision, true, paint);

      // 计算文字位置和角度
      final double textAngle = startAngle + anglePerDivision / 2;
      final double textX = center.dx + radius * 0.85 * cos(textAngle);
      final double textY = center.dy + radius * 0.85 * sin(textAngle);

      // 创建文字
      final textSpan = items[i];

      final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);

      // 使用矩阵变换来旋转文字
      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(textAngle + pi / 2); // 加上90度使文字上边对准扇形外边
      textPainter.layout();
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 自定义裁剪器，只显示上半部分
class HalfCircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height / 3);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
