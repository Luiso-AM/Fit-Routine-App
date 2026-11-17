// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionTotals {

 Duration get duration;/// Session exercises with at least one completed set.
 int get exercises; int get sets; int get reps;/// Always in kg.
 double get volumeKg;
/// Create a copy of SessionTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionTotalsCopyWith<SessionTotals> get copyWith => _$SessionTotalsCopyWithImpl<SessionTotals>(this as SessionTotals, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionTotals;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionTotals&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.exercises, _this.exercises) || other.exercises == _this.exercises)&&(identical(other.sets, _this.sets) || other.sets == _this.sets)&&(identical(other.reps, _this.reps) || other.reps == _this.reps)&&(identical(other.volumeKg, _this.volumeKg) || other.volumeKg == _this.volumeKg));
}


@override
int get hashCode {
  final _this = this as SessionTotals;
  return Object.hash(runtimeType,_this.duration,_this.exercises,_this.sets,_this.reps,_this.volumeKg);
}

@override
String toString() {
  final _this = this as SessionTotals;
  return 'SessionTotals(duration: ${_this.duration}, exercises: ${_this.exercises}, sets: ${_this.sets}, reps: ${_this.reps}, volumeKg: ${_this.volumeKg})';
}


}

/// @nodoc
abstract mixin class $SessionTotalsCopyWith<$Res>  {
  factory $SessionTotalsCopyWith(SessionTotals value, $Res Function(SessionTotals) _then) = _$SessionTotalsCopyWithImpl;
@useResult
$Res call({
 Duration duration, int exercises, int sets, int reps, double volumeKg
});




}
/// @nodoc
class _$SessionTotalsCopyWithImpl<$Res>
    implements $SessionTotalsCopyWith<$Res> {
  _$SessionTotalsCopyWithImpl(this._self, this._then);

  final SessionTotals _self;
  final $Res Function(SessionTotals) _then;

/// Create a copy of SessionTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? duration = null,Object? exercises = null,Object? sets = null,Object? reps = null,Object? volumeKg = null,}) {
  return _then(SessionTotals(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,volumeKg: null == volumeKg ? _self.volumeKg : volumeKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionTotals].
extension SessionTotalsPatterns on SessionTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionTotals value)  $default,){
final _that = this;
switch (_that) {
case _SessionTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionTotals value)?  $default,){
final _that = this;
switch (_that) {
case _SessionTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration duration,  int exercises,  int sets,  int reps,  double volumeKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionTotals() when $default != null:
return $default(_that.duration,_that.exercises,_that.sets,_that.reps,_that.volumeKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration duration,  int exercises,  int sets,  int reps,  double volumeKg)  $default,) {final _that = this;
switch (_that) {
case _SessionTotals():
return $default(_that.duration,_that.exercises,_that.sets,_that.reps,_that.volumeKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration duration,  int exercises,  int sets,  int reps,  double volumeKg)?  $default,) {final _that = this;
switch (_that) {
case _SessionTotals() when $default != null:
return $default(_that.duration,_that.exercises,_that.sets,_that.reps,_that.volumeKg);case _:
  return null;

}
}

}

/// @nodoc


class _SessionTotals implements SessionTotals {
  const _SessionTotals({required this.duration, required this.exercises, required this.sets, required this.reps, required this.volumeKg});
  

@override final  Duration duration;
/// Session exercises with at least one completed set.
@override final  int exercises;
@override final  int sets;
@override final  int reps;
/// Always in kg.
@override final  double volumeKg;

/// Create a copy of SessionTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionTotalsCopyWith<_SessionTotals> get copyWith => __$SessionTotalsCopyWithImpl<_SessionTotals>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionTotals&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.exercises, exercises) || other.exercises == exercises)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.volumeKg, volumeKg) || other.volumeKg == volumeKg));
}


@override
int get hashCode {
    return Object.hash(runtimeType,duration,exercises,sets,reps,volumeKg);
}

@override
String toString() {
    return 'SessionTotals(duration: $duration, exercises: $exercises, sets: $sets, reps: $reps, volumeKg: $volumeKg)';
}


}

