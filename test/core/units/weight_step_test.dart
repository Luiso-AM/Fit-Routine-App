import 'package:app_entrenamiento/core/units/weight_conversion.dart';
import 'package:app_entrenamiento/core/units/weight_step.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('stepWeightKg', () {
    test('given 60 kg, when stepped up in kg, then it is 62.5 kg', () {
      expect(stepWeightKg(60, WeightUnit.kg, 1), 62.5);
    });

    test('given 60 kg, when stepped down twice in kg, then it is 55 kg', () {
      expect(stepWeightKg(60, WeightUnit.kg, -2), 55);
    });

    test('given 135 lb, when stepped up in lb, then it is 140 lb in kg', () {
      final kg = toKg(135, WeightUnit.lb);
      expect(stepWeightKg(kg, WeightUnit.lb, 1), closeTo(140 * kgPerLb, 1e-9));
    });

    test('given 60 kg shown as 132.3 lb, when stepped up in lb, '
        'then it lands on 137.3 lb', () {
      expect(
        fromKg(stepWeightKg(60, WeightUnit.lb, 1), WeightUnit.lb),
        closeTo(137.3, 1e-9),
      );
    });

    test('given 1 kg, when stepped down, then it stops at zero', () {
      expect(stepWeightKg(1, WeightUnit.kg, -1), 0);
    });
  });
}
