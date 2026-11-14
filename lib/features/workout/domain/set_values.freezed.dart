// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_values.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetValues {

/// Always in kg.
 double get weightKg; int get reps; int? get rir;
/// Create a copy of SetValues
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetValuesCopyWith<SetValues> get copyWith => _$SetValuesCopyWithImpl<SetValues>(this as SetValues, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetValues;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetValues&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg)&&(identical(other.reps, _this.reps) || other.reps == _this.reps)&&(identical(other.rir, _this.rir) || other.rir == _this.rir));
}


@override
int get hashCode {
  final _this = this as SetValues;
  return Object.hash(runtimeType,_this.weightKg,_this.reps,_this.rir);
}

@override
String toString() {
  final _this = this as SetValues;
  return 'SetValues(weightKg: ${_this.weightKg}, reps: ${_this.reps}, rir: ${_this.rir})';
}


}

/// @nodoc
abstract mixin class $SetValuesCopyWith<$Res>  {
  factory $SetValuesCopyWith(SetValues value, $Res Function(SetValues) _then) = _$SetValuesCopyWithImpl;
@useResult
$Res call({
 double weightKg, int reps, int? rir
});




}
/// @nodoc
class _$SetValuesCopyWithImpl<$Res>
    implements $SetValuesCopyWith<$Res> {
  _$SetValuesCopyWithImpl(this._self, this._then);

  final SetValues _self;
  final $Res Function(SetValues) _then;

/// Create a copy of SetValues
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weightKg = null,Object? reps = null,Object? rir = freezed,}) {
  return _then(SetValues(
weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,rir: freezed == rir ? _self.rir : rir // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SetValues].
extension SetValuesPatterns on SetValues {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetValues value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetValues() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetValues value)  $default,){
final _that = this;
switch (_that) {
case _SetValues():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetValues value)?  $default,){
final _that = this;
switch (_that) {
case _SetValues() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double weightKg,  int reps,  int? rir)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetValues() when $default != null:
return $default(_that.weightKg,_that.reps,_that.rir);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double weightKg,  int reps,  int? rir)  $default,) {final _that = this;
switch (_that) {
case _SetValues():
return $default(_that.weightKg,_that.reps,_that.rir);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double weightKg,  int reps,  int? rir)?  $default,) {final _that = this;
switch (_that) {
case _SetValues() when $default != null:
return $default(_that.weightKg,_that.reps,_that.rir);case _:
  return null;

}
}

}

/// @nodoc


class _SetValues extends SetValues {
  const _SetValues({this.weightKg = 0, this.reps = 0, this.rir}): super._();
  

/// Always in kg.
@override@JsonKey() final  double weightKg;
@override@JsonKey() final  int reps;
@override final  int? rir;

/// Create a copy of SetValues
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetValuesCopyWith<_SetValues> get copyWith => __$SetValuesCopyWithImpl<_SetValues>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetValues&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.rir, rir) || other.rir == rir));
}


@override
int get hashCode {
    return Object.hash(runtimeType,weightKg,reps,rir);
}

@override
String toString() {
    return 'SetValues(weightKg: $weightKg, reps: $reps, rir: $rir)';
}


}

/// @nodoc
abstract mixin class _$SetValuesCopyWith<$Res> implements $SetValuesCopyWith<$Res> {
  factory _$SetValuesCopyWith(_SetValues value, $Res Function(_SetValues) _then) = __$SetValuesCopyWithImpl;
@override @useResult
$Res call({
 double weightKg, int reps, int? rir
});




}
/// @nodoc
class __$SetValuesCopyWithImpl<$Res>
    implements _$SetValuesCopyWith<$Res> {
  __$SetValuesCopyWithImpl(this._self, this._then);

  final _SetValues _self;
  final $Res Function(_SetValues) _then;

/// Create a copy of SetValues
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weightKg = null,Object? reps = null,Object? rir = freezed,}) {
  return _then(_SetValues(
weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,rir: freezed == rir ? _self.rir : rir // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
