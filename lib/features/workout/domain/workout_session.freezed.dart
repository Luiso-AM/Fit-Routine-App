// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkoutSession {

 String get id;/// `null` for free sessions, or when the routine day was removed.
 String? get routineDayId;/// Names of the routine and day the session started from, if they
/// still exist.
 String? get routineName; String? get routineDayName; DateTime get startedAt; DateTime? get endedAt; int get pausedTotalSeconds;/// Set while the session is paused.
 DateTime? get pausedAt; SessionStatus get status; String get notes; bool get isDemo; List<SessionExercise> get exercises;
/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutSessionCopyWith<WorkoutSession> get copyWith => _$WorkoutSessionCopyWithImpl<WorkoutSession>(this as WorkoutSession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WorkoutSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.routineDayId, _this.routineDayId) || other.routineDayId == _this.routineDayId)&&(identical(other.routineName, _this.routineName) || other.routineName == _this.routineName)&&(identical(other.routineDayName, _this.routineDayName) || other.routineDayName == _this.routineDayName)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.pausedTotalSeconds, _this.pausedTotalSeconds) || other.pausedTotalSeconds == _this.pausedTotalSeconds)&&(identical(other.pausedAt, _this.pausedAt) || other.pausedAt == _this.pausedAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.isDemo, _this.isDemo) || other.isDemo == _this.isDemo)&&const DeepCollectionEquality().equals(other.exercises, _this.exercises));
}


@override
int get hashCode {
  final _this = this as WorkoutSession;
  return Object.hash(runtimeType,_this.id,_this.routineDayId,_this.routineName,_this.routineDayName,_this.startedAt,_this.endedAt,_this.pausedTotalSeconds,_this.pausedAt,_this.status,_this.notes,_this.isDemo,const DeepCollectionEquality().hash(_this.exercises));
}

@override
String toString() {
  final _this = this as WorkoutSession;
  return 'WorkoutSession(id: ${_this.id}, routineDayId: ${_this.routineDayId}, routineName: ${_this.routineName}, routineDayName: ${_this.routineDayName}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt}, pausedTotalSeconds: ${_this.pausedTotalSeconds}, pausedAt: ${_this.pausedAt}, status: ${_this.status}, notes: ${_this.notes}, isDemo: ${_this.isDemo}, exercises: ${_this.exercises})';
}


}

/// @nodoc
abstract mixin class $WorkoutSessionCopyWith<$Res>  {
  factory $WorkoutSessionCopyWith(WorkoutSession value, $Res Function(WorkoutSession) _then) = _$WorkoutSessionCopyWithImpl;
@useResult
$Res call({
 String id, String? routineDayId, String? routineName, String? routineDayName, DateTime startedAt, DateTime? endedAt, int pausedTotalSeconds, DateTime? pausedAt, SessionStatus status, String notes, bool isDemo, List<SessionExercise> exercises
});




}
/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._self, this._then);

  final WorkoutSession _self;
  final $Res Function(WorkoutSession) _then;

