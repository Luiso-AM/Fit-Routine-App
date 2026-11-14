import 'package:material_ui/material_ui.dart';

import '../../../../core/strings/enum_labels.dart';
import '../../../../core/utils/calendar_date.dart';
import '../../../../core/utils/decimal_input.dart';
import '../../../../core/widgets/date_field.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../exercises/domain/enums/equipment.dart';
import '../../domain/body_weight_draft.dart';
import '../../domain/enums/experience_level.dart';
import '../../domain/enums/sex.dart';
import '../../domain/enums/training_goal.dart';
import '../../domain/user_profile_draft.dart';
import '../profile_strings.dart';

// Form sections shared by onboarding and the profile edit screen. Each one
// edits part of a [UserProfileDraft] and shows the errors it is given.

const SizedBox _gap = SizedBox(height: 16);

/// Errors each section can show, used to validate onboarding step by step.
abstract final class ProfileSectionErrors {
  static const Set<ProfileValidationError> personal = {
    ProfileValidationError.aliasRequired,
    ProfileValidationError.aliasTooLong,
    ProfileValidationError.birthDateOutOfRange,
    ProfileValidationError.heightRequired,
    ProfileValidationError.heightOutOfRange,
  };

  static const Set<ProfileValidationError> training = {
    ProfileValidationError.experienceLevelRequired,
    ProfileValidationError.goalRequired,
    ProfileValidationError.daysPerWeekRequired,
    ProfileValidationError.daysPerWeekOutOfRange,
    ProfileValidationError.sessionDurationRequired,
    ProfileValidationError.sessionDurationOutOfRange,
  };

  static const Set<ProfileValidationError> equipment = {
    ProfileValidationError.equipmentRequired,
  };
}

/// The message of the first of [candidates] present in [errors], or `null`.
String? firstErrorMessage<E>(
  Set<E> errors,
  List<E> candidates,
  String Function(E) message,
) {
  for (final error in candidates) {
    if (errors.contains(error)) return message(error);
  }
  return null;
}

String profileErrorMessage(ProfileValidationError error) => switch (error) {
  ProfileValidationError.aliasRequired => ProfileStrings.aliasRequired,
  ProfileValidationError.aliasTooLong => ProfileStrings.aliasTooLong,
  ProfileValidationError.birthDateOutOfRange =>
    ProfileStrings.birthDateOutOfRange,
  ProfileValidationError.heightRequired => ProfileStrings.heightRequired,
  ProfileValidationError.heightOutOfRange => ProfileStrings.heightOutOfRange,
  ProfileValidationError.experienceLevelRequired =>
    ProfileStrings.experienceLevelRequired,
  ProfileValidationError.goalRequired => ProfileStrings.goalRequired,
  ProfileValidationError.daysPerWeekRequired =>
    ProfileStrings.daysPerWeekRequired,
  ProfileValidationError.daysPerWeekOutOfRange =>
    ProfileStrings.daysPerWeekOutOfRange,
  ProfileValidationError.sessionDurationRequired =>
    ProfileStrings.sessionDurationRequired,
  ProfileValidationError.sessionDurationOutOfRange =>
    ProfileStrings.sessionDurationOutOfRange,
  ProfileValidationError.equipmentRequired => ProfileStrings.equipmentRequired,
};

String bodyWeightErrorMessage(BodyWeightValidationError error) =>
    switch (error) {
      BodyWeightValidationError.dateRequired => ProfileStrings.dateRequired,
      BodyWeightValidationError.dateInFuture => ProfileStrings.dateInFuture,
      BodyWeightValidationError.weightRequired => ProfileStrings.weightRequired,
      BodyWeightValidationError.weightOutOfRange =>
        ProfileStrings.weightOutOfRange,
    };

/// Text field for a decimal number with a unit suffix.
class DecimalField extends StatelessWidget {
  const DecimalField({
    required this.controller,
    required this.label,
    required this.suffix,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String suffix;
  final ValueChanged<double?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (text) => onChanged(parseDecimalInput(text)),
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        errorText: errorText,
      ),
    );
  }
}

/// Alias, birth date, sex and height.
class PersonalInfoFields extends StatefulWidget {
  const PersonalInfoFields({
    required this.draft,
    required this.errors,
    required this.onChanged,
    required this.today,
    super.key,
  });

  final UserProfileDraft draft;
  final Set<ProfileValidationError> errors;
  final ValueChanged<UserProfileDraft> onChanged;

  /// Local "now", which bounds the birth date and computes the age.
  final DateTime today;

  @override
  State<PersonalInfoFields> createState() => _PersonalInfoFieldsState();
}

class _PersonalInfoFieldsState extends State<PersonalInfoFields> {
  late final _alias = TextEditingController(text: widget.draft.alias);
  late final _height = TextEditingController(
    text: switch (widget.draft.heightCm) {
      final cm? => formatDecimalInput(cm),
      null => '',
    },
  );

  @override
  void dispose() {
    _alias.dispose();
    _height.dispose();
    super.dispose();
  }

