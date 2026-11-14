import 'exercise_performance.dart';
import 'set_values.dart';
import 'workout_session.dart';

/// Values of the first [count] sets of an exercise when it is added to a
/// session.
///
/// Each set takes its weight from the same set of the [last] performance
/// (or its last set, if it had fewer), then from [initialWeightKg], then 0.
/// Reps start at [targetRepsMin] when the exercise has a target, otherwise
/// at the reps done last time.
List<SetValues> initialSetValues({
  required int count,
  int? targetRepsMin,
  double? initialWeightKg,
  ExercisePerformance? last,
}) {
  final previous = last?.sets ?? const <SetEntry>[];
  final values = <SetValues>[];
  for (var i = 0; i < count; i++) {
    final match = i < previous.length ? previous[i] : previous.lastOrNull;
    values.add(
      SetValues(
        weightKg: match?.weightKg ?? initialWeightKg ?? 0,
        reps: targetRepsMin ?? match?.reps ?? 0,
      ),
    );
  }
  return values;
}

/// The set to prefill with the values of [completed], once it is completed:
/// the one right after it, if it is still pending.
SetEntry? setToPrefillAfter(List<SetEntry> sets, SetEntry completed) {
  final next = sets
      .where((s) => s.setNumber == completed.setNumber + 1)
      .firstOrNull;
  return next == null || next.isCompleted ? null : next;
}

/// Values of a set added at the end of an exercise: a copy of its last set,
/// without RIR.
SetValues valuesForNewSet(List<SetEntry> sets) {
  final last = sets.lastOrNull;
  return last == null
      ? const SetValues()
      : SetValues(weightKg: last.weightKg, reps: last.reps);
}
