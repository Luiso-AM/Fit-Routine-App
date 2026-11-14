import 'package:app_entrenamiento/features/profile/domain/body_measurement_draft.dart';
import 'package:flutter_test/flutter_test.dart';

final _today = DateTime(2026, 11, 14);
final _date = DateTime.utc(2026, 11, 14);

void main() {
  test('given a single value, when validated, then it has no errors', () {
    final draft = BodyMeasurementDraft(date: _date, waistCm: 82);
    expect(draft.validate(today: _today), isEmpty);
  });

  test('given only body fat, when validated, then it has no errors', () {
    final draft = BodyMeasurementDraft(date: _date, bodyFatPct: 18.5);
    expect(draft.validate(today: _today), isEmpty);
  });

  test('given no values, when validated, then it reports no values', () {
    expect(BodyMeasurementDraft(date: _date).validate(today: _today), {
      BodyMeasurementValidationError.noValues,
    });
  });

  test('given a future date, when validated, then it is in the future', () {
    final draft = BodyMeasurementDraft(
      date: DateTime.utc(2026, 11, 15),
      armCm: 35,
    );
    expect(draft.validate(today: _today), {
      BodyMeasurementValidationError.dateInFuture,
    });
  });

  test('given every value out of range, when validated, '
      'then each field is reported', () {
    final draft = BodyMeasurementDraft(
      date: _date,
      waistCm: (kMinCircumferenceCm - 1).toDouble(),
      chestCm: (kMaxCircumferenceCm + 1).toDouble(),
      armCm: 0,
      legCm: 500,
      hipCm: 5,
      bodyFatPct: (kMaxBodyFatPct + 1).toDouble(),
    );
    expect(draft.validate(today: _today), {
      BodyMeasurementValidationError.waistOutOfRange,
      BodyMeasurementValidationError.chestOutOfRange,
      BodyMeasurementValidationError.armOutOfRange,
      BodyMeasurementValidationError.legOutOfRange,
      BodyMeasurementValidationError.hipOutOfRange,
      BodyMeasurementValidationError.bodyFatOutOfRange,
    });
  });
}
