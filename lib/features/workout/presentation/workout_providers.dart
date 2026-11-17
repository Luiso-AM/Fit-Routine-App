import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

// Other features' repositories are injected through their providers; only
// their domain interfaces are used here.
import '../../exercises/data/exercise_data_providers.dart';
import '../../exercises/domain/exercise.dart';
import '../../routines/data/routine_data_providers.dart';
import '../../routines/domain/routine.dart';
import '../data/workout_data_providers.dart';
import '../domain/exercise_performance.dart';
import '../domain/session_summary.dart';
import '../domain/workout_session.dart';

part 'workout_providers.g.dart';

/// The session in progress, or `null`.
@riverpod
Stream<WorkoutSession?> activeWorkout(Ref ref) =>
    ref.watch(workoutRepositoryProvider).watchActive();

/// Active exercises by id, to show the exercises a session references.
@riverpod
Stream<Map<String, Exercise>> workoutExerciseCatalog(Ref ref) => ref
    .watch(exerciseRepositoryProvider)
    .watchAll()
    .map((all) => {for (final e in all) e.id: e});

/// Routines to start a session from.
@riverpod
Stream<List<Routine>> workoutRoutines(Ref ref) =>
    ref.watch(routineRepositoryProvider).watchAll();

/// What was done the last time an exercise was trained, or `null`.
@riverpod
Future<ExercisePerformance?> lastPerformance(Ref ref, String exerciseId) async {
  final last = await ref.watch(workoutRepositoryProvider).lastPerformances([
    exerciseId,
  ]);
  return last[exerciseId];
}

/// Summary of a session, compared with the previous session of its
/// routine day. `null` if the session does not exist.
@riverpod
Future<SessionSummary?> sessionSummary(Ref ref, String sessionId) async {
  final repository = ref.watch(workoutRepositoryProvider);
  final session = await repository.getSession(sessionId);
  if (session == null) return null;
  return SessionSummary.of(
    session,
    previous: await repository.previousSessionOf(session),
  );
}

/// Keeps the rest notification in step with the active session: it is
/// scheduled for the end of each rest and cancelled when the rest is
/// skipped or the session pauses or ends. Watched by the app root so it
/// runs on every screen.
///
/// Nothing is cancelled until a rest has been seen, so the plugin (and its
/// permission request) is not touched at launch.
@Riverpod(keepAlive: true)
void restNotificationSync(Ref ref) {
  final notifier = ref.watch(restNotificationsProvider);
  DateTime? synced;
  ref.listen(activeWorkoutProvider, (_, next) {
    if (!next.hasValue) return;
    final endsAt = next.value?.restEndsAt;
    if (endsAt == synced) return;
    synced = endsAt;
    final sync = endsAt == null ? notifier.cancel() : notifier.schedule(endsAt);
    // The timer on screen still works without the notification.
    unawaited(sync.catchError((Object _) {}));
  }, fireImmediately: true);
}

/// Current UTC time, updated every second, for the session clock.
@riverpod
Stream<DateTime> clock(Ref ref) async* {
  yield DateTime.now().toUtc();
  yield* Stream.periodic(
    const Duration(seconds: 1),
    (_) => DateTime.now().toUtc(),
  );
}
