// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 String get id; String get alias;/// Calendar date (UTC midnight). `null` when not given.
 DateTime? get birthDate;/// `null` means "prefer not to say".
 Sex? get sex; double get heightCm; ExperienceLevel get experienceLevel; TrainingGoal get goal; int get daysPerWeek; int get sessionDurationMin; List<Equipment> get equipment;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.alias, _this.alias) || other.alias == _this.alias)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.sex, _this.sex) || other.sex == _this.sex)&&(identical(other.heightCm, _this.heightCm) || other.heightCm == _this.heightCm)&&(identical(other.experienceLevel, _this.experienceLevel) || other.experienceLevel == _this.experienceLevel)&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.daysPerWeek, _this.daysPerWeek) || other.daysPerWeek == _this.daysPerWeek)&&(identical(other.sessionDurationMin, _this.sessionDurationMin) || other.sessionDurationMin == _this.sessionDurationMin)&&const DeepCollectionEquality().equals(other.equipment, _this.equipment));
}


@override
int get hashCode {
  final _this = this as UserProfile;
  return Object.hash(runtimeType,_this.id,_this.alias,_this.birthDate,_this.sex,_this.heightCm,_this.experienceLevel,_this.goal,_this.daysPerWeek,_this.sessionDurationMin,const DeepCollectionEquality().hash(_this.equipment));
}

@override
String toString() {
  final _this = this as UserProfile;
  return 'UserProfile(id: ${_this.id}, alias: ${_this.alias}, birthDate: ${_this.birthDate}, sex: ${_this.sex}, heightCm: ${_this.heightCm}, experienceLevel: ${_this.experienceLevel}, goal: ${_this.goal}, daysPerWeek: ${_this.daysPerWeek}, sessionDurationMin: ${_this.sessionDurationMin}, equipment: ${_this.equipment})';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String alias, DateTime? birthDate, Sex? sex, double heightCm, ExperienceLevel experienceLevel, TrainingGoal goal, int daysPerWeek, int sessionDurationMin, List<Equipment> equipment
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? alias = null,Object? birthDate = freezed,Object? sex = freezed,Object? heightCm = null,Object? experienceLevel = null,Object? goal = null,Object? daysPerWeek = null,Object? sessionDurationMin = null,Object? equipment = null,}) {
  return _then(UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alias: null == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as Sex?,heightCm: null == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as TrainingGoal,daysPerWeek: null == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int,sessionDurationMin: null == sessionDurationMin ? _self.sessionDurationMin : sessionDurationMin // ignore: cast_nullable_to_non_nullable
as int,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<Equipment>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String alias,  DateTime? birthDate,  Sex? sex,  double heightCm,  ExperienceLevel experienceLevel,  TrainingGoal goal,  int daysPerWeek,  int sessionDurationMin,  List<Equipment> equipment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.alias,_that.birthDate,_that.sex,_that.heightCm,_that.experienceLevel,_that.goal,_that.daysPerWeek,_that.sessionDurationMin,_that.equipment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String alias,  DateTime? birthDate,  Sex? sex,  double heightCm,  ExperienceLevel experienceLevel,  TrainingGoal goal,  int daysPerWeek,  int sessionDurationMin,  List<Equipment> equipment)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.alias,_that.birthDate,_that.sex,_that.heightCm,_that.experienceLevel,_that.goal,_that.daysPerWeek,_that.sessionDurationMin,_that.equipment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String alias,  DateTime? birthDate,  Sex? sex,  double heightCm,  ExperienceLevel experienceLevel,  TrainingGoal goal,  int daysPerWeek,  int sessionDurationMin,  List<Equipment> equipment)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.alias,_that.birthDate,_that.sex,_that.heightCm,_that.experienceLevel,_that.goal,_that.daysPerWeek,_that.sessionDurationMin,_that.equipment);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile extends UserProfile {
  const _UserProfile({required this.id, required this.alias, this.birthDate, this.sex, required this.heightCm, required this.experienceLevel, required this.goal, required this.daysPerWeek, required this.sessionDurationMin,  List<Equipment> equipment = const <Equipment>[]}): _equipment = equipment,super._();
  

@override final  String id;
@override final  String alias;
/// Calendar date (UTC midnight). `null` when not given.
@override final  DateTime? birthDate;
/// `null` means "prefer not to say".
@override final  Sex? sex;
@override final  double heightCm;
@override final  ExperienceLevel experienceLevel;
@override final  TrainingGoal goal;
@override final  int daysPerWeek;
@override final  int sessionDurationMin;
 final  List<Equipment> _equipment;
@override@JsonKey() List<Equipment> get equipment {
  if (_equipment is EqualUnmodifiableListView) return _equipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipment);
}


/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.daysPerWeek, daysPerWeek) || other.daysPerWeek == daysPerWeek)&&(identical(other.sessionDurationMin, sessionDurationMin) || other.sessionDurationMin == sessionDurationMin)&&const DeepCollectionEquality().equals(other.equipment, _equipment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,alias,birthDate,sex,heightCm,experienceLevel,goal,daysPerWeek,sessionDurationMin,const DeepCollectionEquality().hash(_equipment));
}

@override
String toString() {
    return 'UserProfile(id: $id, alias: $alias, birthDate: $birthDate, sex: $sex, heightCm: $heightCm, experienceLevel: $experienceLevel, goal: $goal, daysPerWeek: $daysPerWeek, sessionDurationMin: $sessionDurationMin, equipment: $equipment)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String alias, DateTime? birthDate, Sex? sex, double heightCm, ExperienceLevel experienceLevel, TrainingGoal goal, int daysPerWeek, int sessionDurationMin, List<Equipment> equipment
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? alias = null,Object? birthDate = freezed,Object? sex = freezed,Object? heightCm = null,Object? experienceLevel = null,Object? goal = null,Object? daysPerWeek = null,Object? sessionDurationMin = null,Object? equipment = null,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alias: null == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sex: freezed == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as Sex?,heightCm: null == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as TrainingGoal,daysPerWeek: null == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int,sessionDurationMin: null == sessionDurationMin ? _self.sessionDurationMin : sessionDurationMin // ignore: cast_nullable_to_non_nullable
as int,equipment: null == equipment ? _self._equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<Equipment>,
  ));
}


}

// dart format on
