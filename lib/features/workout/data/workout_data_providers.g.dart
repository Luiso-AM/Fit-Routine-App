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

@ProviderFor(restNotifications)
final restNotificationsProvider = RestNotificationsProvider._();

/// Notifies the end of a rest through its domain interface.

final class RestNotificationsProvider
    extends $FunctionalProvider<RestNotifier, RestNotifier, RestNotifier>
    with $Provider<RestNotifier> {
  /// Notifies the end of a rest through its domain interface.
  RestNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restNotificationsHash();

  @$internal
  @override
  $ProviderElement<RestNotifier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RestNotifier create(Ref ref) {
    return restNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestNotifier>(value),
    );
  }
}

String _$restNotificationsHash() => r'13f3574101cbf3c52b8b7ff782e8bce22b46a279';
