// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyMeasurement {

 String get id;/// Calendar date (UTC midnight).
 DateTime get date; double? get waistCm; double? get chestCm; double? get armCm; double? get legCm; double? get hipCm; double? get bodyFatPct;
/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyMeasurementCopyWith<BodyMeasurement> get copyWith => _$BodyMeasurementCopyWithImpl<BodyMeasurement>(this as BodyMeasurement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BodyMeasurement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyMeasurement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.waistCm, _this.waistCm) || other.waistCm == _this.waistCm)&&(identical(other.chestCm, _this.chestCm) || other.chestCm == _this.chestCm)&&(identical(other.armCm, _this.armCm) || other.armCm == _this.armCm)&&(identical(other.legCm, _this.legCm) || other.legCm == _this.legCm)&&(identical(other.hipCm, _this.hipCm) || other.hipCm == _this.hipCm)&&(identical(other.bodyFatPct, _this.bodyFatPct) || other.bodyFatPct == _this.bodyFatPct));
}


@override
int get hashCode {
  final _this = this as BodyMeasurement;
  return Object.hash(runtimeType,_this.id,_this.date,_this.waistCm,_this.chestCm,_this.armCm,_this.legCm,_this.hipCm,_this.bodyFatPct);
}

@override
String toString() {
  final _this = this as BodyMeasurement;
  return 'BodyMeasurement(id: ${_this.id}, date: ${_this.date}, waistCm: ${_this.waistCm}, chestCm: ${_this.chestCm}, armCm: ${_this.armCm}, legCm: ${_this.legCm}, hipCm: ${_this.hipCm}, bodyFatPct: ${_this.bodyFatPct})';
}


}

/// @nodoc
abstract mixin class $BodyMeasurementCopyWith<$Res>  {
  factory $BodyMeasurementCopyWith(BodyMeasurement value, $Res Function(BodyMeasurement) _then) = _$BodyMeasurementCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, double? waistCm, double? chestCm, double? armCm, double? legCm, double? hipCm, double? bodyFatPct
});




}
/// @nodoc
class _$BodyMeasurementCopyWithImpl<$Res>
    implements $BodyMeasurementCopyWith<$Res> {
  _$BodyMeasurementCopyWithImpl(this._self, this._then);

  final BodyMeasurement _self;
  final $Res Function(BodyMeasurement) _then;

/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? waistCm = freezed,Object? chestCm = freezed,Object? armCm = freezed,Object? legCm = freezed,Object? hipCm = freezed,Object? bodyFatPct = freezed,}) {
  return _then(BodyMeasurement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,waistCm: freezed == waistCm ? _self.waistCm : waistCm // ignore: cast_nullable_to_non_nullable
as double?,chestCm: freezed == chestCm ? _self.chestCm : chestCm // ignore: cast_nullable_to_non_nullable
as double?,armCm: freezed == armCm ? _self.armCm : armCm // ignore: cast_nullable_to_non_nullable
as double?,legCm: freezed == legCm ? _self.legCm : legCm // ignore: cast_nullable_to_non_nullable
as double?,hipCm: freezed == hipCm ? _self.hipCm : hipCm // ignore: cast_nullable_to_non_nullable
as double?,bodyFatPct: freezed == bodyFatPct ? _self.bodyFatPct : bodyFatPct // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyMeasurement].
extension BodyMeasurementPatterns on BodyMeasurement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyMeasurement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyMeasurement value)  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyMeasurement value)?  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  double? waistCm,  double? chestCm,  double? armCm,  double? legCm,  double? hipCm,  double? bodyFatPct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
return $default(_that.id,_that.date,_that.waistCm,_that.chestCm,_that.armCm,_that.legCm,_that.hipCm,_that.bodyFatPct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  double? waistCm,  double? chestCm,  double? armCm,  double? legCm,  double? hipCm,  double? bodyFatPct)  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurement():
return $default(_that.id,_that.date,_that.waistCm,_that.chestCm,_that.armCm,_that.legCm,_that.hipCm,_that.bodyFatPct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  double? waistCm,  double? chestCm,  double? armCm,  double? legCm,  double? hipCm,  double? bodyFatPct)?  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
return $default(_that.id,_that.date,_that.waistCm,_that.chestCm,_that.armCm,_that.legCm,_that.hipCm,_that.bodyFatPct);case _:
  return null;

}
}

}

/// @nodoc


class _BodyMeasurement implements BodyMeasurement {
  const _BodyMeasurement({required this.id, required this.date, this.waistCm, this.chestCm, this.armCm, this.legCm, this.hipCm, this.bodyFatPct});
  

@override final  String id;
/// Calendar date (UTC midnight).
@override final  DateTime date;
@override final  double? waistCm;
@override final  double? chestCm;
@override final  double? armCm;
@override final  double? legCm;
@override final  double? hipCm;
@override final  double? bodyFatPct;

/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyMeasurementCopyWith<_BodyMeasurement> get copyWith => __$BodyMeasurementCopyWithImpl<_BodyMeasurement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyMeasurement&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.waistCm, waistCm) || other.waistCm == waistCm)&&(identical(other.chestCm, chestCm) || other.chestCm == chestCm)&&(identical(other.armCm, armCm) || other.armCm == armCm)&&(identical(other.legCm, legCm) || other.legCm == legCm)&&(identical(other.hipCm, hipCm) || other.hipCm == hipCm)&&(identical(other.bodyFatPct, bodyFatPct) || other.bodyFatPct == bodyFatPct));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,date,waistCm,chestCm,armCm,legCm,hipCm,bodyFatPct);
}

@override
String toString() {
    return 'BodyMeasurement(id: $id, date: $date, waistCm: $waistCm, chestCm: $chestCm, armCm: $armCm, legCm: $legCm, hipCm: $hipCm, bodyFatPct: $bodyFatPct)';
}


}

/// @nodoc
abstract mixin class _$BodyMeasurementCopyWith<$Res> implements $BodyMeasurementCopyWith<$Res> {
  factory _$BodyMeasurementCopyWith(_BodyMeasurement value, $Res Function(_BodyMeasurement) _then) = __$BodyMeasurementCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, double? waistCm, double? chestCm, double? armCm, double? legCm, double? hipCm, double? bodyFatPct
});




}
/// @nodoc
class __$BodyMeasurementCopyWithImpl<$Res>
    implements _$BodyMeasurementCopyWith<$Res> {
  __$BodyMeasurementCopyWithImpl(this._self, this._then);

  final _BodyMeasurement _self;
  final $Res Function(_BodyMeasurement) _then;

/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? waistCm = freezed,Object? chestCm = freezed,Object? armCm = freezed,Object? legCm = freezed,Object? hipCm = freezed,Object? bodyFatPct = freezed,}) {
  return _then(_BodyMeasurement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,waistCm: freezed == waistCm ? _self.waistCm : waistCm // ignore: cast_nullable_to_non_nullable
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
