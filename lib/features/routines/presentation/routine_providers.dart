import 'package:riverpod_annotation/riverpod_annotation.dart';

// The exercise repository is injected through the exercises feature's
// provider; only its domain interface is used here.
import '../../exercises/data/exercise_data_providers.dart';
import '../../exercises/domain/exercise.dart';
import '../data/routine_data_providers.dart';
import '../domain/routine.dart';

part 'routine_providers.g.dart';

@riverpod
Stream<List<Routine>> routines(Ref ref) =>
    ref.watch(routineRepositoryProvider).watchAll();

@riverpod
Stream<Routine?> routineById(Ref ref, String id) =>
    ref.watch(routineRepositoryProvider).watchById(id);

/// Active exercises by id, to show the exercises a routine references.
@riverpod
Stream<Map<String, Exercise>> exerciseCatalog(Ref ref) => ref
    .watch(exerciseRepositoryProvider)
    .watchAll()
    .map((all) => {for (final e in all) e.id: e});
