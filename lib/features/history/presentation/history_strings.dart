/// User-facing strings of the history feature (Spanish).
abstract final class HistoryStrings {
  static const String title = 'Historial';
  static const String loadError = 'No se pudo cargar el historial.';
  static const String noSessionsOnDay = 'No entrenaste este día.';
  static const String freeSession = 'Sesión libre';
  static const String previousMonth = 'Mes anterior';
  static const String nextMonth = 'Mes siguiente';

  static String monthCount(int count) => switch (count) {
    0 => 'Sin entrenamientos este mes',
    1 => '1 entrenamiento este mes',
    _ => '$count entrenamientos este mes',
  };

  static String exercises(int count) =>
      count == 1 ? '1 ejercicio' : '$count ejercicios';

  static String sets(int count) => count == 1 ? '1 serie' : '$count series';
}
