// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Routine {

 String get id; String get name; String get notes;/// `null` for a custom routine.
 RoutineTemplateType? get templateType; List<RoutineDay> get days;
/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineCopyWith<Routine> get copyWith => _$RoutineCopyWithImpl<Routine>(this as Routine, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Routine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Routine&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.templateType, _this.templateType) || other.templateType == _this.templateType)&&const DeepCollectionEquality().equals(other.days, _this.days));
}


@override
int get hashCode {
  final _this = this as Routine;
  return Object.hash(runtimeType,_this.id,_this.name,_this.notes,_this.templateType,const DeepCollectionEquality().hash(_this.days));
}

@override
String toString() {
  final _this = this as Routine;
  return 'Routine(id: ${_this.id}, name: ${_this.name}, notes: ${_this.notes}, templateType: ${_this.templateType}, days: ${_this.days})';
}


}

/// @nodoc
abstract mixin class $RoutineCopyWith<$Res>  {
  factory $RoutineCopyWith(Routine value, $Res Function(Routine) _then) = _$RoutineCopyWithImpl;
@useResult
$Res call({
 String id, String name, String notes, RoutineTemplateType? templateType, List<RoutineDay> days
});




}
/// @nodoc
class _$RoutineCopyWithImpl<$Res>
    implements $RoutineCopyWith<$Res> {
  _$RoutineCopyWithImpl(this._self, this._then);

  final Routine _self;
  final $Res Function(Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? notes = null,Object? templateType = freezed,Object? days = null,}) {
  return _then(Routine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,templateType: freezed == templateType ? _self.templateType : templateType // ignore: cast_nullable_to_non_nullable
as RoutineTemplateType?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<RoutineDay>,
  ));
}

}


/// Adds pattern-matching-related methods to [Routine].
extension RoutinePatterns on Routine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Routine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Routine value)  $default,){
final _that = this;
switch (_that) {
case _Routine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Routine value)?  $default,){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String notes,  RoutineTemplateType? templateType,  List<RoutineDay> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.name,_that.notes,_that.templateType,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String notes,  RoutineTemplateType? templateType,  List<RoutineDay> days)  $default,) {final _that = this;
switch (_that) {
case _Routine():
return $default(_that.id,_that.name,_that.notes,_that.templateType,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String notes,  RoutineTemplateType? templateType,  List<RoutineDay> days)?  $default,) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.name,_that.notes,_that.templateType,_that.days);case _:
  return null;

}
}

}

/// @nodoc


class _Routine extends Routine {
  const _Routine({required this.id, required this.name, this.notes = '', this.templateType,  List<RoutineDay> days = const <RoutineDay>[]}): _days = days,super._();
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  String notes;
/// `null` for a custom routine.
@override final  RoutineTemplateType? templateType;
 final  List<RoutineDay> _days;
@override@JsonKey() List<RoutineDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineCopyWith<_Routine> get copyWith => __$RoutineCopyWithImpl<_Routine>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Routine&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.templateType, templateType) || other.templateType == templateType)&&const DeepCollectionEquality().equals(other.days, _days));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,notes,templateType,const DeepCollectionEquality().hash(_days));
}

@override
String toString() {
    return 'Routine(id: $id, name: $name, notes: $notes, templateType: $templateType, days: $days)';
}


}

/// @nodoc
abstract mixin class _$RoutineCopyWith<$Res> implements $RoutineCopyWith<$Res> {
  factory _$RoutineCopyWith(_Routine value, $Res Function(_Routine) _then) = __$RoutineCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String notes, RoutineTemplateType? templateType, List<RoutineDay> days
});




}
/// @nodoc
class __$RoutineCopyWithImpl<$Res>
    implements _$RoutineCopyWith<$Res> {
  __$RoutineCopyWithImpl(this._self, this._then);

  final _Routine _self;
  final $Res Function(_Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? notes = null,Object? templateType = freezed,Object? days = null,}) {
  return _then(_Routine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,templateType: freezed == templateType ? _self.templateType : templateType // ignore: cast_nullable_to_non_nullable
as RoutineTemplateType?,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<RoutineDay>,
  ));
}


}

