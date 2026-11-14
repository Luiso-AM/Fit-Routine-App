// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_performance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExercisePerformance {

 String get sessionId; String get exerciseId; DateTime get performedAt; List<SetEntry> get sets;
/// Create a copy of ExercisePerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExercisePerformanceCopyWith<ExercisePerformance> get copyWith => _$ExercisePerformanceCopyWithImpl<ExercisePerformance>(this as ExercisePerformance, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExercisePerformance;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExercisePerformance&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.exerciseId, _this.exerciseId) || other.exerciseId == _this.exerciseId)&&(identical(other.performedAt, _this.performedAt) || other.performedAt == _this.performedAt)&&const DeepCollectionEquality().equals(other.sets, _this.sets));
}


@override
int get hashCode {
  final _this = this as ExercisePerformance;
  return Object.hash(runtimeType,_this.sessionId,_this.exerciseId,_this.performedAt,const DeepCollectionEquality().hash(_this.sets));
}

@override
String toString() {
  final _this = this as ExercisePerformance;
  return 'ExercisePerformance(sessionId: ${_this.sessionId}, exerciseId: ${_this.exerciseId}, performedAt: ${_this.performedAt}, sets: ${_this.sets})';
}


}

/// @nodoc
abstract mixin class $ExercisePerformanceCopyWith<$Res>  {
  factory $ExercisePerformanceCopyWith(ExercisePerformance value, $Res Function(ExercisePerformance) _then) = _$ExercisePerformanceCopyWithImpl;
@useResult
$Res call({
 String sessionId, String exerciseId, DateTime performedAt, List<SetEntry> sets
});




}
/// @nodoc
class _$ExercisePerformanceCopyWithImpl<$Res>
    implements $ExercisePerformanceCopyWith<$Res> {
  _$ExercisePerformanceCopyWithImpl(this._self, this._then);

  final ExercisePerformance _self;
  final $Res Function(ExercisePerformance) _then;

/// Create a copy of ExercisePerformance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? exerciseId = null,Object? performedAt = null,Object? sets = null,}) {
  return _then(ExercisePerformance(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,performedAt: null == performedAt ? _self.performedAt : performedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExercisePerformance].
extension ExercisePerformancePatterns on ExercisePerformance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExercisePerformance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExercisePerformance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExercisePerformance value)  $default,){
final _that = this;
switch (_that) {
case _ExercisePerformance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExercisePerformance value)?  $default,){
final _that = this;
switch (_that) {
case _ExercisePerformance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String exerciseId,  DateTime performedAt,  List<SetEntry> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExercisePerformance() when $default != null:
return $default(_that.sessionId,_that.exerciseId,_that.performedAt,_that.sets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String exerciseId,  DateTime performedAt,  List<SetEntry> sets)  $default,) {final _that = this;
switch (_that) {
case _ExercisePerformance():
return $default(_that.sessionId,_that.exerciseId,_that.performedAt,_that.sets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String exerciseId,  DateTime performedAt,  List<SetEntry> sets)?  $default,) {final _that = this;
switch (_that) {
case _ExercisePerformance() when $default != null:
return $default(_that.sessionId,_that.exerciseId,_that.performedAt,_that.sets);case _:
  return null;

}
}

}

/// @nodoc


class _ExercisePerformance extends ExercisePerformance {
  const _ExercisePerformance({required this.sessionId, required this.exerciseId, required this.performedAt, required  List<SetEntry> sets}): _sets = sets,super._();
  

@override final  String sessionId;
@override final  String exerciseId;
@override final  DateTime performedAt;
 final  List<SetEntry> _sets;
@override List<SetEntry> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of ExercisePerformance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExercisePerformanceCopyWith<_ExercisePerformance> get copyWith => __$ExercisePerformanceCopyWithImpl<_ExercisePerformance>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExercisePerformance&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.performedAt, performedAt) || other.performedAt == performedAt)&&const DeepCollectionEquality().equals(other.sets, _sets));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,exerciseId,performedAt,const DeepCollectionEquality().hash(_sets));
}

