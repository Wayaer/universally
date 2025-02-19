import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

enum SpinKitStyle {
  rotatingPlain,
  doubleBounce,
  wave,
  wanderingCubes,
  fadingFour,
  foldingCube,
  pulse,
  chasingDots,
  threeBounce,
  circle,
  cubeGrid,
  fadingCircle,
  rotatingCircle,
  pumpingHeart,
  hourGlass,
  pouringHourGlass,
  pouringHourGlassRefined,
  fadingGrid,
  ring,
  ripple,
  spinningCircle,
  spinningLines,
  squareCircle,
  dualRing,
  pianoWave,
  dancingSquare,
  threeInOut,
  eaveSpinner,
  pulsingGrid,
}

/// flutter_spinKit
class SpinKit extends StatelessWidget {
  const SpinKit(
    this.style, {
    super.key,
    this.size = 50,
    this.itemCount = 6,
    this.lineWidth,
    this.borderWidth = 6,
    this.strokeWidth,
    this.color,
    this.shape = BoxShape.circle,
    this.waveType = SpinKitPianoWaveType.start,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.delay = const Duration(milliseconds: 50),
    this.trackColor = const Color(0x68757575),
    this.waveColor = const Color(0x68757575),
    this.curve = Curves.decelerate,
    this.controller,
  });

  final SpinKitStyle style;
  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  /// [SpinKitWave]、[SpinKitPianoWave]
  final int itemCount;

  /// [SpinKitFadingFour]、[SpinKitFadingGrid]、[SpinKitSpinningCircle]
  final BoxShape shape;

  /// [SpinKitPouringHourGlass]、[SpinKitPouringHourGlassRefined]
  final double? strokeWidth;

  /// [SpinKitRing]、[SpinKitSpinningLines]、[SpinKitDualRing]
  final double? lineWidth;

  /// [SpinKitRipple]
  final double borderWidth;

  /// [SpinKitPianoWave]
  final SpinKitPianoWaveType waveType;

  /// [SpinKitThreeInOut]
  final Duration delay;

  /// [SpinKitWaveSpinner]
  final Color trackColor;

  /// [SpinKitWaveSpinner]
  final Color waveColor;

  /// [SpinKitWaveSpinner]
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.theme.primaryColor;
    switch (style) {
      case SpinKitStyle.rotatingPlain:
        return SpinKitRotatingPlain(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.doubleBounce:
        return SpinKitDoubleBounce(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.wave:
        return SpinKitWave(
          color: color,
          size: size,
          itemCount: itemCount,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.wanderingCubes:
        return SpinKitWanderingCubes(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
        );
      case SpinKitStyle.fadingFour:
        return SpinKitFadingFour(
          color: color,
          size: size,
          shape: shape,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.foldingCube:
        return SpinKitFoldingCube(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.pulse:
        return SpinKitPulse(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.chasingDots:
        return SpinKitChasingDots(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
        );
      case SpinKitStyle.threeBounce:
        return SpinKitThreeBounce(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.circle:
        return SpinKitCircle(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.cubeGrid:
        return SpinKitCubeGrid(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.fadingCircle:
        return SpinKitFadingCircle(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.rotatingCircle:
        return SpinKitRotatingCircle(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.pumpingHeart:
        return SpinKitPumpingHeart(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.hourGlass:
        return SpinKitHourGlass(
          color: color,
          size: size,
          duration: duration,
          controller: controller,
        );
      case SpinKitStyle.pouringHourGlass:
        return SpinKitPouringHourGlass(
          color: color,
          size: size,
          duration: duration,
          strokeWidth: strokeWidth,
          controller: controller,
        );
      case SpinKitStyle.pouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(
          color: color,
          size: size,
          strokeWidth: strokeWidth,
          duration: duration,
          controller: controller,
        );
      case SpinKitStyle.fadingGrid:
        return SpinKitFadingGrid(
          color: color,
          size: size,
          shape: shape,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.ring:
        return SpinKitRing(
          color: color,
          lineWidth: lineWidth ?? 6,
          size: size,
          duration: duration,
          controller: controller,
        );
      case SpinKitStyle.ripple:
        return SpinKitRipple(
          color: color,
          size: size,
          borderWidth: borderWidth,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.spinningCircle:
        return SpinKitSpinningCircle(
          color: color,
          size: size,
          duration: duration,
          shape: shape,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.spinningLines:
        return SpinKitSpinningLines(
          color: color,
          lineWidth: lineWidth ?? 2,
          size: size,
          duration: duration,
          controller: controller,
        );
      case SpinKitStyle.squareCircle:
        return SpinKitSquareCircle(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.dualRing:
        return SpinKitDualRing(
          lineWidth: lineWidth ?? 6,
          color: color,
          size: size,
          duration: duration,
          controller: controller,
        );
      case SpinKitStyle.pianoWave:
        return SpinKitPianoWave(
          color: color,
          size: size,
          itemCount: itemCount,
          type: waveType,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.dancingSquare:
        return SpinKitDancingSquare(
          color: color,
          size: size,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.threeInOut:
        return SpinKitThreeInOut(
          color: color,
          size: size,
          delay: delay,
          duration: duration,
          itemBuilder: itemBuilder,
          controller: controller,
        );
      case SpinKitStyle.eaveSpinner:
        return SpinKitWaveSpinner(
          color: color,
          size: size,
          duration: duration,
          trackColor: trackColor,
          waveColor: waveColor,
          curve: curve,
          controller: controller,
        );
      case SpinKitStyle.pulsingGrid:
        return SpinKitPulsingGrid(
          color: color,
          size: size,
          duration: duration,
          boxShape: shape,
          itemBuilder: itemBuilder,
          controller: controller,
        );
    }
  }
}
