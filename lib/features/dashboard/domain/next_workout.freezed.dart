// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'next_workout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NextWorkout {

 Routine get routine; RoutineDay get day;/// Calendar date the day is scheduled for, or `null` when it was
/// picked by following the routine's order.
 DateTime? get date;
/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextWorkoutCopyWith<NextWorkout> get copyWith => _$NextWorkoutCopyWithImpl<NextWorkout>(this as NextWorkout, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NextWorkout;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextWorkout&&(identical(other.routine, _this.routine) || other.routine == _this.routine)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.date, _this.date) || other.date == _this.date));
}


@override
int get hashCode {
  final _this = this as NextWorkout;
  return Object.hash(runtimeType,_this.routine,_this.day,_this.date);
}

@override
String toString() {
  final _this = this as NextWorkout;
  return 'NextWorkout(routine: ${_this.routine}, day: ${_this.day}, date: ${_this.date})';
}


}

/// @nodoc
abstract mixin class $NextWorkoutCopyWith<$Res>  {
  factory $NextWorkoutCopyWith(NextWorkout value, $Res Function(NextWorkout) _then) = _$NextWorkoutCopyWithImpl;
@useResult
$Res call({
 Routine routine, RoutineDay day, DateTime? date
});


$RoutineCopyWith<$Res> get routine;$RoutineDayCopyWith<$Res> get day;

}
/// @nodoc
class _$NextWorkoutCopyWithImpl<$Res>
    implements $NextWorkoutCopyWith<$Res> {
  _$NextWorkoutCopyWithImpl(this._self, this._then);

  final NextWorkout _self;
  final $Res Function(NextWorkout) _then;

/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routine = null,Object? day = null,Object? date = freezed,}) {
  return _then(NextWorkout(
routine: null == routine ? _self.routine : routine // ignore: cast_nullable_to_non_nullable
as Routine,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as RoutineDay,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineCopyWith<$Res> get routine {
  
  return $RoutineCopyWith<$Res>(_self.routine, (value) {
    return _then(_self.copyWith(routine: value));
  });
}/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineDayCopyWith<$Res> get day {
  
  return $RoutineDayCopyWith<$Res>(_self.day, (value) {
    return _then(_self.copyWith(day: value));
  });
}
}


/// Adds pattern-matching-related methods to [NextWorkout].
extension NextWorkoutPatterns on NextWorkout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextWorkout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextWorkout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextWorkout value)  $default,){
final _that = this;
switch (_that) {
case _NextWorkout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextWorkout value)?  $default,){
final _that = this;
switch (_that) {
case _NextWorkout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Routine routine,  RoutineDay day,  DateTime? date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NextWorkout() when $default != null:
return $default(_that.routine,_that.day,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Routine routine,  RoutineDay day,  DateTime? date)  $default,) {final _that = this;
switch (_that) {
case _NextWorkout():
return $default(_that.routine,_that.day,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Routine routine,  RoutineDay day,  DateTime? date)?  $default,) {final _that = this;
switch (_that) {
case _NextWorkout() when $default != null:
return $default(_that.routine,_that.day,_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _NextWorkout implements NextWorkout {
  const _NextWorkout({required this.routine, required this.day, this.date});
  

@override final  Routine routine;
@override final  RoutineDay day;
/// Calendar date the day is scheduled for, or `null` when it was
/// picked by following the routine's order.
@override final  DateTime? date;

/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextWorkoutCopyWith<_NextWorkout> get copyWith => __$NextWorkoutCopyWithImpl<_NextWorkout>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextWorkout&&(identical(other.routine, routine) || other.routine == routine)&&(identical(other.day, day) || other.day == day)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode {
    return Object.hash(runtimeType,routine,day,date);
}

@override
String toString() {
    return 'NextWorkout(routine: $routine, day: $day, date: $date)';
}


}

/// @nodoc
abstract mixin class _$NextWorkoutCopyWith<$Res> implements $NextWorkoutCopyWith<$Res> {
  factory _$NextWorkoutCopyWith(_NextWorkout value, $Res Function(_NextWorkout) _then) = __$NextWorkoutCopyWithImpl;
@override @useResult
$Res call({
 Routine routine, RoutineDay day, DateTime? date
});


@override $RoutineCopyWith<$Res> get routine;@override $RoutineDayCopyWith<$Res> get day;

}
/// @nodoc
class __$NextWorkoutCopyWithImpl<$Res>
    implements _$NextWorkoutCopyWith<$Res> {
  __$NextWorkoutCopyWithImpl(this._self, this._then);

  final _NextWorkout _self;
  final $Res Function(_NextWorkout) _then;

/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routine = null,Object? day = null,Object? date = freezed,}) {
  return _then(_NextWorkout(
routine: null == routine ? _self.routine : routine // ignore: cast_nullable_to_non_nullable
as Routine,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as RoutineDay,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineCopyWith<$Res> get routine {
  
  return $RoutineCopyWith<$Res>(_self.routine, (value) {
    return _then(_self.copyWith(routine: value));
  });
}/// Create a copy of NextWorkout
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineDayCopyWith<$Res> get day {
  
  return $RoutineDayCopyWith<$Res>(_self.day, (value) {
    return _then(_self.copyWith(day: value));
  });
}
}

// dart format on
