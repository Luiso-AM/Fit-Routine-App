import 'package:intl/intl.dart';

import '../utils/app_locale.dart';
import 'weight_conversion.dart';
import 'weight_unit.dart';

final NumberFormat _oneDecimal = NumberFormat('#,##0.#', kIntlLocale);

/// Absorbs floating point noise from kg/lb round trips, so that a value like
/// `62.249999999` (62.25 lb stored in kg and read back) rounds as `62.25`.
const double _roundingEpsilon = 1e-6;

/// Formats a stored weight in [kg] for display in [unit].
///
/// Shows at most one decimal, rounded half up, and drops a trailing `.0`:
/// `60 kg`, `62.5 kg`, `135 lb`, `12,450 kg`. Negative values (for example
/// a body weight change) keep their sign.
String formatWeight(double kg, WeightUnit unit, {bool withUnit = true}) {
  final number = _oneDecimal.format(_roundToOneDecimal(fromKg(kg, unit)));
  return withUnit ? '$number ${unit.symbol}' : number;
}

double _roundToOneDecimal(double value) {
  // Round the magnitude half up, then restore the sign.
  final rounded = (value.abs() * 10 + _roundingEpsilon).roundToDouble() / 10;
  // Avoid "-0" for tiny negative values.
  return rounded == 0 ? 0 : rounded * value.sign;
}

final RegExp _weightInput = RegExp(r'^(\d+\.?\d*|\.\d+)$');

/// Parses a weight typed by the user in their unit.
///
/// Accepts a decimal point or a decimal comma (`62.5`, `62,5`). Returns
/// `null` for empty, non-numeric or negative input. Thousands separators are
/// not supported: `1,000` would be ambiguous with a decimal comma.
double? parseWeightInput(String text) {
  final normalized = text.trim().replaceAll(',', '.');
  if (!_weightInput.hasMatch(normalized)) return null;
  return double.parse(normalized);
}
