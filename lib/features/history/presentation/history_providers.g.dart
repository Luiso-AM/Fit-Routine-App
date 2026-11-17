// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Finished sessions of the local month that contains [month], grouped by
/// the day they started on.

@ProviderFor(historyMonth)
final historyMonthProvider = HistoryMonthFamily._();

/// Finished sessions of the local month that contains [month], grouped by
/// the day they started on.

final class HistoryMonthProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<DateTime, List<WorkoutSession>>>,
          Map<DateTime, List<WorkoutSession>>,
          Stream<Map<DateTime, List<WorkoutSession>>>
        >
    with
        $FutureModifier<Map<DateTime, List<WorkoutSession>>>,
        $StreamProvider<Map<DateTime, List<WorkoutSession>>> {
  /// Finished sessions of the local month that contains [month], grouped by
  /// the day they started on.
  HistoryMonthProvider._({
    required HistoryMonthFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'historyMonthProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$historyMonthHash();

  @override
  String toString() {
    return r'historyMonthProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Map<DateTime, List<WorkoutSession>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<DateTime, List<WorkoutSession>>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return historyMonth(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HistoryMonthProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$historyMonthHash() => r'd8fd3950f41ff3cf5c84cdf8608d25cbcec1b19f';

/// Finished sessions of the local month that contains [month], grouped by
/// the day they started on.

final class HistoryMonthFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<Map<DateTime, List<WorkoutSession>>>,
          DateTime
        > {
  HistoryMonthFamily._()
    : super(
        retry: null,
        name: r'historyMonthProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Finished sessions of the local month that contains [month], grouped by
  /// the day they started on.

  HistoryMonthProvider call(DateTime month) =>
      HistoryMonthProvider._(argument: month, from: this);

  @override
  String toString() => r'historyMonthProvider';
}
