import 'package:app_entrenamiento/features/workout/domain/set_values.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('given valid values, when validated, then there are no errors', () {
    expect(const SetValues(weightKg: 60, reps: 10, rir: 2).validate(), isEmpty);
  });

  test('given negative or excessive values, when validated, '
      'then each field reports its error', () {
    expect(
      const SetValues(weightKg: -1, reps: -1, rir: 11).validate(),
      SetValuesError.values.toSet(),
    );
  });
}
