// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'writing_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WritingAnswer {

 int? get id; int? get detailId; TestTask get testTask; DateTime get createdAt; DateTime get updatedAt; WritingPromptType get promptType; WritingPromptVo get writingPrompt; List<PromptTopic> get topics; String get answerText; int get duration; bool get isGraded; double? get taskScore; double? get coherenceScore; double? get lexialScore; double? get grammaticalScore; double? get bandScore; String? get taskFeedback; String? get coherenceFeedback; String? get lexialFeedback; String? get grammaticalFeedback;
/// Create a copy of WritingAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WritingAnswerCopyWith<WritingAnswer> get copyWith => _$WritingAnswerCopyWithImpl<WritingAnswer>(this as WritingAnswer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WritingAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.promptType, promptType) || other.promptType == promptType)&&(identical(other.writingPrompt, writingPrompt) || other.writingPrompt == writingPrompt)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.answerText, answerText) || other.answerText == answerText)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.taskScore, taskScore) || other.taskScore == taskScore)&&(identical(other.coherenceScore, coherenceScore) || other.coherenceScore == coherenceScore)&&(identical(other.lexialScore, lexialScore) || other.lexialScore == lexialScore)&&(identical(other.grammaticalScore, grammaticalScore) || other.grammaticalScore == grammaticalScore)&&(identical(other.bandScore, bandScore) || other.bandScore == bandScore)&&(identical(other.taskFeedback, taskFeedback) || other.taskFeedback == taskFeedback)&&(identical(other.coherenceFeedback, coherenceFeedback) || other.coherenceFeedback == coherenceFeedback)&&(identical(other.lexialFeedback, lexialFeedback) || other.lexialFeedback == lexialFeedback)&&(identical(other.grammaticalFeedback, grammaticalFeedback) || other.grammaticalFeedback == grammaticalFeedback));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,detailId,testTask,createdAt,updatedAt,promptType,writingPrompt,const DeepCollectionEquality().hash(topics),answerText,duration,isGraded,taskScore,coherenceScore,lexialScore,grammaticalScore,bandScore,taskFeedback,coherenceFeedback,lexialFeedback,grammaticalFeedback]);

@override
String toString() {
  return 'WritingAnswer(id: $id, detailId: $detailId, testTask: $testTask, createdAt: $createdAt, updatedAt: $updatedAt, promptType: $promptType, writingPrompt: $writingPrompt, topics: $topics, answerText: $answerText, duration: $duration, isGraded: $isGraded, taskScore: $taskScore, coherenceScore: $coherenceScore, lexialScore: $lexialScore, grammaticalScore: $grammaticalScore, bandScore: $bandScore, taskFeedback: $taskFeedback, coherenceFeedback: $coherenceFeedback, lexialFeedback: $lexialFeedback, grammaticalFeedback: $grammaticalFeedback)';
}


}

