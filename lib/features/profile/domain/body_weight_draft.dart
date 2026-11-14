import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/calendar_date.dart';
import 'body_weight_entry.dart';

part 'body_weight_draft.freezed.dart';

const double kMinBodyWeightKg = 20;
const double kMaxBodyWeightKg = 400;

enum BodyWeightValidationError {
  dateRequired,
  dateInFuture,
  weightRequired,
  weightOutOfRange,
}

@freezed
abstract class BodyWeightDraft with _$BodyWeightDraft {
  const factory BodyWeightDraft({
    /// Calendar date (UTC midnight).
    DateTime? date,
    double? weightKg,
  }) = _BodyWeightDraft;

  const BodyWeightDraft._();

  factory BodyWeightDraft.fromEntry(BodyWeightEntry entry) =>
      BodyWeightDraft(date: entry.date, weightKg: entry.weightKg);

  Set<BodyWeightValidationError> validate({required DateTime today}) {
    final errors = <BodyWeightValidationError>{};

    final day = date;
    if (day == null) {
      errors.add(BodyWeightValidationError.dateRequired);
    } else if (calendarDate(day).isAfter(calendarDate(today))) {
      errors.add(BodyWeightValidationError.dateInFuture);
    }

    final weight = weightKg;
    if (weight == null) {
      errors.add(BodyWeightValidationError.weightRequired);
    } else if (weight < kMinBodyWeightKg || weight > kMaxBodyWeightKg) {
      errors.add(BodyWeightValidationError.weightOutOfRange);
    }
    return errors;
  }
}
