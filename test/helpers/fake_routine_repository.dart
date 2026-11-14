import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_drafts.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_repository.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_template.dart';

import 'watchable.dart';

/// In-memory [RoutineRepository] for widget tests. Follows the same rules
/// as the Drift implementation. [exercises] gives the types used for the
/// default targets of template exercises.
class FakeRoutineRepository with Watchable implements RoutineRepository {
  FakeRoutineRepository({
    Iterable<Routine> routines = const [],
    Iterable<Exercise> exercises = const [],
  }) : _routines = [...routines],
       _exercises = {for (final e in exercises) e.id: e};

  final List<Routine> _routines;
  final Map<String, Exercise> _exercises;
  int _nextId = 1;

  List<Routine> get routines => List.unmodifiable(_routines);

  String _id(String prefix) => '$prefix-${_nextId++}';

  int _indexOf(String id) {
    final index = _routines.indexWhere((r) => r.id == id);
    if (index < 0) throw RoutineNotFoundException(id);
    return index;
  }

  (int, int) _dayIndex(String dayId) {
    for (final (r, routine) in _routines.indexed) {
      final d = routine.days.indexWhere((day) => day.id == dayId);
      if (d >= 0) return (r, d);
    }
    throw RoutineNotFoundException(dayId);
  }

  (int, int, int) _exerciseIndex(String id) {
    for (final (r, routine) in _routines.indexed) {
      for (final (d, day) in routine.days.indexed) {
        final e = day.exercises.indexWhere((x) => x.id == id);
        if (e >= 0) return (r, d, e);
      }
    }
    throw RoutineNotFoundException(id);
  }

  void _replaceDay(int r, int d, RoutineDay day) {
    final days = [..._routines[r].days]..[d] = day;
    _routines[r] = _routines[r].copyWith(days: days);
    notifyChanged();
  }

  static List<RoutineDay> _renumberDays(List<RoutineDay> days) => [
    for (final (i, day) in days.indexed) day.copyWith(position: i),
  ];

  static List<RoutineExercise> _renumber(List<RoutineExercise> exercises) => [
    for (final (i, e) in exercises.indexed) e.copyWith(position: i),
  ];

  RoutineExercise _newExercise(String dayId, Exercise exercise, int position) {
    final defaults = RoutineExerciseDraft.defaultsFor(exercise.type);
    return RoutineExercise(
      id: _id('re'),
      routineDayId: dayId,
      exerciseId: exercise.id,
      position: position,
      targetSets: defaults.targetSets!,
      targetRepsMin: defaults.targetRepsMin!,
      targetRepsMax: defaults.targetRepsMax!,
      restSeconds: defaults.restSeconds!,
    );
  }

  @override
  Stream<List<Routine>> watchAll() => watchValue(() => routines);

  @override
  Stream<Routine?> watchById(String id) =>
      watchValue(() => _routines.where((r) => r.id == id).firstOrNull);

