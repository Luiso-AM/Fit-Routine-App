// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_measurement_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyMeasurementDraft {

/// Calendar date (UTC midnight).
 DateTime? get date; double? get waistCm; double? get chestCm; double? get armCm; double? get legCm; double? get hipCm; double? get bodyFatPct;
/// Create a copy of BodyMeasurementDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyMeasurementDraftCopyWith<BodyMeasurementDraft> get copyWith => _$BodyMeasurementDraftCopyWithImpl<BodyMeasurementDraft>(this as BodyMeasurementDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BodyMeasurementDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyMeasurementDraft&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.waistCm, _this.waistCm) || other.waistCm == _this.waistCm)&&(identical(other.chestCm, _this.chestCm) || other.chestCm == _this.chestCm)&&(identical(other.armCm, _this.armCm) || other.armCm == _this.armCm)&&(identical(other.legCm, _this.legCm) || other.legCm == _this.legCm)&&(identical(other.hipCm, _this.hipCm) || other.hipCm == _this.hipCm)&&(identical(other.bodyFatPct, _this.bodyFatPct) || other.bodyFatPct == _this.bodyFatPct));
}


@override
int get hashCode {
  final _this = this as BodyMeasurementDraft;
  return Object.hash(runtimeType,_this.date,_this.waistCm,_this.chestCm,_this.armCm,_this.legCm,_this.hipCm,_this.bodyFatPct);
}

@override
String toString() {
  final _this = this as BodyMeasurementDraft;
  return 'BodyMeasurementDraft(date: ${_this.date}, waistCm: ${_this.waistCm}, chestCm: ${_this.chestCm}, armCm: ${_this.armCm}, legCm: ${_this.legCm}, hipCm: ${_this.hipCm}, bodyFatPct: ${_this.bodyFatPct})';
}


}

/// @nodoc
abstract mixin class $BodyMeasurementDraftCopyWith<$Res>  {
  factory $BodyMeasurementDraftCopyWith(BodyMeasurementDraft value, $Res Function(BodyMeasurementDraft) _then) = _$BodyMeasurementDraftCopyWithImpl;
@useResult
$Res call({
 DateTime? date, double? waistCm, double? chestCm, double? armCm, double? legCm, double? hipCm, double? bodyFatPct
});




}
/// @nodoc
class _$BodyMeasurementDraftCopyWithImpl<$Res>
    implements $BodyMeasurementDraftCopyWith<$Res> {
  _$BodyMeasurementDraftCopyWithImpl(this._self, this._then);

  final BodyMeasurementDraft _self;
  final $Res Function(BodyMeasurementDraft) _then;

/// Create a copy of BodyMeasurementDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? waistCm = freezed,Object? chestCm = freezed,Object? armCm = freezed,Object? legCm = freezed,Object? hipCm = freezed,Object? bodyFatPct = freezed,}) {
  return _then(BodyMeasurementDraft(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,waistCm: freezed == waistCm ? _self.waistCm : waistCm // ignore: cast_nullable_to_non_nullable
as double?,chestCm: freezed == chestCm ? _self.chestCm : chestCm // ignore: cast_nullable_to_non_nullable
as double?,armCm: freezed == armCm ? _self.armCm : armCm // ignore: cast_nullable_to_non_nullable
as double?,legCm: freezed == legCm ? _self.legCm : legCm // ignore: cast_nullable_to_non_nullable
as double?,hipCm: freezed == hipCm ? _self.hipCm : hipCm // ignore: cast_nullable_to_non_nullable
as double?,bodyFatPct: freezed == bodyFatPct ? _self.bodyFatPct : bodyFatPct // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyMeasurementDraft].
extension BodyMeasurementDraftPatterns on BodyMeasurementDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyMeasurementDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyMeasurementDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyMeasurementDraft value)  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurementDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyMeasurementDraft value)?  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurementDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? date,  double? waistCm,  double? chestCm,  double? armCm,  double? legCm,  double? hipCm,  double? bodyFatPct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyMeasurementDraft() when $default != null:
return $default(_that.date,_that.waistCm,_that.chestCm,_that.armCm,_that.legCm,_that.hipCm,_that.bodyFatPct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? date,  double? waistCm,  double? chestCm,  double? armCm,  double? legCm,  double? hipCm,  double? bodyFatPct)  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurementDraft():
return $default(_that.date,_that.waistCm,_that.chestCm,_that.armCm,_that.legCm,_that.hipCm,_that.bodyFatPct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? date,  double? waistCm,  double? chestCm,  double? armCm,  double? legCm,  double? hipCm,  double? bodyFatPct)?  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurementDraft() when $default != null:
return $default(_that.date,_that.waistCm,_that.chestCm,_that.armCm,_that.legCm,_that.hipCm,_that.bodyFatPct);case _:
  return null;

}
}

}

