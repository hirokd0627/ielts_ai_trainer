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

 int? get id; int? get detailId; TestTask get testTask; DateTime get createdAt; String get promptText; List<String> get topics; String get answerText; int get duration; bool get isGraded; double? get achievement; double? get coherence; double? get lexial; double? get grammatical; double? get score; String? get feedback; WritingTask1QuestionType? get questionType; WritingTask2EssayType? get essayType;
/// Create a copy of WritingAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WritingAnswerCopyWith<WritingAnswer> get copyWith => _$WritingAnswerCopyWithImpl<WritingAnswer>(this as WritingAnswer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WritingAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.promptText, promptText) || other.promptText == promptText)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.answerText, answerText) || other.answerText == answerText)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.achievement, achievement) || other.achievement == achievement)&&(identical(other.coherence, coherence) || other.coherence == coherence)&&(identical(other.lexial, lexial) || other.lexial == lexial)&&(identical(other.grammatical, grammatical) || other.grammatical == grammatical)&&(identical(other.score, score) || other.score == score)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.essayType, essayType) || other.essayType == essayType));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,testTask,createdAt,promptText,const DeepCollectionEquality().hash(topics),answerText,duration,isGraded,achievement,coherence,lexial,grammatical,score,feedback,questionType,essayType);

@override
String toString() {
  return 'WritingAnswer(id: $id, detailId: $detailId, testTask: $testTask, createdAt: $createdAt, promptText: $promptText, topics: $topics, answerText: $answerText, duration: $duration, isGraded: $isGraded, achievement: $achievement, coherence: $coherence, lexial: $lexial, grammatical: $grammatical, score: $score, feedback: $feedback, questionType: $questionType, essayType: $essayType)';
}


}

/// @nodoc
abstract mixin class $WritingAnswerCopyWith<$Res>  {
  factory $WritingAnswerCopyWith(WritingAnswer value, $Res Function(WritingAnswer) _then) = _$WritingAnswerCopyWithImpl;
@useResult
$Res call({
 int? id, int? detailId, TestTask testTask, DateTime createdAt, String promptText, List<String> topics, String answerText, int duration, bool isGraded, double? achievement, double? coherence, double? lexial, double? grammatical, double? score, String? feedback, WritingTask1QuestionType? questionType, WritingTask2EssayType? essayType
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? detailId = freezed,Object? testTask = null,Object? createdAt = null,Object? promptText = null,Object? topics = null,Object? answerText = null,Object? duration = null,Object? isGraded = null,Object? achievement = freezed,Object? coherence = freezed,Object? lexial = freezed,Object? grammatical = freezed,Object? score = freezed,Object? feedback = freezed,Object? questionType = freezed,Object? essayType = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,promptText: null == promptText ? _self.promptText : promptText // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,answerText: null == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,achievement: freezed == achievement ? _self.achievement : achievement // ignore: cast_nullable_to_non_nullable
as double?,coherence: freezed == coherence ? _self.coherence : coherence // ignore: cast_nullable_to_non_nullable
as double?,lexial: freezed == lexial ? _self.lexial : lexial // ignore: cast_nullable_to_non_nullable
as double?,grammatical: freezed == grammatical ? _self.grammatical : grammatical // ignore: cast_nullable_to_non_nullable
as double?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,questionType: freezed == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as WritingTask1QuestionType?,essayType: freezed == essayType ? _self.essayType : essayType // ignore: cast_nullable_to_non_nullable
as WritingTask2EssayType?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? detailId,  TestTask testTask,  DateTime createdAt,  String promptText,  List<String> topics,  String answerText,  int duration,  bool isGraded,  double? achievement,  double? coherence,  double? lexial,  double? grammatical,  double? score,  String? feedback,  WritingTask1QuestionType? questionType,  WritingTask2EssayType? essayType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WritingAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.testTask,_that.createdAt,_that.promptText,_that.topics,_that.answerText,_that.duration,_that.isGraded,_that.achievement,_that.coherence,_that.lexial,_that.grammatical,_that.score,_that.feedback,_that.questionType,_that.essayType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? detailId,  TestTask testTask,  DateTime createdAt,  String promptText,  List<String> topics,  String answerText,  int duration,  bool isGraded,  double? achievement,  double? coherence,  double? lexial,  double? grammatical,  double? score,  String? feedback,  WritingTask1QuestionType? questionType,  WritingTask2EssayType? essayType)  $default,) {final _that = this;
switch (_that) {
case _WritingAnswer():
return $default(_that.id,_that.detailId,_that.testTask,_that.createdAt,_that.promptText,_that.topics,_that.answerText,_that.duration,_that.isGraded,_that.achievement,_that.coherence,_that.lexial,_that.grammatical,_that.score,_that.feedback,_that.questionType,_that.essayType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? detailId,  TestTask testTask,  DateTime createdAt,  String promptText,  List<String> topics,  String answerText,  int duration,  bool isGraded,  double? achievement,  double? coherence,  double? lexial,  double? grammatical,  double? score,  String? feedback,  WritingTask1QuestionType? questionType,  WritingTask2EssayType? essayType)?  $default,) {final _that = this;
switch (_that) {
case _WritingAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.testTask,_that.createdAt,_that.promptText,_that.topics,_that.answerText,_that.duration,_that.isGraded,_that.achievement,_that.coherence,_that.lexial,_that.grammatical,_that.score,_that.feedback,_that.questionType,_that.essayType);case _:
  return null;

}
}

}

