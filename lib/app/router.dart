import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../core/routing/app_routes.dart';
import '../core/widgets/app_shell.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/exercises/presentation/screens/exercise_detail_screen.dart';
import '../features/exercises/presentation/screens/exercise_form_screen.dart';
import '../features/exercises/presentation/screens/exercise_list_screen.dart';
import '../features/profile/presentation/profile_providers.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/profile/presentation/screens/onboarding_screen.dart';
import '../features/profile/presentation/screens/profile_form_screen.dart';
import '../features/progress/presentation/progress_screen.dart';
import '../features/routines/presentation/routines_screen.dart';
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
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
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
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.progress,
                builder: (context, state) => const ProgressScreen(),
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
