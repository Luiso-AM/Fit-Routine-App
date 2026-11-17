import 'package:app_entrenamiento/features/dashboard/domain/weight_trend.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_entry.dart';
import 'package:flutter_test/flutter_test.dart';

BodyWeightEntry _entry(int month, int day, double kg) => BodyWeightEntry(
  id: '$month-$day',
  date: DateTime.utc(2026, month, day),
  weightKg: kg,
);

void main() {
  test('given entries in any order, when the trend is taken, then it '
      'compares the latest with the latest at least a week older', () {
    final latest = _entry(11, 17, 80.2);
    final weekOld = _entry(11, 10, 81);

    final trend = weightTrend([
      _entry(11, 1, 82),
      latest,
      _entry(11, 14, 80.5),
      weekOld,
    ])!;

    expect(trend.latest, latest);
    expect(trend.reference, weekOld);
    expect(trend.changeKg, closeTo(-0.8, 1e-9));
    expect(trend.daysBetween, 7);
  });

  test('given only recent entries, then there is nothing to compare', () {
    final trend = weightTrend([_entry(11, 17, 80), _entry(11, 12, 81)])!;

    expect(trend.reference, isNull);
    expect(trend.changeKg, isNull);
    expect(trend.daysBetween, isNull);
  });

  test('given an older entry across months, then it is compared', () {
    final trend = weightTrend([_entry(12, 3, 79), _entry(11, 2, 80)])!;

    expect(trend.changeKg, -1);
    expect(trend.daysBetween, 31);
  });

  test('given no entries, then there is no trend', () {
    expect(weightTrend(const []), isNull);
  });
}
