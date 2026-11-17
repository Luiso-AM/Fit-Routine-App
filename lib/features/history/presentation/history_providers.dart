import 'package:riverpod_annotation/riverpod_annotation.dart';

// The workout repository is injected through its provider; only its
// domain interface is used here.
import '../../workout/data/workout_data_providers.dart';
import '../../workout/domain/workout_session.dart';
import '../domain/training_days.dart';

part 'history_providers.g.dart';

/// Finished sessions of the local month that contains [month], grouped by
/// the day they started on.
@riverpod
Stream<Map<DateTime, List<WorkoutSession>>> historyMonth(
  Ref ref,
  DateTime month,
) {
  final range = monthRange(month);
  return ref
      .watch(workoutRepositoryProvider)
      .watchFinished(from: range.from, to: range.to)
      .map(sessionsByDay);
}
