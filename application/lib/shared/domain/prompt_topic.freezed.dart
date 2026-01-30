// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prompt_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PromptTopic {

 int get order; String get title;
/// Create a copy of PromptTopic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromptTopicCopyWith<PromptTopic> get copyWith => _$PromptTopicCopyWithImpl<PromptTopic>(this as PromptTopic, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromptTopic&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,order,title);

@override
String toString() {
  return 'PromptTopic(order: $order, title: $title)';
}


}

/// @nodoc
abstract mixin class $PromptTopicCopyWith<$Res>  {
  factory $PromptTopicCopyWith(PromptTopic value, $Res Function(PromptTopic) _then) = _$PromptTopicCopyWithImpl;
@useResult
$Res call({
 int order, String title
});




}
/// @nodoc
class _$PromptTopicCopyWithImpl<$Res>
    implements $PromptTopicCopyWith<$Res> {
  _$PromptTopicCopyWithImpl(this._self, this._then);

  final PromptTopic _self;
  final $Res Function(PromptTopic) _then;

/// Create a copy of PromptTopic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? title = null,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PromptTopic].
extension PromptTopicPatterns on PromptTopic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromptTopic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromptTopic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromptTopic value)  $default,){
final _that = this;
switch (_that) {
case _PromptTopic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromptTopic value)?  $default,){
final _that = this;
switch (_that) {
case _PromptTopic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int order,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromptTopic() when $default != null:
return $default(_that.order,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int order,  String title)  $default,) {final _that = this;
switch (_that) {
case _PromptTopic():
return $default(_that.order,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int order,  String title)?  $default,) {final _that = this;
switch (_that) {
case _PromptTopic() when $default != null:
return $default(_that.order,_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _PromptTopic implements PromptTopic {
  const _PromptTopic({required this.order, required this.title});
  

@override final  int order;
@override final  String title;

/// Create a copy of PromptTopic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromptTopicCopyWith<_PromptTopic> get copyWith => __$PromptTopicCopyWithImpl<_PromptTopic>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromptTopic&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,order,title);

@override
String toString() {
  return 'PromptTopic(order: $order, title: $title)';
}


}

/// @nodoc
abstract mixin class _$PromptTopicCopyWith<$Res> implements $PromptTopicCopyWith<$Res> {
  factory _$PromptTopicCopyWith(_PromptTopic value, $Res Function(_PromptTopic) _then) = __$PromptTopicCopyWithImpl;
@override @useResult
$Res call({
 int order, String title
});




}
/// @nodoc
class __$PromptTopicCopyWithImpl<$Res>
    implements _$PromptTopicCopyWith<$Res> {
  __$PromptTopicCopyWithImpl(this._self, this._then);

  final _PromptTopic _self;
  final $Res Function(_PromptTopic) _then;

/// Create a copy of PromptTopic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? title = null,}) {
  return _then(_PromptTopic(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