/// @nodoc
mixin _$RoutineDay {

 String get id; String get routineId; String get name; int get position;/// ISO weekday, 1 = Monday ... 7 = Sunday. `null` when not scheduled.
 int? get weekday; List<RoutineExercise> get exercises;
/// Create a copy of RoutineDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineDayCopyWith<RoutineDay> get copyWith => _$RoutineDayCopyWithImpl<RoutineDay>(this as RoutineDay, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineDay&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.routineId, _this.routineId) || other.routineId == _this.routineId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday)&&const DeepCollectionEquality().equals(other.exercises, _this.exercises));
}


@override
int get hashCode {
  final _this = this as RoutineDay;
  return Object.hash(runtimeType,_this.id,_this.routineId,_this.name,_this.position,_this.weekday,const DeepCollectionEquality().hash(_this.exercises));
}

@override
String toString() {
  final _this = this as RoutineDay;
  return 'RoutineDay(id: ${_this.id}, routineId: ${_this.routineId}, name: ${_this.name}, position: ${_this.position}, weekday: ${_this.weekday}, exercises: ${_this.exercises})';
}


}

/// @nodoc
abstract mixin class $RoutineDayCopyWith<$Res>  {
  factory $RoutineDayCopyWith(RoutineDay value, $Res Function(RoutineDay) _then) = _$RoutineDayCopyWithImpl;
@useResult
$Res call({
 String id, String routineId, String name, int position, int? weekday, List<RoutineExercise> exercises
});




}
/// @nodoc
class _$RoutineDayCopyWithImpl<$Res>
    implements $RoutineDayCopyWith<$Res> {
  _$RoutineDayCopyWithImpl(this._self, this._then);

  final RoutineDay _self;
  final $Res Function(RoutineDay) _then;

/// Create a copy of RoutineDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routineId = null,Object? name = null,Object? position = null,Object? weekday = freezed,Object? exercises = null,}) {
  return _then(RoutineDay(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routineId: null == routineId ? _self.routineId : routineId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,weekday: freezed == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<RoutineExercise>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineDay].
extension RoutineDayPatterns on RoutineDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineDay value)  $default,){
final _that = this;
switch (_that) {
case _RoutineDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineDay value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String routineId,  String name,  int position,  int? weekday,  List<RoutineExercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineDay() when $default != null:
return $default(_that.id,_that.routineId,_that.name,_that.position,_that.weekday,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String routineId,  String name,  int position,  int? weekday,  List<RoutineExercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _RoutineDay():
return $default(_that.id,_that.routineId,_that.name,_that.position,_that.weekday,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String routineId,  String name,  int position,  int? weekday,  List<RoutineExercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _RoutineDay() when $default != null:
return $default(_that.id,_that.routineId,_that.name,_that.position,_that.weekday,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineDay implements RoutineDay {
  const _RoutineDay({required this.id, required this.routineId, required this.name, required this.position, this.weekday,  List<RoutineExercise> exercises = const <RoutineExercise>[]}): _exercises = exercises;
  

@override final  String id;
@override final  String routineId;
@override final  String name;
@override final  int position;
/// ISO weekday, 1 = Monday ... 7 = Sunday. `null` when not scheduled.
@override final  int? weekday;
 final  List<RoutineExercise> _exercises;
@override@JsonKey() List<RoutineExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of RoutineDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineDayCopyWith<_RoutineDay> get copyWith => __$RoutineDayCopyWithImpl<_RoutineDay>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineDay&&(identical(other.id, id) || other.id == id)&&(identical(other.routineId, routineId) || other.routineId == routineId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&const DeepCollectionEquality().equals(other.exercises, _exercises));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,routineId,name,position,weekday,const DeepCollectionEquality().hash(_exercises));
}

@override
String toString() {
    return 'RoutineDay(id: $id, routineId: $routineId, name: $name, position: $position, weekday: $weekday, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$RoutineDayCopyWith<$Res> implements $RoutineDayCopyWith<$Res> {
  factory _$RoutineDayCopyWith(_RoutineDay value, $Res Function(_RoutineDay) _then) = __$RoutineDayCopyWithImpl;
@override @useResult
$Res call({
 String id, String routineId, String name, int position, int? weekday, List<RoutineExercise> exercises
});




}
/// @nodoc
class __$RoutineDayCopyWithImpl<$Res>
    implements _$RoutineDayCopyWith<$Res> {
  __$RoutineDayCopyWithImpl(this._self, this._then);

  final _RoutineDay _self;
  final $Res Function(_RoutineDay) _then;

/// Create a copy of RoutineDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routineId = null,Object? name = null,Object? position = null,Object? weekday = freezed,Object? exercises = null,}) {
  return _then(_RoutineDay(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routineId: null == routineId ? _self.routineId : routineId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,weekday: freezed == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int?,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<RoutineExercise>,
  ));
}


}

/// @nodoc
mixin _$RoutineExercise {

 String get id; String get routineDayId; String get exerciseId; int get position; int get targetSets; int get targetRepsMin; int get targetRepsMax;/// Always in kg. `null` when not set.
 double? get initialWeightKg; int get restSeconds; String get notes;
/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineExerciseCopyWith<RoutineExercise> get copyWith => _$RoutineExerciseCopyWithImpl<RoutineExercise>(this as RoutineExercise, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineExercise;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineExercise&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.routineDayId, _this.routineDayId) || other.routineDayId == _this.routineDayId)&&(identical(other.exerciseId, _this.exerciseId) || other.exerciseId == _this.exerciseId)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.targetSets, _this.targetSets) || other.targetSets == _this.targetSets)&&(identical(other.targetRepsMin, _this.targetRepsMin) || other.targetRepsMin == _this.targetRepsMin)&&(identical(other.targetRepsMax, _this.targetRepsMax) || other.targetRepsMax == _this.targetRepsMax)&&(identical(other.initialWeightKg, _this.initialWeightKg) || other.initialWeightKg == _this.initialWeightKg)&&(identical(other.restSeconds, _this.restSeconds) || other.restSeconds == _this.restSeconds)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}


