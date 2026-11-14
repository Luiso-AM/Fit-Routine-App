import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/calendar_date.dart';
import '../../data/profile_data_providers.dart';
import '../../domain/body_weight_draft.dart';
import '../../domain/user_profile_draft.dart';
import '../profile_strings.dart';
import '../widgets/profile_form_fields.dart';

enum _Step { aboutYou, training, equipment }

/// First-run profile creation in three steps. Once the profile is saved the
/// router leaves this screen on its own.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  _Step _step = _Step.aboutYou;
  UserProfileDraft _draft = const UserProfileDraft();
  double? _weightKg;
  final _weight = TextEditingController();

  /// Steps whose "next" was tapped; only they show their errors.
  final Set<_Step> _attempted = {};
  bool _saving = false;

  bool get _isLast => _step == _Step.values.last;

  @override
  void dispose() {
    _weight.dispose();
    super.dispose();
  }

  BodyWeightDraft get _weightDraft =>
      BodyWeightDraft(date: calendarDate(DateTime.now()), weightKg: _weightKg);

  Set<ProfileValidationError> _profileErrors(_Step step) {
    final section = switch (step) {
      _Step.aboutYou => ProfileSectionErrors.personal,
      _Step.training => ProfileSectionErrors.training,
      _Step.equipment => ProfileSectionErrors.equipment,
    };
    return _draft.validate(today: DateTime.now()).intersection(section);
  }

  Set<BodyWeightValidationError> _weightErrors(_Step step) =>
      step == _Step.aboutYou
      ? _weightDraft.validate(today: DateTime.now())
      : const {};

  bool _isValid(_Step step) =>
      _profileErrors(step).isEmpty && _weightErrors(step).isEmpty;

  void _goTo(_Step step) => setState(() => _step = step);

  Future<void> _next() async {
    setState(() => _attempted.add(_step));
    if (!_isValid(_step)) return;
    if (!_isLast) return _goTo(_Step.values[_step.index + 1]);

    // Every step was valid when left, but check again before saving.
    for (final step in _Step.values) {
      if (!_isValid(step)) {
        _attempted.add(step);
        return _goTo(step);
      }
    }

    setState(() => _saving = true);
    try {
      await ref.read(profileRepositoryProvider).create(_draft, _weightDraft);
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(ProfileStrings.saveError)));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _content() {
    final showErrors = _attempted.contains(_step);
    final errors = showErrors
        ? _profileErrors(_step)
        : <ProfileValidationError>{};
    void update(UserProfileDraft draft) => setState(() => _draft = draft);

    return switch (_step) {
      _Step.aboutYou => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PersonalInfoFields(
            draft: _draft,
            errors: errors,
            today: DateTime.now(),
            onChanged: update,
          ),
          const SizedBox(height: 16),
          DecimalField(
            controller: _weight,
            label: ProfileStrings.bodyWeight,
            suffix: ProfileStrings.kg,
            errorText: showErrors
                ? firstErrorMessage(_weightErrors(_step), const [
                    BodyWeightValidationError.weightRequired,
                    BodyWeightValidationError.weightOutOfRange,
                  ], bodyWeightErrorMessage)
                : null,
            onChanged: (kg) => setState(() => _weightKg = kg),
          ),
        ],
      ),
      _Step.training => TrainingFields(
        draft: _draft,
        errors: errors,
        onChanged: update,
      ),
      _Step.equipment => EquipmentFields(
        draft: _draft,
        errors: errors,
        onChanged: update,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (title, hint) = switch (_step) {
      _Step.aboutYou => (
        ProfileStrings.stepAboutYou,
        ProfileStrings.stepAboutYouHint,
      ),
      _Step.training => (
        ProfileStrings.stepTraining,
        ProfileStrings.stepTrainingHint,
      ),
      _Step.equipment => (
        ProfileStrings.stepEquipment,
        ProfileStrings.stepEquipmentHint,
      ),
    };
    final total = _Step.values.length;

    return PopScope(
      canPop: _step == _Step.aboutYou,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goTo(_Step.values[_step.index - 1]);
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            children: [
              Text(
                ProfileStrings.welcome,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: (_step.index + 1) / total,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 8),
              Text(
                ProfileStrings.stepCounter(_step.index + 1, total),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Text(title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                hint,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                // The default layout centers children narrower than the
                // screen, such as the equipment chips; keep them left-aligned.
                layoutBuilder: (current, previous) => Stack(
                  alignment: Alignment.topLeft,
                  children: [...previous, ?current],
                ),
                child: KeyedSubtree(key: ValueKey(_step), child: _content()),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                if (_step != _Step.aboutYou) ...[
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 52),
                      ),
                      onPressed: _saving
                          ? null
                          : () => _goTo(_Step.values[_step.index - 1]),
                      child: const Text(ProfileStrings.back),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 52),
                    ),
                    onPressed: _saving ? null : _next,
                    child: Text(
                      _isLast ? ProfileStrings.finish : ProfileStrings.next,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
