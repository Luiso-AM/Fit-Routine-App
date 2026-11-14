import 'package:freezed_annotation/freezed_annotation.dart';

import 'workout_session.dart';

part 'exercise_performance.freezed.dart';

/// What was done for an exercise in one finished session: its completed
/// sets, in order.
@freezed
abstract class ExercisePerformance with _$ExercisePerformance {
  const factory ExercisePerformance({
    required String sessionId,
    required String exerciseId,
    required DateTime performedAt,
    required List<SetEntry> sets,
  }) = _ExercisePerformance;

  const ExercisePerformance._();

  /// Consecutive sets with the same weight and reps, merged, e.g.
  /// 3 × 10 × 60 kg followed by 1 × 8 × 60 kg.
  List<SetGroup> get groups {
    final groups = <SetGroup>[];
    for (final set in sets) {
      final last = groups.lastOrNull;
      if (last != null &&
          last.reps == set.reps &&
          last.weightKg == set.weightKg) {
        groups[groups.length - 1] = last.copyWith(count: last.count + 1);
      } else {
        groups.add(SetGroup(count: 1, reps: set.reps, weightKg: set.weightKg));
      }
    }
    return groups;
  }
}

/// [count] sets of [reps] reps with [weightKg].
@freezed
abstract class SetGroup with _$SetGroup {
  const factory SetGroup({
    required int count,
    required int reps,
    required double weightKg,
  }) = _SetGroup;
}
