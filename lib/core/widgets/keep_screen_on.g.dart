// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keep_screen_on.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(screenWakeLock)
final screenWakeLockProvider = ScreenWakeLockProvider._();

final class ScreenWakeLockProvider
    extends $FunctionalProvider<ScreenWakeLock, ScreenWakeLock, ScreenWakeLock>
    with $Provider<ScreenWakeLock> {
  ScreenWakeLockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenWakeLockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenWakeLockHash();

  @$internal
  @override
  $ProviderElement<ScreenWakeLock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScreenWakeLock create(Ref ref) {
    return screenWakeLock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenWakeLock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenWakeLock>(value),
    );
  }
}

String _$screenWakeLockHash() => r'7c30989d76af4f52b22558b9c39d578d7a58abe7';
