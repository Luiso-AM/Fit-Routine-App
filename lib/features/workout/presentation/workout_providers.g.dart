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

/// Summary of a session, compared with the previous session of its
/// routine day. `null` if the session does not exist.

@ProviderFor(sessionSummary)
final sessionSummaryProvider = SessionSummaryFamily._();

/// Summary of a session, compared with the previous session of its
/// routine day. `null` if the session does not exist.

final class SessionSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SessionSummary?>,
          SessionSummary?,
          FutureOr<SessionSummary?>
        >
    with $FutureModifier<SessionSummary?>, $FutureProvider<SessionSummary?> {
  /// Summary of a session, compared with the previous session of its
  /// routine day. `null` if the session does not exist.
  SessionSummaryProvider._({
    required SessionSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'sessionSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sessionSummaryHash();

  @override
  String toString() {
    return r'sessionSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SessionSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SessionSummary?> create(Ref ref) {
    final argument = this.argument as String;
    return sessionSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionSummaryHash() => r'8dbda3139f934c29ff0fdf7f80eb69c0ee9fc6ce';

/// Summary of a session, compared with the previous session of its
/// routine day. `null` if the session does not exist.

final class SessionSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SessionSummary?>, String> {
  SessionSummaryFamily._()
    : super(
        retry: null,
        name: r'sessionSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Summary of a session, compared with the previous session of its
  /// routine day. `null` if the session does not exist.

  SessionSummaryProvider call(String sessionId) =>
      SessionSummaryProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'sessionSummaryProvider';
}

/// Keeps the rest notification in step with the active session: it is
/// scheduled for the end of each rest and cancelled when the rest is
/// skipped or the session pauses or ends. Watched by the app root so it
/// runs on every screen.
///
/// Nothing is cancelled until a rest has been seen, so the plugin (and its
/// permission request) is not touched at launch.

@ProviderFor(restNotificationSync)
final restNotificationSyncProvider = RestNotificationSyncProvider._();

/// Keeps the rest notification in step with the active session: it is
/// scheduled for the end of each rest and cancelled when the rest is
/// skipped or the session pauses or ends. Watched by the app root so it
/// runs on every screen.
///
/// Nothing is cancelled until a rest has been seen, so the plugin (and its
/// permission request) is not touched at launch.

final class RestNotificationSyncProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Keeps the rest notification in step with the active session: it is
  /// scheduled for the end of each rest and cancelled when the rest is
  /// skipped or the session pauses or ends. Watched by the app root so it
  /// runs on every screen.
  ///
  /// Nothing is cancelled until a rest has been seen, so the plugin (and its
  /// permission request) is not touched at launch.
  RestNotificationSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restNotificationSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restNotificationSyncHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return restNotificationSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$restNotificationSyncHash() =>
    r'5fd5f6942816656d6dbcb19a5474462cbc27fb2e';

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