/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routineDayId = freezed,Object? routineName = freezed,Object? routineDayName = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? pausedTotalSeconds = null,Object? pausedAt = freezed,Object? status = null,Object? notes = null,Object? isDemo = null,Object? exercises = null,}) {
  return _then(WorkoutSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routineDayId: freezed == routineDayId ? _self.routineDayId : routineDayId // ignore: cast_nullable_to_non_nullable
as String?,routineName: freezed == routineName ? _self.routineName : routineName // ignore: cast_nullable_to_non_nullable
as String?,routineDayName: freezed == routineDayName ? _self.routineDayName : routineDayName // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedTotalSeconds: null == pausedTotalSeconds ? _self.pausedTotalSeconds : pausedTotalSeconds // ignore: cast_nullable_to_non_nullable
as int,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<SessionExercise>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutSession].
extension WorkoutSessionPatterns on WorkoutSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutSession value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutSession value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? routineDayId,  String? routineName,  String? routineDayName,  DateTime startedAt,  DateTime? endedAt,  int pausedTotalSeconds,  DateTime? pausedAt,  SessionStatus status,  String notes,  bool isDemo,  List<SessionExercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
return $default(_that.id,_that.routineDayId,_that.routineName,_that.routineDayName,_that.startedAt,_that.endedAt,_that.pausedTotalSeconds,_that.pausedAt,_that.status,_that.notes,_that.isDemo,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? routineDayId,  String? routineName,  String? routineDayName,  DateTime startedAt,  DateTime? endedAt,  int pausedTotalSeconds,  DateTime? pausedAt,  SessionStatus status,  String notes,  bool isDemo,  List<SessionExercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _WorkoutSession():
return $default(_that.id,_that.routineDayId,_that.routineName,_that.routineDayName,_that.startedAt,_that.endedAt,_that.pausedTotalSeconds,_that.pausedAt,_that.status,_that.notes,_that.isDemo,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? routineDayId,  String? routineName,  String? routineDayName,  DateTime startedAt,  DateTime? endedAt,  int pausedTotalSeconds,  DateTime? pausedAt,  SessionStatus status,  String notes,  bool isDemo,  List<SessionExercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutSession() when $default != null:
return $default(_that.id,_that.routineDayId,_that.routineName,_that.routineDayName,_that.startedAt,_that.endedAt,_that.pausedTotalSeconds,_that.pausedAt,_that.status,_that.notes,_that.isDemo,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutSession extends WorkoutSession {
  const _WorkoutSession({required this.id, this.routineDayId, this.routineName, this.routineDayName, required this.startedAt, this.endedAt, this.pausedTotalSeconds = 0, this.pausedAt, this.status = SessionStatus.inProgress, this.notes = '', this.isDemo = false,  List<SessionExercise> exercises = const <SessionExercise>[]}): _exercises = exercises,super._();
  

@override final  String id;
/// `null` for free sessions, or when the routine day was removed.
@override final  String? routineDayId;
/// Names of the routine and day the session started from, if they
/// still exist.
@override final  String? routineName;
@override final  String? routineDayName;
@override final  DateTime startedAt;
@override final  DateTime? endedAt;
@override@JsonKey() final  int pausedTotalSeconds;
/// Set while the session is paused.
@override final  DateTime? pausedAt;
@override@JsonKey() final  SessionStatus status;
@override@JsonKey() final  String notes;
@override@JsonKey() final  bool isDemo;
 final  List<SessionExercise> _exercises;
@override@JsonKey() List<SessionExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutSessionCopyWith<_WorkoutSession> get copyWith => __$WorkoutSessionCopyWithImpl<_WorkoutSession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutSession&&(identical(other.id, id) || other.id == id)&&(identical(other.routineDayId, routineDayId) || other.routineDayId == routineDayId)&&(identical(other.routineName, routineName) || other.routineName == routineName)&&(identical(other.routineDayName, routineDayName) || other.routineDayName == routineDayName)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.pausedTotalSeconds, pausedTotalSeconds) || other.pausedTotalSeconds == pausedTotalSeconds)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isDemo, isDemo) || other.isDemo == isDemo)&&const DeepCollectionEquality().equals(other.exercises, _exercises));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,routineDayId,routineName,routineDayName,startedAt,endedAt,pausedTotalSeconds,pausedAt,status,notes,isDemo,const DeepCollectionEquality().hash(_exercises));
}

@override
String toString() {
    return 'WorkoutSession(id: $id, routineDayId: $routineDayId, routineName: $routineName, routineDayName: $routineDayName, startedAt: $startedAt, endedAt: $endedAt, pausedTotalSeconds: $pausedTotalSeconds, pausedAt: $pausedAt, status: $status, notes: $notes, isDemo: $isDemo, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$WorkoutSessionCopyWith<$Res> implements $WorkoutSessionCopyWith<$Res> {
  factory _$WorkoutSessionCopyWith(_WorkoutSession value, $Res Function(_WorkoutSession) _then) = __$WorkoutSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String? routineDayId, String? routineName, String? routineDayName, DateTime startedAt, DateTime? endedAt, int pausedTotalSeconds, DateTime? pausedAt, SessionStatus status, String notes, bool isDemo, List<SessionExercise> exercises
});




}
/// @nodoc
class __$WorkoutSessionCopyWithImpl<$Res>
    implements _$WorkoutSessionCopyWith<$Res> {
  __$WorkoutSessionCopyWithImpl(this._self, this._then);

  final _WorkoutSession _self;
  final $Res Function(_WorkoutSession) _then;

/// Create a copy of WorkoutSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routineDayId = freezed,Object? routineName = freezed,Object? routineDayName = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? pausedTotalSeconds = null,Object? pausedAt = freezed,Object? status = null,Object? notes = null,Object? isDemo = null,Object? exercises = null,}) {
  return _then(_WorkoutSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routineDayId: freezed == routineDayId ? _self.routineDayId : routineDayId // ignore: cast_nullable_to_non_nullable
as String?,routineName: freezed == routineName ? _self.routineName : routineName // ignore: cast_nullable_to_non_nullable
as String?,routineDayName: freezed == routineDayName ? _self.routineDayName : routineDayName // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedTotalSeconds: null == pausedTotalSeconds ? _self.pausedTotalSeconds : pausedTotalSeconds // ignore: cast_nullable_to_non_nullable
as int,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<SessionExercise>,
  ));
}


}