  @override
  Future<Routine> create(RoutineDraft draft) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineValidationException(errors);
    final routine = Routine(
      id: _id('routine'),
      name: draft.name.trim(),
      notes: draft.notes.trim(),
    );
    _routines.add(routine);
    notifyChanged();
    return routine;
  }

  @override
  Future<Routine> createFromTemplate(RoutineTemplate template) async {
    final id = _id('routine');
    final routine = Routine(
      id: id,
      name: template.name,
      templateType: template.type,
      days: [
        for (final (i, day) in template.days.indexed)
          () {
            final dayId = _id('day');
            final known = [
              for (final exerciseId in day.exerciseIds) ?_exercises[exerciseId],
            ];
            return RoutineDay(
              id: dayId,
              routineId: id,
              name: day.name,
              position: i,
              exercises: [
                for (final (p, e) in known.indexed) _newExercise(dayId, e, p),
              ],
            );
          }(),
      ],
    );
    _routines.add(routine);
    notifyChanged();
    return routine;
  }

  @override
  Future<void> update(String id, RoutineDraft draft) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineValidationException(errors);
    final i = _indexOf(id);
    _routines[i] = _routines[i].copyWith(
      name: draft.name.trim(),
      notes: draft.notes.trim(),
    );
    notifyChanged();
  }

  @override
  Future<Routine> duplicate(String id, {required String name}) async {
    final source = _routines[_indexOf(id)];
    final errors = RoutineDraft(name: name).validate();
    if (errors.isNotEmpty) throw RoutineValidationException(errors);
    final copyId = _id('routine');
    final copy = source.copyWith(
      id: copyId,
      name: name,
      days: [
        for (final day in source.days)
          () {
            final dayId = _id('day');
            return day.copyWith(
              id: dayId,
              routineId: copyId,
              exercises: [
                for (final e in day.exercises)
                  e.copyWith(id: _id('re'), routineDayId: dayId),
              ],
            );
          }(),
      ],
    );
    _routines.add(copy);
    notifyChanged();
    return copy;
  }

  @override
  Future<void> softDelete(String id) async {
    _routines.removeAt(_indexOf(id));
    notifyChanged();
  }

  @override
  Future<RoutineDay> addDay(String routineId, RoutineDayDraft draft) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineDayValidationException(errors);
    final i = _indexOf(routineId);
    final day = RoutineDay(
      id: _id('day'),
      routineId: routineId,
      name: draft.name.trim(),
      position: _routines[i].days.length,
      weekday: draft.weekday,
    );
    _routines[i] = _routines[i].copyWith(days: [..._routines[i].days, day]);
    notifyChanged();
    return day;
  }

  @override
  Future<void> updateDay(String dayId, RoutineDayDraft draft) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineDayValidationException(errors);
    final (r, d) = _dayIndex(dayId);
    _replaceDay(
      r,
      d,
      _routines[r].days[d].copyWith(
        name: draft.name.trim(),
        weekday: draft.weekday,
      ),
    );
  }

  @override
  Future<void> deleteDay(String dayId) async {
    final (r, d) = _dayIndex(dayId);
    final days = [..._routines[r].days]..removeAt(d);
    _routines[r] = _routines[r].copyWith(days: _renumberDays(days));
    notifyChanged();
  }

  @override
  Future<void> reorderDays(String routineId, List<String> orderedDayIds) async {
    final i = _indexOf(routineId);
    final byId = {for (final d in _routines[i].days) d.id: d};
    if (orderedDayIds.length != byId.length ||
        !orderedDayIds.every(byId.containsKey)) {
      throw ArgumentError.value(orderedDayIds);
    }
    _routines[i] = _routines[i].copyWith(
      days: _renumberDays([for (final id in orderedDayIds) byId[id]!]),
    );
    notifyChanged();
  }

  @override
  Future<void> addExercises(String dayId, List<Exercise> exercises) async {
    final (r, d) = _dayIndex(dayId);
    final day = _routines[r].days[d];
    var position = day.exercises.length;
    _replaceDay(
      r,
      d,
      day.copyWith(
        exercises: [
          ...day.exercises,
          for (final e in exercises) _newExercise(dayId, e, position++),
        ],
      ),
    );
  }

  @override
  Future<void> updateExercise(
    String routineExerciseId,
    RoutineExerciseDraft draft,
  ) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineExerciseValidationException(errors);
    final (r, d, e) = _exerciseIndex(routineExerciseId);
    final day = _routines[r].days[d];
    final exercises = [...day.exercises]
      ..[e] = day.exercises[e].copyWith(
        targetSets: draft.targetSets!,
        targetRepsMin: draft.targetRepsMin!,
        targetRepsMax: draft.targetRepsMax!,
        initialWeightKg: draft.initialWeightKg,
        restSeconds: draft.restSeconds!,
        notes: draft.notes.trim(),
      );
    _replaceDay(r, d, day.copyWith(exercises: exercises));
  }

  @override
  Future<void> removeExercise(String routineExerciseId) async {
    final (r, d, e) = _exerciseIndex(routineExerciseId);
    final day = _routines[r].days[d];
    final exercises = [...day.exercises]..removeAt(e);
    _replaceDay(r, d, day.copyWith(exercises: _renumber(exercises)));
  }

  @override
  Future<void> reorderExercises(String dayId, List<String> orderedIds) async {
    final (r, d) = _dayIndex(dayId);
    final day = _routines[r].days[d];
    final byId = {for (final e in day.exercises) e.id: e};
    if (orderedIds.length != byId.length ||
        !orderedIds.every(byId.containsKey)) {
      throw ArgumentError.value(orderedIds);
    }
    _replaceDay(
      r,
      d,
      day.copyWith(
        exercises: _renumber([for (final id in orderedIds) byId[id]!]),
      ),
    );
  }
}
