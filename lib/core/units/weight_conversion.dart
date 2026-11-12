import 'weight_unit.dart';

/// Exact definition of the international avoirdupois pound.
const double kgPerLb = 0.45359237;

/// Converts a [value] expressed in [unit] to kilograms, without rounding.
///
/// Use it before storing anything the user typed.
double toKg(double value, WeightUnit unit) => switch (unit) {
  WeightUnit.kg => value,
  WeightUnit.lb => value * kgPerLb,
};

/// Converts a stored weight in [kg] to [unit], without rounding.
///
/// Rounding only happens when formatting for display.
double fromKg(double kg, WeightUnit unit) => switch (unit) {
  WeightUnit.kg => kg,
  WeightUnit.lb => kg / kgPerLb,
};