/// @nodoc
abstract mixin class $WritingAnswerCopyWith<$Res>  {
  factory $WritingAnswerCopyWith(WritingAnswer value, $Res Function(WritingAnswer) _then) = _$WritingAnswerCopyWithImpl;
@useResult
$Res call({
 int? id, int? detailId, TestTask testTask, DateTime createdAt, DateTime updatedAt, WritingPromptType promptType, WritingPromptVo writingPrompt, List<PromptTopic> topics, String answerText, int duration, bool isGraded, double? taskScore, double? coherenceScore, double? lexialScore, double? grammaticalScore, double? bandScore, String? taskFeedback, String? coherenceFeedback, String? lexialFeedback, String? grammaticalFeedback
});




}
/// @nodoc
class _$WritingAnswerCopyWithImpl<$Res>
    implements $WritingAnswerCopyWith<$Res> {
  _$WritingAnswerCopyWithImpl(this._self, this._then);

  final WritingAnswer _self;
  final $Res Function(WritingAnswer) _then;

/// Create a copy of WritingAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? detailId = freezed,Object? testTask = null,Object? createdAt = null,Object? updatedAt = null,Object? promptType = null,Object? writingPrompt = null,Object? topics = null,Object? answerText = null,Object? duration = null,Object? isGraded = null,Object? taskScore = freezed,Object? coherenceScore = freezed,Object? lexialScore = freezed,Object? grammaticalScore = freezed,Object? bandScore = freezed,Object? taskFeedback = freezed,Object? coherenceFeedback = freezed,Object? lexialFeedback = freezed,Object? grammaticalFeedback = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,promptType: null == promptType ? _self.promptType : promptType // ignore: cast_nullable_to_non_nullable
as WritingPromptType,writingPrompt: null == writingPrompt ? _self.writingPrompt : writingPrompt // ignore: cast_nullable_to_non_nullable
as WritingPromptVo,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,answerText: null == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,taskScore: freezed == taskScore ? _self.taskScore : taskScore // ignore: cast_nullable_to_non_nullable
as double?,coherenceScore: freezed == coherenceScore ? _self.coherenceScore : coherenceScore // ignore: cast_nullable_to_non_nullable
as double?,lexialScore: freezed == lexialScore ? _self.lexialScore : lexialScore // ignore: cast_nullable_to_non_nullable
as double?,grammaticalScore: freezed == grammaticalScore ? _self.grammaticalScore : grammaticalScore // ignore: cast_nullable_to_non_nullable
as double?,bandScore: freezed == bandScore ? _self.bandScore : bandScore // ignore: cast_nullable_to_non_nullable
as double?,taskFeedback: freezed == taskFeedback ? _self.taskFeedback : taskFeedback // ignore: cast_nullable_to_non_nullable
as String?,coherenceFeedback: freezed == coherenceFeedback ? _self.coherenceFeedback : coherenceFeedback // ignore: cast_nullable_to_non_nullable
as String?,lexialFeedback: freezed == lexialFeedback ? _self.lexialFeedback : lexialFeedback // ignore: cast_nullable_to_non_nullable
as String?,grammaticalFeedback: freezed == grammaticalFeedback ? _self.grammaticalFeedback : grammaticalFeedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WritingAnswer].
extension WritingAnswerPatterns on WritingAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WritingAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WritingAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WritingAnswer value)  $default,){
final _that = this;
switch (_that) {
case _WritingAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WritingAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _WritingAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? detailId,  TestTask testTask,  DateTime createdAt,  DateTime updatedAt,  WritingPromptType promptType,  WritingPromptVo writingPrompt,  List<PromptTopic> topics,  String answerText,  int duration,  bool isGraded,  double? taskScore,  double? coherenceScore,  double? lexialScore,  double? grammaticalScore,  double? bandScore,  String? taskFeedback,  String? coherenceFeedback,  String? lexialFeedback,  String? grammaticalFeedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WritingAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.testTask,_that.createdAt,_that.updatedAt,_that.promptType,_that.writingPrompt,_that.topics,_that.answerText,_that.duration,_that.isGraded,_that.taskScore,_that.coherenceScore,_that.lexialScore,_that.grammaticalScore,_that.bandScore,_that.taskFeedback,_that.coherenceFeedback,_that.lexialFeedback,_that.grammaticalFeedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? detailId,  TestTask testTask,  DateTime createdAt,  DateTime updatedAt,  WritingPromptType promptType,  WritingPromptVo writingPrompt,  List<PromptTopic> topics,  String answerText,  int duration,  bool isGraded,  double? taskScore,  double? coherenceScore,  double? lexialScore,  double? grammaticalScore,  double? bandScore,  String? taskFeedback,  String? coherenceFeedback,  String? lexialFeedback,  String? grammaticalFeedback)  $default,) {final _that = this;
switch (_that) {
case _WritingAnswer():
return $default(_that.id,_that.detailId,_that.testTask,_that.createdAt,_that.updatedAt,_that.promptType,_that.writingPrompt,_that.topics,_that.answerText,_that.duration,_that.isGraded,_that.taskScore,_that.coherenceScore,_that.lexialScore,_that.grammaticalScore,_that.bandScore,_that.taskFeedback,_that.coherenceFeedback,_that.lexialFeedback,_that.grammaticalFeedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? detailId,  TestTask testTask,  DateTime createdAt,  DateTime updatedAt,  WritingPromptType promptType,  WritingPromptVo writingPrompt,  List<PromptTopic> topics,  String answerText,  int duration,  bool isGraded,  double? taskScore,  double? coherenceScore,  double? lexialScore,  double? grammaticalScore,  double? bandScore,  String? taskFeedback,  String? coherenceFeedback,  String? lexialFeedback,  String? grammaticalFeedback)?  $default,) {final _that = this;
switch (_that) {
case _WritingAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.testTask,_that.createdAt,_that.updatedAt,_that.promptType,_that.writingPrompt,_that.topics,_that.answerText,_that.duration,_that.isGraded,_that.taskScore,_that.coherenceScore,_that.lexialScore,_that.grammaticalScore,_that.bandScore,_that.taskFeedback,_that.coherenceFeedback,_that.lexialFeedback,_that.grammaticalFeedback);case _:
  return null;

}
}

}

