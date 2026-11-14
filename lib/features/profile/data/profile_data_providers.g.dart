// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the repositories through their domain interfaces.

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

/// Exposes the repositories through their domain interfaces.

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  /// Exposes the repositories through their domain interfaces.
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'9f979afb3a9ca342b2a8f56235f5efc5fab09483';

@ProviderFor(bodyMetricsRepository)
final bodyMetricsRepositoryProvider = BodyMetricsRepositoryProvider._();

final class BodyMetricsRepositoryProvider
    extends
        $FunctionalProvider<
          BodyMetricsRepository,
          BodyMetricsRepository,
          BodyMetricsRepository
        >
    with $Provider<BodyMetricsRepository> {
  BodyMetricsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyMetricsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyMetricsRepositoryHash();

  @$internal
  @override
  $ProviderElement<BodyMetricsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BodyMetricsRepository create(Ref ref) {
    return bodyMetricsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BodyMetricsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BodyMetricsRepository>(value),
    );
  }
}

String _$bodyMetricsRepositoryHash() =>
    r'efd885eabc1aa1c6c205ae04543b69c2af850317';
