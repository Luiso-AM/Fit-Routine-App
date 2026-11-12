// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the repository through its domain interface.

@ProviderFor(exerciseRepository)
final exerciseRepositoryProvider = ExerciseRepositoryProvider._();

/// Exposes the repository through its domain interface.

final class ExerciseRepositoryProvider
    extends
        $FunctionalProvider<
          ExerciseRepository,
          ExerciseRepository,
          ExerciseRepository
        >
    with $Provider<ExerciseRepository> {
  /// Exposes the repository through its domain interface.
  ExerciseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExerciseRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExerciseRepository create(Ref ref) {
    return exerciseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseRepository>(value),
    );
  }
}

String _$exerciseRepositoryHash() =>
    r'99ac086ee663333a56bc3b53bf17c9ebd8085900';

@ProviderFor(exerciseSeeder)
final exerciseSeederProvider = ExerciseSeederProvider._();

final class ExerciseSeederProvider
    extends $FunctionalProvider<ExerciseSeeder, ExerciseSeeder, ExerciseSeeder>
    with $Provider<ExerciseSeeder> {
  ExerciseSeederProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseSeederProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseSeederHash();

  @$internal
  @override
  $ProviderElement<ExerciseSeeder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExerciseSeeder create(Ref ref) {
    return exerciseSeeder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseSeeder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseSeeder>(value),
    );
  }
}

String _$exerciseSeederHash() => r'061a9ca59d4ac59735950b08259cda0010e67e5a';
