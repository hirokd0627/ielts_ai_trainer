// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaking_utterance_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeakingUtteranceVO {

 int get order; bool get isUser; String get text; double? get fluency;
/// Create a copy of SpeakingUtteranceVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakingUtteranceVOCopyWith<SpeakingUtteranceVO> get copyWith => _$SpeakingUtteranceVOCopyWithImpl<SpeakingUtteranceVO>(this as SpeakingUtteranceVO, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakingUtteranceVO&&(identical(other.order, order) || other.order == order)&&(identical(other.isUser, isUser) || other.isUser == isUser)&&(identical(other.text, text) || other.text == text)&&(identical(other.fluency, fluency) || other.fluency == fluency));
}


@override
int get hashCode => Object.hash(runtimeType,order,isUser,text,fluency);

@override
String toString() {
  return 'SpeakingUtteranceVO(order: $order, isUser: $isUser, text: $text, fluency: $fluency)';
}


}

/// @nodoc
abstract mixin class $SpeakingUtteranceVOCopyWith<$Res>  {
  factory $SpeakingUtteranceVOCopyWith(SpeakingUtteranceVO value, $Res Function(SpeakingUtteranceVO) _then) = _$SpeakingUtteranceVOCopyWithImpl;
@useResult
$Res call({
 int order, bool isUser, String text, double? fluency
});




}
/// @nodoc
class _$SpeakingUtteranceVOCopyWithImpl<$Res>
    implements $SpeakingUtteranceVOCopyWith<$Res> {
  _$SpeakingUtteranceVOCopyWithImpl(this._self, this._then);

  final SpeakingUtteranceVO _self;
  final $Res Function(SpeakingUtteranceVO) _then;

/// Create a copy of SpeakingUtteranceVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? isUser = null,Object? text = null,Object? fluency = freezed,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,isUser: null == isUser ? _self.isUser : isUser // ignore: cast_nullable_to_non_nullable
as bool,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,fluency: freezed == fluency ? _self.fluency : fluency // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakingUtteranceVO].
extension SpeakingUtteranceVOPatterns on SpeakingUtteranceVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakingUtteranceVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakingUtteranceVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakingUtteranceVO value)  $default,){
final _that = this;
switch (_that) {
case _SpeakingUtteranceVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakingUtteranceVO value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakingUtteranceVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int order,  bool isUser,  String text,  double? fluency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakingUtteranceVO() when $default != null:
return $default(_that.order,_that.isUser,_that.text,_that.fluency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int order,  bool isUser,  String text,  double? fluency)  $default,) {final _that = this;
switch (_that) {
case _SpeakingUtteranceVO():
return $default(_that.order,_that.isUser,_that.text,_that.fluency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int order,  bool isUser,  String text,  double? fluency)?  $default,) {final _that = this;
switch (_that) {
case _SpeakingUtteranceVO() when $default != null:
return $default(_that.order,_that.isUser,_that.text,_that.fluency);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakingUtteranceVO implements SpeakingUtteranceVO {
  const _SpeakingUtteranceVO({required this.order, required this.isUser, required this.text, this.fluency});
  

@override final  int order;
@override final  bool isUser;
@override final  String text;
@override final  double? fluency;

/// Create a copy of SpeakingUtteranceVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakingUtteranceVOCopyWith<_SpeakingUtteranceVO> get copyWith => __$SpeakingUtteranceVOCopyWithImpl<_SpeakingUtteranceVO>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakingUtteranceVO&&(identical(other.order, order) || other.order == order)&&(identical(other.isUser, isUser) || other.isUser == isUser)&&(identical(other.text, text) || other.text == text)&&(identical(other.fluency, fluency) || other.fluency == fluency));
}


@override
int get hashCode => Object.hash(runtimeType,order,isUser,text,fluency);

@override
String toString() {
  return 'SpeakingUtteranceVO(order: $order, isUser: $isUser, text: $text, fluency: $fluency)';
}


}

/// @nodoc
abstract mixin class _$SpeakingUtteranceVOCopyWith<$Res> implements $SpeakingUtteranceVOCopyWith<$Res> {
  factory _$SpeakingUtteranceVOCopyWith(_SpeakingUtteranceVO value, $Res Function(_SpeakingUtteranceVO) _then) = __$SpeakingUtteranceVOCopyWithImpl;
@override @useResult
$Res call({
 int order, bool isUser, String text, double? fluency
});




}
/// @nodoc
class __$SpeakingUtteranceVOCopyWithImpl<$Res>
    implements _$SpeakingUtteranceVOCopyWith<$Res> {
  __$SpeakingUtteranceVOCopyWithImpl(this._self, this._then);

  final _SpeakingUtteranceVO _self;
  final $Res Function(_SpeakingUtteranceVO) _then;

/// Create a copy of SpeakingUtteranceVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? isUser = null,Object? text = null,Object? fluency = freezed,}) {
  return _then(_SpeakingUtteranceVO(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,isUser: null == isUser ? _self.isUser : isUser // ignore: cast_nullable_to_non_nullable
as bool,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,fluency: freezed == fluency ? _self.fluency : fluency // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
