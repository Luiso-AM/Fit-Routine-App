import 'package:app_entrenamiento/core/units/weight_conversion.dart';
import 'package:app_entrenamiento/core/units/weight_format.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatWeight', () {
    final cases = <(double, WeightUnit, String)>[
      (60, WeightUnit.kg, '60 kg'),
      (62.5, WeightUnit.kg, '62.5 kg'),
      (0, WeightUnit.kg, '0 kg'),
      (60.04, WeightUnit.kg, '60 kg'),
      (62.25, WeightUnit.kg, '62.3 kg'),
      (1.15, WeightUnit.kg, '1.2 kg'),
      (0.05, WeightUnit.kg, '0.1 kg'),
      (12450, WeightUnit.kg, '12,450 kg'),
      (1234567.89, WeightUnit.kg, '1,234,567.9 kg'),
      (-1.24, WeightUnit.kg, '-1.2 kg'),
      (-0.04, WeightUnit.kg, '0 kg'),
      (toKg(135, WeightUnit.lb), WeightUnit.lb, '135 lb'),
      (toKg(62.25, WeightUnit.lb), WeightUnit.lb, '62.3 lb'),
      (toKg(2.5, WeightUnit.lb), WeightUnit.lb, '2.5 lb'),
      (100, WeightUnit.lb, '220.5 lb'),
    ];

    for (final (kg, unit, expected) in cases) {
      test(
        'given $kg kg, when formatted in ${unit.symbol}, then it is "$expected"',
        () {
          expect(formatWeight(kg, unit), expected);
        },
      );
    }

    test(
      'given withUnit false, when formatted, then only the number is shown',
      () {
        expect(formatWeight(62.5, WeightUnit.kg, withUnit: false), '62.5');
        expect(
          formatWeight(
            toKg(135, WeightUnit.lb),
            WeightUnit.lb,
            withUnit: false,
          ),
          '135',
        );
      },
    );
  });

  group('parseWeightInput', () {
    final valid = <String, double>{
      '60': 60,
      '62.5': 62.5,
      '62,5': 62.5,
      ' 62.5 ': 62.5,
      '0': 0,
      '62.': 62,
      '.5': 0.5,
      ',5': 0.5,
      '135.25': 135.25,
    };

    for (final MapEntry(key: input, value: expected) in valid.entries) {
      test('given "$input", when parsed, then it is $expected', () {
        expect(parseWeightInput(input), expected);
      });
    }

    for (final input in [
      '',
      '   ',
      'abc',
      '-5',
      '1,2,3',
      '1.2.3',
      '5kg',
      '.',
    ]) {
      test('given "$input", when parsed, then it is null', () {
        expect(parseWeightInput(input), isNull);
      });
    }
  });
}