/// @nodoc
abstract mixin class _$SessionTotalsCopyWith<$Res> implements $SessionTotalsCopyWith<$Res> {
  factory _$SessionTotalsCopyWith(_SessionTotals value, $Res Function(_SessionTotals) _then) = __$SessionTotalsCopyWithImpl;
@override @useResult
$Res call({
 Duration duration, int exercises, int sets, int reps, double volumeKg
});




}
/// @nodoc
class __$SessionTotalsCopyWithImpl<$Res>
    implements _$SessionTotalsCopyWith<$Res> {
  __$SessionTotalsCopyWithImpl(this._self, this._then);

  final _SessionTotals _self;
  final $Res Function(_SessionTotals) _then;

/// Create a copy of SessionTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? duration = null,Object? exercises = null,Object? sets = null,Object? reps = null,Object? volumeKg = null,}) {
  return _then(_SessionTotals(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,volumeKg: null == volumeKg ? _self.volumeKg : volumeKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SessionComparison {

 String get previousSessionId; DateTime get previousStartedAt; Duration get durationDelta; int get exercisesDelta; int get setsDelta; int get repsDelta;/// Always in kg.
 double get volumeDeltaKg;
/// Create a copy of SessionComparison
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionComparisonCopyWith<SessionComparison> get copyWith => _$SessionComparisonCopyWithImpl<SessionComparison>(this as SessionComparison, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionComparison;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionComparison&&(identical(other.previousSessionId, _this.previousSessionId) || other.previousSessionId == _this.previousSessionId)&&(identical(other.previousStartedAt, _this.previousStartedAt) || other.previousStartedAt == _this.previousStartedAt)&&(identical(other.durationDelta, _this.durationDelta) || other.durationDelta == _this.durationDelta)&&(identical(other.exercisesDelta, _this.exercisesDelta) || other.exercisesDelta == _this.exercisesDelta)&&(identical(other.setsDelta, _this.setsDelta) || other.setsDelta == _this.setsDelta)&&(identical(other.repsDelta, _this.repsDelta) || other.repsDelta == _this.repsDelta)&&(identical(other.volumeDeltaKg, _this.volumeDeltaKg) || other.volumeDeltaKg == _this.volumeDeltaKg));
}


@override
int get hashCode {
  final _this = this as SessionComparison;
  return Object.hash(runtimeType,_this.previousSessionId,_this.previousStartedAt,_this.durationDelta,_this.exercisesDelta,_this.setsDelta,_this.repsDelta,_this.volumeDeltaKg);
}

@override
String toString() {
  final _this = this as SessionComparison;
  return 'SessionComparison(previousSessionId: ${_this.previousSessionId}, previousStartedAt: ${_this.previousStartedAt}, durationDelta: ${_this.durationDelta}, exercisesDelta: ${_this.exercisesDelta}, setsDelta: ${_this.setsDelta}, repsDelta: ${_this.repsDelta}, volumeDeltaKg: ${_this.volumeDeltaKg})';
}


}

/// @nodoc
abstract mixin class $SessionComparisonCopyWith<$Res>  {
  factory $SessionComparisonCopyWith(SessionComparison value, $Res Function(SessionComparison) _then) = _$SessionComparisonCopyWithImpl;
@useResult
$Res call({
 String previousSessionId, DateTime previousStartedAt, Duration durationDelta, int exercisesDelta, int setsDelta, int repsDelta, double volumeDeltaKg
});




}
/// @nodoc
class _$SessionComparisonCopyWithImpl<$Res>
    implements $SessionComparisonCopyWith<$Res> {
  _$SessionComparisonCopyWithImpl(this._self, this._then);

  final SessionComparison _self;
  final $Res Function(SessionComparison) _then;

/// Create a copy of SessionComparison
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? previousSessionId = null,Object? previousStartedAt = null,Object? durationDelta = null,Object? exercisesDelta = null,Object? setsDelta = null,Object? repsDelta = null,Object? volumeDeltaKg = null,}) {
  return _then(SessionComparison(
previousSessionId: null == previousSessionId ? _self.previousSessionId : previousSessionId // ignore: cast_nullable_to_non_nullable
as String,previousStartedAt: null == previousStartedAt ? _self.previousStartedAt : previousStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationDelta: null == durationDelta ? _self.durationDelta : durationDelta // ignore: cast_nullable_to_non_nullable
as Duration,exercisesDelta: null == exercisesDelta ? _self.exercisesDelta : exercisesDelta // ignore: cast_nullable_to_non_nullable
as int,setsDelta: null == setsDelta ? _self.setsDelta : setsDelta // ignore: cast_nullable_to_non_nullable
as int,repsDelta: null == repsDelta ? _self.repsDelta : repsDelta // ignore: cast_nullable_to_non_nullable
as int,volumeDeltaKg: null == volumeDeltaKg ? _self.volumeDeltaKg : volumeDeltaKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionComparison].
extension SessionComparisonPatterns on SessionComparison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionComparison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionComparison() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionComparison value)  $default,){
final _that = this;
switch (_that) {
case _SessionComparison():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionComparison value)?  $default,){
final _that = this;
switch (_that) {
case _SessionComparison() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String previousSessionId,  DateTime previousStartedAt,  Duration durationDelta,  int exercisesDelta,  int setsDelta,  int repsDelta,  double volumeDeltaKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionComparison() when $default != null:
return $default(_that.previousSessionId,_that.previousStartedAt,_that.durationDelta,_that.exercisesDelta,_that.setsDelta,_that.repsDelta,_that.volumeDeltaKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String previousSessionId,  DateTime previousStartedAt,  Duration durationDelta,  int exercisesDelta,  int setsDelta,  int repsDelta,  double volumeDeltaKg)  $default,) {final _that = this;
switch (_that) {
case _SessionComparison():
return $default(_that.previousSessionId,_that.previousStartedAt,_that.durationDelta,_that.exercisesDelta,_that.setsDelta,_that.repsDelta,_that.volumeDeltaKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String previousSessionId,  DateTime previousStartedAt,  Duration durationDelta,  int exercisesDelta,  int setsDelta,  int repsDelta,  double volumeDeltaKg)?  $default,) {final _that = this;
switch (_that) {
case _SessionComparison() when $default != null:
return $default(_that.previousSessionId,_that.previousStartedAt,_that.durationDelta,_that.exercisesDelta,_that.setsDelta,_that.repsDelta,_that.volumeDeltaKg);case _:
  return null;

}
}

}

/// @nodoc


class _SessionComparison implements SessionComparison {
  const _SessionComparison({required this.previousSessionId, required this.previousStartedAt, required this.durationDelta, required this.exercisesDelta, required this.setsDelta, required this.repsDelta, required this.volumeDeltaKg});
  

@override final  String previousSessionId;
@override final  DateTime previousStartedAt;
@override final  Duration durationDelta;
@override final  int exercisesDelta;
@override final  int setsDelta;
@override final  int repsDelta;
/// Always in kg.
@override final  double volumeDeltaKg;

/// Create a copy of SessionComparison
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionComparisonCopyWith<_SessionComparison> get copyWith => __$SessionComparisonCopyWithImpl<_SessionComparison>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionComparison&&(identical(other.previousSessionId, previousSessionId) || other.previousSessionId == previousSessionId)&&(identical(other.previousStartedAt, previousStartedAt) || other.previousStartedAt == previousStartedAt)&&(identical(other.durationDelta, durationDelta) || other.durationDelta == durationDelta)&&(identical(other.exercisesDelta, exercisesDelta) || other.exercisesDelta == exercisesDelta)&&(identical(other.setsDelta, setsDelta) || other.setsDelta == setsDelta)&&(identical(other.repsDelta, repsDelta) || other.repsDelta == repsDelta)&&(identical(other.volumeDeltaKg, volumeDeltaKg) || other.volumeDeltaKg == volumeDeltaKg));
}


@override
int get hashCode {
    return Object.hash(runtimeType,previousSessionId,previousStartedAt,durationDelta,exercisesDelta,setsDelta,repsDelta,volumeDeltaKg);
}

@override
String toString() {
    return 'SessionComparison(previousSessionId: $previousSessionId, previousStartedAt: $previousStartedAt, durationDelta: $durationDelta, exercisesDelta: $exercisesDelta, setsDelta: $setsDelta, repsDelta: $repsDelta, volumeDeltaKg: $volumeDeltaKg)';
}


}

