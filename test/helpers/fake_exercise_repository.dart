import 'dart:async';

import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise_draft.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise_repository.dart';

/// In-memory [ExerciseRepository] for widget tests. Follows the same rules
/// as the Drift implementation.
class FakeExerciseRepository implements ExerciseRepository {
  FakeExerciseRepository([Iterable<Exercise> initial = const []])
    : _items = {for (final e in initial) e.id: e};

  final Map<String, Exercise> _items;
  final _changes = StreamController<void>.broadcast();
  int _nextId = 1;

  List<Exercise> get _active => _items.values.toList();

  void _notify() => _changes.add(null);

  /// Emits the current value on listen and again after every change. Like
  /// Drift, changes made while the subscription is paused are delivered on
  /// resume (Riverpod pauses providers of off-screen routes).
  Stream<T> _watch<T>(T Function() read) {
    late final StreamController<T> controller;
    StreamSubscription<void>? changes;
    controller = StreamController<T>(
      onListen: () {
        changes = _changes.stream.listen((_) => controller.add(read()));
        controller.add(read());
      },
      onCancel: () => changes?.cancel(),
    );
    return controller.stream;
  }

  @override
  Stream<List<Exercise>> watchAll() => _watch(() => _active);

  @override
  Stream<Exercise?> watchById(String id) => _watch(() => _items[id]);

  @override
  Future<Exercise?> getById(String id) async => _items[id];

  @override
  Future<Exercise> create(ExerciseDraft draft) async {
    _validate(draft);
    final exercise = _fromDraft('custom-${_nextId++}', draft);
    _items[exercise.id] = exercise;
    _notify();
    return exercise;
  }

  @override
  Future<void> update(String id, ExerciseDraft draft) async {
    _requireEditable(id);
    _validate(draft, editingId: id);
    _items[id] = _fromDraft(id, draft);
    _notify();
  }

  @override
  Future<void> softDelete(String id) async {
    _requireEditable(id);
    _items.remove(id);
    _notify();
  }

  @override
  Future<void> setPreferredUnit(String id, WeightUnit unit) async {
    final exercise = _items[id];
    if (exercise == null) throw ExerciseNotFoundException(id);
    _items[id] = exercise.copyWith(preferredUnit: unit);
    _notify();
  }

  void _requireEditable(String id) {
    final exercise = _items[id];
    if (exercise == null) throw ExerciseNotFoundException(id);
    if (exercise.isSeed) throw ExerciseNotEditableException(id);
  }

  void _validate(ExerciseDraft draft, {String? editingId}) {
    final errors = draft.validate(existing: _active, editingId: editingId);
    if (errors.isNotEmpty) throw ExerciseValidationException(errors);
  }

  Exercise _fromDraft(String id, ExerciseDraft draft) => Exercise(
    id: id,
    name: draft.name.trim(),
    primaryMuscle: draft.primaryMuscle!,
    secondaryMuscles: draft.secondaryMuscles,
    type: draft.type!,
    equipment: draft.equipment!,
    difficulty: draft.difficulty!,
    instructions: draft.instructions.trim(),
    commonMistakes: draft.commonMistakes.trim(),
    preferredUnit: draft.preferredUnit,
    isCustom: true,
  );
}
