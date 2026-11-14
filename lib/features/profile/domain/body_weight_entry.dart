import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_weight_entry.freezed.dart';

/// A body weight measurement. There is at most one entry per day.
@freezed
abstract class BodyWeightEntry with _$BodyWeightEntry {
  const factory BodyWeightEntry({
    required String id,

    /// Calendar date (UTC midnight).
    required DateTime date,
    required double weightKg,
  }) = _BodyWeightEntry;
}