/// @nodoc


class _BodyMeasurementDraft extends BodyMeasurementDraft {
  const _BodyMeasurementDraft({this.date, this.waistCm, this.chestCm, this.armCm, this.legCm, this.hipCm, this.bodyFatPct}): super._();
  

/// Calendar date (UTC midnight).
@override final  DateTime? date;
@override final  double? waistCm;
@override final  double? chestCm;
@override final  double? armCm;
@override final  double? legCm;
@override final  double? hipCm;
@override final  double? bodyFatPct;

/// Create a copy of BodyMeasurementDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyMeasurementDraftCopyWith<_BodyMeasurementDraft> get copyWith => __$BodyMeasurementDraftCopyWithImpl<_BodyMeasurementDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyMeasurementDraft&&(identical(other.date, date) || other.date == date)&&(identical(other.waistCm, waistCm) || other.waistCm == waistCm)&&(identical(other.chestCm, chestCm) || other.chestCm == chestCm)&&(identical(other.armCm, armCm) || other.armCm == armCm)&&(identical(other.legCm, legCm) || other.legCm == legCm)&&(identical(other.hipCm, hipCm) || other.hipCm == hipCm)&&(identical(other.bodyFatPct, bodyFatPct) || other.bodyFatPct == bodyFatPct));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,waistCm,chestCm,armCm,legCm,hipCm,bodyFatPct);
}

@override
String toString() {
    return 'BodyMeasurementDraft(date: $date, waistCm: $waistCm, chestCm: $chestCm, armCm: $armCm, legCm: $legCm, hipCm: $hipCm, bodyFatPct: $bodyFatPct)';
}


}

/// @nodoc
abstract mixin class _$BodyMeasurementDraftCopyWith<$Res> implements $BodyMeasurementDraftCopyWith<$Res> {
  factory _$BodyMeasurementDraftCopyWith(_BodyMeasurementDraft value, $Res Function(_BodyMeasurementDraft) _then) = __$BodyMeasurementDraftCopyWithImpl;
@override @useResult
$Res call({
 DateTime? date, double? waistCm, double? chestCm, double? armCm, double? legCm, double? hipCm, double? bodyFatPct
});




}
/// @nodoc
class __$BodyMeasurementDraftCopyWithImpl<$Res>
    implements _$BodyMeasurementDraftCopyWith<$Res> {
  __$BodyMeasurementDraftCopyWithImpl(this._self, this._then);

  final _BodyMeasurementDraft _self;
  final $Res Function(_BodyMeasurementDraft) _then;

/// Create a copy of BodyMeasurementDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? waistCm = freezed,Object? chestCm = freezed,Object? armCm = freezed,Object? legCm = freezed,Object? hipCm = freezed,Object? bodyFatPct = freezed,}) {
  return _then(_BodyMeasurementDraft(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,waistCm: freezed == waistCm ? _self.waistCm : waistCm // ignore: cast_nullable_to_non_nullable
as double?,chestCm: freezed == chestCm ? _self.chestCm : chestCm // ignore: cast_nullable_to_non_nullable
as double?,armCm: freezed == armCm ? _self.armCm : armCm // ignore: cast_nullable_to_non_nullable
as double?,legCm: freezed == legCm ? _self.legCm : legCm // ignore: cast_nullable_to_non_nullable
as double?,hipCm: freezed == hipCm ? _self.hipCm : hipCm // ignore: cast_nullable_to_non_nullable
as double?,bodyFatPct: freezed == bodyFatPct ? _self.bodyFatPct : bodyFatPct // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
