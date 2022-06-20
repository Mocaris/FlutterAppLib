export 'package:decimal/decimal.dart';
import 'package:decimal/decimal.dart';

/// Extensions on [num].
extension DoubleExt on double {
  /// This [num] as a [Decimal].
  Decimal toDecimal() => Decimal.parse('$this');
}