  String? _error(List<ProfileValidationError> candidates) =>
      firstErrorMessage(widget.errors, candidates, profileErrorMessage);

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final today = calendarDate(widget.today);
    final birth = draft.birthDate;
    final age = birth == null ? null : yearsBetween(birth, today);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _alias,
          maxLength: kAliasMaxLength,
          textCapitalization: TextCapitalization.words,
          onChanged: (value) => widget.onChanged(draft.copyWith(alias: value)),
          decoration: InputDecoration(
            labelText: ProfileStrings.alias,
            errorText: _error([
              ProfileValidationError.aliasRequired,
              ProfileValidationError.aliasTooLong,
            ]),
          ),
        ),
        _gap,
        DateField(
          label: ProfileStrings.birthDateOptional,
          value: birth,
          firstDate: DateTime.utc(today.year - kMaxAge - 1, today.month),
          lastDate: today,
          initialPickerDate: DateTime.utc(today.year - 25, 1, 1),
          yearFirst: true,
          clearTooltip: ProfileStrings.clearDate,
          helperText: age == null ? null : ProfileStrings.years(age),
          errorText: _error([ProfileValidationError.birthDateOutOfRange]),
          onChanged: (date) =>
              widget.onChanged(draft.copyWith(birthDate: date)),
        ),
        _gap,
        LabeledField(
          label: ProfileStrings.sexOptional,
          children: [
            for (final sex in [...Sex.values, null])
              ChoiceChip(
                label: Text(sex?.label ?? ProfileStrings.sexUnspecified),
                selected: draft.sex == sex,
                onSelected: (_) => widget.onChanged(draft.copyWith(sex: sex)),
              ),
          ],
        ),
        _gap,
        DecimalField(
          controller: _height,
          label: ProfileStrings.height,
          suffix: ProfileStrings.cm,
          errorText: _error([
            ProfileValidationError.heightRequired,
            ProfileValidationError.heightOutOfRange,
          ]),
          onChanged: (cm) => widget.onChanged(draft.copyWith(heightCm: cm)),
        ),
      ],
    );
  }
}

/// Experience level, goal, days per week and session duration.
class TrainingFields extends StatefulWidget {
  const TrainingFields({
    required this.draft,
    required this.errors,
    required this.onChanged,
    super.key,
  });

  final UserProfileDraft draft;
  final Set<ProfileValidationError> errors;
  final ValueChanged<UserProfileDraft> onChanged;

  @override
  State<TrainingFields> createState() => _TrainingFieldsState();
}

class _TrainingFieldsState extends State<TrainingFields> {
  late final _duration = TextEditingController(
    text: widget.draft.sessionDurationMin?.toString() ?? '',
  );

  @override
  void dispose() {
    _duration.dispose();
    super.dispose();
  }

  String? _error(List<ProfileValidationError> candidates) =>
      firstErrorMessage(widget.errors, candidates, profileErrorMessage);

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LabeledField(
          label: ProfileStrings.experienceLevel,
          errorText: _error([ProfileValidationError.experienceLevelRequired]),
          children: [
            for (final level in ExperienceLevel.values)
              ChoiceChip(
                label: Text(level.label),
                selected: draft.experienceLevel == level,
                onSelected: (_) =>
                    widget.onChanged(draft.copyWith(experienceLevel: level)),
              ),
          ],
        ),
        _gap,
        LabeledField(
          label: ProfileStrings.goal,
          errorText: _error([ProfileValidationError.goalRequired]),
          children: [
            for (final goal in TrainingGoal.values)
              ChoiceChip(
                label: Text(goal.label),
                selected: draft.goal == goal,
                onSelected: (_) => widget.onChanged(draft.copyWith(goal: goal)),
              ),
          ],
        ),
        _gap,
        LabeledField(
          label: ProfileStrings.daysPerWeek,
          errorText: _error([
            ProfileValidationError.daysPerWeekRequired,
            ProfileValidationError.daysPerWeekOutOfRange,
          ]),
          children: [
            for (var days = kMinDaysPerWeek; days <= kMaxDaysPerWeek; days++)
              ChoiceChip(
                label: Text('$days'),
                selected: draft.daysPerWeek == days,
                onSelected: (_) =>
                    widget.onChanged(draft.copyWith(daysPerWeek: days)),
              ),
          ],
        ),
        _gap,
        TextField(
          controller: _duration,
          keyboardType: TextInputType.number,
          onChanged: (text) => widget.onChanged(
            draft.copyWith(sessionDurationMin: parseIntInput(text)),
          ),
          decoration: InputDecoration(
            labelText: ProfileStrings.sessionDuration,
            suffixText: ProfileStrings.minutes,
            errorText: _error([
              ProfileValidationError.sessionDurationRequired,
              ProfileValidationError.sessionDurationOutOfRange,
            ]),
          ),
        ),
      ],
    );
  }
}

/// Available equipment, as filter chips.
class EquipmentFields extends StatelessWidget {
  const EquipmentFields({
    required this.draft,
    required this.errors,
    required this.onChanged,
    super.key,
  });

  final UserProfileDraft draft;
  final Set<ProfileValidationError> errors;
  final ValueChanged<UserProfileDraft> onChanged;

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: ProfileStrings.equipment,
      errorText: firstErrorMessage(errors, const [
        ProfileValidationError.equipmentRequired,
      ], profileErrorMessage),
      children: [
        for (final item in Equipment.values)
          FilterChip(
            label: Text(item.label),
            selected: draft.equipment.contains(item),
            onSelected: (selected) => onChanged(
              draft.copyWith(
                equipment: selected
                    ? [...draft.equipment, item]
                    : [
                        for (final e in draft.equipment)
                          if (e != item) e,
                      ],
              ),
            ),
          ),
      ],
    );
  }
}
