import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise_query.dart';
import 'package:flutter_test/flutter_test.dart';

Exercise _exercise(
  String name,
  MuscleGroup muscle, {
  Equipment equipment = Equipment.barbell,
  ExerciseType type = ExerciseType.compound,
  List<MuscleGroup> secondary = const [],
}) => Exercise(
  id: name,
  name: name,
  primaryMuscle: muscle,
  secondaryMuscles: secondary,
  type: type,
  equipment: equipment,
  difficulty: Difficulty.beginner,
);

final _bench = _exercise(
  'Press de Banca (Barra)',
  MuscleGroup.chest,
  secondary: [MuscleGroup.triceps],
);
final _fly = _exercise(
  'Aperturas (Polea)',
  MuscleGroup.chest,
  equipment: Equipment.cable,
  type: ExerciseType.isolation,
);
final _curl = _exercise(
  'Curl de Bíceps (Mancuerna)',
  MuscleGroup.biceps,
  equipment: Equipment.dumbbell,
  type: ExerciseType.isolation,
);
final _squat = _exercise('Sentadilla (Barra Alta)', MuscleGroup.quadriceps);
final _all = [_bench, _fly, _curl, _squat];

List<String> names(Iterable<Exercise> exercises) => [
  for (final e in exercises) e.name,
];

void main() {
  group('ExerciseQuery', () {
    test('given an empty query, when applied, then everything matches', () {
      const query = ExerciseQuery();
      expect(query.isEmpty, isTrue);
      expect(query.apply(_all), _all);
    });

    test('given text without accents or case, when applied, '
        'then names with accents match', () {
      expect(names(const ExerciseQuery(text: 'BICEPS').apply(_all)), [
        _curl.name,
      ]);
    });

    test(
      'given text in the middle of a name, when applied, then it matches',
      () {
        expect(names(const ExerciseQuery(text: 'banca').apply(_all)), [
          _bench.name,
        ]);
      },
    );

    test('given a muscle filter, when applied, '
        'then only the primary muscle is considered', () {
      const query = ExerciseQuery(muscles: {MuscleGroup.triceps});
      expect(query.apply(_all), isEmpty);
    });

    test('given two values of the same filter, when applied, '
        'then either one matches', () {
      const query = ExerciseQuery(
        muscles: {MuscleGroup.biceps, MuscleGroup.quadriceps},
      );
      expect(names(query.apply(_all)), [_curl.name, _squat.name]);
    });

    test(
      'given filters of different kinds, when applied, then all must match',
      () {
        const query = ExerciseQuery(
          muscles: {MuscleGroup.chest},
          equipment: {Equipment.barbell},
          types: {ExerciseType.compound},
        );
        expect(query.activeFilterCount, 3);
        expect(names(query.apply(_all)), [_bench.name]);
      },
    );

    test('given text and a filter, when applied, then both must match', () {
      const query = ExerciseQuery(
        text: 'press',
        types: {ExerciseType.isolation},
      );
      expect(query.apply(_all), isEmpty);
    });
  });

  group('groupByPrimaryMuscle', () {
    test('given exercises of several muscles, when grouped, '
        'then groups follow the muscle order and omit empty ones', () {
      final groups = groupByPrimaryMuscle([_squat, _curl, _bench]);
      expect(groups.keys, [
        MuscleGroup.chest,
        MuscleGroup.biceps,
        MuscleGroup.quadriceps,
      ]);
    });

    test('given a group, when grouped, then exercises are sorted by name', () {
      final groups = groupByPrimaryMuscle([_bench, _fly]);
      expect(names(groups[MuscleGroup.chest]!), [_fly.name, _bench.name]);
    });

    test('given no exercises, when grouped, then there are no groups', () {
      expect(groupByPrimaryMuscle([]), isEmpty);
    });
  });
}
