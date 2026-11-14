import 'package:app_entrenamiento/core/utils/calendar_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calendarDate', () {
    test('given a local time late at night, when converted, '
        'then it keeps the local day at UTC midnight', () {
      final date = calendarDate(DateTime(2026, 11, 14, 23, 59));
      expect(date, DateTime.utc(2026, 11, 14));
      expect(date.isUtc, isTrue);
    });

    test(
      'given a calendar date, when converted again, then it is unchanged',
      () {
        final date = DateTime.utc(2026, 2, 28);
        expect(calendarDate(date), date);
      },
    );
  });

  group('yearsBetween', () {
    final birth = DateTime.utc(2000, 6, 15);

    test('given the birthday has passed this year, when computed, '
        'then it counts this year', () {
      expect(yearsBetween(birth, DateTime.utc(2026, 6, 15)), 26);
    });

    test('given the birthday is tomorrow, when computed, '
        'then it does not count this year', () {
      expect(yearsBetween(birth, DateTime.utc(2026, 6, 14)), 25);
      expect(yearsBetween(birth, DateTime.utc(2026, 1, 31)), 25);
    });

    test('given a 29 February birthday, when computed on 28 February, '
        'then the year is not complete yet', () {
      final leap = DateTime.utc(2004, 2, 29);
      expect(yearsBetween(leap, DateTime.utc(2026, 2, 28)), 21);
      expect(yearsBetween(leap, DateTime.utc(2026, 3, 1)), 22);
    });
  });
}