/// @nodoc


class _WritingAnswer extends WritingAnswer {
  const _WritingAnswer({this.id, this.detailId, required this.testTask, required this.createdAt, required this.updatedAt, required this.promptType, required this.writingPrompt, required final  List<PromptTopic> topics, required this.answerText, required this.duration, required this.isGraded, this.taskScore, this.coherenceScore, this.lexialScore, this.grammaticalScore, this.bandScore, this.taskFeedback, this.coherenceFeedback, this.lexialFeedback, this.grammaticalFeedback}): _topics = topics,super._();
  

@override final  int? id;
@override final  int? detailId;
@override final  TestTask testTask;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  WritingPromptType promptType;
@override final  WritingPromptVo writingPrompt;
 final  List<PromptTopic> _topics;
@override List<PromptTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  String answerText;
@override final  int duration;
@override final  bool isGraded;
@override final  double? taskScore;
@override final  double? coherenceScore;
@override final  double? lexialScore;
@override final  double? grammaticalScore;
@override final  double? bandScore;
@override final  String? taskFeedback;
@override final  String? coherenceFeedback;
@override final  String? lexialFeedback;
@override final  String? grammaticalFeedback;

/// Create a copy of WritingAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WritingAnswerCopyWith<_WritingAnswer> get copyWith => __$WritingAnswerCopyWithImpl<_WritingAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WritingAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.promptType, promptType) || other.promptType == promptType)&&(identical(other.writingPrompt, writingPrompt) || other.writingPrompt == writingPrompt)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.answerText, answerText) || other.answerText == answerText)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.taskScore, taskScore) || other.taskScore == taskScore)&&(identical(other.coherenceScore, coherenceScore) || other.coherenceScore == coherenceScore)&&(identical(other.lexialScore, lexialScore) || other.lexialScore == lexialScore)&&(identical(other.grammaticalScore, grammaticalScore) || other.grammaticalScore == grammaticalScore)&&(identical(other.bandScore, bandScore) || other.bandScore == bandScore)&&(identical(other.taskFeedback, taskFeedback) || other.taskFeedback == taskFeedback)&&(identical(other.coherenceFeedback, coherenceFeedback) || other.coherenceFeedback == coherenceFeedback)&&(identical(other.lexialFeedback, lexialFeedback) || other.lexialFeedback == lexialFeedback)&&(identical(other.grammaticalFeedback, grammaticalFeedback) || other.grammaticalFeedback == grammaticalFeedback));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,detailId,testTask,createdAt,updatedAt,promptType,writingPrompt,const DeepCollectionEquality().hash(_topics),answerText,duration,isGraded,taskScore,coherenceScore,lexialScore,grammaticalScore,bandScore,taskFeedback,coherenceFeedback,lexialFeedback,grammaticalFeedback]);

@override
String toString() {
  return 'WritingAnswer(id: $id, detailId: $detailId, testTask: $testTask, createdAt: $createdAt, updatedAt: $updatedAt, promptType: $promptType, writingPrompt: $writingPrompt, topics: $topics, answerText: $answerText, duration: $duration, isGraded: $isGraded, taskScore: $taskScore, coherenceScore: $coherenceScore, lexialScore: $lexialScore, grammaticalScore: $grammaticalScore, bandScore: $bandScore, taskFeedback: $taskFeedback, coherenceFeedback: $coherenceFeedback, lexialFeedback: $lexialFeedback, grammaticalFeedback: $grammaticalFeedback)';
}


}

