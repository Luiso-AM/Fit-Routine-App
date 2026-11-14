// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routines)
final routinesProvider = RoutinesProvider._();

final class RoutinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Routine>>,
          List<Routine>,
          Stream<List<Routine>>
        >
    with $FutureModifier<List<Routine>>, $StreamProvider<List<Routine>> {
  RoutinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routinesHash();

  @$internal
  @override
  $StreamProviderElement<List<Routine>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Routine>> create(Ref ref) {
    return routines(ref);
  }
}

String _$routinesHash() => r'd9c9ed27420b4ede967409db5ff3b128a01bcb49';

@ProviderFor(routineById)
final routineByIdProvider = RoutineByIdFamily._();

final class RoutineByIdProvider
    extends
        $FunctionalProvider<AsyncValue<Routine?>, Routine?, Stream<Routine?>>
    with $FutureModifier<Routine?>, $StreamProvider<Routine?> {
  RoutineByIdProvider._({
    required RoutineByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'routineByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routineByIdHash();

  @override
  String toString() {
    return r'routineByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Routine?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Routine?> create(Ref ref) {
    final argument = this.argument as String;
    return routineById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routineByIdHash() => r'601bd2d8d2f2e7778d60a99cde7f24a1e231fd53';

final class RoutineByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Routine?>, String> {
  RoutineByIdFamily._()
    : super(
        retry: null,
        name: r'routineByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutineByIdProvider call(String id) =>
      RoutineByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'routineByIdProvider';
}

/// Active exercises by id, to show the exercises a routine references.

@ProviderFor(exerciseCatalog)
final exerciseCatalogProvider = ExerciseCatalogProvider._();

/// Active exercises by id, to show the exercises a routine references.

final class ExerciseCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Exercise>>,
          Map<String, Exercise>,
          Stream<Map<String, Exercise>>
        >
    with
        $FutureModifier<Map<String, Exercise>>,
        $StreamProvider<Map<String, Exercise>> {
  /// Active exercises by id, to show the exercises a routine references.
  ExerciseCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseCatalogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseCatalogHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, Exercise>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, Exercise>> create(Ref ref) {
    return exerciseCatalog(ref);
  }
}

String _$exerciseCatalogHash() => r'c00d3b25c20205d3c0706c93a02c00b8d03cc0dc';
