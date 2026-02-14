// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'writing_prompt_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WritingPromptVo {

 String get taskContext; String get taskInstruction; String? get diagramDescription; String? get diagramUuid;
/// Create a copy of WritingPromptVo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WritingPromptVoCopyWith<WritingPromptVo> get copyWith => _$WritingPromptVoCopyWithImpl<WritingPromptVo>(this as WritingPromptVo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WritingPromptVo&&(identical(other.taskContext, taskContext) || other.taskContext == taskContext)&&(identical(other.taskInstruction, taskInstruction) || other.taskInstruction == taskInstruction)&&(identical(other.diagramDescription, diagramDescription) || other.diagramDescription == diagramDescription)&&(identical(other.diagramUuid, diagramUuid) || other.diagramUuid == diagramUuid));
}


@override
int get hashCode => Object.hash(runtimeType,taskContext,taskInstruction,diagramDescription,diagramUuid);

@override
String toString() {
  return 'WritingPromptVo(taskContext: $taskContext, taskInstruction: $taskInstruction, diagramDescription: $diagramDescription, diagramUuid: $diagramUuid)';
}


}

/// @nodoc
abstract mixin class $WritingPromptVoCopyWith<$Res>  {
  factory $WritingPromptVoCopyWith(WritingPromptVo value, $Res Function(WritingPromptVo) _then) = _$WritingPromptVoCopyWithImpl;
@useResult
$Res call({
 String taskContext, String taskInstruction, String? diagramDescription, String? diagramUuid
});




}
/// @nodoc
class _$WritingPromptVoCopyWithImpl<$Res>
    implements $WritingPromptVoCopyWith<$Res> {
  _$WritingPromptVoCopyWithImpl(this._self, this._then);

  final WritingPromptVo _self;
  final $Res Function(WritingPromptVo) _then;

/// Create a copy of WritingPromptVo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskContext = null,Object? taskInstruction = null,Object? diagramDescription = freezed,Object? diagramUuid = freezed,}) {
  return _then(_self.copyWith(
taskContext: null == taskContext ? _self.taskContext : taskContext // ignore: cast_nullable_to_non_nullable
as String,taskInstruction: null == taskInstruction ? _self.taskInstruction : taskInstruction // ignore: cast_nullable_to_non_nullable
as String,diagramDescription: freezed == diagramDescription ? _self.diagramDescription : diagramDescription // ignore: cast_nullable_to_non_nullable
as String?,diagramUuid: freezed == diagramUuid ? _self.diagramUuid : diagramUuid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WritingPromptVo].
extension WritingPromptVoPatterns on WritingPromptVo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WritingPromptVo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WritingPromptVo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WritingPromptVo value)  $default,){
final _that = this;
switch (_that) {
case _WritingPromptVo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WritingPromptVo value)?  $default,){
final _that = this;
switch (_that) {
case _WritingPromptVo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskContext,  String taskInstruction,  String? diagramDescription,  String? diagramUuid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WritingPromptVo() when $default != null:
return $default(_that.taskContext,_that.taskInstruction,_that.diagramDescription,_that.diagramUuid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskContext,  String taskInstruction,  String? diagramDescription,  String? diagramUuid)  $default,) {final _that = this;
switch (_that) {
case _WritingPromptVo():
return $default(_that.taskContext,_that.taskInstruction,_that.diagramDescription,_that.diagramUuid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskContext,  String taskInstruction,  String? diagramDescription,  String? diagramUuid)?  $default,) {final _that = this;
switch (_that) {
case _WritingPromptVo() when $default != null:
return $default(_that.taskContext,_that.taskInstruction,_that.diagramDescription,_that.diagramUuid);case _:
  return null;

}
}

}

/// @nodoc


class _WritingPromptVo extends WritingPromptVo {
  const _WritingPromptVo({required this.taskContext, required this.taskInstruction, this.diagramDescription, this.diagramUuid}): super._();
  

@override final  String taskContext;
@override final  String taskInstruction;
@override final  String? diagramDescription;
@override final  String? diagramUuid;

/// Create a copy of WritingPromptVo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WritingPromptVoCopyWith<_WritingPromptVo> get copyWith => __$WritingPromptVoCopyWithImpl<_WritingPromptVo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WritingPromptVo&&(identical(other.taskContext, taskContext) || other.taskContext == taskContext)&&(identical(other.taskInstruction, taskInstruction) || other.taskInstruction == taskInstruction)&&(identical(other.diagramDescription, diagramDescription) || other.diagramDescription == diagramDescription)&&(identical(other.diagramUuid, diagramUuid) || other.diagramUuid == diagramUuid));
}


@override
int get hashCode => Object.hash(runtimeType,taskContext,taskInstruction,diagramDescription,diagramUuid);

@override
String toString() {
  return 'WritingPromptVo(taskContext: $taskContext, taskInstruction: $taskInstruction, diagramDescription: $diagramDescription, diagramUuid: $diagramUuid)';
}


}

/// @nodoc
abstract mixin class _$WritingPromptVoCopyWith<$Res> implements $WritingPromptVoCopyWith<$Res> {
  factory _$WritingPromptVoCopyWith(_WritingPromptVo value, $Res Function(_WritingPromptVo) _then) = __$WritingPromptVoCopyWithImpl;
@override @useResult
$Res call({
 String taskContext, String taskInstruction, String? diagramDescription, String? diagramUuid
});




}
/// @nodoc
class __$WritingPromptVoCopyWithImpl<$Res>
    implements _$WritingPromptVoCopyWith<$Res> {
  __$WritingPromptVoCopyWithImpl(this._self, this._then);

  final _WritingPromptVo _self;
  final $Res Function(_WritingPromptVo) _then;

/// Create a copy of WritingPromptVo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskContext = null,Object? taskInstruction = null,Object? diagramDescription = freezed,Object? diagramUuid = freezed,}) {
  return _then(_WritingPromptVo(
taskContext: null == taskContext ? _self.taskContext : taskContext // ignore: cast_nullable_to_non_nullable
as String,taskInstruction: null == taskInstruction ? _self.taskInstruction : taskInstruction // ignore: cast_nullable_to_non_nullable
as String,diagramDescription: freezed == diagramDescription ? _self.diagramDescription : diagramDescription // ignore: cast_nullable_to_non_nullable
as String?,diagramUuid: freezed == diagramUuid ? _self.diagramUuid : diagramUuid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
