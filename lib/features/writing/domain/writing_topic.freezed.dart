// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'writing_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WritingTopic {

 int? get id; int get order; String get title;
/// Create a copy of WritingTopic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WritingTopicCopyWith<WritingTopic> get copyWith => _$WritingTopicCopyWithImpl<WritingTopic>(this as WritingTopic, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WritingTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,id,order,title);

@override
String toString() {
  return 'WritingTopic(id: $id, order: $order, title: $title)';
}


}

/// @nodoc
abstract mixin class $WritingTopicCopyWith<$Res>  {
  factory $WritingTopicCopyWith(WritingTopic value, $Res Function(WritingTopic) _then) = _$WritingTopicCopyWithImpl;
@useResult
$Res call({
 int? id, int order, String title
});




}
/// @nodoc
class _$WritingTopicCopyWithImpl<$Res>
    implements $WritingTopicCopyWith<$Res> {
  _$WritingTopicCopyWithImpl(this._self, this._then);

  final WritingTopic _self;
  final $Res Function(WritingTopic) _then;

/// Create a copy of WritingTopic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? order = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WritingTopic].
extension WritingTopicPatterns on WritingTopic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WritingTopic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WritingTopic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WritingTopic value)  $default,){
final _that = this;
switch (_that) {
case _WritingTopic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WritingTopic value)?  $default,){
final _that = this;
switch (_that) {
case _WritingTopic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int order,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WritingTopic() when $default != null:
return $default(_that.id,_that.order,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int order,  String title)  $default,) {final _that = this;
switch (_that) {
case _WritingTopic():
return $default(_that.id,_that.order,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int order,  String title)?  $default,) {final _that = this;
switch (_that) {
case _WritingTopic() when $default != null:
return $default(_that.id,_that.order,_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _WritingTopic implements WritingTopic {
  const _WritingTopic({this.id, required this.order, required this.title});
  

@override final  int? id;
@override final  int order;
@override final  String title;

/// Create a copy of WritingTopic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WritingTopicCopyWith<_WritingTopic> get copyWith => __$WritingTopicCopyWithImpl<_WritingTopic>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WritingTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,id,order,title);

@override
String toString() {
  return 'WritingTopic(id: $id, order: $order, title: $title)';
}


}

/// @nodoc
abstract mixin class _$WritingTopicCopyWith<$Res> implements $WritingTopicCopyWith<$Res> {
  factory _$WritingTopicCopyWith(_WritingTopic value, $Res Function(_WritingTopic) _then) = __$WritingTopicCopyWithImpl;
@override @useResult
$Res call({
 int? id, int order, String title
});




}
/// @nodoc
class __$WritingTopicCopyWithImpl<$Res>
    implements _$WritingTopicCopyWith<$Res> {
  __$WritingTopicCopyWithImpl(this._self, this._then);

  final _WritingTopic _self;
  final $Res Function(_WritingTopic) _then;

/// Create a copy of WritingTopic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? order = null,Object? title = null,}) {
  return _then(_WritingTopic(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
