// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's profile, `null` before onboarding. Kept alive because the
/// router depends on it.

@ProviderFor(currentProfile)
final currentProfileProvider = CurrentProfileProvider._();

/// The user's profile, `null` before onboarding. Kept alive because the
/// router depends on it.

final class CurrentProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile?>,
          UserProfile?,
          Stream<UserProfile?>
        >
    with $FutureModifier<UserProfile?>, $StreamProvider<UserProfile?> {
  /// The user's profile, `null` before onboarding. Kept alive because the
  /// router depends on it.
  CurrentProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentProfileHash();

  @$internal
  @override
  $StreamProviderElement<UserProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UserProfile?> create(Ref ref) {
    return currentProfile(ref);
  }
}

String _$currentProfileHash() => r'f5f2227fda446c7f6f6f8d3d44dd0c132dcb6283';
