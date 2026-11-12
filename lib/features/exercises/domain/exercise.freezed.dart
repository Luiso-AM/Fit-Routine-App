// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Exercise {

 String get id; String get name; MuscleGroup get primaryMuscle; List<MuscleGroup> get secondaryMuscles; ExerciseType get type; Equipment get equipment; Difficulty get difficulty; String get instructions; String get commonMistakes;/// `null` means the default placeholder image.
 String? get imagePath; WeightUnit get preferredUnit; bool get isCustom;/// Reference data shipped with the app.
 bool get isSeed;
/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseCopyWith<Exercise> get copyWith => _$ExerciseCopyWithImpl<Exercise>(this as Exercise, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Exercise;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exercise&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.primaryMuscle, _this.primaryMuscle) || other.primaryMuscle == _this.primaryMuscle)&&const DeepCollectionEquality().equals(other.secondaryMuscles, _this.secondaryMuscles)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.equipment, _this.equipment) || other.equipment == _this.equipment)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.instructions, _this.instructions) || other.instructions == _this.instructions)&&(identical(other.commonMistakes, _this.commonMistakes) || other.commonMistakes == _this.commonMistakes)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&(identical(other.preferredUnit, _this.preferredUnit) || other.preferredUnit == _this.preferredUnit)&&(identical(other.isCustom, _this.isCustom) || other.isCustom == _this.isCustom)&&(identical(other.isSeed, _this.isSeed) || other.isSeed == _this.isSeed));
}


@override
int get hashCode {
  final _this = this as Exercise;
  return Object.hash(runtimeType,_this.id,_this.name,_this.primaryMuscle,const DeepCollectionEquality().hash(_this.secondaryMuscles),_this.type,_this.equipment,_this.difficulty,_this.instructions,_this.commonMistakes,_this.imagePath,_this.preferredUnit,_this.isCustom,_this.isSeed);
}

@override
String toString() {
  final _this = this as Exercise;
  return 'Exercise(id: ${_this.id}, name: ${_this.name}, primaryMuscle: ${_this.primaryMuscle}, secondaryMuscles: ${_this.secondaryMuscles}, type: ${_this.type}, equipment: ${_this.equipment}, difficulty: ${_this.difficulty}, instructions: ${_this.instructions}, commonMistakes: ${_this.commonMistakes}, imagePath: ${_this.imagePath}, preferredUnit: ${_this.preferredUnit}, isCustom: ${_this.isCustom}, isSeed: ${_this.isSeed})';
}


}

/// @nodoc
abstract mixin class $ExerciseCopyWith<$Res>  {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) _then) = _$ExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String name, MuscleGroup primaryMuscle, List<MuscleGroup> secondaryMuscles, ExerciseType type, Equipment equipment, Difficulty difficulty, String instructions, String commonMistakes, String? imagePath, WeightUnit preferredUnit, bool isCustom, bool isSeed
});




}
/// @nodoc
class _$ExerciseCopyWithImpl<$Res>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._self, this._then);

  final Exercise _self;
  final $Res Function(Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? primaryMuscle = null,Object? secondaryMuscles = null,Object? type = null,Object? equipment = null,Object? difficulty = null,Object? instructions = null,Object? commonMistakes = null,Object? imagePath = freezed,Object? preferredUnit = null,Object? isCustom = null,Object? isSeed = null,}) {
  return _then(Exercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscle: null == primaryMuscle ? _self.primaryMuscle : primaryMuscle // ignore: cast_nullable_to_non_nullable
as MuscleGroup,secondaryMuscles: null == secondaryMuscles ? _self.secondaryMuscles : secondaryMuscles // ignore: cast_nullable_to_non_nullable
as List<MuscleGroup>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as Equipment,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String,commonMistakes: null == commonMistakes ? _self.commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,preferredUnit: null == preferredUnit ? _self.preferredUnit : preferredUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,isSeed: null == isSeed ? _self.isSeed : isSeed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Exercise].
extension ExercisePatterns on Exercise {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Exercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Exercise value)  $default,){
final _that = this;
switch (_that) {
case _Exercise():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Exercise value)?  $default,){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  MuscleGroup primaryMuscle,  List<MuscleGroup> secondaryMuscles,  ExerciseType type,  Equipment equipment,  Difficulty difficulty,  String instructions,  String commonMistakes,  String? imagePath,  WeightUnit preferredUnit,  bool isCustom,  bool isSeed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.name,_that.primaryMuscle,_that.secondaryMuscles,_that.type,_that.equipment,_that.difficulty,_that.instructions,_that.commonMistakes,_that.imagePath,_that.preferredUnit,_that.isCustom,_that.isSeed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  MuscleGroup primaryMuscle,  List<MuscleGroup> secondaryMuscles,  ExerciseType type,  Equipment equipment,  Difficulty difficulty,  String instructions,  String commonMistakes,  String? imagePath,  WeightUnit preferredUnit,  bool isCustom,  bool isSeed)  $default,) {final _that = this;
switch (_that) {
case _Exercise():
return $default(_that.id,_that.name,_that.primaryMuscle,_that.secondaryMuscles,_that.type,_that.equipment,_that.difficulty,_that.instructions,_that.commonMistakes,_that.imagePath,_that.preferredUnit,_that.isCustom,_that.isSeed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  MuscleGroup primaryMuscle,  List<MuscleGroup> secondaryMuscles,  ExerciseType type,  Equipment equipment,  Difficulty difficulty,  String instructions,  String commonMistakes,  String? imagePath,  WeightUnit preferredUnit,  bool isCustom,  bool isSeed)?  $default,) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.name,_that.primaryMuscle,_that.secondaryMuscles,_that.type,_that.equipment,_that.difficulty,_that.instructions,_that.commonMistakes,_that.imagePath,_that.preferredUnit,_that.isCustom,_that.isSeed);case _:
  return null;

}
}

}

