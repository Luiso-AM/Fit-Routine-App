import 'package:intl/intl.dart';

final RegExp _decimalInput = RegExp(r'^(\d+\.?\d*|\.\d+)$');
final RegExp _integerInput = RegExp(r'^\d+$');

final NumberFormat _inputFormat = NumberFormat('0.#', 'en');

/// Parses a non-negative decimal typed by the user.
///
/// Accepts a decimal point or a decimal comma (`82.5`, `82,5`). Returns
/// `null` for empty, non-numeric or negative input.
double? parseDecimalInput(String text) {
  final normalized = text.trim().replaceAll(',', '.');
  if (!_decimalInput.hasMatch(normalized)) return null;
  return double.parse(normalized);
}

/// Parses a non-negative whole number typed by the user, or returns `null`.
int? parseIntInput(String text) {
  final trimmed = text.trim();
  return _integerInput.hasMatch(trimmed) ? int.parse(trimmed) : null;
}

/// Formats a value to prefill a text field: at most one decimal, no
/// thousands separator and no trailing `.0` (`175`, `82.5`).
String formatDecimalInput(double value) => _inputFormat.format(value);