/// @nodoc
mixin _$SessionExercise {

 String get id; String get sessionId; String get exerciseId; int get position;/// Targets, `null` for exercises without a routine plan.
 int? get targetSets; int? get targetRepsMin; int? get targetRepsMax; int? get restSeconds; String get notes;/// Ordered by set number.
 List<SetEntry> get sets;
/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionExerciseCopyWith<SessionExercise> get copyWith => _$SessionExerciseCopyWithImpl<SessionExercise>(this as SessionExercise, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionExercise;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionExercise&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.exerciseId, _this.exerciseId) || other.exerciseId == _this.exerciseId)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.targetSets, _this.targetSets) || other.targetSets == _this.targetSets)&&(identical(other.targetRepsMin, _this.targetRepsMin) || other.targetRepsMin == _this.targetRepsMin)&&(identical(other.targetRepsMax, _this.targetRepsMax) || other.targetRepsMax == _this.targetRepsMax)&&(identical(other.restSeconds, _this.restSeconds) || other.restSeconds == _this.restSeconds)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&const DeepCollectionEquality().equals(other.sets, _this.sets));
}


@override
int get hashCode {
  final _this = this as SessionExercise;
  return Object.hash(runtimeType,_this.id,_this.sessionId,_this.exerciseId,_this.position,_this.targetSets,_this.targetRepsMin,_this.targetRepsMax,_this.restSeconds,_this.notes,const DeepCollectionEquality().hash(_this.sets));
}

@override
String toString() {
  final _this = this as SessionExercise;
  return 'SessionExercise(id: ${_this.id}, sessionId: ${_this.sessionId}, exerciseId: ${_this.exerciseId}, position: ${_this.position}, targetSets: ${_this.targetSets}, targetRepsMin: ${_this.targetRepsMin}, targetRepsMax: ${_this.targetRepsMax}, restSeconds: ${_this.restSeconds}, notes: ${_this.notes}, sets: ${_this.sets})';
}


}

/// @nodoc
abstract mixin class $SessionExerciseCopyWith<$Res>  {
  factory $SessionExerciseCopyWith(SessionExercise value, $Res Function(SessionExercise) _then) = _$SessionExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String sessionId, String exerciseId, int position, int? targetSets, int? targetRepsMin, int? targetRepsMax, int? restSeconds, String notes, List<SetEntry> sets
});




}
/// @nodoc
class _$SessionExerciseCopyWithImpl<$Res>
    implements $SessionExerciseCopyWith<$Res> {
  _$SessionExerciseCopyWithImpl(this._self, this._then);

  final SessionExercise _self;
  final $Res Function(SessionExercise) _then;

/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionId = null,Object? exerciseId = null,Object? position = null,Object? targetSets = freezed,Object? targetRepsMin = freezed,Object? targetRepsMax = freezed,Object? restSeconds = freezed,Object? notes = null,Object? sets = null,}) {
  return _then(SessionExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,targetSets: freezed == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMin: freezed == targetRepsMin ? _self.targetRepsMin : targetRepsMin // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,restSeconds: freezed == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionExercise].
extension SessionExercisePatterns on SessionExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionExercise value)  $default,){
final _that = this;
switch (_that) {
case _SessionExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionExercise value)?  $default,){
final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sessionId,  String exerciseId,  int position,  int? targetSets,  int? targetRepsMin,  int? targetRepsMax,  int? restSeconds,  String notes,  List<SetEntry> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
return $default(_that.id,_that.sessionId,_that.exerciseId,_that.position,_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.restSeconds,_that.notes,_that.sets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sessionId,  String exerciseId,  int position,  int? targetSets,  int? targetRepsMin,  int? targetRepsMax,  int? restSeconds,  String notes,  List<SetEntry> sets)  $default,) {final _that = this;
switch (_that) {
case _SessionExercise():
return $default(_that.id,_that.sessionId,_that.exerciseId,_that.position,_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.restSeconds,_that.notes,_that.sets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sessionId,  String exerciseId,  int position,  int? targetSets,  int? targetRepsMin,  int? targetRepsMax,  int? restSeconds,  String notes,  List<SetEntry> sets)?  $default,) {final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
return $default(_that.id,_that.sessionId,_that.exerciseId,_that.position,_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.restSeconds,_that.notes,_that.sets);case _:
  return null;

}
}

}

