// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_weight_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyWeightEntry {

 String get id;/// Calendar date (UTC midnight).
 DateTime get date; double get weightKg;
/// Create a copy of BodyWeightEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyWeightEntryCopyWith<BodyWeightEntry> get copyWith => _$BodyWeightEntryCopyWithImpl<BodyWeightEntry>(this as BodyWeightEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BodyWeightEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyWeightEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg));
}


@override
int get hashCode {
  final _this = this as BodyWeightEntry;
  return Object.hash(runtimeType,_this.id,_this.date,_this.weightKg);
}

@override
String toString() {
  final _this = this as BodyWeightEntry;
  return 'BodyWeightEntry(id: ${_this.id}, date: ${_this.date}, weightKg: ${_this.weightKg})';
}


}

/// @nodoc
abstract mixin class $BodyWeightEntryCopyWith<$Res>  {
  factory $BodyWeightEntryCopyWith(BodyWeightEntry value, $Res Function(BodyWeightEntry) _then) = _$BodyWeightEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, double weightKg
});




}
/// @nodoc
class _$BodyWeightEntryCopyWithImpl<$Res>
    implements $BodyWeightEntryCopyWith<$Res> {
  _$BodyWeightEntryCopyWithImpl(this._self, this._then);

  final BodyWeightEntry _self;
  final $Res Function(BodyWeightEntry) _then;

/// Create a copy of BodyWeightEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? weightKg = null,}) {
  return _then(BodyWeightEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyWeightEntry].
extension BodyWeightEntryPatterns on BodyWeightEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyWeightEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyWeightEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyWeightEntry value)  $default,){
final _that = this;
switch (_that) {
case _BodyWeightEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyWeightEntry value)?  $default,){
final _that = this;
switch (_that) {
case _BodyWeightEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  double weightKg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyWeightEntry() when $default != null:
return $default(_that.id,_that.date,_that.weightKg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  double weightKg)  $default,) {final _that = this;
switch (_that) {
case _BodyWeightEntry():
return $default(_that.id,_that.date,_that.weightKg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  double weightKg)?  $default,) {final _that = this;
switch (_that) {
case _BodyWeightEntry() when $default != null:
return $default(_that.id,_that.date,_that.weightKg);case _:
  return null;

}
}

}

/// @nodoc


class _BodyWeightEntry implements BodyWeightEntry {
  const _BodyWeightEntry({required this.id, required this.date, required this.weightKg});
  

@override final  String id;
/// Calendar date (UTC midnight).
@override final  DateTime date;
@override final  double weightKg;

/// Create a copy of BodyWeightEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyWeightEntryCopyWith<_BodyWeightEntry> get copyWith => __$BodyWeightEntryCopyWithImpl<_BodyWeightEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyWeightEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,date,weightKg);
}

@override
String toString() {
    return 'BodyWeightEntry(id: $id, date: $date, weightKg: $weightKg)';
}


}

/// @nodoc
abstract mixin class _$BodyWeightEntryCopyWith<$Res> implements $BodyWeightEntryCopyWith<$Res> {
  factory _$BodyWeightEntryCopyWith(_BodyWeightEntry value, $Res Function(_BodyWeightEntry) _then) = __$BodyWeightEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, double weightKg
});




}
/// @nodoc
class __$BodyWeightEntryCopyWithImpl<$Res>
    implements _$BodyWeightEntryCopyWith<$Res> {
  __$BodyWeightEntryCopyWithImpl(this._self, this._then);

  final _BodyWeightEntry _self;
  final $Res Function(_BodyWeightEntry) _then;

/// Create a copy of BodyWeightEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? weightKg = null,}) {
  return _then(_BodyWeightEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
