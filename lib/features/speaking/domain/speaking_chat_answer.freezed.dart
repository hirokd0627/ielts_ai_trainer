// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaking_chat_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeakingChatAnswer {

 int? get id; int? get detailId; List<SpeakingUtteranceVO> get utterances; DateTime get createdAt; DateTime get updatedAt; List<PromptTopic> get topics; int get duration; bool get isGraded; TestTask get testTask; double? get coherence; double? get lexial; double? get grammatical; double? get fluency; double? get score; String? get feedback;
/// Create a copy of SpeakingChatAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakingChatAnswerCopyWith<SpeakingChatAnswer> get copyWith => _$SpeakingChatAnswerCopyWithImpl<SpeakingChatAnswer>(this as SpeakingChatAnswer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakingChatAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&const DeepCollectionEquality().equals(other.utterances, utterances)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.coherence, coherence) || other.coherence == coherence)&&(identical(other.lexial, lexial) || other.lexial == lexial)&&(identical(other.grammatical, grammatical) || other.grammatical == grammatical)&&(identical(other.fluency, fluency) || other.fluency == fluency)&&(identical(other.score, score) || other.score == score)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,const DeepCollectionEquality().hash(utterances),createdAt,updatedAt,const DeepCollectionEquality().hash(topics),duration,isGraded,testTask,coherence,lexial,grammatical,fluency,score,feedback);

