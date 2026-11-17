import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../core/routing/app_routes.dart';
import '../core/widgets/app_shell.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/exercises/presentation/screens/exercise_detail_screen.dart';
import '../features/exercises/presentation/screens/exercise_form_screen.dart';
import '../features/exercises/presentation/screens/exercise_list_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/profile/presentation/profile_providers.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/profile/presentation/screens/body_measurement_form_screen.dart';
import '../features/profile/presentation/screens/body_measurements_history_screen.dart';
import '../features/profile/presentation/screens/body_weight_history_screen.dart';
import '../features/profile/presentation/screens/onboarding_screen.dart';
import '../features/profile/presentation/screens/profile_form_screen.dart';
import '../features/routines/presentation/screens/exercise_picker_screen.dart';
import '../features/routines/presentation/screens/routine_day_screen.dart';
import '../features/routines/presentation/screens/routine_detail_screen.dart';
import '../features/routines/presentation/screens/routines_screen.dart';
import '../features/workout/presentation/screens/session_edit_screen.dart';
import '../features/workout/presentation/screens/session_summary_screen.dart';
import '../features/workout/presentation/screens/start_workout_screen.dart';
import '../features/workout/presentation/screens/workout_exercise_picker_screen.dart';
import '../features/workout/presentation/widgets/resume_workout_prompt.dart';
import '../features/workout/presentation/workout_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Whether onboarding is done; `null` while the profile is loading.
  final onboarded = ValueNotifier<bool?>(null);
  ref.listen(currentProfileProvider, (_, profile) {
    if (profile.hasValue) onboarded.value = profile.value != null;
  }, fireImmediately: true);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: onboarded,
    redirect: (context, state) {
      final done = onboarded.value;
      if (done == null) return null;
      final atOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!done) return atOnboarding ? null : AppRoutes.onboarding;
      return atOnboarding ? AppRoutes.home : null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ResumeWorkoutPrompt(
          child: AppShell(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.workout,
                builder: (context, state) => const WorkoutScreen(),
                routes: [
                  GoRoute(
                    path: 'add',
                    builder: (context, state) =>
                        const WorkoutExercisePickerScreen(),
                  ),
                  GoRoute(
                    path: 'start/:dayId',
                    builder: (context, state) => StartWorkoutScreen(
                      routineDayId: state.pathParameters['dayId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'summary/:sessionId',
                    builder: (context, state) => SessionSummaryScreen(
                      sessionId: state.pathParameters['sessionId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.routines,
                builder: (context, state) => const RoutinesScreen(),
                routes: [
                  GoRoute(
                    path: 'exercises',
                    builder: (context, state) => const ExerciseListScreen(),
                    routes: [
                      // Declared before ':id' so "new" is not read as an id.
                      GoRoute(
                        path: 'new',
                        builder: (context, state) => const ExerciseFormScreen(),
                      ),
                      GoRoute(
                        path: ':id',
                        builder: (context, state) => ExerciseDetailScreen(
                          exerciseId: state.pathParameters['id']!,
                        ),
                        routes: [
                          GoRoute(
                            path: 'edit',
                            builder: (context, state) => ExerciseFormScreen(
                              exerciseId: state.pathParameters['id'],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Declared after 'exercises' so it is not read as an id.
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => RoutineDetailScreen(
                      routineId: state.pathParameters['id']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'days/:dayId',
                        builder: (context, state) => RoutineDayScreen(
                          routineId: state.pathParameters['id']!,
                          dayId: state.pathParameters['dayId']!,
                        ),
                        routes: [
                          GoRoute(
                            path: 'add',
                            builder: (context, state) => ExercisePickerScreen(
                              routineId: state.pathParameters['id']!,
                              dayId: state.pathParameters['dayId']!,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              // The training history; progress charts join it in phase 2.
              GoRoute(
                path: AppRoutes.progress,
                builder: (context, state) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: 'sessions/:sessionId',
                    builder: (context, state) => SessionSummaryScreen(
                      sessionId: state.pathParameters['sessionId']!,
                      fromHistory: true,
                    ),
                    routes: [
                      GoRoute(
                        path: 'edit',
                        builder: (context, state) => SessionEditScreen(
                          sessionId: state.pathParameters['sessionId']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) => const ProfileFormScreen(),
                  ),
                  GoRoute(
                    path: 'weight',
                    builder: (context, state) =>
                        const BodyWeightHistoryScreen(),
                  ),
                  GoRoute(
                    path: 'measurements',
                    builder: (context, state) =>
                        const BodyMeasurementsHistoryScreen(),
                    routes: [
                      GoRoute(
                        path: 'new',
                        builder: (context, state) =>
                            const BodyMeasurementFormScreen(),
                      ),
                      GoRoute(
                        path: ':id/edit',
                        builder: (context, state) => BodyMeasurementFormScreen(
                          measurementId: state.pathParameters['id'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref
    ..onDispose(router.dispose)
    ..onDispose(onboarded.dispose);
  return router;
});
