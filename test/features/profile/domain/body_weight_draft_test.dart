import 'package:app_entrenamiento/features/profile/domain/body_weight_draft.dart';
import 'package:flutter_test/flutter_test.dart';

final _today = DateTime(2026, 11, 14, 22);

void main() {
  test('given today and a normal weight, when validated, '
      'then it has no errors', () {
    final draft = BodyWeightDraft(
      date: DateTime.utc(2026, 11, 14),
      weightKg: 78.4,
    );
    expect(draft.validate(today: _today), isEmpty);
  });

  test('given an empty draft, when validated, '
      'then date and weight are required', () {
    expect(const BodyWeightDraft().validate(today: _today), {
      BodyWeightValidationError.dateRequired,
      BodyWeightValidationError.weightRequired,
    });
  });

  test('given tomorrow, when validated, then the date is in the future', () {
    final draft = BodyWeightDraft(
      date: DateTime.utc(2026, 11, 15),
      weightKg: 78,
    );
    expect(draft.validate(today: _today), {
      BodyWeightValidationError.dateInFuture,
    });
  });

  test('given weights outside the limits, when validated, '
      'then they are out of range', () {
    for (final kg in [kMinBodyWeightKg - 0.1, kMaxBodyWeightKg + 0.1]) {
      final draft = BodyWeightDraft(
        date: DateTime.utc(2026, 11, 1),
        weightKg: kg,
      );
      expect(draft.validate(today: _today), {
        BodyWeightValidationError.weightOutOfRange,
      });
    }
  });
}
