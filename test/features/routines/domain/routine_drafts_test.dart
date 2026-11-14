import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_drafts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RoutineDraft', () {
    test('given a name, when validated, then it has no errors', () {
      expect(const RoutineDraft(name: 'Mi rutina').validate(), isEmpty);
    });

    test('given a blank or too long name, when validated, '
        'then it is reported', () {
      expect(const RoutineDraft(name: '  ').validate(), {
        RoutineValidationError.nameRequired,
      });
      expect(RoutineDraft(name: 'a' * (kRoutineNameMaxLength + 1)).validate(), {
        RoutineValidationError.nameTooLong,
      });
    });

    test('given notes too long, when validated, then they are reported', () {
      final draft = RoutineDraft(
        name: 'Rutina',
        notes: 'a' * (kRoutineNotesMaxLength + 1),
      );
      expect(draft.validate(), {RoutineValidationError.notesTooLong});
    });
  });

  group('RoutineDayDraft', () {
    test('given a name without weekday, when validated, then it is valid', () {
      expect(const RoutineDayDraft(name: 'Push').validate(), isEmpty);
    });

    test('given a weekday outside 1 to 7, when validated, '
        'then it is out of range', () {
      for (final weekday in [0, 8]) {
        expect(RoutineDayDraft(name: 'Push', weekday: weekday).validate(), {
          RoutineDayValidationError.weekdayOutOfRange,
        });
      }
    });

    test('given an empty name, when validated, then it is required', () {
      expect(const RoutineDayDraft().validate(), {
        RoutineDayValidationError.nameRequired,
      });
    });
  });

  group('RoutineExerciseDraft', () {
    test('given a compound exercise, when using defaults, '
        'then it is 3 x 10-12 with 120 s rest', () {
      final draft = RoutineExerciseDraft.defaultsFor(ExerciseType.compound);
      expect(draft.targetSets, 3);
      expect(draft.targetRepsMin, 10);
      expect(draft.targetRepsMax, 12);
      expect(draft.restSeconds, 120);
      expect(draft.initialWeightKg, isNull);
      expect(draft.validate(), isEmpty);
    });

    test('given an isolation exercise, when using defaults, '
        'then it is 3 x 10-12 with 90 s rest', () {
      final draft = RoutineExerciseDraft.defaultsFor(ExerciseType.isolation);
      expect(
        (draft.targetSets, draft.targetRepsMin, draft.targetRepsMax),
        (3, 10, 12),
      );
      expect(draft.restSeconds, 90);
    });

    test('given an empty draft, when validated, '
        'then every required target is reported', () {
      expect(const RoutineExerciseDraft().validate(), {
        RoutineExerciseValidationError.setsRequired,
        RoutineExerciseValidationError.repsMinRequired,
        RoutineExerciseValidationError.repsMaxRequired,
        RoutineExerciseValidationError.restRequired,
      });
    });

    final valid = RoutineExerciseDraft.defaultsFor(ExerciseType.compound);

    test('given min reps above max, when validated, '
        'then the range is inverted', () {
      expect(valid.copyWith(targetRepsMin: 12, targetRepsMax: 8).validate(), {
        RoutineExerciseValidationError.repsRangeInverted,
      });
    });

    test('given equal min and max reps, when validated, then it is valid', () {
      expect(
        valid.copyWith(targetRepsMin: 5, targetRepsMax: 5).validate(),
        isEmpty,
      );
    });

    test('given values outside their limits, when validated, '
        'then each one is reported', () {
      final draft = valid.copyWith(
        targetSets: kMaxTargetSets + 1,
        targetRepsMax: 0,
        initialWeightKg: -1,
        restSeconds: kMaxRestSeconds + 1,
      );
      expect(draft.validate(), {
        RoutineExerciseValidationError.setsOutOfRange,
        RoutineExerciseValidationError.repsOutOfRange,
        RoutineExerciseValidationError.weightOutOfRange,
        RoutineExerciseValidationError.restOutOfRange,
      });
    });

    test('given a zero weight and zero rest, when validated, '
        'then they are accepted', () {
      expect(
        valid.copyWith(initialWeightKg: 0, restSeconds: 0).validate(),
        isEmpty,
      );
    });
  });
}