@override
String toString() {
    return 'ExercisePerformance(sessionId: $sessionId, exerciseId: $exerciseId, performedAt: $performedAt, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$ExercisePerformanceCopyWith<$Res> implements $ExercisePerformanceCopyWith<$Res> {
  factory _$ExercisePerformanceCopyWith(_ExercisePerformance value, $Res Function(_ExercisePerformance) _then) = __$ExercisePerformanceCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String exerciseId, DateTime performedAt, List<SetEntry> sets
});




}
/// @nodoc
class __$ExercisePerformanceCopyWithImpl<$Res>
    implements _$ExercisePerformanceCopyWith<$Res> {
  __$ExercisePerformanceCopyWithImpl(this._self, this._then);

  final _ExercisePerformance _self;
  final $Res Function(_ExercisePerformance) _then;

/// Create a copy of ExercisePerformance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? exerciseId = null,Object? performedAt = null,Object? sets = null,}) {
  return _then(_ExercisePerformance(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,performedAt: null == performedAt ? _self.performedAt : performedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetEntry>,
  ));
}


}

/// @nodoc
mixin _$SetGroup {

 int get count; int get reps; double get weightKg;
/// Create a copy of SetGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetGroupCopyWith<SetGroup> get copyWith => _$SetGroupCopyWithImpl<SetGroup>(this as SetGroup, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetGroup;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetGroup&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.reps, _this.reps) || other.reps == _this.reps)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg));
}


@override
int get hashCode {
  final _this = this as SetGroup;
  return Object.hash(runtimeType,_this.count,_this.reps,_this.weightKg);
}

@override
String toString() {
  final _this = this as SetGroup;
  return 'SetGroup(count: ${_this.count}, reps: ${_this.reps}, weightKg: ${_this.weightKg})';
}


}

/// @nodoc
abstract mixin class $SetGroupCopyWith<$Res>  {
  factory $SetGroupCopyWith(SetGroup value, $Res Function(SetGroup) _then) = _$SetGroupCopyWithImpl;
@useResult
$Res call({
 int count, int reps, double weightKg
});




}
/// @nodoc
class _$SetGroupCopyWithImpl<$Res>
    implements $SetGroupCopyWith<$Res> {
  _$SetGroupCopyWithImpl(this._self, this._then);

  final SetGroup _self;
  final $Res Function(SetGroup) _then;

/// Create a copy of SetGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? reps = null,Object? weightKg = null,}) {
  return _then(SetGroup(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SetGroup].
extension SetGroupPatterns on SetGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetGroup value)  $default,){
final _that = this;
switch (_that) {
case _SetGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetGroup value)?  $default,){
final _that = this;
switch (_that) {
case _SetGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int reps,  double weightKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetGroup() when $default != null:
return $default(_that.count,_that.reps,_that.weightKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int reps,  double weightKg)  $default,) {final _that = this;
switch (_that) {
case _SetGroup():
return $default(_that.count,_that.reps,_that.weightKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int reps,  double weightKg)?  $default,) {final _that = this;
switch (_that) {
case _SetGroup() when $default != null:
return $default(_that.count,_that.reps,_that.weightKg);case _:
  return null;

}
}

}

/// @nodoc


class _SetGroup implements SetGroup {
  const _SetGroup({required this.count, required this.reps, required this.weightKg});
  

@override final  int count;
@override final  int reps;
@override final  double weightKg;

/// Create a copy of SetGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetGroupCopyWith<_SetGroup> get copyWith => __$SetGroupCopyWithImpl<_SetGroup>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetGroup&&(identical(other.count, count) || other.count == count)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg));
}


@override
int get hashCode {
    return Object.hash(runtimeType,count,reps,weightKg);
}

@override
String toString() {
    return 'SetGroup(count: $count, reps: $reps, weightKg: $weightKg)';
}


}

/// @nodoc
abstract mixin class _$SetGroupCopyWith<$Res> implements $SetGroupCopyWith<$Res> {
  factory _$SetGroupCopyWith(_SetGroup value, $Res Function(_SetGroup) _then) = __$SetGroupCopyWithImpl;
@override @useResult
$Res call({
 int count, int reps, double weightKg
});




}
/// @nodoc
class __$SetGroupCopyWithImpl<$Res>
    implements _$SetGroupCopyWith<$Res> {
  __$SetGroupCopyWithImpl(this._self, this._then);

  final _SetGroup _self;
  final $Res Function(_SetGroup) _then;

/// Create a copy of SetGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? reps = null,Object? weightKg = null,}) {
  return _then(_SetGroup(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