/// @nodoc
abstract mixin class _$SessionComparisonCopyWith<$Res> implements $SessionComparisonCopyWith<$Res> {
  factory _$SessionComparisonCopyWith(_SessionComparison value, $Res Function(_SessionComparison) _then) = __$SessionComparisonCopyWithImpl;
@override @useResult
$Res call({
 String previousSessionId, DateTime previousStartedAt, Duration durationDelta, int exercisesDelta, int setsDelta, int repsDelta, double volumeDeltaKg
});




}
/// @nodoc
class __$SessionComparisonCopyWithImpl<$Res>
    implements _$SessionComparisonCopyWith<$Res> {
  __$SessionComparisonCopyWithImpl(this._self, this._then);

  final _SessionComparison _self;
  final $Res Function(_SessionComparison) _then;

/// Create a copy of SessionComparison
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? previousSessionId = null,Object? previousStartedAt = null,Object? durationDelta = null,Object? exercisesDelta = null,Object? setsDelta = null,Object? repsDelta = null,Object? volumeDeltaKg = null,}) {
  return _then(_SessionComparison(
previousSessionId: null == previousSessionId ? _self.previousSessionId : previousSessionId // ignore: cast_nullable_to_non_nullable
as String,previousStartedAt: null == previousStartedAt ? _self.previousStartedAt : previousStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationDelta: null == durationDelta ? _self.durationDelta : durationDelta // ignore: cast_nullable_to_non_nullable
as Duration,exercisesDelta: null == exercisesDelta ? _self.exercisesDelta : exercisesDelta // ignore: cast_nullable_to_non_nullable
as int,setsDelta: null == setsDelta ? _self.setsDelta : setsDelta // ignore: cast_nullable_to_non_nullable
as int,repsDelta: null == repsDelta ? _self.repsDelta : repsDelta // ignore: cast_nullable_to_non_nullable
as int,volumeDeltaKg: null == volumeDeltaKg ? _self.volumeDeltaKg : volumeDeltaKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SessionSummary {

 WorkoutSession get session; SessionTotals get totals;/// The completed sets of each session exercise, in session order.
/// Exercises without completed sets are left out.
 List<ExercisePerformance> get exercises;/// Against the previous session of the same routine day, if any.
 SessionComparison? get comparison;
/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSummaryCopyWith<SessionSummary> get copyWith => _$SessionSummaryCopyWithImpl<SessionSummary>(this as SessionSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSummary&&(identical(other.session, _this.session) || other.session == _this.session)&&(identical(other.totals, _this.totals) || other.totals == _this.totals)&&const DeepCollectionEquality().equals(other.exercises, _this.exercises)&&(identical(other.comparison, _this.comparison) || other.comparison == _this.comparison));
}


@override
int get hashCode {
  final _this = this as SessionSummary;
  return Object.hash(runtimeType,_this.session,_this.totals,const DeepCollectionEquality().hash(_this.exercises),_this.comparison);
}

@override
String toString() {
  final _this = this as SessionSummary;
  return 'SessionSummary(session: ${_this.session}, totals: ${_this.totals}, exercises: ${_this.exercises}, comparison: ${_this.comparison})';
}


}

/// @nodoc
abstract mixin class $SessionSummaryCopyWith<$Res>  {
  factory $SessionSummaryCopyWith(SessionSummary value, $Res Function(SessionSummary) _then) = _$SessionSummaryCopyWithImpl;
@useResult
$Res call({
 WorkoutSession session, SessionTotals totals, List<ExercisePerformance> exercises, SessionComparison? comparison
});


$WorkoutSessionCopyWith<$Res> get session;$SessionTotalsCopyWith<$Res> get totals;$SessionComparisonCopyWith<$Res>? get comparison;

}
/// @nodoc
class _$SessionSummaryCopyWithImpl<$Res>
    implements $SessionSummaryCopyWith<$Res> {
  _$SessionSummaryCopyWithImpl(this._self, this._then);

  final SessionSummary _self;
  final $Res Function(SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? totals = null,Object? exercises = null,Object? comparison = freezed,}) {
  return _then(SessionSummary(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WorkoutSession,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as SessionTotals,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExercisePerformance>,comparison: freezed == comparison ? _self.comparison : comparison // ignore: cast_nullable_to_non_nullable
as SessionComparison?,
  ));
}
/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutSessionCopyWith<$Res> get session {
  
  return $WorkoutSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionTotalsCopyWith<$Res> get totals {
  
  return $SessionTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionComparisonCopyWith<$Res>? get comparison {
    if (_self.comparison == null) {
    return null;
  }

  return $SessionComparisonCopyWith<$Res>(_self.comparison!, (value) {
    return _then(_self.copyWith(comparison: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionSummary].
extension SessionSummaryPatterns on SessionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionSummary value)  $default,){
final _that = this;
switch (_that) {
case _SessionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WorkoutSession session,  SessionTotals totals,  List<ExercisePerformance> exercises,  SessionComparison? comparison)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.session,_that.totals,_that.exercises,_that.comparison);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WorkoutSession session,  SessionTotals totals,  List<ExercisePerformance> exercises,  SessionComparison? comparison)  $default,) {final _that = this;
switch (_that) {
case _SessionSummary():
return $default(_that.session,_that.totals,_that.exercises,_that.comparison);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WorkoutSession session,  SessionTotals totals,  List<ExercisePerformance> exercises,  SessionComparison? comparison)?  $default,) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.session,_that.totals,_that.exercises,_that.comparison);case _:
  return null;

}
}

}

