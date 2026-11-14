// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_weight_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyWeightDraft {

/// Calendar date (UTC midnight).
 DateTime? get date; double? get weightKg;
/// Create a copy of BodyWeightDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyWeightDraftCopyWith<BodyWeightDraft> get copyWith => _$BodyWeightDraftCopyWithImpl<BodyWeightDraft>(this as BodyWeightDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BodyWeightDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyWeightDraft&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg));
}


@override
int get hashCode {
  final _this = this as BodyWeightDraft;
  return Object.hash(runtimeType,_this.date,_this.weightKg);
}

@override
String toString() {
  final _this = this as BodyWeightDraft;
  return 'BodyWeightDraft(date: ${_this.date}, weightKg: ${_this.weightKg})';
}


}

/// @nodoc
abstract mixin class $BodyWeightDraftCopyWith<$Res>  {
  factory $BodyWeightDraftCopyWith(BodyWeightDraft value, $Res Function(BodyWeightDraft) _then) = _$BodyWeightDraftCopyWithImpl;
@useResult
$Res call({
 DateTime? date, double? weightKg
});




}
/// @nodoc
class _$BodyWeightDraftCopyWithImpl<$Res>
    implements $BodyWeightDraftCopyWith<$Res> {
  _$BodyWeightDraftCopyWithImpl(this._self, this._then);

  final BodyWeightDraft _self;
  final $Res Function(BodyWeightDraft) _then;

/// Create a copy of BodyWeightDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? weightKg = freezed,}) {
  return _then(BodyWeightDraft(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyWeightDraft].
extension BodyWeightDraftPatterns on BodyWeightDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyWeightDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyWeightDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyWeightDraft value)  $default,){
final _that = this;
switch (_that) {
case _BodyWeightDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyWeightDraft value)?  $default,){
final _that = this;
switch (_that) {
case _BodyWeightDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? date,  double? weightKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyWeightDraft() when $default != null:
return $default(_that.date,_that.weightKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? date,  double? weightKg)  $default,) {final _that = this;
switch (_that) {
case _BodyWeightDraft():
return $default(_that.date,_that.weightKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? date,  double? weightKg)?  $default,) {final _that = this;
switch (_that) {
case _BodyWeightDraft() when $default != null:
return $default(_that.date,_that.weightKg);case _:
  return null;

}
}

}

/// @nodoc


class _BodyWeightDraft extends BodyWeightDraft {
  const _BodyWeightDraft({this.date, this.weightKg}): super._();
  

/// Calendar date (UTC midnight).
@override final  DateTime? date;
@override final  double? weightKg;

/// Create a copy of BodyWeightDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyWeightDraftCopyWith<_BodyWeightDraft> get copyWith => __$BodyWeightDraftCopyWithImpl<_BodyWeightDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyWeightDraft&&(identical(other.date, date) || other.date == date)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,weightKg);
}

@override
String toString() {
    return 'BodyWeightDraft(date: $date, weightKg: $weightKg)';
}


}

/// @nodoc
abstract mixin class _$BodyWeightDraftCopyWith<$Res> implements $BodyWeightDraftCopyWith<$Res> {
  factory _$BodyWeightDraftCopyWith(_BodyWeightDraft value, $Res Function(_BodyWeightDraft) _then) = __$BodyWeightDraftCopyWithImpl;
@override @useResult
$Res call({
 DateTime? date, double? weightKg
});




}
/// @nodoc
class __$BodyWeightDraftCopyWithImpl<$Res>
    implements _$BodyWeightDraftCopyWith<$Res> {
  __$BodyWeightDraftCopyWithImpl(this._self, this._then);

  final _BodyWeightDraft _self;
  final $Res Function(_BodyWeightDraft) _then;

/// Create a copy of BodyWeightDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? weightKg = freezed,}) {
  return _then(_BodyWeightDraft(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
