// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_start.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionStart {

 String get sessionId;/// `null` for free sessions, or when the routine day was removed.
 String? get routineDayId; DateTime get startedAt;
/// Create a copy of SessionStart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStartCopyWith<SessionStart> get copyWith => _$SessionStartCopyWithImpl<SessionStart>(this as SessionStart, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionStart;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStart&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.routineDayId, _this.routineDayId) || other.routineDayId == _this.routineDayId)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt));
}


@override
int get hashCode {
  final _this = this as SessionStart;
  return Object.hash(runtimeType,_this.sessionId,_this.routineDayId,_this.startedAt);
}

@override
String toString() {
  final _this = this as SessionStart;
  return 'SessionStart(sessionId: ${_this.sessionId}, routineDayId: ${_this.routineDayId}, startedAt: ${_this.startedAt})';
}


}

/// @nodoc
abstract mixin class $SessionStartCopyWith<$Res>  {
  factory $SessionStartCopyWith(SessionStart value, $Res Function(SessionStart) _then) = _$SessionStartCopyWithImpl;
@useResult
$Res call({
 String sessionId, String? routineDayId, DateTime startedAt
});




}
/// @nodoc
class _$SessionStartCopyWithImpl<$Res>
    implements $SessionStartCopyWith<$Res> {
  _$SessionStartCopyWithImpl(this._self, this._then);

  final SessionStart _self;
  final $Res Function(SessionStart) _then;

/// Create a copy of SessionStart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? routineDayId = freezed,Object? startedAt = null,}) {
  return _then(SessionStart(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,routineDayId: freezed == routineDayId ? _self.routineDayId : routineDayId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionStart].
extension SessionStartPatterns on SessionStart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionStart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionStart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionStart value)  $default,){
final _that = this;
switch (_that) {
case _SessionStart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionStart value)?  $default,){
final _that = this;
switch (_that) {
case _SessionStart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String? routineDayId,  DateTime startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionStart() when $default != null:
return $default(_that.sessionId,_that.routineDayId,_that.startedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String? routineDayId,  DateTime startedAt)  $default,) {final _that = this;
switch (_that) {
case _SessionStart():
return $default(_that.sessionId,_that.routineDayId,_that.startedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String? routineDayId,  DateTime startedAt)?  $default,) {final _that = this;
switch (_that) {
case _SessionStart() when $default != null:
return $default(_that.sessionId,_that.routineDayId,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SessionStart implements SessionStart {
  const _SessionStart({required this.sessionId, this.routineDayId, required this.startedAt});
  

@override final  String sessionId;
/// `null` for free sessions, or when the routine day was removed.
@override final  String? routineDayId;
@override final  DateTime startedAt;

/// Create a copy of SessionStart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionStartCopyWith<_SessionStart> get copyWith => __$SessionStartCopyWithImpl<_SessionStart>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionStart&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.routineDayId, routineDayId) || other.routineDayId == routineDayId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,routineDayId,startedAt);
}

@override
String toString() {
    return 'SessionStart(sessionId: $sessionId, routineDayId: $routineDayId, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$SessionStartCopyWith<$Res> implements $SessionStartCopyWith<$Res> {
  factory _$SessionStartCopyWith(_SessionStart value, $Res Function(_SessionStart) _then) = __$SessionStartCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String? routineDayId, DateTime startedAt
});




}
/// @nodoc
class __$SessionStartCopyWithImpl<$Res>
    implements _$SessionStartCopyWith<$Res> {
  __$SessionStartCopyWithImpl(this._self, this._then);

  final _SessionStart _self;
  final $Res Function(_SessionStart) _then;

/// Create a copy of SessionStart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? routineDayId = freezed,Object? startedAt = null,}) {
  return _then(_SessionStart(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,routineDayId: freezed == routineDayId ? _self.routineDayId : routineDayId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
