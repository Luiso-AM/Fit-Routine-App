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
  static const String profileWeight = '$profile/weight';
  static const String profileMeasurements = '$profile/measurements';
  static const String profileMeasurementNew = '$profileMeasurements/new';

  static String profileMeasurementEdit(String id) =>
      '$profileMeasurements/$id/edit';

  // Workout tab.
  static const String workoutAddExercises = '$workout/add';

  /// Starts a session from a routine day, then opens the workout tab.
  static String workoutStart(String dayId) => '$workout/start/$dayId';

  // Routines tab.
  static String routineDetail(String id) => '$routines/$id';

  static String routineDay(String id, String dayId) =>
      '$routines/$id/days/$dayId';

  static String routineDayAddExercises(String id, String dayId) =>
      '${routineDay(id, dayId)}/add';

  // Exercise library, nested in the routines tab.
  static const String exercises = '$routines/exercises';
  static const String exerciseNew = '$exercises/new';

  static String exerciseDetail(String id) => '$exercises/$id';

  static String exerciseEdit(String id) => '$exercises/$id/edit';
}
