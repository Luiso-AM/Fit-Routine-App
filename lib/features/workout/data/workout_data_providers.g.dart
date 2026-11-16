// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the repository through its domain interface.

@ProviderFor(workoutRepository)
final workoutRepositoryProvider = WorkoutRepositoryProvider._();

/// Exposes the repository through its domain interface.

final class WorkoutRepositoryProvider
    extends
        $FunctionalProvider<
          WorkoutRepository,
          WorkoutRepository,
          WorkoutRepository
        >
    with $Provider<WorkoutRepository> {
  /// Exposes the repository through its domain interface.
  WorkoutRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkoutRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkoutRepository create(Ref ref) {
    return workoutRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutRepository>(value),
    );
  }
}

String _$workoutRepositoryHash() => r'f96937fc2789db7d85f044ba4abf770e34d1fef3';

/// Notifies the end of a rest through its domain interface.

@ProviderFor(restNotifier)
final restProvider = RestNotifierProvider._();

/// Notifies the end of a rest through its domain interface.

final class RestNotifierProvider
    extends $FunctionalProvider<RestNotifier, RestNotifier, RestNotifier>
    with $Provider<RestNotifier> {
  /// Notifies the end of a rest through its domain interface.
  RestNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restNotifierHash();

  @$internal
  @override
  $ProviderElement<RestNotifier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RestNotifier create(Ref ref) {
    return restNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestNotifier>(value),
    );
  }
}

String _$restNotifierHash() => r'da8402541ffbebbbc0623421336e6adbb09dc3b4';
