// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The session in progress, or `null`.

@ProviderFor(activeWorkout)
final activeWorkoutProvider = ActiveWorkoutProvider._();

/// The session in progress, or `null`.

final class ActiveWorkoutProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkoutSession?>,
          WorkoutSession?,
          Stream<WorkoutSession?>
        >
    with $FutureModifier<WorkoutSession?>, $StreamProvider<WorkoutSession?> {
  /// The session in progress, or `null`.
  ActiveWorkoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeWorkoutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeWorkoutHash();

  @$internal
  @override
  $StreamProviderElement<WorkoutSession?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WorkoutSession?> create(Ref ref) {
    return activeWorkout(ref);
  }
}

String _$activeWorkoutHash() => r'50cdbb439ca38898bc70b814df6696a672499cdc';

/// Active exercises by id, to show the exercises a session references.

@ProviderFor(workoutExerciseCatalog)
final workoutExerciseCatalogProvider = WorkoutExerciseCatalogProvider._();

/// Active exercises by id, to show the exercises a session references.

final class WorkoutExerciseCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Exercise>>,
          Map<String, Exercise>,
          Stream<Map<String, Exercise>>
        >
    with
        $FutureModifier<Map<String, Exercise>>,
        $StreamProvider<Map<String, Exercise>> {
  /// Active exercises by id, to show the exercises a session references.
  WorkoutExerciseCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutExerciseCatalogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutExerciseCatalogHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, Exercise>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, Exercise>> create(Ref ref) {
    return workoutExerciseCatalog(ref);
  }
}

String _$workoutExerciseCatalogHash() =>
    r'c3a3f260d2223b90913d0b53c20088a30e348c1c';

/// Routines to start a session from.

@ProviderFor(workoutRoutines)
final workoutRoutinesProvider = WorkoutRoutinesProvider._();

/// Routines to start a session from.

final class WorkoutRoutinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Routine>>,
          List<Routine>,
          Stream<List<Routine>>
        >
    with $FutureModifier<List<Routine>>, $StreamProvider<List<Routine>> {
  /// Routines to start a session from.
  WorkoutRoutinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutRoutinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutRoutinesHash();

  @$internal
  @override
  $StreamProviderElement<List<Routine>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Routine>> create(Ref ref) {
    return workoutRoutines(ref);
  }
}

String _$workoutRoutinesHash() => r'f7b2f4361503603f0bb6a85935e28791cc69cc92';

/// What was done the last time an exercise was trained, or `null`.

@ProviderFor(lastPerformance)
final lastPerformanceProvider = LastPerformanceFamily._();

/// What was done the last time an exercise was trained, or `null`.

final class LastPerformanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<ExercisePerformance?>,
          ExercisePerformance?,
          FutureOr<ExercisePerformance?>
        >
    with
        $FutureModifier<ExercisePerformance?>,
        $FutureProvider<ExercisePerformance?> {
  /// What was done the last time an exercise was trained, or `null`.
  LastPerformanceProvider._({
    required LastPerformanceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'lastPerformanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lastPerformanceHash();

  @override
  String toString() {
    return r'lastPerformanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ExercisePerformance?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ExercisePerformance?> create(Ref ref) {
    final argument = this.argument as String;
    return lastPerformance(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LastPerformanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lastPerformanceHash() => r'8583b67d88abb3cf22cea27a473b46a94faf4e5b';

/// What was done the last time an exercise was trained, or `null`.

final class LastPerformanceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ExercisePerformance?>, String> {
  LastPerformanceFamily._()
    : super(
        retry: null,
        name: r'lastPerformanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// What was done the last time an exercise was trained, or `null`.

  LastPerformanceProvider call(String exerciseId) =>
      LastPerformanceProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'lastPerformanceProvider';
}

/// Current UTC time, updated every second, for the session clock.

@ProviderFor(clock)
final clockProvider = ClockProvider._();

/// Current UTC time, updated every second, for the session clock.

final class ClockProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  /// Current UTC time, updated every second, for the session clock.
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    return clock(ref);
  }
}

String _$clockHash() => r'd66cdfdc8998826688211ad245df87e2267c8d35';
