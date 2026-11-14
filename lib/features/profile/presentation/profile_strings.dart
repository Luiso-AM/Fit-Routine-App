import '../domain/body_measurement_draft.dart';
import '../domain/body_weight_draft.dart';
import '../domain/user_profile_draft.dart';

/// User-facing strings of the profile feature (Spanish).
abstract final class ProfileStrings {
  // Onboarding.
  static const String welcome = 'Te damos la bienvenida';
  static const String stepAboutYou = 'Sobre ti';
  static const String stepAboutYouHint =
      'Con estos datos adaptamos la app a ti. Puedes cambiarlos cuando '
      'quieras desde tu perfil.';
  static const String stepTraining = 'Tu entrenamiento';
  static const String stepTrainingHint =
      'Cuéntanos cómo entrenas y qué buscas.';
  static const String stepEquipment = 'Tu equipamiento';
  static const String stepEquipmentHint =
      'Elige el equipamiento que tienes disponible.';
  static const String next = 'Siguiente';
  static const String back = 'Atrás';
  static const String finish = 'Comenzar';

  static String stepCounter(int step, int total) => 'Paso $step de $total';

  // Profile fields.
  static const String alias = 'Nombre o alias';
  static const String birthDate = 'Fecha de nacimiento';
  static const String birthDateOptional = 'Fecha de nacimiento (opcional)';
  static const String clearDate = 'Quitar fecha';
  static const String sexOptional = 'Sexo (opcional)';
  static const String sexUnspecified = 'Prefiero no decirlo';
  static const String height = 'Estatura';
  static const String bodyWeight = 'Peso corporal';
  static const String experienceLevel = 'Nivel de experiencia';
  static const String goal = 'Objetivo principal';
  static const String daysPerWeek = 'Días por semana';
  static const String sessionDuration = 'Duración por sesión';
  static const String equipment = 'Equipamiento disponible';
  static const String cm = 'cm';
  static const String kg = 'kg';
  static const String minutes = 'min';

  static String years(int years) => '$years años';

  // Profile screen and edit form.
  static const String editProfile = 'Editar perfil';
  static const String personalData = 'Datos personales';
  static const String training = 'Entrenamiento';
  static const String age = 'Edad';
  static const String sex = 'Sexo';
  static const String notSpecified = 'Sin indicar';
  static const String save = 'Guardar';
  static const String profileSaved = 'Perfil actualizado';
  static const String loadError = 'No se pudo cargar el perfil.';

  static String days(int days) => days == 1 ? '1 día' : '$days días';

  static String durationMinutes(int minutes) => '$minutes min';

  static const String saveError = 'No se pudo guardar. Inténtalo de nuevo.';

  // Profile validation.
  static const String aliasRequired = 'Escribe tu nombre o alias.';
  static const String aliasTooLong =
      'Usa como máximo $kAliasMaxLength caracteres.';
  static const String birthDateOutOfRange =
      'La edad debe estar entre $kMinAge y $kMaxAge años.';
  static const String heightRequired = 'Escribe tu estatura.';
  static const String heightOutOfRange =
      'Escribe una estatura entre $kMinHeightCm y $kMaxHeightCm cm.';
  static const String experienceLevelRequired = 'Elige tu nivel.';
  static const String goalRequired = 'Elige tu objetivo.';
  static const String daysPerWeekRequired = 'Elige cuántos días.';
  static const String daysPerWeekOutOfRange =
      'Elige entre $kMinDaysPerWeek y $kMaxDaysPerWeek días.';
  static const String sessionDurationRequired = 'Escribe la duración.';
  static const String sessionDurationOutOfRange =
      'Escribe entre $kMinSessionDurationMin y $kMaxSessionDurationMin '
      'minutos.';
  static const String equipmentRequired = 'Elige al menos una opción.';

  // Body weight validation.
  static const String dateRequired = 'Elige una fecha.';
  static const String dateInFuture = 'La fecha no puede ser futura.';
  static const String weightRequired = 'Escribe tu peso.';
  static const String weightOutOfRange =
      'Escribe un peso entre $kMinBodyWeightKg y $kMaxBodyWeightKg kg.';

  // Measurement validation.
  static const String measurementNoValues = 'Escribe al menos una medida.';
  static const String circumferenceOutOfRange =
      'Escribe entre $kMinCircumferenceCm y $kMaxCircumferenceCm cm.';
  static const String bodyFatOutOfRange =
      'Escribe entre $kMinBodyFatPct y $kMaxBodyFatPct %.';
}
