// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_drafts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoutineDraft {

 String get name; String get notes;
/// Create a copy of RoutineDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineDraftCopyWith<RoutineDraft> get copyWith => _$RoutineDraftCopyWithImpl<RoutineDraft>(this as RoutineDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineDraft&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}


@override
int get hashCode {
  final _this = this as RoutineDraft;
  return Object.hash(runtimeType,_this.name,_this.notes);
}

@override
String toString() {
  final _this = this as RoutineDraft;
  return 'RoutineDraft(name: ${_this.name}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $RoutineDraftCopyWith<$Res>  {
  factory $RoutineDraftCopyWith(RoutineDraft value, $Res Function(RoutineDraft) _then) = _$RoutineDraftCopyWithImpl;
@useResult
$Res call({
 String name, String notes
});




}
/// @nodoc
class _$RoutineDraftCopyWithImpl<$Res>
    implements $RoutineDraftCopyWith<$Res> {
  _$RoutineDraftCopyWithImpl(this._self, this._then);

  final RoutineDraft _self;
  final $Res Function(RoutineDraft) _then;

/// Create a copy of RoutineDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? notes = null,}) {
  return _then(RoutineDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineDraft].
extension RoutineDraftPatterns on RoutineDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineDraft value)  $default,){
final _that = this;
switch (_that) {
case _RoutineDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineDraft value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineDraft() when $default != null:
return $default(_that.name,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String notes)  $default,) {final _that = this;
switch (_that) {
case _RoutineDraft():
return $default(_that.name,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _RoutineDraft() when $default != null:
return $default(_that.name,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineDraft extends RoutineDraft {
  const _RoutineDraft({this.name = '', this.notes = ''}): super._();
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String notes;

/// Create a copy of RoutineDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineDraftCopyWith<_RoutineDraft> get copyWith => __$RoutineDraftCopyWithImpl<_RoutineDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineDraft&&(identical(other.name, name) || other.name == name)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,notes);
}

@override
String toString() {
    return 'RoutineDraft(name: $name, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$RoutineDraftCopyWith<$Res> implements $RoutineDraftCopyWith<$Res> {
  factory _$RoutineDraftCopyWith(_RoutineDraft value, $Res Function(_RoutineDraft) _then) = __$RoutineDraftCopyWithImpl;
@override @useResult
$Res call({
 String name, String notes
});




}
/// @nodoc
class __$RoutineDraftCopyWithImpl<$Res>
    implements _$RoutineDraftCopyWith<$Res> {
  __$RoutineDraftCopyWithImpl(this._self, this._then);

  final _RoutineDraft _self;
  final $Res Function(_RoutineDraft) _then;

/// Create a copy of RoutineDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? notes = null,}) {
  return _then(_RoutineDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RoutineDayDraft {

 String get name;/// ISO weekday (1 = Monday), or `null` when not scheduled.
 int? get weekday;
/// Create a copy of RoutineDayDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineDayDraftCopyWith<RoutineDayDraft> get copyWith => _$RoutineDayDraftCopyWithImpl<RoutineDayDraft>(this as RoutineDayDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineDayDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineDayDraft&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday));
}


@override
int get hashCode {
  final _this = this as RoutineDayDraft;
  return Object.hash(runtimeType,_this.name,_this.weekday);
}

@override
String toString() {
  final _this = this as RoutineDayDraft;
  return 'RoutineDayDraft(name: ${_this.name}, weekday: ${_this.weekday})';
}


}

/// @nodoc
abstract mixin class $RoutineDayDraftCopyWith<$Res>  {
  factory $RoutineDayDraftCopyWith(RoutineDayDraft value, $Res Function(RoutineDayDraft) _then) = _$RoutineDayDraftCopyWithImpl;
@useResult
$Res call({
 String name, int? weekday
});




}
/// @nodoc
class _$RoutineDayDraftCopyWithImpl<$Res>
    implements $RoutineDayDraftCopyWith<$Res> {
  _$RoutineDayDraftCopyWithImpl(this._self, this._then);

  final RoutineDayDraft _self;
  final $Res Function(RoutineDayDraft) _then;

/// Create a copy of RoutineDayDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? weekday = freezed,}) {
  return _then(RoutineDayDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weekday: freezed == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineDayDraft].
extension RoutineDayDraftPatterns on RoutineDayDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineDayDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineDayDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineDayDraft value)  $default,){
final _that = this;
switch (_that) {
case _RoutineDayDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineDayDraft value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineDayDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int? weekday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineDayDraft() when $default != null:
return $default(_that.name,_that.weekday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int? weekday)  $default,) {final _that = this;
switch (_that) {
case _RoutineDayDraft():
return $default(_that.name,_that.weekday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int? weekday)?  $default,) {final _that = this;
switch (_that) {
case _RoutineDayDraft() when $default != null:
return $default(_that.name,_that.weekday);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineDayDraft extends RoutineDayDraft {
  const _RoutineDayDraft({this.name = '', this.weekday}): super._();
  

@override@JsonKey() final  String name;
/// ISO weekday (1 = Monday), or `null` when not scheduled.
@override final  int? weekday;

/// Create a copy of RoutineDayDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineDayDraftCopyWith<_RoutineDayDraft> get copyWith => __$RoutineDayDraftCopyWithImpl<_RoutineDayDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineDayDraft&&(identical(other.name, name) || other.name == name)&&(identical(other.weekday, weekday) || other.weekday == weekday));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,weekday);
}

@override
String toString() {
    return 'RoutineDayDraft(name: $name, weekday: $weekday)';
}


}

/// @nodoc
abstract mixin class _$RoutineDayDraftCopyWith<$Res> implements $RoutineDayDraftCopyWith<$Res> {
  factory _$RoutineDayDraftCopyWith(_RoutineDayDraft value, $Res Function(_RoutineDayDraft) _then) = __$RoutineDayDraftCopyWithImpl;
@override @useResult
$Res call({
 String name, int? weekday
});




}
/// @nodoc
class __$RoutineDayDraftCopyWithImpl<$Res>
    implements _$RoutineDayDraftCopyWith<$Res> {
  __$RoutineDayDraftCopyWithImpl(this._self, this._then);

  final _RoutineDayDraft _self;
  final $Res Function(_RoutineDayDraft) _then;

/// Create a copy of RoutineDayDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? weekday = freezed,}) {
  return _then(_RoutineDayDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weekday: freezed == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$RoutineExerciseDraft {

 int? get targetSets; int? get targetRepsMin; int? get targetRepsMax;/// Always in kg; the form converts from the exercise's unit.
 double? get initialWeightKg; int? get restSeconds; String get notes;
/// Create a copy of RoutineExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineExerciseDraftCopyWith<RoutineExerciseDraft> get copyWith => _$RoutineExerciseDraftCopyWithImpl<RoutineExerciseDraft>(this as RoutineExerciseDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineExerciseDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineExerciseDraft&&(identical(other.targetSets, _this.targetSets) || other.targetSets == _this.targetSets)&&(identical(other.targetRepsMin, _this.targetRepsMin) || other.targetRepsMin == _this.targetRepsMin)&&(identical(other.targetRepsMax, _this.targetRepsMax) || other.targetRepsMax == _this.targetRepsMax)&&(identical(other.initialWeightKg, _this.initialWeightKg) || other.initialWeightKg == _this.initialWeightKg)&&(identical(other.restSeconds, _this.restSeconds) || other.restSeconds == _this.restSeconds)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}


@override
int get hashCode {
  final _this = this as RoutineExerciseDraft;
  return Object.hash(runtimeType,_this.targetSets,_this.targetRepsMin,_this.targetRepsMax,_this.initialWeightKg,_this.restSeconds,_this.notes);
}

@override
String toString() {
  final _this = this as RoutineExerciseDraft;
  return 'RoutineExerciseDraft(targetSets: ${_this.targetSets}, targetRepsMin: ${_this.targetRepsMin}, targetRepsMax: ${_this.targetRepsMax}, initialWeightKg: ${_this.initialWeightKg}, restSeconds: ${_this.restSeconds}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $RoutineExerciseDraftCopyWith<$Res>  {
  factory $RoutineExerciseDraftCopyWith(RoutineExerciseDraft value, $Res Function(RoutineExerciseDraft) _then) = _$RoutineExerciseDraftCopyWithImpl;
@useResult
$Res call({
 int? targetSets, int? targetRepsMin, int? targetRepsMax, double? initialWeightKg, int? restSeconds, String notes
});




}
/// @nodoc
class _$RoutineExerciseDraftCopyWithImpl<$Res>
    implements $RoutineExerciseDraftCopyWith<$Res> {
  _$RoutineExerciseDraftCopyWithImpl(this._self, this._then);

  final RoutineExerciseDraft _self;
  final $Res Function(RoutineExerciseDraft) _then;

/// Create a copy of RoutineExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetSets = freezed,Object? targetRepsMin = freezed,Object? targetRepsMax = freezed,Object? initialWeightKg = freezed,Object? restSeconds = freezed,Object? notes = null,}) {
  return _then(RoutineExerciseDraft(
targetSets: freezed == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMin: freezed == targetRepsMin ? _self.targetRepsMin : targetRepsMin // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,initialWeightKg: freezed == initialWeightKg ? _self.initialWeightKg : initialWeightKg // ignore: cast_nullable_to_non_nullable
as double?,restSeconds: freezed == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineExerciseDraft].
extension RoutineExerciseDraftPatterns on RoutineExerciseDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineExerciseDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineExerciseDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineExerciseDraft value)  $default,){
final _that = this;
switch (_that) {
case _RoutineExerciseDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineExerciseDraft value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineExerciseDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? targetSets,  int? targetRepsMin,  int? targetRepsMax,  double? initialWeightKg,  int? restSeconds,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineExerciseDraft() when $default != null:
return $default(_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.initialWeightKg,_that.restSeconds,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? targetSets,  int? targetRepsMin,  int? targetRepsMax,  double? initialWeightKg,  int? restSeconds,  String notes)  $default,) {final _that = this;
switch (_that) {
case _RoutineExerciseDraft():
return $default(_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.initialWeightKg,_that.restSeconds,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? targetSets,  int? targetRepsMin,  int? targetRepsMax,  double? initialWeightKg,  int? restSeconds,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _RoutineExerciseDraft() when $default != null:
return $default(_that.targetSets,_that.targetRepsMin,_that.targetRepsMax,_that.initialWeightKg,_that.restSeconds,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineExerciseDraft extends RoutineExerciseDraft {
  const _RoutineExerciseDraft({this.targetSets, this.targetRepsMin, this.targetRepsMax, this.initialWeightKg, this.restSeconds, this.notes = ''}): super._();
  

@override final  int? targetSets;
@override final  int? targetRepsMin;
@override final  int? targetRepsMax;
/// Always in kg; the form converts from the exercise's unit.
@override final  double? initialWeightKg;
@override final  int? restSeconds;
@override@JsonKey() final  String notes;

/// Create a copy of RoutineExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineExerciseDraftCopyWith<_RoutineExerciseDraft> get copyWith => __$RoutineExerciseDraftCopyWithImpl<_RoutineExerciseDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineExerciseDraft&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.targetRepsMin, targetRepsMin) || other.targetRepsMin == targetRepsMin)&&(identical(other.targetRepsMax, targetRepsMax) || other.targetRepsMax == targetRepsMax)&&(identical(other.initialWeightKg, initialWeightKg) || other.initialWeightKg == initialWeightKg)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,targetSets,targetRepsMin,targetRepsMax,initialWeightKg,restSeconds,notes);
}

@override
String toString() {
    return 'RoutineExerciseDraft(targetSets: $targetSets, targetRepsMin: $targetRepsMin, targetRepsMax: $targetRepsMax, initialWeightKg: $initialWeightKg, restSeconds: $restSeconds, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$RoutineExerciseDraftCopyWith<$Res> implements $RoutineExerciseDraftCopyWith<$Res> {
  factory _$RoutineExerciseDraftCopyWith(_RoutineExerciseDraft value, $Res Function(_RoutineExerciseDraft) _then) = __$RoutineExerciseDraftCopyWithImpl;
@override @useResult
$Res call({
 int? targetSets, int? targetRepsMin, int? targetRepsMax, double? initialWeightKg, int? restSeconds, String notes
});




}
/// @nodoc
class __$RoutineExerciseDraftCopyWithImpl<$Res>
    implements _$RoutineExerciseDraftCopyWith<$Res> {
  __$RoutineExerciseDraftCopyWithImpl(this._self, this._then);

  final _RoutineExerciseDraft _self;
  final $Res Function(_RoutineExerciseDraft) _then;

/// Create a copy of RoutineExerciseDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetSets = freezed,Object? targetRepsMin = freezed,Object? targetRepsMax = freezed,Object? initialWeightKg = freezed,Object? restSeconds = freezed,Object? notes = null,}) {
  return _then(_RoutineExerciseDraft(
targetSets: freezed == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMin: freezed == targetRepsMin ? _self.targetRepsMin : targetRepsMin // ignore: cast_nullable_to_non_nullable
as int?,targetRepsMax: freezed == targetRepsMax ? _self.targetRepsMax : targetRepsMax // ignore: cast_nullable_to_non_nullable
as int?,initialWeightKg: freezed == initialWeightKg ? _self.initialWeightKg : initialWeightKg // ignore: cast_nullable_to_non_nullable
as double?,restSeconds: freezed == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
