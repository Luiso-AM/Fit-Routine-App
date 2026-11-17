// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dashboardProfile)
final dashboardProfileProvider = DashboardProfileProvider._();

final class DashboardProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile?>,
          UserProfile?,
          Stream<UserProfile?>
        >
    with $FutureModifier<UserProfile?>, $StreamProvider<UserProfile?> {
  DashboardProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardProfileHash();

  @$internal
  @override
  $StreamProviderElement<UserProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UserProfile?> create(Ref ref) {
    return dashboardProfile(ref);
  }
}

String _$dashboardProfileHash() => r'a13e2ac58ab517da5fd87bfbc6a897fd25baaa66';

/// The session in progress, or `null`.

@ProviderFor(dashboardActiveSession)
final dashboardActiveSessionProvider = DashboardActiveSessionProvider._();

/// The session in progress, or `null`.

final class DashboardActiveSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkoutSession?>,
          WorkoutSession?,
          Stream<WorkoutSession?>
        >
    with $FutureModifier<WorkoutSession?>, $StreamProvider<WorkoutSession?> {
  /// The session in progress, or `null`.
  DashboardActiveSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardActiveSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardActiveSessionHash();

  @$internal
  @override
  $StreamProviderElement<WorkoutSession?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<WorkoutSession?> create(Ref ref) {
    return dashboardActiveSession(ref);
  }
}

String _$dashboardActiveSessionHash() =>
    r'11f573e9eb228b1e7b7b341b5b56a0a08e27f8e1';

/// Sessions finished this week (Monday to Sunday, local time).

@ProviderFor(dashboardWeekSessions)
final dashboardWeekSessionsProvider = DashboardWeekSessionsProvider._();

/// Sessions finished this week (Monday to Sunday, local time).

final class DashboardWeekSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WorkoutSession>>,
          List<WorkoutSession>,
          Stream<List<WorkoutSession>>
        >
    with
        $FutureModifier<List<WorkoutSession>>,
        $StreamProvider<List<WorkoutSession>> {
  /// Sessions finished this week (Monday to Sunday, local time).
  DashboardWeekSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardWeekSessionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardWeekSessionsHash();

  @$internal
  @override
  $StreamProviderElement<List<WorkoutSession>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WorkoutSession>> create(Ref ref) {
    return dashboardWeekSessions(ref);
  }
}

String _$dashboardWeekSessionsHash() =>
    r'2d4890db11b53a56d7b3b017c741540eb155dbae';

/// When every finished session started, newest first.

@ProviderFor(dashboardFinishedStarts)
final dashboardFinishedStartsProvider = DashboardFinishedStartsProvider._();

/// When every finished session started, newest first.

final class DashboardFinishedStartsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SessionStart>>,
          List<SessionStart>,
          Stream<List<SessionStart>>
        >
    with
        $FutureModifier<List<SessionStart>>,
        $StreamProvider<List<SessionStart>> {
  /// When every finished session started, newest first.
  DashboardFinishedStartsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardFinishedStartsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardFinishedStartsHash();

  @$internal
  @override
  $StreamProviderElement<List<SessionStart>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<SessionStart>> create(Ref ref) {
    return dashboardFinishedStarts(ref);
  }
}

String _$dashboardFinishedStartsHash() =>
    r'89a40f83be71400b6f9764c6f367e27add8ae991';

@ProviderFor(dashboardRoutines)
final dashboardRoutinesProvider = DashboardRoutinesProvider._();

final class DashboardRoutinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Routine>>,
          List<Routine>,
          Stream<List<Routine>>
        >
    with $FutureModifier<List<Routine>>, $StreamProvider<List<Routine>> {
  DashboardRoutinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRoutinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRoutinesHash();

  @$internal
  @override
  $StreamProviderElement<List<Routine>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Routine>> create(Ref ref) {
    return dashboardRoutines(ref);
  }
}

String _$dashboardRoutinesHash() => r'd2e81376b3fa149bf670aa24618897638268efc4';

/// Active exercises by id, to derive the muscles of a routine day.

@ProviderFor(dashboardExerciseCatalog)
final dashboardExerciseCatalogProvider = DashboardExerciseCatalogProvider._();

/// Active exercises by id, to derive the muscles of a routine day.

final class DashboardExerciseCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Exercise>>,
          Map<String, Exercise>,
          Stream<Map<String, Exercise>>
        >
    with
        $FutureModifier<Map<String, Exercise>>,
        $StreamProvider<Map<String, Exercise>> {
  /// Active exercises by id, to derive the muscles of a routine day.
  DashboardExerciseCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardExerciseCatalogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardExerciseCatalogHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, Exercise>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, Exercise>> create(Ref ref) {
    return dashboardExerciseCatalog(ref);
  }
}

String _$dashboardExerciseCatalogHash() =>
    r'5df06e74c05289bc90e7e1d924b23a41e6a7522e';

/// Body weight entries, newest first.

@ProviderFor(dashboardWeights)
final dashboardWeightsProvider = DashboardWeightsProvider._();

/// Body weight entries, newest first.

final class DashboardWeightsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BodyWeightEntry>>,
          List<BodyWeightEntry>,
          Stream<List<BodyWeightEntry>>
        >
    with
        $FutureModifier<List<BodyWeightEntry>>,
        $StreamProvider<List<BodyWeightEntry>> {
  /// Body weight entries, newest first.
  DashboardWeightsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardWeightsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardWeightsHash();

  @$internal
  @override
  $StreamProviderElement<List<BodyWeightEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BodyWeightEntry>> create(Ref ref) {
    return dashboardWeights(ref);
  }
}

String _$dashboardWeightsHash() => r'7d663389aa69b4d61aa697c7e39b359256d30df6';
