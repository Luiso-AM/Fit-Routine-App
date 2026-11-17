import 'package:riverpod_annotation/riverpod_annotation.dart';

// Other features' repositories are injected through their providers; only
// their domain interfaces are used here.
import '../../exercises/data/exercise_data_providers.dart';
import '../../exercises/domain/exercise.dart';
import '../../profile/data/profile_data_providers.dart';
import '../../profile/domain/body_weight_entry.dart';
import '../../profile/domain/user_profile.dart';
import '../../routines/data/routine_data_providers.dart';
import '../../routines/domain/routine.dart';
import '../../workout/data/workout_data_providers.dart';
import '../../workout/domain/session_start.dart';
import '../../workout/domain/workout_session.dart';
import '../domain/weekly_activity.dart';

part 'dashboard_providers.g.dart';

@riverpod
Stream<UserProfile?> dashboardProfile(Ref ref) =>
    ref.watch(profileRepositoryProvider).watch();

/// The session in progress, or `null`.
@riverpod
Stream<WorkoutSession?> dashboardActiveSession(Ref ref) =>
    ref.watch(workoutRepositoryProvider).watchActive();

/// Sessions finished this week (Monday to Sunday, local time).
@riverpod
Stream<List<WorkoutSession>> dashboardWeekSessions(Ref ref) {
  final from = weekStart(DateTime.now());
  return ref
      .watch(workoutRepositoryProvider)
      .watchFinished(from: from, to: nextWeekStart(from));
}

/// When every finished session started, newest first.
@riverpod
Stream<List<SessionStart>> dashboardFinishedStarts(Ref ref) =>
    ref.watch(workoutRepositoryProvider).watchFinishedStarts();

@riverpod
Stream<List<Routine>> dashboardRoutines(Ref ref) =>
    ref.watch(routineRepositoryProvider).watchAll();

/// Active exercises by id, to derive the muscles of a routine day.
@riverpod
Stream<Map<String, Exercise>> dashboardExerciseCatalog(Ref ref) => ref
    .watch(exerciseRepositoryProvider)
    .watchAll()
    .map((all) => {for (final e in all) e.id: e});

/// Body weight entries, newest first.
@riverpod
Stream<List<BodyWeightEntry>> dashboardWeights(Ref ref) =>
    ref.watch(bodyMetricsRepositoryProvider).watchWeights();
