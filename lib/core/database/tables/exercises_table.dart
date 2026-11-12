import 'package:drift/drift.dart';

import '../../../features/exercises/domain/enums/difficulty.dart';
import '../../../features/exercises/domain/enums/equipment.dart';
import '../../../features/exercises/domain/enums/exercise_type.dart';
import '../../../features/exercises/domain/enums/muscle_group.dart';
import '../../units/weight_unit.dart';
import '../converters/enum_list_converter.dart';
import 'table_mixins.dart';

@DataClassName('ExerciseRow')
@TableIndex(name: 'idx_exercises_primary_muscle', columns: {#primaryMuscle})
class Exercises extends Table with EntityColumns, SoftDeleteColumn {
  TextColumn get name => text()();

  TextColumn get primaryMuscle => textEnum<MuscleGroup>()();

  TextColumn get secondaryMuscles => text()
      .map(const EnumListConverter(MuscleGroup.values))
      .withDefault(const Constant('[]'))();

  TextColumn get type => textEnum<ExerciseType>()();

  TextColumn get equipment => textEnum<Equipment>()();

  TextColumn get difficulty => textEnum<Difficulty>()();

  TextColumn get instructions => text().withDefault(const Constant(''))();

  TextColumn get commonMistakes => text().withDefault(const Constant(''))();

  /// `null` means the default placeholder image.
  TextColumn get imagePath => text().nullable()();

  TextColumn get preferredUnit =>
      textEnum<WeightUnit>().withDefault(Constant(WeightUnit.kg.name))();

  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();

  /// Reference data shipped with the app.
  BoolColumn get isSeed => boolean().withDefault(const Constant(false))();
}
