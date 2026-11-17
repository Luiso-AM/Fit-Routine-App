import 'package:freezed_annotation/freezed_annotation.dart';

import '../../profile/domain/body_weight_entry.dart';

part 'weight_trend.freezed.dart';

/// The latest body weight and how it changed since an earlier entry.
@freezed
abstract class WeightTrend with _$WeightTrend {
  const factory WeightTrend({
    required BodyWeightEntry latest,

    /// The latest entry at least [minimumGap] older than [latest], if any.
    BodyWeightEntry? reference,
  }) = _WeightTrend;

  const WeightTrend._();

  /// How far back an entry has to be to compare with: comparing with
  /// yesterday would mostly show daily noise.
  static const Duration minimumGap = Duration(days: 7);

  /// [latest] − [reference], in kg. `null` without a reference.
  double? get changeKg {
    final reference = this.reference;
    return reference == null ? null : latest.weightKg - reference.weightKg;
  }

  /// Days from [reference] to [latest]. `null` without a reference.
  int? get daysBetween =>
      reference == null ? null : latest.date.difference(reference!.date).inDays;
}

/// The trend of [entries], in any order, or `null` if there are none.
WeightTrend? weightTrend(Iterable<BodyWeightEntry> entries) {
  final sorted = [...entries]..sort((a, b) => b.date.compareTo(a.date));
  if (sorted.isEmpty) return null;
  final latest = sorted.first;
  final limit = latest.date.subtract(WeightTrend.minimumGap);
  return WeightTrend(
    latest: latest,
    reference: sorted.where((e) => !e.date.isAfter(limit)).firstOrNull,
  );
}
