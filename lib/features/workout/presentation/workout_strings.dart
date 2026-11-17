/// User-facing strings of the workout feature (Spanish).
abstract final class WorkoutStrings {
  // No session in progress.
  static const String freeSession = 'Sesión libre';
  static const String freeSessionHint =
      'Empieza sin rutina y agrega los ejercicios sobre la marcha.';
  static const String startFreeSession = 'Empezar sesión libre';
  static const String fromRoutine = 'Desde una rutina';
  static const String noRoutines =
      'Crea una rutina en la pestaña Rutinas para empezar desde uno de sus '
      'días.';
  static const String today = 'Hoy';
  static const String startDay = 'Iniciar entrenamiento';
  static const String loadError = 'No se pudo cargar el entrenamiento.';
  static const String saveError = 'No se pudo guardar. Inténtalo de nuevo.';
  static const String startError = 'No se pudo iniciar el entrenamiento.';
  static const String starting = 'Preparando el entrenamiento…';

  static String exercisesCount(int count) =>
      count == 1 ? '1 ejercicio' : '$count ejercicios';

  // Another session in progress.
  static const String activeExistsTitle = 'Ya tienes un entrenamiento en curso';
  static const String activeExistsMessage =
      'Puedes continuarlo, o descartarlo y empezar el nuevo.';
  static const String continueActive = 'Continuar el actual';
  static const String discardAndStart = 'Descartar y empezar';

  // Resuming at launch.
  static const String resumeTitle = 'Tienes un entrenamiento en curso';
  static const String continueWorkout = 'Continuar';

  static String resumeMessage(String name) =>
      'Tu entrenamiento ($name) sigue en curso y tus series están '
      'guardadas. ¿Quieres continuarlo?';

  // Session in progress.
  static const String paused = 'En pausa';
  static const String pause = 'Pausar';
  static const String resume = 'Reanudar';
  static const String finish = 'Finalizar';
  static const String addExercise = 'Agregar ejercicio';
  static const String discard = 'Descartar';
  static const String cancel = 'Cancelar';
  static const String more = 'Más opciones';
  static const String noExercises =
      'Agrega ejercicios para empezar a registrar tus series.';
  static const String duration = 'Duración';

  static String setsProgress(int completed, int total) =>
      '$completed/$total series';

  // Rest timer.
  static const String rest = 'Descanso';
  static const String restLess = '−15 s';
  static const String restMore = '+15 s';
  static const String restLessTooltip = 'Restar 15 segundos';
  static const String restMoreTooltip = 'Sumar 15 segundos';
  static const String skipRest = 'Saltar';

  // Exercise card.
  static const String missingExercise = 'Ejercicio eliminado de la biblioteca';
  static const String lastTime = 'Última vez';
  static const String noHistory = 'Primera vez con este ejercicio';
  static const String set = 'Serie';
  static const String weight = 'Peso';
  static const String reps = 'Reps';
  static const String rir = 'RIR';
  static const String addSet = 'Agregar serie';
  static const String removeExercise = 'Quitar ejercicio';
  static const String exerciseActions = 'Opciones del ejercicio';
  static const String changeUnit = 'Cambiar unidad';
  static const String completeSet = 'Completar serie';
  static const String undoSet = 'Marcar como pendiente';
  static const String noValue = '–';

  /// "4 × 6–8", or "4 × 8" when the range is a single value.
  static String target(int sets, int min, int max) =>
      min == max ? '$sets × $min' : '$sets × $min–$max';

  /// "3 × 10", one group of equal sets of the last session.
  static String setGroup(int count, int reps) => '$count × $reps';

  static String setTitle(int number) => '$set $number';

  // Set editor.
  static const String removeSet = 'Eliminar serie';
  static const String done = 'Listo';
  static const String increase = 'Aumentar';
  static const String decrease = 'Disminuir';
  static const String rirHint = 'Repeticiones en reserva (opcional)';

  // Confirmations.
  static const String finishTitle = '¿Finalizar entrenamiento?';
  static const String finishMessage = 'Se guardará en tu historial.';

  static String finishPendingMessage(int pending) =>
      'Se guardará en tu historial. '
      '${pending == 1 ? 'La serie pendiente no cuenta' : 'Las $pending series pendientes no cuentan'} '
      'para tus estadísticas.';

  static const String discardTitle = '¿Descartar entrenamiento?';
  static const String discardMessage =
      'No se guardará en tu historial ni contará para tus estadísticas.';
  static const String removeExerciseTitle = '¿Quitar ejercicio?';
  static const String removeExerciseMessage =
      'Se quitará de este entrenamiento junto con sus series.';
  static const String discarded = 'Entrenamiento descartado';

  // Session summary.
  static const String summaryTitle = 'Resumen';
  static const String summaryLoadError = 'No se pudo cargar el resumen.';
  static const String summaryNotFound = 'Este entrenamiento ya no existe.';
  static const String exercises = 'Ejercicios';
  static const String sets = 'Series';
  static const String totalReps = 'Repeticiones';
  static const String volume = 'Volumen';
  static const String performed = 'Lo que hiciste';
  static const String noCompletedSets =
      'No completaste ninguna serie en este entrenamiento.';
  static const String firstTimeDay =
      'Es la primera vez que haces este día. La próxima vez verás aquí la '
      'comparación con este entrenamiento.';
  static const String noChange = 'Igual';

  static String comparedWith(String date) => 'Frente a tu sesión del $date';

  /// "sáb, 14 nov, 9:30 a. m.", when a session started.
  static String startedAt(String date, String time) => '$date, $time';

  // Past session, from the history.
  static const String sessionTitle = 'Entrenamiento';
  static const String firstTimeDayInHistory =
      'Fue la primera vez que hiciste este día de rutina.';
  static const String sessionNotes = 'Observaciones';
  static const String editSession = 'Editar';
  static const String removeFromHistory = 'Quitar del historial';
  static const String removeFromHistoryTitle = '¿Quitar del historial?';
  static const String removeFromHistoryMessage =
      'Dejará de aparecer en tu historial y no contará para tus '
      'estadísticas.';
  static const String removedFromHistory =
      'Entrenamiento quitado del historial';

  // Editing a past session.
  static const String editTitle = 'Editar entrenamiento';
  static const String notesHint = 'Cómo te sentiste, molestias, ideas…';
  static const String noExercisesLeft =
      'Este entrenamiento ya no tiene ejercicios.';
}
