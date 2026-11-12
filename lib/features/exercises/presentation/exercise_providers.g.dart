// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exercises)
final exercisesProvider = ExercisesProvider._();

final class ExercisesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Exercise>>,
          List<Exercise>,
          Stream<List<Exercise>>
        >
    with $FutureModifier<List<Exercise>>, $StreamProvider<List<Exercise>> {
  ExercisesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exercisesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exercisesHash();

  @$internal
  @override
  $StreamProviderElement<List<Exercise>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Exercise>> create(Ref ref) {
    return exercises(ref);
  }
}

String _$exercisesHash() => r'd8657ef77b45556fa6d06c3710976dc46313020b';

@ProviderFor(exerciseById)
final exerciseByIdProvider = ExerciseByIdFamily._();

final class ExerciseByIdProvider
    extends
        $FunctionalProvider<AsyncValue<Exercise?>, Exercise?, Stream<Exercise?>>
    with $FutureModifier<Exercise?>, $StreamProvider<Exercise?> {
  ExerciseByIdProvider._({
    required ExerciseByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'exerciseByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exerciseByIdHash();

  @override
  String toString() {
    return r'exerciseByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Exercise?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Exercise?> create(Ref ref) {
    final argument = this.argument as String;
    return exerciseById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exerciseByIdHash() => r'c5d53ceb4c4fee4bb5bfca7272fb95b1eb567814';

final class ExerciseByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Exercise?>, String> {
  ExerciseByIdFamily._()
    : super(
        retry: null,
        name: r'exerciseByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExerciseByIdProvider call(String id) =>
      ExerciseByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'exerciseByIdProvider';
}

/// Search text and filters of the library screen.

@ProviderFor(ExerciseQueryController)
final exerciseQueryControllerProvider = ExerciseQueryControllerProvider._();

/// Search text and filters of the library screen.
final class ExerciseQueryControllerProvider
    extends $NotifierProvider<ExerciseQueryController, ExerciseQuery> {
  /// Search text and filters of the library screen.
  ExerciseQueryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseQueryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseQueryControllerHash();

  @$internal
  @override
  ExerciseQueryController create() => ExerciseQueryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseQuery>(value),
    );
  }
}

String _$exerciseQueryControllerHash() =>
    r'617126c2f4988f6a7b1c020a4a68df997070e2eb';

/// Search text and filters of the library screen.

abstract class _$ExerciseQueryController extends $Notifier<ExerciseQuery> {
  ExerciseQuery build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ExerciseQuery, ExerciseQuery>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExerciseQuery, ExerciseQuery>,
              ExerciseQuery,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Exercises matching the current query, grouped by primary muscle.

@ProviderFor(filteredExerciseGroups)
final filteredExerciseGroupsProvider = FilteredExerciseGroupsProvider._();

/// Exercises matching the current query, grouped by primary muscle.

final class FilteredExerciseGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<MuscleGroup, List<Exercise>>>,
          AsyncValue<Map<MuscleGroup, List<Exercise>>>,
          AsyncValue<Map<MuscleGroup, List<Exercise>>>
        >
    with $Provider<AsyncValue<Map<MuscleGroup, List<Exercise>>>> {
  /// Exercises matching the current query, grouped by primary muscle.
  FilteredExerciseGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredExerciseGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredExerciseGroupsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<Map<MuscleGroup, List<Exercise>>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<Map<MuscleGroup, List<Exercise>>> create(Ref ref) {
    return filteredExerciseGroups(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    AsyncValue<Map<MuscleGroup, List<Exercise>>> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<Map<MuscleGroup, List<Exercise>>>>(
            value,
          ),
    );
  }
}

String _$filteredExerciseGroupsHash() =>
    r'a7a29ae26b709d376d6c8964638d2ce4468428cc';
