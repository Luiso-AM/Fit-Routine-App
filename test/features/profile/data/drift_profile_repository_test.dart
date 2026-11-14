import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/profile/data/drift_body_metrics_repository.dart';
import 'package:app_entrenamiento/features/profile/data/drift_profile_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/body_metrics_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_draft.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/experience_level.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/sex.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/training_goal.dart';
import 'package:app_entrenamiento/features/profile/domain/profile_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/user_profile_draft.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime _clock() => DateTime(2026, 11, 14, 10);

final _draft = UserProfileDraft(
  alias: '  Luis  ',
  birthDate: DateTime.utc(1995, 3, 20),
  sex: Sex.male,
  heightCm: 175.5,
  experienceLevel: ExperienceLevel.intermediate,
  goal: TrainingGoal.hypertrophy,
  daysPerWeek: 4,
  sessionDurationMin: 60,
  equipment: const [Equipment.dumbbell, Equipment.barbell, Equipment.barbell],
);

final _weight = BodyWeightDraft(
  date: DateTime.utc(2026, 11, 14),
  weightKg: 78.4,
);

void main() {
  late AppDatabase db;
  late DriftProfileRepository repository;
  late DriftBodyMetricsRepository bodyMetrics;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftProfileRepository(db, clock: _clock);
    bodyMetrics = DriftBodyMetricsRepository(db, clock: _clock);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'given a new database, when reading the profile, then it is null',
    () async {
      expect(await repository.get(), isNull);
      expect(await repository.watch().first, isNull);
    },
  );

  group('create', () {
    test('given valid data, when created, then the profile is stored '
        'with trimmed alias and ordered unique equipment', () async {
      final created = await repository.create(_draft, _weight);

      final stored = await repository.get();
      expect(stored, created);
      expect(stored!.alias, 'Luis');
      expect(stored.birthDate, DateTime.utc(1995, 3, 20));
      expect(stored.sex, Sex.male);
      expect(stored.heightCm, 175.5);
      expect(stored.equipment, [Equipment.barbell, Equipment.dumbbell]);
    });

    test('given valid data, when created, '
        'then the initial body weight is logged', () async {
      await repository.create(_draft, _weight);

      final weights = await bodyMetrics.watchWeights().first;
      expect(weights, hasLength(1));
      expect(weights.single.weightKg, 78.4);
      expect(weights.single.date, DateTime.utc(2026, 11, 14));
    });

    test('given an existing profile, when created again, '
        'then it fails and nothing else is written', () async {
      await repository.create(_draft, _weight);

      await expectLater(
        repository.create(
          _draft,
          _weight.copyWith(date: DateTime.utc(2026, 11, 1)),
        ),
        throwsA(isA<ProfileAlreadyExistsException>()),
      );
      expect(await db.select(db.userProfile).get(), hasLength(1));
      expect(await bodyMetrics.watchWeights().first, hasLength(1));
    });

    test('given an invalid profile, when created, '
        'then it fails and the weight is not logged', () async {
      await expectLater(
        repository.create(_draft.copyWith(alias: ''), _weight),
        throwsA(
          isA<ProfileValidationException>().having((e) => e.errors, 'errors', {
            ProfileValidationError.aliasRequired,
          }),
        ),
      );
      expect(await repository.get(), isNull);
      expect(await bodyMetrics.watchWeights().first, isEmpty);
    });

    test('given an invalid weight, when created, '
        'then it fails and no profile is stored', () async {
      await expectLater(
        repository.create(_draft, const BodyWeightDraft()),
        throwsA(isA<BodyWeightValidationException>()),
      );
      expect(await repository.get(), isNull);
    });

    test('given a watcher, when the profile is created, '
        'then the stream emits it', () async {
      expect(repository.watch(), emitsThrough(isNotNull));
      await repository.create(_draft, _weight);
    });
  });

  group('update', () {
    test('given a profile, when updated, '
        'then fields and updatedAt change but the row is the same', () async {
      final created = await repository.create(_draft, _weight);
      final before = (await db.select(db.userProfile).getSingle()).updatedAt;
      await Future<void>.delayed(const Duration(milliseconds: 5));

      await repository.update(
        _draft.copyWith(alias: 'Lucho', birthDate: null, sex: null),
      );

      final rows = await db.select(db.userProfile).get();
      expect(rows, hasLength(1));
      expect(rows.single.id, created.id);
      expect(rows.single.alias, 'Lucho');
      expect(rows.single.birthDate, isNull);
      expect(rows.single.sex, isNull);
      expect(rows.single.updatedAt.isAfter(before), isTrue);
    });

    test('given no profile, when updated, then it is not found', () async {
      expect(
        repository.update(_draft),
        throwsA(isA<ProfileNotFoundException>()),
      );
    });

    test('given an invalid draft, when updated, then it is rejected', () async {
      await repository.create(_draft, _weight);
      expect(
        repository.update(_draft.copyWith(daysPerWeek: 8)),
        throwsA(isA<ProfileValidationException>()),
      );
    });
  });
}
