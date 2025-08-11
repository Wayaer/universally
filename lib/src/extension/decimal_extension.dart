import 'package:decimal/decimal.dart';

extension UniversallyExtensionString on String {
  Decimal get parseDecimal => Decimal.parse(this);

  Decimal? get tryParseDecimal => Decimal.tryParse(this);
}

extension UniversallyExtensionInt on int {
  Decimal get parseDecimal => Decimal.fromInt(this);
}

extension UniversallyExtensionBigInt on BigInt {
  Decimal get parseDecimal => Decimal.fromBigInt(this);
}