/// @nodoc
abstract mixin class _$WritingAnswerCopyWith<$Res> implements $WritingAnswerCopyWith<$Res> {
  factory _$WritingAnswerCopyWith(_WritingAnswer value, $Res Function(_WritingAnswer) _then) = __$WritingAnswerCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? detailId, TestTask testTask, DateTime createdAt, DateTime updatedAt, WritingPromptType promptType, WritingPromptVo writingPrompt, List<PromptTopic> topics, String answerText, int duration, bool isGraded, double? taskScore, double? coherenceScore, double? lexialScore, double? grammaticalScore, double? bandScore, String? taskFeedback, String? coherenceFeedback, String? lexialFeedback, String? grammaticalFeedback
});




}
/// @nodoc
class __$WritingAnswerCopyWithImpl<$Res>
    implements _$WritingAnswerCopyWith<$Res> {
  __$WritingAnswerCopyWithImpl(this._self, this._then);

  final _WritingAnswer _self;
  final $Res Function(_WritingAnswer) _then;

/// Create a copy of WritingAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? detailId = freezed,Object? testTask = null,Object? createdAt = null,Object? updatedAt = null,Object? promptType = null,Object? writingPrompt = null,Object? topics = null,Object? answerText = null,Object? duration = null,Object? isGraded = null,Object? taskScore = freezed,Object? coherenceScore = freezed,Object? lexialScore = freezed,Object? grammaticalScore = freezed,Object? bandScore = freezed,Object? taskFeedback = freezed,Object? coherenceFeedback = freezed,Object? lexialFeedback = freezed,Object? grammaticalFeedback = freezed,}) {
  return _then(_WritingAnswer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,promptType: null == promptType ? _self.promptType : promptType // ignore: cast_nullable_to_non_nullable
as WritingPromptType,writingPrompt: null == writingPrompt ? _self.writingPrompt : writingPrompt // ignore: cast_nullable_to_non_nullable
as WritingPromptVo,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,answerText: null == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,taskScore: freezed == taskScore ? _self.taskScore : taskScore // ignore: cast_nullable_to_non_nullable
as double?,coherenceScore: freezed == coherenceScore ? _self.coherenceScore : coherenceScore // ignore: cast_nullable_to_non_nullable
as double?,lexialScore: freezed == lexialScore ? _self.lexialScore : lexialScore // ignore: cast_nullable_to_non_nullable
as double?,grammaticalScore: freezed == grammaticalScore ? _self.grammaticalScore : grammaticalScore // ignore: cast_nullable_to_non_nullable
as double?,bandScore: freezed == bandScore ? _self.bandScore : bandScore // ignore: cast_nullable_to_non_nullable
as double?,taskFeedback: freezed == taskFeedback ? _self.taskFeedback : taskFeedback // ignore: cast_nullable_to_non_nullable
as String?,coherenceFeedback: freezed == coherenceFeedback ? _self.coherenceFeedback : coherenceFeedback // ignore: cast_nullable_to_non_nullable
as String?,lexialFeedback: freezed == lexialFeedback ? _self.lexialFeedback : lexialFeedback // ignore: cast_nullable_to_non_nullable
as String?,grammaticalFeedback: freezed == grammaticalFeedback ? _self.grammaticalFeedback : grammaticalFeedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
