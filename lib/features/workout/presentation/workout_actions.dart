import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../data/workout_data_providers.dart';
import '../domain/workout_repository.dart';
import 'workout_strings.dart';

/// Runs a repository [action] and reports a failure with a snackbar.
/// Returns whether it succeeded.
Future<bool> guardWorkout(
  BuildContext context,
  Future<void> Function() action, {
  String errorMessage = WorkoutStrings.saveError,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
    return true;
  } on Exception {
    messenger.showSnackBar(SnackBar(content: Text(errorMessage)));
    return false;
  }
}

enum _ActiveSessionChoice { continueActive, discardAndStart }

/// Starts a session from [routineDayId], or a free one.
///
/// If a session is already in progress, asks whether to continue it or to
/// discard it and start the new one. Returns whether a session is in
/// progress afterwards.
Future<bool> startWorkout(
  BuildContext context,
  WidgetRef ref, {
  String? routineDayId,
}) async {
  final repository = ref.read(workoutRepositoryProvider);
  Future<void> start() => routineDayId == null
      ? repository.startFree()
      : repository.startFromRoutineDay(routineDayId);

  String? activeId;
  final started = await guardWorkout(context, () async {
    try {
      await start();
    } on ActiveSessionExistsException catch (e) {
      activeId = e.sessionId;
    }
  }, errorMessage: WorkoutStrings.startError);
  final existing = activeId;
  if (!started || existing == null) return started;
  if (!context.mounted) return false;

  final choice = await showDialog<_ActiveSessionChoice>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(WorkoutStrings.activeExistsTitle),
      content: const Text(WorkoutStrings.activeExistsMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(WorkoutStrings.cancel),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(_ActiveSessionChoice.discardAndStart),
          child: const Text(WorkoutStrings.discardAndStart),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(_ActiveSessionChoice.continueActive),
          child: const Text(WorkoutStrings.continueActive),
        ),
      ],
    ),
  );
  if (!context.mounted) return false;
  return switch (choice) {
    _ActiveSessionChoice.continueActive => true,
    _ActiveSessionChoice.discardAndStart => guardWorkout(context, () async {
      await repository.discard(existing);
      await start();
    }, errorMessage: WorkoutStrings.startError),
    null => false,
  };
}
