import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 顶部带尖角的气泡形状，适合 Tooltip、PopupMenu、聊天气泡等容器。
class BubbleShape extends ShapeBorder {
  const BubbleShape({
    this.side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.arrowWidth = 16,
    this.arrowHeight = 8,
  });

  final BorderSide side;

  final BorderRadiusGeometry borderRadius;

  /// 尖角底边的宽度。
  final double arrowWidth;

  /// 尖角的高度，尖角位于组件顶部矩形内部。
  final double arrowHeight;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.strokeInset);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect.deflate(side.strokeInset), textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double height = math.min(arrowHeight, rect.height / 2);
    final double halfWidth = math.min(arrowWidth / 2, rect.width / 2);
    final double centerX = rect.center.dx;

    final RRect body = borderRadius
        .resolve(textDirection)
        .toRRect(Rect.fromLTRB(rect.left, rect.top + height, rect.right, rect.bottom));
    final Path bodyPath = Path()..addRRect(body);
    final Path arrow = Path()
      ..moveTo(centerX - halfWidth, body.top)
      ..lineTo(centerX, rect.top)
      ..lineTo(centerX + halfWidth, body.top)
      ..close();
    return Path.combine(PathOperation.union, bodyPath, arrow);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none || side.width == 0) return;
    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), side.toPaint());
  }

  @override
  ShapeBorder scale(double t) => BubbleShape(
    side: side.scale(t),
    borderRadius: borderRadius * t,
    arrowWidth: arrowWidth * t,
    arrowHeight: arrowHeight * t,
  );
}
