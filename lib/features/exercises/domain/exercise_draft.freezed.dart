// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseDraft {

 String get name; MuscleGroup? get primaryMuscle; List<MuscleGroup> get secondaryMuscles; ExerciseType? get type; Equipment? get equipment; Difficulty? get difficulty; String get instructions; String get commonMistakes; WeightUnit get preferredUnit;
/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseDraftCopyWith<ExerciseDraft> get copyWith => _$ExerciseDraftCopyWithImpl<ExerciseDraft>(this as ExerciseDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExerciseDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseDraft&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.primaryMuscle, _this.primaryMuscle) || other.primaryMuscle == _this.primaryMuscle)&&const DeepCollectionEquality().equals(other.secondaryMuscles, _this.secondaryMuscles)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.equipment, _this.equipment) || other.equipment == _this.equipment)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.instructions, _this.instructions) || other.instructions == _this.instructions)&&(identical(other.commonMistakes, _this.commonMistakes) || other.commonMistakes == _this.commonMistakes)&&(identical(other.preferredUnit, _this.preferredUnit) || other.preferredUnit == _this.preferredUnit));
}


@override
int get hashCode {
  final _this = this as ExerciseDraft;
  return Object.hash(runtimeType,_this.name,_this.primaryMuscle,const DeepCollectionEquality().hash(_this.secondaryMuscles),_this.type,_this.equipment,_this.difficulty,_this.instructions,_this.commonMistakes,_this.preferredUnit);
}

@override
String toString() {
  final _this = this as ExerciseDraft;
  return 'ExerciseDraft(name: ${_this.name}, primaryMuscle: ${_this.primaryMuscle}, secondaryMuscles: ${_this.secondaryMuscles}, type: ${_this.type}, equipment: ${_this.equipment}, difficulty: ${_this.difficulty}, instructions: ${_this.instructions}, commonMistakes: ${_this.commonMistakes}, preferredUnit: ${_this.preferredUnit})';
}


}

/// @nodoc
abstract mixin class $ExerciseDraftCopyWith<$Res>  {
  factory $ExerciseDraftCopyWith(ExerciseDraft value, $Res Function(ExerciseDraft) _then) = _$ExerciseDraftCopyWithImpl;
@useResult
$Res call({
 String name, MuscleGroup? primaryMuscle, List<MuscleGroup> secondaryMuscles, ExerciseType? type, Equipment? equipment, Difficulty? difficulty, String instructions, String commonMistakes, WeightUnit preferredUnit
});




}
/// @nodoc
class _$ExerciseDraftCopyWithImpl<$Res>
    implements $ExerciseDraftCopyWith<$Res> {
  _$ExerciseDraftCopyWithImpl(this._self, this._then);

  final ExerciseDraft _self;
  final $Res Function(ExerciseDraft) _then;

/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? primaryMuscle = freezed,Object? secondaryMuscles = null,Object? type = freezed,Object? equipment = freezed,Object? difficulty = freezed,Object? instructions = null,Object? commonMistakes = null,Object? preferredUnit = null,}) {
  return _then(ExerciseDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscle: freezed == primaryMuscle ? _self.primaryMuscle : primaryMuscle // ignore: cast_nullable_to_non_nullable
as MuscleGroup?,secondaryMuscles: null == secondaryMuscles ? _self.secondaryMuscles : secondaryMuscles // ignore: cast_nullable_to_non_nullable
as List<MuscleGroup>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType?,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as Equipment?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String,commonMistakes: null == commonMistakes ? _self.commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as String,preferredUnit: null == preferredUnit ? _self.preferredUnit : preferredUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseDraft].
extension ExerciseDraftPatterns on ExerciseDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseDraft value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseDraft value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  MuscleGroup? primaryMuscle,  List<MuscleGroup> secondaryMuscles,  ExerciseType? type,  Equipment? equipment,  Difficulty? difficulty,  String instructions,  String commonMistakes,  WeightUnit preferredUnit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
return $default(_that.name,_that.primaryMuscle,_that.secondaryMuscles,_that.type,_that.equipment,_that.difficulty,_that.instructions,_that.commonMistakes,_that.preferredUnit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  MuscleGroup? primaryMuscle,  List<MuscleGroup> secondaryMuscles,  ExerciseType? type,  Equipment? equipment,  Difficulty? difficulty,  String instructions,  String commonMistakes,  WeightUnit preferredUnit)  $default,) {final _that = this;
switch (_that) {
case _ExerciseDraft():
return $default(_that.name,_that.primaryMuscle,_that.secondaryMuscles,_that.type,_that.equipment,_that.difficulty,_that.instructions,_that.commonMistakes,_that.preferredUnit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  MuscleGroup? primaryMuscle,  List<MuscleGroup> secondaryMuscles,  ExerciseType? type,  Equipment? equipment,  Difficulty? difficulty,  String instructions,  String commonMistakes,  WeightUnit preferredUnit)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseDraft() when $default != null:
return $default(_that.name,_that.primaryMuscle,_that.secondaryMuscles,_that.type,_that.equipment,_that.difficulty,_that.instructions,_that.commonMistakes,_that.preferredUnit);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseDraft extends ExerciseDraft {
  const _ExerciseDraft({this.name = '', this.primaryMuscle,  List<MuscleGroup> secondaryMuscles = const <MuscleGroup>[], this.type, this.equipment, this.difficulty, this.instructions = '', this.commonMistakes = '', this.preferredUnit = WeightUnit.kg}): _secondaryMuscles = secondaryMuscles,super._();
  

@override@JsonKey() final  String name;
@override final  MuscleGroup? primaryMuscle;
 final  List<MuscleGroup> _secondaryMuscles;
@override@JsonKey() List<MuscleGroup> get secondaryMuscles {
  if (_secondaryMuscles is EqualUnmodifiableListView) return _secondaryMuscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryMuscles);
}

@override final  ExerciseType? type;
@override final  Equipment? equipment;
@override final  Difficulty? difficulty;
@override@JsonKey() final  String instructions;
@override@JsonKey() final  String commonMistakes;
@override@JsonKey() final  WeightUnit preferredUnit;

/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseDraftCopyWith<_ExerciseDraft> get copyWith => __$ExerciseDraftCopyWithImpl<_ExerciseDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseDraft&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryMuscle, primaryMuscle) || other.primaryMuscle == primaryMuscle)&&const DeepCollectionEquality().equals(other.secondaryMuscles, _secondaryMuscles)&&(identical(other.type, type) || other.type == type)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.commonMistakes, commonMistakes) || other.commonMistakes == commonMistakes)&&(identical(other.preferredUnit, preferredUnit) || other.preferredUnit == preferredUnit));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,primaryMuscle,const DeepCollectionEquality().hash(_secondaryMuscles),type,equipment,difficulty,instructions,commonMistakes,preferredUnit);
}

