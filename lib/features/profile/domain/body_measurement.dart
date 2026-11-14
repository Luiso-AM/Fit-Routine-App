import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_measurement.freezed.dart';

/// Body circumferences in cm and body fat percentage. Every value is
/// optional, but a stored measurement has at least one.
@freezed
abstract class BodyMeasurement with _$BodyMeasurement {
  const factory BodyMeasurement({
    required String id,

    /// Calendar date (UTC midnight).
    required DateTime date,
    double? waistCm,
    double? chestCm,
    double? armCm,
    double? legCm,
    double? hipCm,
    double? bodyFatPct,
  }) = _BodyMeasurement;
}
