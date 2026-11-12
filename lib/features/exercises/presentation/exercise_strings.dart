/// User-facing strings of the exercise library (Spanish).
abstract final class ExerciseStrings {
  static const String searchHint = 'Buscar ejercicio';
  static const String clearSearch = 'Borrar búsqueda';
  static const String filters = 'Filtros';
  static const String clearFilters = 'Limpiar filtros';
  static const String done = 'Listo';
  static const String muscle = 'Músculo';
  static const String equipment = 'Equipamiento';
  static const String type = 'Tipo';
  static const String noResults = 'No hay ejercicios que coincidan.';
  static const String loadError = 'No se pudieron cargar los ejercicios.';
  static const String custom = 'Personalizado';

  static const String notFound = 'Este ejercicio no existe o fue eliminado.';
  static const String primaryMuscle = 'Músculo principal';
  static const String secondaryMuscles = 'Músculos secundarios';
  static const String difficulty = 'Dificultad';
  static const String preferredUnit = 'Unidad preferida';
  static const String instructions = 'Instrucciones';
  static const String commonMistakes = 'Errores frecuentes';
  static const String none = 'Ninguno';
  static const String noText = 'Sin información.';

  // Create, edit and delete.
  static const String newExercise = 'Nuevo ejercicio';
  static const String editExercise = 'Editar ejercicio';
  static const String edit = 'Editar';
  static const String delete = 'Eliminar';
  static const String cancel = 'Cancelar';
  static const String save = 'Guardar';
  static const String create = 'Crear ejercicio';
  static const String name = 'Nombre';
  static const String nameHint = 'Ej.: Remo en T (Barra)';
  static const String secondaryMusclesOptional =
      'Músculos secundarios (opcional)';
  static const String instructionsOptional = 'Instrucciones (opcional)';
  static const String commonMistakesOptional = 'Errores frecuentes (opcional)';
  static const String seedNotEditable =
      'Los ejercicios base no se pueden editar.';
  static const String saveError = 'No se pudo guardar. Inténtalo de nuevo.';
  static const String deleteError = 'No se pudo eliminar. Inténtalo de nuevo.';
  static const String deleteTitle = '¿Eliminar ejercicio?';
  static const String deleteMessage =
      'Dejará de aparecer en la biblioteca. Los entrenamientos que ya lo '
      'usaron lo conservan en su historial.';
  static const String deleted = 'Ejercicio eliminado';

  // Validation.
  static const String nameRequired = 'Escribe un nombre.';
  static const String nameTooLong = 'Usa como máximo 60 caracteres.';
  static const String nameDuplicate = 'Ya existe un ejercicio con ese nombre.';
  static const String primaryMuscleRequired = 'Elige el músculo principal.';
  static const String secondaryIncludesPrimary =
      'El músculo principal no puede ser también secundario.';
  static const String typeRequired = 'Elige el tipo.';
  static const String equipmentRequired = 'Elige el equipamiento.';
  static const String difficultyRequired = 'Elige la dificultad.';
}
