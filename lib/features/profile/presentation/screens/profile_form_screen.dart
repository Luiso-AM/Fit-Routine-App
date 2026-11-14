import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/profile_data_providers.dart';
import '../../domain/profile_repository.dart';
import '../../domain/user_profile.dart';
import '../../domain/user_profile_draft.dart';
import '../profile_providers.dart';
import '../profile_strings.dart';
import '../widgets/profile_form_fields.dart';

/// Edits the existing profile.
class ProfileFormScreen extends ConsumerWidget {
  const ProfileFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(currentProfileProvider)) {
      AsyncData(value: final profile?) => _ProfileForm(initial: profile),
      AsyncError() || AsyncData() => Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text(ProfileStrings.loadError)),
      ),
      _ => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
    };
  }
}

class _ProfileForm extends ConsumerStatefulWidget {
  const _ProfileForm({required this.initial});

  final UserProfile initial;

  @override
  ConsumerState<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<_ProfileForm> {
  late UserProfileDraft _draft = UserProfileDraft.fromProfile(widget.initial);
  bool _submitted = false;
  bool _saving = false;

  Set<ProfileValidationError> get _errors => _submitted
      ? _draft.validate(today: DateTime.now())
      : const <ProfileValidationError>{};

  void _update(UserProfileDraft draft) => setState(() => _draft = draft);

  Future<void> _save() async {
    setState(() => _submitted = true);
    if (_errors.isNotEmpty) return;

    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(profileRepositoryProvider).update(_draft);
      if (mounted) context.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text(ProfileStrings.profileSaved)),
      );
    } on ProfileValidationException {
      // Shown by the fields: the draft is validated again on rebuild.
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text(ProfileStrings.saveError)),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final errors = _errors;
    const divider = Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(height: 1),
    );

    return Scaffold(
      appBar: AppBar(title: const Text(ProfileStrings.editProfile)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          PersonalInfoFields(
            draft: _draft,
            errors: errors,
            today: DateTime.now(),
            onChanged: _update,
          ),
          divider,
          TrainingFields(draft: _draft, errors: errors, onChanged: _update),
          divider,
          EquipmentFields(draft: _draft, errors: errors, onChanged: _update),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            onPressed: _saving ? null : _save,
            child: const Text(ProfileStrings.save),
          ),
        ),
      ),
    );
  }
}