@override
String toString() {
    return 'ExerciseDraft(name: $name, primaryMuscle: $primaryMuscle, secondaryMuscles: $secondaryMuscles, type: $type, equipment: $equipment, difficulty: $difficulty, instructions: $instructions, commonMistakes: $commonMistakes, preferredUnit: $preferredUnit)';
}


}

/// @nodoc
abstract mixin class _$ExerciseDraftCopyWith<$Res> implements $ExerciseDraftCopyWith<$Res> {
  factory _$ExerciseDraftCopyWith(_ExerciseDraft value, $Res Function(_ExerciseDraft) _then) = __$ExerciseDraftCopyWithImpl;
@override @useResult
$Res call({
 String name, MuscleGroup? primaryMuscle, List<MuscleGroup> secondaryMuscles, ExerciseType? type, Equipment? equipment, Difficulty? difficulty, String instructions, String commonMistakes, WeightUnit preferredUnit
});




}
/// @nodoc
class __$ExerciseDraftCopyWithImpl<$Res>
    implements _$ExerciseDraftCopyWith<$Res> {
  __$ExerciseDraftCopyWithImpl(this._self, this._then);

  final _ExerciseDraft _self;
  final $Res Function(_ExerciseDraft) _then;

/// Create a copy of ExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? primaryMuscle = freezed,Object? secondaryMuscles = null,Object? type = freezed,Object? equipment = freezed,Object? difficulty = freezed,Object? instructions = null,Object? commonMistakes = null,Object? preferredUnit = null,}) {
  return _then(_ExerciseDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryMuscle: freezed == primaryMuscle ? _self.primaryMuscle : primaryMuscle // ignore: cast_nullable_to_non_nullable
as MuscleGroup?,secondaryMuscles: null == secondaryMuscles ? _self._secondaryMuscles : secondaryMuscles // ignore: cast_nullable_to_non_nullable
as List<MuscleGroup>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType?,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as Equipment?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty?,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String,commonMistakes: null == commonMistakes ? _self.commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as String,preferredUnit: null == preferredUnit ? _self.preferredUnit : preferredUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,
  ));
}


}

// dart format on