@override
String toString() {
  return 'SpeakingChatAnswer(id: $id, detailId: $detailId, utterances: $utterances, createdAt: $createdAt, updatedAt: $updatedAt, topics: $topics, duration: $duration, isGraded: $isGraded, testTask: $testTask, coherence: $coherence, lexial: $lexial, grammatical: $grammatical, fluency: $fluency, score: $score, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class $SpeakingChatAnswerCopyWith<$Res>  {
  factory $SpeakingChatAnswerCopyWith(SpeakingChatAnswer value, $Res Function(SpeakingChatAnswer) _then) = _$SpeakingChatAnswerCopyWithImpl;
@useResult
$Res call({
 int? id, int? detailId, List<SpeakingUtteranceVO> utterances, DateTime createdAt, DateTime updatedAt, List<PromptTopic> topics, int duration, bool isGraded, TestTask testTask, double? coherence, double? lexial, double? grammatical, double? fluency, double? score, String? feedback
});




}
/// @nodoc
class _$SpeakingChatAnswerCopyWithImpl<$Res>
    implements $SpeakingChatAnswerCopyWith<$Res> {
  _$SpeakingChatAnswerCopyWithImpl(this._self, this._then);

  final SpeakingChatAnswer _self;
  final $Res Function(SpeakingChatAnswer) _then;

/// Create a copy of SpeakingChatAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? detailId = freezed,Object? utterances = null,Object? createdAt = null,Object? updatedAt = null,Object? topics = null,Object? duration = null,Object? isGraded = null,Object? testTask = null,Object? coherence = freezed,Object? lexial = freezed,Object? grammatical = freezed,Object? fluency = freezed,Object? score = freezed,Object? feedback = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,utterances: null == utterances ? _self.utterances : utterances // ignore: cast_nullable_to_non_nullable
as List<SpeakingUtteranceVO>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,coherence: freezed == coherence ? _self.coherence : coherence // ignore: cast_nullable_to_non_nullable
as double?,lexial: freezed == lexial ? _self.lexial : lexial // ignore: cast_nullable_to_non_nullable
as double?,grammatical: freezed == grammatical ? _self.grammatical : grammatical // ignore: cast_nullable_to_non_nullable
as double?,fluency: freezed == fluency ? _self.fluency : fluency // ignore: cast_nullable_to_non_nullable
as double?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakingChatAnswer].
extension SpeakingChatAnswerPatterns on SpeakingChatAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakingChatAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakingChatAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakingChatAnswer value)  $default,){
final _that = this;
switch (_that) {
case _SpeakingChatAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakingChatAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakingChatAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? detailId,  List<SpeakingUtteranceVO> utterances,  DateTime createdAt,  DateTime updatedAt,  List<PromptTopic> topics,  int duration,  bool isGraded,  TestTask testTask,  double? coherence,  double? lexial,  double? grammatical,  double? fluency,  double? score,  String? feedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakingChatAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.utterances,_that.createdAt,_that.updatedAt,_that.topics,_that.duration,_that.isGraded,_that.testTask,_that.coherence,_that.lexial,_that.grammatical,_that.fluency,_that.score,_that.feedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? detailId,  List<SpeakingUtteranceVO> utterances,  DateTime createdAt,  DateTime updatedAt,  List<PromptTopic> topics,  int duration,  bool isGraded,  TestTask testTask,  double? coherence,  double? lexial,  double? grammatical,  double? fluency,  double? score,  String? feedback)  $default,) {final _that = this;
switch (_that) {
case _SpeakingChatAnswer():
return $default(_that.id,_that.detailId,_that.utterances,_that.createdAt,_that.updatedAt,_that.topics,_that.duration,_that.isGraded,_that.testTask,_that.coherence,_that.lexial,_that.grammatical,_that.fluency,_that.score,_that.feedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? detailId,  List<SpeakingUtteranceVO> utterances,  DateTime createdAt,  DateTime updatedAt,  List<PromptTopic> topics,  int duration,  bool isGraded,  TestTask testTask,  double? coherence,  double? lexial,  double? grammatical,  double? fluency,  double? score,  String? feedback)?  $default,) {final _that = this;
switch (_that) {
case _SpeakingChatAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.utterances,_that.createdAt,_that.updatedAt,_that.topics,_that.duration,_that.isGraded,_that.testTask,_that.coherence,_that.lexial,_that.grammatical,_that.fluency,_that.score,_that.feedback);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakingChatAnswer implements SpeakingChatAnswer {
  const _SpeakingChatAnswer({this.id, this.detailId, required final  List<SpeakingUtteranceVO> utterances, required this.createdAt, required this.updatedAt, required final  List<PromptTopic> topics, required this.duration, required this.isGraded, required this.testTask, this.coherence, this.lexial, this.grammatical, this.fluency, this.score, this.feedback}): _utterances = utterances,_topics = topics;
  

@override final  int? id;
@override final  int? detailId;
 final  List<SpeakingUtteranceVO> _utterances;
@override List<SpeakingUtteranceVO> get utterances {
  if (_utterances is EqualUnmodifiableListView) return _utterances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_utterances);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<PromptTopic> _topics;
@override List<PromptTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  int duration;
@override final  bool isGraded;
@override final  TestTask testTask;
@override final  double? coherence;
@override final  double? lexial;
@override final  double? grammatical;
@override final  double? fluency;
@override final  double? score;
@override final  String? feedback;

/// Create a copy of SpeakingChatAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakingChatAnswerCopyWith<_SpeakingChatAnswer> get copyWith => __$SpeakingChatAnswerCopyWithImpl<_SpeakingChatAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakingChatAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&const DeepCollectionEquality().equals(other._utterances, _utterances)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.coherence, coherence) || other.coherence == coherence)&&(identical(other.lexial, lexial) || other.lexial == lexial)&&(identical(other.grammatical, grammatical) || other.grammatical == grammatical)&&(identical(other.fluency, fluency) || other.fluency == fluency)&&(identical(other.score, score) || other.score == score)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,const DeepCollectionEquality().hash(_utterances),createdAt,updatedAt,const DeepCollectionEquality().hash(_topics),duration,isGraded,testTask,coherence,lexial,grammatical,fluency,score,feedback);

@override
String toString() {
  return 'SpeakingChatAnswer(id: $id, detailId: $detailId, utterances: $utterances, createdAt: $createdAt, updatedAt: $updatedAt, topics: $topics, duration: $duration, isGraded: $isGraded, testTask: $testTask, coherence: $coherence, lexial: $lexial, grammatical: $grammatical, fluency: $fluency, score: $score, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class _$SpeakingChatAnswerCopyWith<$Res> implements $SpeakingChatAnswerCopyWith<$Res> {
  factory _$SpeakingChatAnswerCopyWith(_SpeakingChatAnswer value, $Res Function(_SpeakingChatAnswer) _then) = __$SpeakingChatAnswerCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? detailId, List<SpeakingUtteranceVO> utterances, DateTime createdAt, DateTime updatedAt, List<PromptTopic> topics, int duration, bool isGraded, TestTask testTask, double? coherence, double? lexial, double? grammatical, double? fluency, double? score, String? feedback
});




}
/// @nodoc
class __$SpeakingChatAnswerCopyWithImpl<$Res>
    implements _$SpeakingChatAnswerCopyWith<$Res> {
  __$SpeakingChatAnswerCopyWithImpl(this._self, this._then);

  final _SpeakingChatAnswer _self;
  final $Res Function(_SpeakingChatAnswer) _then;

/// Create a copy of SpeakingChatAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? detailId = freezed,Object? utterances = null,Object? createdAt = null,Object? updatedAt = null,Object? topics = null,Object? duration = null,Object? isGraded = null,Object? testTask = null,Object? coherence = freezed,Object? lexial = freezed,Object? grammatical = freezed,Object? fluency = freezed,Object? score = freezed,Object? feedback = freezed,}) {
  return _then(_SpeakingChatAnswer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,utterances: null == utterances ? _self._utterances : utterances // ignore: cast_nullable_to_non_nullable
as List<SpeakingUtteranceVO>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,coherence: freezed == coherence ? _self.coherence : coherence // ignore: cast_nullable_to_non_nullable
as double?,lexial: freezed == lexial ? _self.lexial : lexial // ignore: cast_nullable_to_non_nullable
as double?,grammatical: freezed == grammatical ? _self.grammatical : grammatical // ignore: cast_nullable_to_non_nullable
as double?,fluency: freezed == fluency ? _self.fluency : fluency // ignore: cast_nullable_to_non_nullable
as double?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