/// @nodoc


class _WritingAnswer implements WritingAnswer {
  const _WritingAnswer({this.id, this.detailId, required this.testTask, required this.createdAt, required this.promptText, required final  List<String> topics, required this.answerText, required this.duration, required this.isGraded, this.achievement, this.coherence, this.lexial, this.grammatical, this.score, this.feedback, this.questionType, this.essayType}): _topics = topics;
  

@override final  int? id;
@override final  int? detailId;
@override final  TestTask testTask;
@override final  DateTime createdAt;
@override final  String promptText;
 final  List<String> _topics;
@override List<String> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  String answerText;
@override final  int duration;
@override final  bool isGraded;
@override final  double? achievement;
@override final  double? coherence;
@override final  double? lexial;
@override final  double? grammatical;
@override final  double? score;
@override final  String? feedback;
@override final  WritingTask1QuestionType? questionType;
@override final  WritingTask2EssayType? essayType;

/// Create a copy of WritingAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WritingAnswerCopyWith<_WritingAnswer> get copyWith => __$WritingAnswerCopyWithImpl<_WritingAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WritingAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.promptText, promptText) || other.promptText == promptText)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.answerText, answerText) || other.answerText == answerText)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.achievement, achievement) || other.achievement == achievement)&&(identical(other.coherence, coherence) || other.coherence == coherence)&&(identical(other.lexial, lexial) || other.lexial == lexial)&&(identical(other.grammatical, grammatical) || other.grammatical == grammatical)&&(identical(other.score, score) || other.score == score)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.essayType, essayType) || other.essayType == essayType));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,testTask,createdAt,promptText,const DeepCollectionEquality().hash(_topics),answerText,duration,isGraded,achievement,coherence,lexial,grammatical,score,feedback,questionType,essayType);

@override
String toString() {
  return 'WritingAnswer(id: $id, detailId: $detailId, testTask: $testTask, createdAt: $createdAt, promptText: $promptText, topics: $topics, answerText: $answerText, duration: $duration, isGraded: $isGraded, achievement: $achievement, coherence: $coherence, lexial: $lexial, grammatical: $grammatical, score: $score, feedback: $feedback, questionType: $questionType, essayType: $essayType)';
}


}

/// @nodoc
abstract mixin class _$WritingAnswerCopyWith<$Res> implements $WritingAnswerCopyWith<$Res> {
  factory _$WritingAnswerCopyWith(_WritingAnswer value, $Res Function(_WritingAnswer) _then) = __$WritingAnswerCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? detailId, TestTask testTask, DateTime createdAt, String promptText, List<String> topics, String answerText, int duration, bool isGraded, double? achievement, double? coherence, double? lexial, double? grammatical, double? score, String? feedback, WritingTask1QuestionType? questionType, WritingTask2EssayType? essayType
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? detailId = freezed,Object? testTask = null,Object? createdAt = null,Object? promptText = null,Object? topics = null,Object? answerText = null,Object? duration = null,Object? isGraded = null,Object? achievement = freezed,Object? coherence = freezed,Object? lexial = freezed,Object? grammatical = freezed,Object? score = freezed,Object? feedback = freezed,Object? questionType = freezed,Object? essayType = freezed,}) {
  return _then(_WritingAnswer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,promptText: null == promptText ? _self.promptText : promptText // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,answerText: null == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,achievement: freezed == achievement ? _self.achievement : achievement // ignore: cast_nullable_to_non_nullable
as double?,coherence: freezed == coherence ? _self.coherence : coherence // ignore: cast_nullable_to_non_nullable
as double?,lexial: freezed == lexial ? _self.lexial : lexial // ignore: cast_nullable_to_non_nullable
as double?,grammatical: freezed == grammatical ? _self.grammatical : grammatical // ignore: cast_nullable_to_non_nullable
as double?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,questionType: freezed == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as WritingTask1QuestionType?,essayType: freezed == essayType ? _self.essayType : essayType // ignore: cast_nullable_to_non_nullable
as WritingTask2EssayType?,
  ));
}


}

// dart format on
