// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfileDraft {

 String get alias;/// Optional calendar date (UTC midnight).
 DateTime? get birthDate; Sex? get sex; double? get heightCm; ExperienceLevel? get experienceLevel; TrainingGoal? get goal; int? get daysPerWeek; int? get sessionDurationMin; List<Equipment> get equipment;
/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDraftCopyWith<UserProfileDraft> get copyWith => _$UserProfileDraftCopyWithImpl<UserProfileDraft>(this as UserProfileDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserProfileDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDraft&&(identical(other.alias, _this.alias) || other.alias == _this.alias)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.sex, _this.sex) || other.sex == _this.sex)&&(identical(other.heightCm, _this.heightCm) || other.heightCm == _this.heightCm)&&(identical(other.experienceLevel, _this.experienceLevel) || other.experienceLevel == _this.experienceLevel)&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.daysPerWeek, _this.daysPerWeek) || other.daysPerWeek == _this.daysPerWeek)&&(identical(other.sessionDurationMin, _this.sessionDurationMin) || other.sessionDurationMin == _this.sessionDurationMin)&&const DeepCollectionEquality().equals(other.equipment, _this.equipment));
}


@override
int get hashCode {
  final _this = this as UserProfileDraft;
  return Object.hash(runtimeType,_this.alias,_this.birthDate,_this.sex,_this.heightCm,_this.experienceLevel,_this.goal,_this.daysPerWeek,_this.sessionDurationMin,const DeepCollectionEquality().hash(_this.equipment));
}

@override
String toString() {
  final _this = this as UserProfileDraft;
  return 'UserProfileDraft(alias: ${_this.alias}, birthDate: ${_this.birthDate}, sex: ${_this.sex}, heightCm: ${_this.heightCm}, experienceLevel: ${_this.experienceLevel}, goal: ${_this.goal}, daysPerWeek: ${_this.daysPerWeek}, sessionDurationMin: ${_this.sessionDurationMin}, equipment: ${_this.equipment})';
}


}

