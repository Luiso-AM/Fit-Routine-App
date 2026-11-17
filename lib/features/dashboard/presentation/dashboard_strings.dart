/// User-facing strings of the dashboard (Spanish).
abstract final class DashboardStrings {
  static String greeting(String alias) => 'Hola, $alias';

  // Next workout.
  static const String nextWorkout = 'Próximo entrenamiento';
  static const String today = 'Hoy';
  static const String tomorrow = 'Mañana';
  static const String nextInRoutine = 'Siguiente en tu rutina';
  static const String start = 'Iniciar';
  static const String noRoutines =
      'Crea una rutina con ejercicios para ver aquí tu próximo '
      'entrenamiento.';
  static const String goToRoutines = 'Ir a Rutinas';
  static const String inProgress = 'Entrenamiento en curso';
  static const String freeSession = 'Sesión libre';
  static const String continueWorkout = 'Continuar';

  static String exercises(int count) =>
      count == 1 ? '1 ejercicio' : '$count ejercicios';

  static String setsProgress(int completed, int total) =>
      '$completed/$total series';

  // This week.
  static const String thisWeek = 'Esta semana';
  static const String workouts = 'Entrenamientos';
  static const String time = 'Tiempo';
  static const String streak = 'Racha';

  static String ofGoal(int done, int goal) => '$done de $goal';

  static String weeks(int count) => count == 1 ? '1 semana' : '$count semanas';

  static String streakHint(int goal) =>
      'Semanas seguidas con al menos '
      '${goal == 1 ? '1 entrenamiento' : '$goal entrenamientos'}.';

  // Body weight.
  static const String bodyWeight = 'Peso corporal';
  static const String noWeight = 'Registra tu peso para seguir su evolución.';
  static const String noEarlierWeight =
      'Aún no hay un registro de hace una semana o más para comparar.';

  static String loggedOn(String date) => 'Registrado el $date';

  static String changeSince(String change, int days) {
    final weeks = days ~/ 7;
    return '$change vs. hace ${weeks == 1 ? '1 semana' : '$weeks semanas'}';
  }

  // Quick actions.
  static const String quickActions = 'Accesos rápidos';
  static const String logWeight = 'Registrar peso';
  static const String history = 'Historial';
  static const String routines = 'Rutinas';
  static const String loadError = 'No se pudo cargar esta información.';
}
