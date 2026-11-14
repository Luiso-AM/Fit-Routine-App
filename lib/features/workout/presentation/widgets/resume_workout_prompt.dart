import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../data/workout_data_providers.dart';
import '../../domain/workout_session.dart';
import '../workout_actions.dart';
import '../workout_providers.dart';
import '../workout_strings.dart';

/// When the app opens with a session in progress (for example after the
/// process was killed), offers to continue it.
///
/// Asks once per launch, and only about a session that was already in
/// progress at launch, not one started afterwards.
class ResumeWorkoutPrompt extends ConsumerStatefulWidget {
  const ResumeWorkoutPrompt({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<ResumeWorkoutPrompt> createState() =>
      _ResumeWorkoutPromptState();
}

class _ResumeWorkoutPromptState extends ConsumerState<ResumeWorkoutPrompt> {
  ProviderSubscription<AsyncValue<WorkoutSession?>>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = ref.listenManual(activeWorkoutProvider, (_, active) {
      if (!active.hasValue && !active.hasError) return;
      // Only the first known state counts.
      _subscription?.close();
      _subscription = null;
      final session = active.value;
      if (session != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _ask(session));
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  Future<void> _ask(WorkoutSession session) async {
    if (!mounted) return;
    final router = GoRouter.of(context);
    final resume = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(WorkoutStrings.resumeTitle),
        content: Text(
          WorkoutStrings.resumeMessage(
            session.routineDayName ?? WorkoutStrings.freeSession,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(WorkoutStrings.discard),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(WorkoutStrings.continueWorkout),
          ),
        ],
      ),
    );
    if (!mounted) return;
    switch (resume) {
      case true:
        router.go(AppRoutes.workout);
      case false:
        await _discard(session);
      case null:
        // Dismissed: the session stays in the workout tab.
        break;
    }
  }

  Future<void> _discard(WorkoutSession session) async {
    final confirmed = await showConfirmDialog(
      context,
      title: WorkoutStrings.discardTitle,
      message: WorkoutStrings.discardMessage,
      confirmLabel: WorkoutStrings.discard,
      cancelLabel: WorkoutStrings.cancel,
    );
    if (!confirmed || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final done = await guardWorkout(
      context,
      () => ref.read(workoutRepositoryProvider).discard(session.id),
    );
    if (done) {
      messenger.showSnackBar(
        const SnackBar(content: Text(WorkoutStrings.discarded)),
      );
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
