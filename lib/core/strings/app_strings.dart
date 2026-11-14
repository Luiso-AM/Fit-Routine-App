/// User-facing strings shared across the app (Spanish).
abstract final class AppStrings {
  static const String appName = 'Fit Routine';

  static const String tabHome = 'Inicio';
  static const String tabWorkout = 'Entrenamiento';
  static const String tabRoutines = 'Rutinas';
  static const String tabProgress = 'Progreso';
  static const String tabProfile = 'Perfil';

  /// Entry point to the exercise library, shown in more than one tab.
  static const String exerciseLibrary = 'Ejercicios';

  // Exercise picker.
  static const String pickerTitle = 'Agregar ejercicios';
  static const String pickerSearchHint = 'Buscar ejercicio';
  static const String pickerClearSearch = 'Borrar búsqueda';
  static const String pickerNoResults = 'No hay ejercicios que coincidan.';
  static const String pickerLoadError = 'No se pudieron cargar los ejercicios.';

  static String pickerAddSelected(int count) =>
      count == 0 ? pickerTitle : 'Agregar ($count)';
}