/// @nodoc


class _SessionSummary implements SessionSummary {
  const _SessionSummary({required this.session, required this.totals, required  List<ExercisePerformance> exercises, this.comparison}): _exercises = exercises;
  

@override final  WorkoutSession session;
@override final  SessionTotals totals;
/// The completed sets of each session exercise, in session order.
/// Exercises without completed sets are left out.
 final  List<ExercisePerformance> _exercises;
/// The completed sets of each session exercise, in session order.
/// Exercises without completed sets are left out.
@override List<ExercisePerformance> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

/// Against the previous session of the same routine day, if any.
@override final  SessionComparison? comparison;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionSummaryCopyWith<_SessionSummary> get copyWith => __$SessionSummaryCopyWithImpl<_SessionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionSummary&&(identical(other.session, session) || other.session == session)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other.exercises, _exercises)&&(identical(other.comparison, comparison) || other.comparison == comparison));
}


@override
int get hashCode {
    return Object.hash(runtimeType,session,totals,const DeepCollectionEquality().hash(_exercises),comparison);
}

@override
String toString() {
    return 'SessionSummary(session: $session, totals: $totals, exercises: $exercises, comparison: $comparison)';
}


}

/// @nodoc
abstract mixin class _$SessionSummaryCopyWith<$Res> implements $SessionSummaryCopyWith<$Res> {
  factory _$SessionSummaryCopyWith(_SessionSummary value, $Res Function(_SessionSummary) _then) = __$SessionSummaryCopyWithImpl;
@override @useResult
$Res call({
 WorkoutSession session, SessionTotals totals, List<ExercisePerformance> exercises, SessionComparison? comparison
});


@override $WorkoutSessionCopyWith<$Res> get session;@override $SessionTotalsCopyWith<$Res> get totals;@override $SessionComparisonCopyWith<$Res>? get comparison;

}
/// @nodoc
class __$SessionSummaryCopyWithImpl<$Res>
    implements _$SessionSummaryCopyWith<$Res> {
  __$SessionSummaryCopyWithImpl(this._self, this._then);

  final _SessionSummary _self;
  final $Res Function(_SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? totals = null,Object? exercises = null,Object? comparison = freezed,}) {
  return _then(_SessionSummary(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as WorkoutSession,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as SessionTotals,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExercisePerformance>,comparison: freezed == comparison ? _self.comparison : comparison // ignore: cast_nullable_to_non_nullable
as SessionComparison?,
  ));
}

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutSessionCopyWith<$Res> get session {
  
  return $WorkoutSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionTotalsCopyWith<$Res> get totals {
  
  return $SessionTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionComparisonCopyWith<$Res>? get comparison {
    if (_self.comparison == null) {
    return null;
  }

  return $SessionComparisonCopyWith<$Res>(_self.comparison!, (value) {
    return _then(_self.copyWith(comparison: value));
  });
}
}

// dart format on
