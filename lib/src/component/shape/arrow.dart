import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ArrowShape
class ArrowShape extends ShapeBorder {
  const ArrowShape(
      {this.side = BorderSide.none, this.borderRadius = BorderRadius.zero});

  final BorderSide side;

  final BorderRadiusGeometry borderRadius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    path.addRRect(
        borderRadius.resolve(textDirection).toRRect(rect).deflate(side.width));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = borderRadius.resolve(textDirection).toRRect(rect);

    double radio = 4;
    path.moveTo(0, radio);
    path.quadraticBezierTo(0, 0, radio, 0);
    path.lineTo(rrect.width / 2 - 8, 0);
    path.lineTo(rrect.width / 2, -8);
    path.lineTo(rrect.width - (rrect.width / 2 - 8), 0);
    path.lineTo(rrect.width - radio, 0);

    path.quadraticBezierTo(rrect.width, 0, rrect.width, radio);
    path.lineTo(rrect.width, rrect.height - radio);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - radio, rrect.height);
    path.lineTo(radio, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - radio);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
      side: side.scale(t), borderRadius: borderRadius * t);
}
