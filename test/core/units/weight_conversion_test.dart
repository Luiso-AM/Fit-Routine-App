import 'package:app_entrenamiento/core/units/weight_conversion.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toKg', () {
    test('given a value in kg, when converted to kg, then it is unchanged', () {
      expect(toKg(62.5, WeightUnit.kg), 62.5);
    });

    test('given 1 lb, when converted to kg, then it is exactly 0.45359237', () {
      expect(toKg(1, WeightUnit.lb), 0.45359237);
    });

    test(
      'given 135 lb, when converted to kg, then the result is not rounded',
      () {
        expect(toKg(135, WeightUnit.lb), closeTo(61.23496995, 1e-9));
      },
    );
  });

  group('fromKg', () {
    test('given a weight in kg, when shown in kg, then it is unchanged', () {
      expect(fromKg(61.23497, WeightUnit.kg), 61.23497);
    });

    test('given 100 kg, when converted to lb, then it is about 220.462', () {
      expect(fromKg(100, WeightUnit.lb), closeTo(220.46226218, 1e-8));
    });

    test('given 0 kg, when converted to lb, then it is 0', () {
      expect(fromKg(0, WeightUnit.lb), 0);
    });
  });

  group('round trip', () {
    for (final lb in <double>[1.25, 2.5, 45, 135, 225, 315.5]) {
      test(
        'given $lb lb, when stored as kg and read back, then no value is lost',
        () {
          expect(
            fromKg(toKg(lb, WeightUnit.lb), WeightUnit.lb),
            closeTo(lb, 1e-9),
          );
        },
      );
    }
  });
}
