import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_values.freezed.dart';

const double kMaxSetWeightKg = 1000;
const int kMaxSetReps = 999;
const int kMaxRir = 10;

enum SetValuesError { weightOutOfRange, repsOutOfRange, rirOutOfRange }

/// The values the user enters for a set.
@freezed
abstract class SetValues with _$SetValues {
  const factory SetValues({
    /// Always in kg.
    @Default(0) double weightKg,
    @Default(0) int reps,
    int? rir,
  }) = _SetValues;

  const SetValues._();

  Set<SetValuesError> validate() {
    final rir = this.rir;
    return {
      if (weightKg.isNaN || weightKg < 0 || weightKg > kMaxSetWeightKg)
        SetValuesError.weightOutOfRange,
      if (reps < 0 || reps > kMaxSetReps) SetValuesError.repsOutOfRange,
      if (rir != null && (rir < 0 || rir > kMaxRir))
        SetValuesError.rirOutOfRange,
    };
  }
}
