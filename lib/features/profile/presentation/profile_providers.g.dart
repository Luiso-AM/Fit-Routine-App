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

/// Body weight entries, newest first.

@ProviderFor(bodyWeights)
final bodyWeightsProvider = BodyWeightsProvider._();

/// Body weight entries, newest first.

final class BodyWeightsProvider
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
  BodyWeightsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyWeightsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyWeightsHash();

  @$internal
  @override
  $StreamProviderElement<List<BodyWeightEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BodyWeightEntry>> create(Ref ref) {
    return bodyWeights(ref);
  }
}

String _$bodyWeightsHash() => r'2afa557736f8760499c76b9d85ad79ee70e620b3';

/// Body measurements, newest first.

@ProviderFor(bodyMeasurements)
final bodyMeasurementsProvider = BodyMeasurementsProvider._();

/// Body measurements, newest first.

final class BodyMeasurementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BodyMeasurement>>,
          List<BodyMeasurement>,
          Stream<List<BodyMeasurement>>
        >
    with
        $FutureModifier<List<BodyMeasurement>>,
        $StreamProvider<List<BodyMeasurement>> {
  /// Body measurements, newest first.
  BodyMeasurementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyMeasurementsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyMeasurementsHash();

  @$internal
  @override
  $StreamProviderElement<List<BodyMeasurement>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BodyMeasurement>> create(Ref ref) {
    return bodyMeasurements(ref);
  }
}

String _$bodyMeasurementsHash() => r'4599e584460d5fafe6c0bf15d8f415a15576cf58';

@ProviderFor(bodyMeasurementById)
final bodyMeasurementByIdProvider = BodyMeasurementByIdFamily._();

final class BodyMeasurementByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<BodyMeasurement?>,
          BodyMeasurement?,
          Stream<BodyMeasurement?>
        >
    with $FutureModifier<BodyMeasurement?>, $StreamProvider<BodyMeasurement?> {
  BodyMeasurementByIdProvider._({
    required BodyMeasurementByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bodyMeasurementByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bodyMeasurementByIdHash();

  @override
  String toString() {
    return r'bodyMeasurementByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<BodyMeasurement?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BodyMeasurement?> create(Ref ref) {
    final argument = this.argument as String;
    return bodyMeasurementById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BodyMeasurementByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bodyMeasurementByIdHash() =>
    r'aa8c6fabec5ba924d07c480ce618612a4a6681c7';

final class BodyMeasurementByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<BodyMeasurement?>, String> {
  BodyMeasurementByIdFamily._()
    : super(
        retry: null,
        name: r'bodyMeasurementByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BodyMeasurementByIdProvider call(String id) =>
      BodyMeasurementByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'bodyMeasurementByIdProvider';
}
