// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_answer_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserAnswerVM {

 TestTask get testTask; DateTime get createdAt;
/// Create a copy of UserAnswerVM
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAnswerVMCopyWith<UserAnswerVM> get copyWith => _$UserAnswerVMCopyWithImpl<UserAnswerVM>(this as UserAnswerVM, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAnswerVM&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,testTask,createdAt);

@override
String toString() {
  return 'UserAnswerVM(testTask: $testTask, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserAnswerVMCopyWith<$Res>  {
  factory $UserAnswerVMCopyWith(UserAnswerVM value, $Res Function(UserAnswerVM) _then) = _$UserAnswerVMCopyWithImpl;
@useResult
$Res call({
 TestTask testTask, DateTime createdAt
});




}
/// @nodoc
class _$UserAnswerVMCopyWithImpl<$Res>
    implements $UserAnswerVMCopyWith<$Res> {
  _$UserAnswerVMCopyWithImpl(this._self, this._then);

  final UserAnswerVM _self;
  final $Res Function(UserAnswerVM) _then;

/// Create a copy of UserAnswerVM
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? testTask = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAnswerVM].
extension UserAnswerVMPatterns on UserAnswerVM {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAnswerVM value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAnswerVM() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAnswerVM value)  $default,){
final _that = this;
switch (_that) {
case _UserAnswerVM():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAnswerVM value)?  $default,){
final _that = this;
switch (_that) {
case _UserAnswerVM() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TestTask testTask,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAnswerVM() when $default != null:
return $default(_that.testTask,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TestTask testTask,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserAnswerVM():
return $default(_that.testTask,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TestTask testTask,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserAnswerVM() when $default != null:
return $default(_that.testTask,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _UserAnswerVM implements UserAnswerVM {
  const _UserAnswerVM({required this.testTask, required this.createdAt});
  

@override final  TestTask testTask;
@override final  DateTime createdAt;

/// Create a copy of UserAnswerVM
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAnswerVMCopyWith<_UserAnswerVM> get copyWith => __$UserAnswerVMCopyWithImpl<_UserAnswerVM>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAnswerVM&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,testTask,createdAt);

@override
String toString() {
  return 'UserAnswerVM(testTask: $testTask, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserAnswerVMCopyWith<$Res> implements $UserAnswerVMCopyWith<$Res> {
  factory _$UserAnswerVMCopyWith(_UserAnswerVM value, $Res Function(_UserAnswerVM) _then) = __$UserAnswerVMCopyWithImpl;
@override @useResult
$Res call({
 TestTask testTask, DateTime createdAt
});




}
/// @nodoc
class __$UserAnswerVMCopyWithImpl<$Res>
    implements _$UserAnswerVMCopyWith<$Res> {
  __$UserAnswerVMCopyWithImpl(this._self, this._then);

  final _UserAnswerVM _self;
  final $Res Function(_UserAnswerVM) _then;

/// Create a copy of UserAnswerVM
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? testTask = null,Object? createdAt = null,}) {
  return _then(_UserAnswerVM(
testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
