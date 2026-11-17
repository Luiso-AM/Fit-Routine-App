// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weight_trend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeightTrend {

 BodyWeightEntry get latest;/// The latest entry at least [minimumGap] older than [latest], if any.
 BodyWeightEntry? get reference;
/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeightTrendCopyWith<WeightTrend> get copyWith => _$WeightTrendCopyWithImpl<WeightTrend>(this as WeightTrend, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WeightTrend;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightTrend&&(identical(other.latest, _this.latest) || other.latest == _this.latest)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}


@override
int get hashCode {
  final _this = this as WeightTrend;
  return Object.hash(runtimeType,_this.latest,_this.reference);
}

@override
String toString() {
  final _this = this as WeightTrend;
  return 'WeightTrend(latest: ${_this.latest}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $WeightTrendCopyWith<$Res>  {
  factory $WeightTrendCopyWith(WeightTrend value, $Res Function(WeightTrend) _then) = _$WeightTrendCopyWithImpl;
@useResult
$Res call({
 BodyWeightEntry latest, BodyWeightEntry? reference
});


$BodyWeightEntryCopyWith<$Res> get latest;$BodyWeightEntryCopyWith<$Res>? get reference;

}
/// @nodoc
class _$WeightTrendCopyWithImpl<$Res>
    implements $WeightTrendCopyWith<$Res> {
  _$WeightTrendCopyWithImpl(this._self, this._then);

  final WeightTrend _self;
  final $Res Function(WeightTrend) _then;

/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latest = null,Object? reference = freezed,}) {
  return _then(WeightTrend(
latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as BodyWeightEntry,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as BodyWeightEntry?,
  ));
}
/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BodyWeightEntryCopyWith<$Res> get latest {
  
  return $BodyWeightEntryCopyWith<$Res>(_self.latest, (value) {
    return _then(_self.copyWith(latest: value));
  });
}/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BodyWeightEntryCopyWith<$Res>? get reference {
    if (_self.reference == null) {
    return null;
  }

  return $BodyWeightEntryCopyWith<$Res>(_self.reference!, (value) {
    return _then(_self.copyWith(reference: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeightTrend].
extension WeightTrendPatterns on WeightTrend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeightTrend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeightTrend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeightTrend value)  $default,){
final _that = this;
switch (_that) {
case _WeightTrend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeightTrend value)?  $default,){
final _that = this;
switch (_that) {
case _WeightTrend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BodyWeightEntry latest,  BodyWeightEntry? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeightTrend() when $default != null:
return $default(_that.latest,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BodyWeightEntry latest,  BodyWeightEntry? reference)  $default,) {final _that = this;
switch (_that) {
case _WeightTrend():
return $default(_that.latest,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BodyWeightEntry latest,  BodyWeightEntry? reference)?  $default,) {final _that = this;
switch (_that) {
case _WeightTrend() when $default != null:
return $default(_that.latest,_that.reference);case _:
  return null;

}
}

}

/// @nodoc


class _WeightTrend extends WeightTrend {
  const _WeightTrend({required this.latest, this.reference}): super._();
  

@override final  BodyWeightEntry latest;
/// The latest entry at least [minimumGap] older than [latest], if any.
@override final  BodyWeightEntry? reference;

/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeightTrendCopyWith<_WeightTrend> get copyWith => __$WeightTrendCopyWithImpl<_WeightTrend>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeightTrend&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.reference, reference) || other.reference == reference));
}


@override
int get hashCode {
    return Object.hash(runtimeType,latest,reference);
}

@override
String toString() {
    return 'WeightTrend(latest: $latest, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$WeightTrendCopyWith<$Res> implements $WeightTrendCopyWith<$Res> {
  factory _$WeightTrendCopyWith(_WeightTrend value, $Res Function(_WeightTrend) _then) = __$WeightTrendCopyWithImpl;
@override @useResult
$Res call({
 BodyWeightEntry latest, BodyWeightEntry? reference
});


@override $BodyWeightEntryCopyWith<$Res> get latest;@override $BodyWeightEntryCopyWith<$Res>? get reference;

}
/// @nodoc
class __$WeightTrendCopyWithImpl<$Res>
    implements _$WeightTrendCopyWith<$Res> {
  __$WeightTrendCopyWithImpl(this._self, this._then);

  final _WeightTrend _self;
  final $Res Function(_WeightTrend) _then;

/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latest = null,Object? reference = freezed,}) {
  return _then(_WeightTrend(
latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as BodyWeightEntry,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as BodyWeightEntry?,
  ));
}

/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BodyWeightEntryCopyWith<$Res> get latest {
  
  return $BodyWeightEntryCopyWith<$Res>(_self.latest, (value) {
    return _then(_self.copyWith(latest: value));
  });
}/// Create a copy of WeightTrend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BodyWeightEntryCopyWith<$Res>? get reference {
    if (_self.reference == null) {
    return null;
  }

  return $BodyWeightEntryCopyWith<$Res>(_self.reference!, (value) {
    return _then(_self.copyWith(reference: value));
  });
}
}

// dart format on
