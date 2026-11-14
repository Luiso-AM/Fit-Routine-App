import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../widgets/workout_widgets.dart';
import '../workout_actions.dart';
import '../workout_strings.dart';

/// Starts a session from a routine day and opens the workout tab.
///
/// Reached by route, so other features can start a session without
/// depending on this one.
class StartWorkoutScreen extends ConsumerStatefulWidget {
  const StartWorkoutScreen({required this.routineDayId, super.key});

  final String routineDayId;

  @override
  ConsumerState<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends ConsumerState<StartWorkoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  Future<void> _start() async {
    await startWorkout(context, ref, routineDayId: widget.routineDayId);
    if (mounted) context.go(AppRoutes.workout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      // Starting takes a moment; a dialog may cover this if a session is
      // already in progress.
      body: const WorkoutMessage(WorkoutStrings.starting),
    );
  }
}