/// @nodoc


class _SessionExercise extends SessionExercise {
  const _SessionExercise({required this.id, required this.sessionId, required this.exerciseId, required this.position, this.targetSets, this.targetRepsMin, this.targetRepsMax, this.restSeconds, this.notes = '',  List<SetEntry> sets = const <SetEntry>[]}): _sets = sets,super._();
  

@override final  String id;
@override final  String sessionId;
@override final  String exerciseId;
@override final  int position;
/// Targets, `null` for exercises without a routine plan.
@override final  int? targetSets;
@override final  int? targetRepsMin;
@override final  int? targetRepsMax;
@override final  int? restSeconds;
@override@JsonKey() final  String notes;
/// Ordered by set number.
 final  List<SetEntry> _sets;
/// Ordered by set number.
@override@JsonKey() List<SetEntry> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionExerciseCopyWith<_SessionExercise> get copyWith => __$SessionExerciseCopyWithImpl<_SessionExercise>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.position, position) || other.position == position)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.targetRepsMin, targetRepsMin) || other.targetRepsMin == targetRepsMin)&&(identical(other.targetRepsMax, targetRepsMax) || other.targetRepsMax == targetRepsMax)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.sets, _sets));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,sessionId,exerciseId,position,targetSets,targetRepsMin,targetRepsMax,restSeconds,notes,const DeepCollectionEquality().hash(_sets));
}

@override
String toString() {
    return 'SessionExercise(id: $id, sessionId: $sessionId, exerciseId: $exerciseId, position: $position, targetSets: $targetSets, targetRepsMin: $targetRepsMin, targetRepsMax: $targetRepsMax, restSeconds: $restSeconds, notes: $notes, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$SessionExerciseCopyWith<$Res> implements $SessionExerciseCopyWith<$Res> {
  factory _$SessionExerciseCopyWith(_SessionExercise value, $Res Function(_SessionExercise) _then) = __$SessionExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionId, String exerciseId, int position, int? targetSets, int? targetRepsMin, int? targetRepsMax, int? restSeconds, String notes, List<SetEntry> sets
});




}
/// @nodoc
class __$SessionExerciseCopyWithImpl<$Res>
    implements _$SessionExerciseCopyWith<$Res> {
  __$SessionExerciseCopyWithImpl(this._self, this._then);

  final _SessionExercise _self;
  final $Res Function(_SessionExercise) _then;

/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionId = null,Object? exerciseId = null,Object? position = null,Object? targetSets = freezed,Object? targetRepsMin = freezed,Object? targetRepsMax = freezed,Object? restSeconds = freezed,Object? notes = null,Object? sets = null,}) {
  return _then(_SessionExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,targetSets: freezed == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMin: freezed == targetRepsMin ? _self.targetRepsMin : targetRepsMin // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,restSeconds: freezed == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetEntry>,
  ));
}


}

/// @nodoc
mixin _$SetEntry {

 String get id; String get sessionExerciseId;/// 1-based, contiguous within the exercise.
 int get setNumber;/// Always in kg, never rounded.
 double get weightKg; int get reps;/// Reps in reserve, optional.
 int? get rir; bool get isCompleted; DateTime? get completedAt;
/// Create a copy of SetEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetEntryCopyWith<SetEntry> get copyWith => _$SetEntryCopyWithImpl<SetEntry>(this as SetEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sessionExerciseId, _this.sessionExerciseId) || other.sessionExerciseId == _this.sessionExerciseId)&&(identical(other.setNumber, _this.setNumber) || other.setNumber == _this.setNumber)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg)&&(identical(other.reps, _this.reps) || other.reps == _this.reps)&&(identical(other.rir, _this.rir) || other.rir == _this.rir)&&(identical(other.isCompleted, _this.isCompleted) || other.isCompleted == _this.isCompleted)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt));
}


@override
int get hashCode {
  final _this = this as SetEntry;
  return Object.hash(runtimeType,_this.id,_this.sessionExerciseId,_this.setNumber,_this.weightKg,_this.reps,_this.rir,_this.isCompleted,_this.completedAt);
}

@override
String toString() {
  final _this = this as SetEntry;
  return 'SetEntry(id: ${_this.id}, sessionExerciseId: ${_this.sessionExerciseId}, setNumber: ${_this.setNumber}, weightKg: ${_this.weightKg}, reps: ${_this.reps}, rir: ${_this.rir}, isCompleted: ${_this.isCompleted}, completedAt: ${_this.completedAt})';
}


}

