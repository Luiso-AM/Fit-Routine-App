// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseQuery {

 String get text; Set<MuscleGroup> get muscles; Set<Equipment> get equipment; Set<ExerciseType> get types;
/// Create a copy of ExerciseQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseQueryCopyWith<ExerciseQuery> get copyWith => _$ExerciseQueryCopyWithImpl<ExerciseQuery>(this as ExerciseQuery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExerciseQuery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseQuery&&(identical(other.text, _this.text) || other.text == _this.text)&&const DeepCollectionEquality().equals(other.muscles, _this.muscles)&&const DeepCollectionEquality().equals(other.equipment, _this.equipment)&&const DeepCollectionEquality().equals(other.types, _this.types));
}


@override
int get hashCode {
  final _this = this as ExerciseQuery;
  return Object.hash(runtimeType,_this.text,const DeepCollectionEquality().hash(_this.muscles),const DeepCollectionEquality().hash(_this.equipment),const DeepCollectionEquality().hash(_this.types));
}

@override
String toString() {
  final _this = this as ExerciseQuery;
  return 'ExerciseQuery(text: ${_this.text}, muscles: ${_this.muscles}, equipment: ${_this.equipment}, types: ${_this.types})';
}


}

/// @nodoc
abstract mixin class $ExerciseQueryCopyWith<$Res>  {
  factory $ExerciseQueryCopyWith(ExerciseQuery value, $Res Function(ExerciseQuery) _then) = _$ExerciseQueryCopyWithImpl;
@useResult
$Res call({
 String text, Set<MuscleGroup> muscles, Set<Equipment> equipment, Set<ExerciseType> types
});




}
/// @nodoc
class _$ExerciseQueryCopyWithImpl<$Res>
    implements $ExerciseQueryCopyWith<$Res> {
  _$ExerciseQueryCopyWithImpl(this._self, this._then);

  final ExerciseQuery _self;
  final $Res Function(ExerciseQuery) _then;

/// Create a copy of ExerciseQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? muscles = null,Object? equipment = null,Object? types = null,}) {
  return _then(ExerciseQuery(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,muscles: null == muscles ? _self.muscles : muscles // ignore: cast_nullable_to_non_nullable
as Set<MuscleGroup>,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as Set<Equipment>,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as Set<ExerciseType>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseQuery].
extension ExerciseQueryPatterns on ExerciseQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseQuery value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseQuery value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  Set<MuscleGroup> muscles,  Set<Equipment> equipment,  Set<ExerciseType> types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseQuery() when $default != null:
return $default(_that.text,_that.muscles,_that.equipment,_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  Set<MuscleGroup> muscles,  Set<Equipment> equipment,  Set<ExerciseType> types)  $default,) {final _that = this;
switch (_that) {
case _ExerciseQuery():
return $default(_that.text,_that.muscles,_that.equipment,_that.types);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  Set<MuscleGroup> muscles,  Set<Equipment> equipment,  Set<ExerciseType> types)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseQuery() when $default != null:
return $default(_that.text,_that.muscles,_that.equipment,_that.types);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseQuery extends ExerciseQuery {
  const _ExerciseQuery({this.text = '',  Set<MuscleGroup> muscles = const <MuscleGroup>{},  Set<Equipment> equipment = const <Equipment>{},  Set<ExerciseType> types = const <ExerciseType>{}}): _muscles = muscles,_equipment = equipment,_types = types,super._();
  

@override@JsonKey() final  String text;
 final  Set<MuscleGroup> _muscles;
@override@JsonKey() Set<MuscleGroup> get muscles {
  if (_muscles is EqualUnmodifiableSetView) return _muscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_muscles);
}

 final  Set<Equipment> _equipment;
@override@JsonKey() Set<Equipment> get equipment {
  if (_equipment is EqualUnmodifiableSetView) return _equipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_equipment);
}

 final  Set<ExerciseType> _types;
@override@JsonKey() Set<ExerciseType> get types {
  if (_types is EqualUnmodifiableSetView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_types);
}


/// Create a copy of ExerciseQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseQueryCopyWith<_ExerciseQuery> get copyWith => __$ExerciseQueryCopyWithImpl<_ExerciseQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseQuery&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.muscles, _muscles)&&const DeepCollectionEquality().equals(other.equipment, _equipment)&&const DeepCollectionEquality().equals(other.types, _types));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_muscles),const DeepCollectionEquality().hash(_equipment),const DeepCollectionEquality().hash(_types));
}

@override
String toString() {
    return 'ExerciseQuery(text: $text, muscles: $muscles, equipment: $equipment, types: $types)';
}


}

/// @nodoc
abstract mixin class _$ExerciseQueryCopyWith<$Res> implements $ExerciseQueryCopyWith<$Res> {
  factory _$ExerciseQueryCopyWith(_ExerciseQuery value, $Res Function(_ExerciseQuery) _then) = __$ExerciseQueryCopyWithImpl;
@override @useResult
$Res call({
 String text, Set<MuscleGroup> muscles, Set<Equipment> equipment, Set<ExerciseType> types
});




}
/// @nodoc
class __$ExerciseQueryCopyWithImpl<$Res>
    implements _$ExerciseQueryCopyWith<$Res> {
  __$ExerciseQueryCopyWithImpl(this._self, this._then);

  final _ExerciseQuery _self;
  final $Res Function(_ExerciseQuery) _then;

/// Create a copy of ExerciseQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? muscles = null,Object? equipment = null,Object? types = null,}) {
  return _then(_ExerciseQuery(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,muscles: null == muscles ? _self._muscles : muscles // ignore: cast_nullable_to_non_nullable
as Set<MuscleGroup>,equipment: null == equipment ? _self._equipment : equipment // ignore: cast_nullable_to_non_nullable
as Set<Equipment>,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as Set<ExerciseType>,
  ));
}


}

// dart format on
