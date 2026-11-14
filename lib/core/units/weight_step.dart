import 'weight_conversion.dart';
import 'weight_unit.dart';

/// Increment of the +/− weight buttons, in the display unit: the smallest
/// common plate jump (2 × 1.25 kg or 2 × 2.5 lb).
double weightStep(WeightUnit unit) => switch (unit) {
  WeightUnit.kg => 2.5,
  WeightUnit.lb => 5,
};

/// [kg] moved [steps] increments in [unit] (negative to decrease), in kg.
///
/// The value is first rounded to one decimal in [unit], as shown on screen,
/// so a step from `132.3 lb` lands on `137.3 lb` and not on a value with
/// hidden decimals. Never goes below zero.
double stepWeightKg(double kg, WeightUnit unit, int steps) {
  final shown = (fromKg(kg, unit) * 10).roundToDouble() / 10;
  final next = shown + steps * weightStep(unit);
  return next <= 0 ? 0 : toKg(next, unit);
}
