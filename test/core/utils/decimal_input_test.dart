import 'package:app_entrenamiento/core/utils/decimal_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseDecimalInput', () {
    test('given a point or a comma, when parsed, then both are decimals', () {
      expect(parseDecimalInput('82.5'), 82.5);
      expect(parseDecimalInput(' 82,5 '), 82.5);
      expect(parseDecimalInput('175'), 175);
    });

    test('given invalid text, when parsed, then it is null', () {
      for (final text in ['', ' ', 'abc', '-3', '1.2.3', '1,000.5']) {
        expect(parseDecimalInput(text), isNull, reason: text);
      }
    });
  });

  group('parseIntInput', () {
    test('given digits, when parsed, then it returns the number', () {
      expect(parseIntInput(' 60 '), 60);
    });

    test('given decimals or text, when parsed, then it is null', () {
      for (final text in ['', '60.5', 'sesenta', '-1']) {
        expect(parseIntInput(text), isNull, reason: text);
      }
    });
  });

  test('given whole and decimal values, when formatted for input, '
      'then trailing zeros and separators are dropped', () {
    expect(formatDecimalInput(175), '175');
    expect(formatDecimalInput(82.5), '82.5');
    expect(formatDecimalInput(78.46), '78.5');
    expect(formatDecimalInput(1200), '1200');
  });
}
