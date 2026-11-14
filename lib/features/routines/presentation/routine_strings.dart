import '../domain/routine_drafts.dart';

/// User-facing strings of the routines feature (Spanish).
abstract final class RoutineStrings {
  // Routine list.
  static const String newRoutine = 'Nueva rutina';
  static const String noRoutines =
      'Aún no tienes rutinas. Crea una en blanco o parte de una plantilla.';
  static const String loadError = 'No se pudieron cargar las rutinas.';
  static const String blankRoutine = 'Rutina en blanco';
  static const String blankRoutineHint = 'Empieza desde cero.';
  static const String templates = 'Plantillas';

  static String daysCount(int days) => days == 1 ? '1 día' : '$days días';

  static String exercisesCount(int count) =>
      count == 1 ? '1 ejercicio' : '$count ejercicios';

  // Routine detail.
  static const String notFound = 'Esta rutina no existe o fue eliminada.';
  static const String editRoutine = 'Editar rutina';
  static const String name = 'Nombre';
  static const String notesOptional = 'Notas (opcional)';
  static const String days = 'Días';
  static const String noDays = 'Agrega el primer día de entrenamiento.';
  static const String addDay = 'Agregar día';
  static const String editDay = 'Editar día';
  static const String dayName = 'Nombre del día';
  static const String dayNameHint = 'Ej.: Push, Pierna, Día 1';
  static const String weekdayOptional = 'Día de la semana (opcional)';
  static const String noWeekday = 'Sin asignar';
  static const String dayActions = 'Opciones del día';
  static const String reorder = 'Mantén presionado y arrastra para reordenar';
  static const String more = 'Más opciones';
  static const String duplicate = 'Duplicar';
  static const String duplicated = 'Rutina duplicada';
  static const String delete = 'Eliminar';
  static const String cancel = 'Cancelar';
  static const String save = 'Guardar';
  static const String create = 'Crear';
  static const String deleteRoutineTitle = '¿Eliminar rutina?';
  static const String deleteRoutineMessage =
      'Dejará de aparecer en tus rutinas. Los entrenamientos que ya hiciste '
      'con ella se conservan en el historial.';
  static const String routineDeleted = 'Rutina eliminada';
  static const String deleteDayTitle = '¿Eliminar día?';
  static const String deleteDayMessage =
      'Se quitarán el día y sus ejercicios de la rutina. Los entrenamientos '
      'que ya hiciste se conservan en el historial.';
  static const String saveError = 'No se pudo guardar. Inténtalo de nuevo.';

  static const String _copySuffix = ' (copia)';

  /// Name of a duplicated routine, shortened to fit the maximum length.
  static String copyName(String name) {
    const room = kRoutineNameMaxLength - _copySuffix.length;
    final base = name.length > room ? name.substring(0, room).trim() : name;
    return '$base$_copySuffix';
  }

  // Validation.
  static const String nameRequired = 'Escribe un nombre.';
  static const String nameTooLong =
      'Usa como máximo $kRoutineNameMaxLength caracteres.';
  static const String dayNameTooLong =
      'Usa como máximo $kRoutineDayNameMaxLength caracteres.';
  static const String notesTooLong =
      'Usa como máximo $kRoutineNotesMaxLength caracteres.';

  /// Full weekday names, Monday first (ISO weekday - 1).
  static const List<String> weekdays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  /// One-letter weekday labels, Monday first.
  static const List<String> weekdayInitials = [
    'L',
    'M',
    'X',
    'J',
    'V',
    'S',
    'D',
  ];
}
