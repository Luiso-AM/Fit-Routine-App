import 'package:app_entrenamiento/core/utils/duration_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatClock', () {
    test('given under an hour, then it shows minutes and seconds', () {
      expect(formatClock(const Duration(minutes: 5, seconds: 7)), '5:07');
    });

    test('given an hour or more, then it shows hours too', () {
      expect(
        formatClock(const Duration(hours: 1, minutes: 2, seconds: 3)),
        '1:02:03',
      );
    });

    test('given a negative duration, then it shows zero', () {
      expect(formatClock(const Duration(seconds: -5)), '0:00');
    });
  });

  group('formatHoursMinutes', () {
    test('given under an hour, then it shows whole minutes', () {
      expect(
        formatHoursMinutes(const Duration(minutes: 45, seconds: 59)),
        '45 min',
      );
      expect(formatHoursMinutes(Duration.zero), '0 min');
    });

    test('given whole hours, then the minutes are left out', () {
      expect(formatHoursMinutes(const Duration(hours: 2)), '2 h');
    });

    test('given hours and minutes, then it shows both', () {
      expect(
        formatHoursMinutes(const Duration(hours: 2, minutes: 15)),
        '2 h 15 min',
      );
    });

    test('given a negative duration, then it shows zero', () {
      expect(formatHoursMinutes(const Duration(minutes: -3)), '0 min');
    });
  });
}
