import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/workout_data_providers.dart';
import '../../domain/workout_repository.dart';
import '../../domain/workout_session.dart';
import '../widgets/session_exercise_card.dart';
import '../widgets/workout_widgets.dart';
import '../workout_providers.dart';
import '../workout_strings.dart';

/// Edits a past session: its sets and notes. Every change is saved as it
/// is made.
class SessionEditScreen extends ConsumerWidget {
  const SessionEditScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(workoutExerciseCatalogProvider).value ?? {};

    return Scaffold(
      appBar: AppBar(title: const Text(WorkoutStrings.editTitle)),
      body: switch (ref.watch(workoutSessionProvider(sessionId))) {
        AsyncData(value: final session?) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            _NotesField(session: session),
            const SizedBox(height: 12),
            if (session.exercises.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: WorkoutMessage(WorkoutStrings.noExercisesLeft),
              ),
            for (final entry in session.exercises)
              Padding(
                key: ValueKey(entry.id),
                padding: const EdgeInsets.only(bottom: 12),
                child: SessionExerciseCard(
                  entry: entry,
                  exercise: catalog[entry.exerciseId],
                  showLastTime: false,
                ),
              ),
          ],
        ),
        AsyncData() => const WorkoutMessage(WorkoutStrings.summaryNotFound),
        AsyncError() => const WorkoutMessage(WorkoutStrings.loadError),
        _ => const Center(child: CircularProgressIndicator()),
      },
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            onPressed: () => context.pop(),
            child: const Text(WorkoutStrings.done),
          ),
        ),
      ),
    );
  }
}

/// The session's notes, saved shortly after typing stops and when the
/// screen closes.
class _NotesField extends ConsumerStatefulWidget {
  const _NotesField({required this.session});

  final WorkoutSession session;

  @override
  ConsumerState<_NotesField> createState() => _NotesFieldState();
}

class _NotesFieldState extends ConsumerState<_NotesField> {
  static const Duration _saveDelay = Duration(milliseconds: 500);

  late final TextEditingController _controller = TextEditingController(
    text: widget.session.notes,
  );
  late final WorkoutRepository _repository = ref.read(
    workoutRepositoryProvider,
  );
  Timer? _pending;
  late String _saved = widget.session.notes;

  void _scheduleSave(String _) {
    _pending?.cancel();
    _pending = Timer(_saveDelay, _save);
  }

  void _save() {
    _pending?.cancel();
    final notes = _controller.text.trim();
    if (notes == _saved) return;
    _saved = notes;
    unawaited(
      _repository.updateNotes(widget.session.id, notes).catchError((Object _) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(WorkoutStrings.saveError)));
      }),
    );
  }

  @override
  void dispose() {
    _save();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('session-notes-field'),
      controller: _controller,
      onChanged: _scheduleSave,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      minLines: 2,
      maxLines: 5,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: WorkoutStrings.sessionNotes,
        hintText: WorkoutStrings.notesHint,
        alignLabelWithHint: true,
      ),
    );
  }
}
