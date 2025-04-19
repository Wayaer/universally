import 'package:universally/universally.dart';

class BaseIndicator extends FlIndicator {
  const BaseIndicator({
    super.key,
    required super.count,
    required super.position,
    required super.index,
    super.style = FlIndicatorStyle.scale,
    super.size = 8,
    super.color = UCS.background,
    super.activeColor,
  });
}