/// @nodoc


class _Exercise extends Exercise {
  const _Exercise({required this.id, required this.name, required this.primaryMuscle,  List<MuscleGroup> secondaryMuscles = const <MuscleGroup>[], required this.type, required this.equipment, required this.difficulty, this.instructions = '', this.commonMistakes = '', this.imagePath, this.preferredUnit = WeightUnit.kg, this.isCustom = false, this.isSeed = false}): _secondaryMuscles = secondaryMuscles,super._();
  

@override final  String id;
@override final  String name;
@override final  MuscleGroup primaryMuscle;
 final  List<MuscleGroup> _secondaryMuscles;
@override@JsonKey() List<MuscleGroup> get secondaryMuscles {
  if (_secondaryMuscles is EqualUnmodifiableListView) return _secondaryMuscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryMuscles);
}

@override final  ExerciseType type;
@override final  Equipment equipment;
@override final  Difficulty difficulty;
@override@JsonKey() final  String instructions;
@override@JsonKey() final  String commonMistakes;
/// `null` means the default placeholder image.
@override final  String? imagePath;
@override@JsonKey() final  WeightUnit preferredUnit;
@override@JsonKey() final  bool isCustom;
/// Reference data shipped with the app.
@override@JsonKey() final  bool isSeed;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseCopyWith<_Exercise> get copyWith => __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exercise&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscle, primaryMuscle) || other.primaryMuscle == primaryMuscle)&&const DeepCollectionEquality().equals(other.secondaryMuscles, _secondaryMuscles)&&(identical(other.type, type) || other.type == type)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.commonMistakes, commonMistakes) || other.commonMistakes == commonMistakes)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.preferredUnit, preferredUnit) || other.preferredUnit == preferredUnit)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.isSeed, isSeed) || other.isSeed == isSeed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,primaryMuscle,const DeepCollectionEquality().hash(_secondaryMuscles),type,equipment,difficulty,instructions,commonMistakes,imagePath,preferredUnit,isCustom,isSeed);
}

@override
String toString() {
    return 'Exercise(id: $id, name: $name, primaryMuscle: $primaryMuscle, secondaryMuscles: $secondaryMuscles, type: $type, equipment: $equipment, difficulty: $difficulty, instructions: $instructions, commonMistakes: $commonMistakes, imagePath: $imagePath, preferredUnit: $preferredUnit, isCustom: $isCustom, isSeed: $isSeed)';
}


}

/// @nodoc
abstract mixin class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) _then) = __$ExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, MuscleGroup primaryMuscle, List<MuscleGroup> secondaryMuscles, ExerciseType type, Equipment equipment, Difficulty difficulty, String instructions, String commonMistakes, String? imagePath, WeightUnit preferredUnit, bool isCustom, bool isSeed
});




}
/// @nodoc
class __$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(this._self, this._then);

  final _Exercise _self;
  final $Res Function(_Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? primaryMuscle = null,Object? secondaryMuscles = null,Object? type = null,Object? equipment = null,Object? difficulty = null,Object? instructions = null,Object? commonMistakes = null,Object? imagePath = freezed,Object? preferredUnit = null,Object? isCustom = null,Object? isSeed = null,}) {
  return _then(_Exercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscle: null == primaryMuscle ? _self.primaryMuscle : primaryMuscle // ignore: cast_nullable_to_non_nullable
as MuscleGroup,secondaryMuscles: null == secondaryMuscles ? _self._secondaryMuscles : secondaryMuscles // ignore: cast_nullable_to_non_nullable
as List<MuscleGroup>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as Equipment,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String,commonMistakes: null == commonMistakes ? _self.commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,preferredUnit: null == preferredUnit ? _self.preferredUnit : preferredUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,isSeed: null == isSeed ? _self.isSeed : isSeed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