/// @nodoc
abstract mixin class $UserProfileDraftCopyWith<$Res>  {
  factory $UserProfileDraftCopyWith(UserProfileDraft value, $Res Function(UserProfileDraft) _then) = _$UserProfileDraftCopyWithImpl;
@useResult
$Res call({
 String alias, DateTime? birthDate, Sex? sex, double? heightCm, ExperienceLevel? experienceLevel, TrainingGoal? goal, int? daysPerWeek, int? sessionDurationMin, List<Equipment> equipment
});




}
/// @nodoc
class _$UserProfileDraftCopyWithImpl<$Res>
    implements $UserProfileDraftCopyWith<$Res> {
  _$UserProfileDraftCopyWithImpl(this._self, this._then);

  final UserProfileDraft _self;
  final $Res Function(UserProfileDraft) _then;

/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? alias = null,Object? birthDate = freezed,Object? sex = freezed,Object? heightCm = freezed,Object? experienceLevel = freezed,Object? goal = freezed,Object? daysPerWeek = freezed,Object? sessionDurationMin = freezed,Object? equipment = null,}) {
  return _then(UserProfileDraft(
alias: null == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as Sex?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,goal: freezed == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as TrainingGoal?,daysPerWeek: freezed == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int?,sessionDurationMin: freezed == sessionDurationMin ? _self.sessionDurationMin : sessionDurationMin // ignore: cast_nullable_to_non_nullable
as int?,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<Equipment>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileDraft].
extension UserProfileDraftPatterns on UserProfileDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDraft value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDraft value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String alias,  DateTime? birthDate,  Sex? sex,  double? heightCm,  ExperienceLevel? experienceLevel,  TrainingGoal? goal,  int? daysPerWeek,  int? sessionDurationMin,  List<Equipment> equipment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDraft() when $default != null:
return $default(_that.alias,_that.birthDate,_that.sex,_that.heightCm,_that.experienceLevel,_that.goal,_that.daysPerWeek,_that.sessionDurationMin,_that.equipment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String alias,  DateTime? birthDate,  Sex? sex,  double? heightCm,  ExperienceLevel? experienceLevel,  TrainingGoal? goal,  int? daysPerWeek,  int? sessionDurationMin,  List<Equipment> equipment)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDraft():
return $default(_that.alias,_that.birthDate,_that.sex,_that.heightCm,_that.experienceLevel,_that.goal,_that.daysPerWeek,_that.sessionDurationMin,_that.equipment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String alias,  DateTime? birthDate,  Sex? sex,  double? heightCm,  ExperienceLevel? experienceLevel,  TrainingGoal? goal,  int? daysPerWeek,  int? sessionDurationMin,  List<Equipment> equipment)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDraft() when $default != null:
return $default(_that.alias,_that.birthDate,_that.sex,_that.heightCm,_that.experienceLevel,_that.goal,_that.daysPerWeek,_that.sessionDurationMin,_that.equipment);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfileDraft extends UserProfileDraft {
  const _UserProfileDraft({this.alias = '', this.birthDate, this.sex, this.heightCm, this.experienceLevel, this.goal, this.daysPerWeek, this.sessionDurationMin,  List<Equipment> equipment = const <Equipment>[]}): _equipment = equipment,super._();
  

@override@JsonKey() final  String alias;
/// Optional calendar date (UTC midnight).
@override final  DateTime? birthDate;
@override final  Sex? sex;
@override final  double? heightCm;
@override final  ExperienceLevel? experienceLevel;
@override final  TrainingGoal? goal;
@override final  int? daysPerWeek;
@override final  int? sessionDurationMin;
 final  List<Equipment> _equipment;
@override@JsonKey() List<Equipment> get equipment {
  if (_equipment is EqualUnmodifiableListView) return _equipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipment);
}


/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDraftCopyWith<_UserProfileDraft> get copyWith => __$UserProfileDraftCopyWithImpl<_UserProfileDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDraft&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.daysPerWeek, daysPerWeek) || other.daysPerWeek == daysPerWeek)&&(identical(other.sessionDurationMin, sessionDurationMin) || other.sessionDurationMin == sessionDurationMin)&&const DeepCollectionEquality().equals(other.equipment, _equipment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,alias,birthDate,sex,heightCm,experienceLevel,goal,daysPerWeek,sessionDurationMin,const DeepCollectionEquality().hash(_equipment));
}

@override
String toString() {
    return 'UserProfileDraft(alias: $alias, birthDate: $birthDate, sex: $sex, heightCm: $heightCm, experienceLevel: $experienceLevel, goal: $goal, daysPerWeek: $daysPerWeek, sessionDurationMin: $sessionDurationMin, equipment: $equipment)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDraftCopyWith<$Res> implements $UserProfileDraftCopyWith<$Res> {
  factory _$UserProfileDraftCopyWith(_UserProfileDraft value, $Res Function(_UserProfileDraft) _then) = __$UserProfileDraftCopyWithImpl;
@override @useResult
$Res call({
 String alias, DateTime? birthDate, Sex? sex, double? heightCm, ExperienceLevel? experienceLevel, TrainingGoal? goal, int? daysPerWeek, int? sessionDurationMin, List<Equipment> equipment
});




}
/// @nodoc
class __$UserProfileDraftCopyWithImpl<$Res>
    implements _$UserProfileDraftCopyWith<$Res> {
  __$UserProfileDraftCopyWithImpl(this._self, this._then);

  final _UserProfileDraft _self;
  final $Res Function(_UserProfileDraft) _then;

/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? alias = null,Object? birthDate = freezed,Object? sex = freezed,Object? heightCm = freezed,Object? experienceLevel = freezed,Object? goal = freezed,Object? daysPerWeek = freezed,Object? sessionDurationMin = freezed,Object? equipment = null,}) {
  return _then(_UserProfileDraft(
alias: null == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as Sex?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,goal: freezed == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as TrainingGoal?,daysPerWeek: freezed == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int?,sessionDurationMin: freezed == sessionDurationMin ? _self.sessionDurationMin : sessionDurationMin // ignore: cast_nullable_to_non_nullable
as int?,equipment: null == equipment ? _self._equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<Equipment>,
  ));
}


}

// dart format on
