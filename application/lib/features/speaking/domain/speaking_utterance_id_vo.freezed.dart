// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaking_utterance_id_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeakingUtteranceIdVO {

 int get userAnswerId; int get order;
/// Create a copy of SpeakingUtteranceIdVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakingUtteranceIdVOCopyWith<SpeakingUtteranceIdVO> get copyWith => _$SpeakingUtteranceIdVOCopyWithImpl<SpeakingUtteranceIdVO>(this as SpeakingUtteranceIdVO, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakingUtteranceIdVO&&(identical(other.userAnswerId, userAnswerId) || other.userAnswerId == userAnswerId)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,userAnswerId,order);

@override
String toString() {
  return 'SpeakingUtteranceIdVO(userAnswerId: $userAnswerId, order: $order)';
}


}

/// @nodoc
abstract mixin class $SpeakingUtteranceIdVOCopyWith<$Res>  {
  factory $SpeakingUtteranceIdVOCopyWith(SpeakingUtteranceIdVO value, $Res Function(SpeakingUtteranceIdVO) _then) = _$SpeakingUtteranceIdVOCopyWithImpl;
@useResult
$Res call({
 int userAnswerId, int order
});




}
/// @nodoc
class _$SpeakingUtteranceIdVOCopyWithImpl<$Res>
    implements $SpeakingUtteranceIdVOCopyWith<$Res> {
  _$SpeakingUtteranceIdVOCopyWithImpl(this._self, this._then);

  final SpeakingUtteranceIdVO _self;
  final $Res Function(SpeakingUtteranceIdVO) _then;

/// Create a copy of SpeakingUtteranceIdVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userAnswerId = null,Object? order = null,}) {
  return _then(_self.copyWith(
userAnswerId: null == userAnswerId ? _self.userAnswerId : userAnswerId // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakingUtteranceIdVO].
extension SpeakingUtteranceIdVOPatterns on SpeakingUtteranceIdVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakingUtteranceIdVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakingUtteranceIdVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakingUtteranceIdVO value)  $default,){
final _that = this;
switch (_that) {
case _SpeakingUtteranceIdVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakingUtteranceIdVO value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakingUtteranceIdVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userAnswerId,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakingUtteranceIdVO() when $default != null:
return $default(_that.userAnswerId,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userAnswerId,  int order)  $default,) {final _that = this;
switch (_that) {
case _SpeakingUtteranceIdVO():
return $default(_that.userAnswerId,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userAnswerId,  int order)?  $default,) {final _that = this;
switch (_that) {
case _SpeakingUtteranceIdVO() when $default != null:
return $default(_that.userAnswerId,_that.order);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakingUtteranceIdVO implements SpeakingUtteranceIdVO {
  const _SpeakingUtteranceIdVO({required this.userAnswerId, required this.order});
  

@override final  int userAnswerId;
@override final  int order;

/// Create a copy of SpeakingUtteranceIdVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakingUtteranceIdVOCopyWith<_SpeakingUtteranceIdVO> get copyWith => __$SpeakingUtteranceIdVOCopyWithImpl<_SpeakingUtteranceIdVO>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakingUtteranceIdVO&&(identical(other.userAnswerId, userAnswerId) || other.userAnswerId == userAnswerId)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,userAnswerId,order);

@override
String toString() {
  return 'SpeakingUtteranceIdVO(userAnswerId: $userAnswerId, order: $order)';
}


}

/// @nodoc
abstract mixin class _$SpeakingUtteranceIdVOCopyWith<$Res> implements $SpeakingUtteranceIdVOCopyWith<$Res> {
  factory _$SpeakingUtteranceIdVOCopyWith(_SpeakingUtteranceIdVO value, $Res Function(_SpeakingUtteranceIdVO) _then) = __$SpeakingUtteranceIdVOCopyWithImpl;
@override @useResult
$Res call({
 int userAnswerId, int order
});




}
/// @nodoc
class __$SpeakingUtteranceIdVOCopyWithImpl<$Res>
    implements _$SpeakingUtteranceIdVOCopyWith<$Res> {
  __$SpeakingUtteranceIdVOCopyWithImpl(this._self, this._then);

  final _SpeakingUtteranceIdVO _self;
  final $Res Function(_SpeakingUtteranceIdVO) _then;

/// Create a copy of SpeakingUtteranceIdVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userAnswerId = null,Object? order = null,}) {
  return _then(_SpeakingUtteranceIdVO(
userAnswerId: null == userAnswerId ? _self.userAnswerId : userAnswerId // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