/// @nodoc
abstract mixin class $SetEntryCopyWith<$Res>  {
  factory $SetEntryCopyWith(SetEntry value, $Res Function(SetEntry) _then) = _$SetEntryCopyWithImpl;
@useResult
$Res call({
 String id, String sessionExerciseId, int setNumber, double weightKg, int reps, int? rir, bool isCompleted, DateTime? completedAt
});




}
/// @nodoc
class _$SetEntryCopyWithImpl<$Res>
    implements $SetEntryCopyWith<$Res> {
  _$SetEntryCopyWithImpl(this._self, this._then);

  final SetEntry _self;
  final $Res Function(SetEntry) _then;

/// Create a copy of SetEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionExerciseId = null,Object? setNumber = null,Object? weightKg = null,Object? reps = null,Object? rir = freezed,Object? isCompleted = null,Object? completedAt = freezed,}) {
  return _then(SetEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionExerciseId: null == sessionExerciseId ? _self.sessionExerciseId : sessionExerciseId // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,rir: freezed == rir ? _self.rir : rir // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SetEntry].
extension SetEntryPatterns on SetEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetEntry value)  $default,){
final _that = this;
switch (_that) {
case _SetEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetEntry value)?  $default,){
final _that = this;
switch (_that) {
case _SetEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sessionExerciseId,  int setNumber,  double weightKg,  int reps,  int? rir,  bool isCompleted,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetEntry() when $default != null:
return $default(_that.id,_that.sessionExerciseId,_that.setNumber,_that.weightKg,_that.reps,_that.rir,_that.isCompleted,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sessionExerciseId,  int setNumber,  double weightKg,  int reps,  int? rir,  bool isCompleted,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _SetEntry():
return $default(_that.id,_that.sessionExerciseId,_that.setNumber,_that.weightKg,_that.reps,_that.rir,_that.isCompleted,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sessionExerciseId,  int setNumber,  double weightKg,  int reps,  int? rir,  bool isCompleted,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _SetEntry() when $default != null:
return $default(_that.id,_that.sessionExerciseId,_that.setNumber,_that.weightKg,_that.reps,_that.rir,_that.isCompleted,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SetEntry implements SetEntry {
  const _SetEntry({required this.id, required this.sessionExerciseId, required this.setNumber, this.weightKg = 0, this.reps = 0, this.rir, this.isCompleted = false, this.completedAt});
  

@override final  String id;
@override final  String sessionExerciseId;
/// 1-based, contiguous within the exercise.
@override final  int setNumber;
/// Always in kg, never rounded.
@override@JsonKey() final  double weightKg;
@override@JsonKey() final  int reps;
/// Reps in reserve, optional.
@override final  int? rir;
@override@JsonKey() final  bool isCompleted;
@override final  DateTime? completedAt;

/// Create a copy of SetEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetEntryCopyWith<_SetEntry> get copyWith => __$SetEntryCopyWithImpl<_SetEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionExerciseId, sessionExerciseId) || other.sessionExerciseId == sessionExerciseId)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.rir, rir) || other.rir == rir)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,sessionExerciseId,setNumber,weightKg,reps,rir,isCompleted,completedAt);
}

@override
String toString() {
    return 'SetEntry(id: $id, sessionExerciseId: $sessionExerciseId, setNumber: $setNumber, weightKg: $weightKg, reps: $reps, rir: $rir, isCompleted: $isCompleted, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$SetEntryCopyWith<$Res> implements $SetEntryCopyWith<$Res> {
  factory _$SetEntryCopyWith(_SetEntry value, $Res Function(_SetEntry) _then) = __$SetEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionExerciseId, int setNumber, double weightKg, int reps, int? rir, bool isCompleted, DateTime? completedAt
});




}
/// @nodoc
class __$SetEntryCopyWithImpl<$Res>
    implements _$SetEntryCopyWith<$Res> {
  __$SetEntryCopyWithImpl(this._self, this._then);

  final _SetEntry _self;
  final $Res Function(_SetEntry) _then;

/// Create a copy of SetEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionExerciseId = null,Object? setNumber = null,Object? weightKg = null,Object? reps = null,Object? rir = freezed,Object? isCompleted = null,Object? completedAt = freezed,}) {
  return _then(_SetEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionExerciseId: null == sessionExerciseId ? _self.sessionExerciseId : sessionExerciseId // ignore: cast_nullable_to_non_nullable
as String,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,rir: freezed == rir ? _self.rir : rir // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