@override
int get hashCode {
  final _this = this as RoutineExercise;
  return Object.hash(runtimeType,_this.id,_this.routineDayId,_this.exerciseId,_this.position,_this.targetSets,_this.targetRepsMin,_this.targetRepsMax,_this.initialWeightKg,_this.restSeconds,_this.notes);
}

@override
String toString() {
  final _this = this as RoutineExercise;
  return 'RoutineExercise(id: ${_this.id}, routineDayId: ${_this.routineDayId}, exerciseId: ${_this.exerciseId}, position: ${_this.position}, targetSets: ${_this.targetSets}, targetRepsMin: ${_this.targetRepsMin}, targetRepsMax: ${_this.targetRepsMax}, initialWeightKg: ${_this.initialWeightKg}, restSeconds: ${_this.restSeconds}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $RoutineExerciseCopyWith<$Res>  {
  factory $RoutineExerciseCopyWith(RoutineExercise value, $Res Function(RoutineExercise) _then) = _$RoutineExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String routineDayId, String exerciseId, int position, int targetSets, int targetRepsMin, int targetRepsMax, double? initialWeightKg, int restSeconds, String notes
});




}
/// @nodoc
class _$RoutineExerciseCopyWithImpl<$Res>
    implements $RoutineExerciseCopyWith<$Res> {
  _$RoutineExerciseCopyWithImpl(this._self, this._then);

  final RoutineExercise _self;
  final $Res Function(RoutineExercise) _then;

/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routineDayId = null,Object? exerciseId = null,Object? position = null,Object? targetSets = null,Object? targetRepsMin = null,Object? targetRepsMax = null,Object? initialWeightKg = freezed,Object? restSeconds = null,Object? notes = null,}) {
  return _then(RoutineExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routineDayId: null == routineDayId ? _self.routineDayId : routineDayId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,targetSets: null == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int,targetRepsMin: null == targetRepsMin ? _self.targetRepsMin : targetRepsMin // ignore: cast_nullable_to_non_nullable
as int,targetRepsMax: null == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int,initialWeightKg: freezed == initialWeightKg ? _self.initialWeightKg : initialWeightKg // ignore: cast_nullable_to_non_nullable
as double?,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineExercise].
extension RoutineExercisePatterns on RoutineExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineExercise value)  $default,){
final _that = this;
switch (_that) {
case _RoutineExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineExercise value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String routineDayId,  String exerciseId,  int position,  int targetSets,  int targetRepsMin,  int targetRepsMax,  double? initialWeightKg,  int restSeconds,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
return $default(_that.id,_that.routineDayId,_that.exerciseId,_that.position,_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.initialWeightKg,_that.restSeconds,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String routineDayId,  String exerciseId,  int position,  int targetSets,  int targetRepsMin,  int targetRepsMax,  double? initialWeightKg,  int restSeconds,  String notes)  $default,) {final _that = this;
switch (_that) {
case _RoutineExercise():
return $default(_that.id,_that.routineDayId,_that.exerciseId,_that.position,_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.initialWeightKg,_that.restSeconds,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String routineDayId,  String exerciseId,  int position,  int targetSets,  int targetRepsMin,  int targetRepsMax,  double? initialWeightKg,  int restSeconds,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _RoutineExercise() when $default != null:
return $default(_that.id,_that.routineDayId,_that.exerciseId,_that.position,_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.initialWeightKg,_that.restSeconds,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineExercise implements RoutineExercise {
  const _RoutineExercise({required this.id, required this.routineDayId, required this.exerciseId, required this.position, required this.targetSets, required this.targetRepsMin, required this.targetRepsMax, this.initialWeightKg, required this.restSeconds, this.notes = ''});
  

@override final  String id;
@override final  String routineDayId;
@override final  String exerciseId;
@override final  int position;
@override final  int targetSets;
@override final  int targetRepsMin;
@override final  int targetRepsMax;
/// Always in kg. `null` when not set.
@override final  double? initialWeightKg;
@override final  int restSeconds;
@override@JsonKey() final  String notes;

/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineExerciseCopyWith<_RoutineExercise> get copyWith => __$RoutineExerciseCopyWithImpl<_RoutineExercise>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.routineDayId, routineDayId) || other.routineDayId == routineDayId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.position, position) || other.position == position)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.targetRepsMin, targetRepsMin) || other.targetRepsMin == targetRepsMin)&&(identical(other.targetRepsMax, targetRepsMax) || other.targetRepsMax == targetRepsMax)&&(identical(other.initialWeightKg, initialWeightKg) || other.initialWeightKg == initialWeightKg)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,routineDayId,exerciseId,position,targetSets,targetRepsMin,targetRepsMax,initialWeightKg,restSeconds,notes);
}

