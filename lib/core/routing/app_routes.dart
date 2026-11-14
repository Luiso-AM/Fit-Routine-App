/// Route paths. Kept in `core` so features can navigate without importing
/// the router, which in turn imports their screens.
abstract final class AppRoutes {
  // Bottom navigation tabs.
  static const String home = '/';
  static const String workout = '/workout';
  static const String routines = '/routines';
  static const String progress = '/progress';
  static const String profile = '/profile';

  /// First-run profile creation, outside the tab shell.
  static const String onboarding = '/onboarding';

  // Profile tab.
  static const String profileEdit = '$profile/edit';

  // Exercise library, nested in the routines tab.
  static const String exercises = '$routines/exercises';
  static const String exerciseNew = '$exercises/new';

  static String exerciseDetail(String id) => '$exercises/$id';

  static String exerciseEdit(String id) => '$exercises/$id/edit';
}