@override
String toString() {
    return 'RoutineExercise(id: $id, routineDayId: $routineDayId, exerciseId: $exerciseId, position: $position, targetSets: $targetSets, targetRepsMin: $targetRepsMin, targetRepsMax: $targetRepsMax, initialWeightKg: $initialWeightKg, restSeconds: $restSeconds, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$RoutineExerciseCopyWith<$Res> implements $RoutineExerciseCopyWith<$Res> {
  factory _$RoutineExerciseCopyWith(_RoutineExercise value, $Res Function(_RoutineExercise) _then) = __$RoutineExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String routineDayId, String exerciseId, int position, int targetSets, int targetRepsMin, int targetRepsMax, double? initialWeightKg, int restSeconds, String notes
});




}
/// @nodoc
class __$RoutineExerciseCopyWithImpl<$Res>
    implements _$RoutineExerciseCopyWith<$Res> {
  __$RoutineExerciseCopyWithImpl(this._self, this._then);

  final _RoutineExercise _self;
  final $Res Function(_RoutineExercise) _then;

/// Create a copy of RoutineExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routineDayId = null,Object? exerciseId = null,Object? position = null,Object? targetSets = null,Object? targetRepsMin = null,Object? targetRepsMax = null,Object? initialWeightKg = freezed,Object? restSeconds = null,Object? notes = null,}) {
  return _then(_RoutineExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routineDayId: null == routineDayId ? _self.routineDayId : routineDayId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,targetSets: null == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int,targetRepsMin: null == targetRepsMin ? _self.targetRepsMin : targetRepsMin // ignore: cast_nullable_to_non_nullable
as int,targetRepsMax: null == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int,initialWeightKg: freezed == initialWeightKg ? _self.initialWeightKg : initialWeightKg // ignore: cast_nullable_to_non_nullable
as double?,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
