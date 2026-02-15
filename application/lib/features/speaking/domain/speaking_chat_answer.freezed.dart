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

 int? get id; int? get detailId; List<SpeakingUtteranceVO> get utterances; DateTime get createdAt; List<PromptTopic> get topics; int get duration; bool get isGraded; TestTask get testTask; double? get coherenceScore; double? get lexicalScore; double? get grammaticalScore; String? get coherenceFeedback; String? get lexicalFeedback; String? get grammaticalFeedback;
/// Create a copy of SpeakingChatAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakingChatAnswerCopyWith<SpeakingChatAnswer> get copyWith => _$SpeakingChatAnswerCopyWithImpl<SpeakingChatAnswer>(this as SpeakingChatAnswer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakingChatAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&const DeepCollectionEquality().equals(other.utterances, utterances)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.coherenceScore, coherenceScore) || other.coherenceScore == coherenceScore)&&(identical(other.lexicalScore, lexicalScore) || other.lexicalScore == lexicalScore)&&(identical(other.grammaticalScore, grammaticalScore) || other.grammaticalScore == grammaticalScore)&&(identical(other.coherenceFeedback, coherenceFeedback) || other.coherenceFeedback == coherenceFeedback)&&(identical(other.lexicalFeedback, lexicalFeedback) || other.lexicalFeedback == lexicalFeedback)&&(identical(other.grammaticalFeedback, grammaticalFeedback) || other.grammaticalFeedback == grammaticalFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,const DeepCollectionEquality().hash(utterances),createdAt,const DeepCollectionEquality().hash(topics),duration,isGraded,testTask,coherenceScore,lexicalScore,grammaticalScore,coherenceFeedback,lexicalFeedback,grammaticalFeedback);

@override
String toString() {
  return 'SpeakingChatAnswer(id: $id, detailId: $detailId, utterances: $utterances, createdAt: $createdAt, topics: $topics, duration: $duration, isGraded: $isGraded, testTask: $testTask, coherenceScore: $coherenceScore, lexicalScore: $lexicalScore, grammaticalScore: $grammaticalScore, coherenceFeedback: $coherenceFeedback, lexicalFeedback: $lexicalFeedback, grammaticalFeedback: $grammaticalFeedback)';
}


}

/// @nodoc
abstract mixin class $SpeakingChatAnswerCopyWith<$Res>  {
  factory $SpeakingChatAnswerCopyWith(SpeakingChatAnswer value, $Res Function(SpeakingChatAnswer) _then) = _$SpeakingChatAnswerCopyWithImpl;
@useResult
$Res call({
 int? id, int? detailId, List<SpeakingUtteranceVO> utterances, DateTime createdAt, List<PromptTopic> topics, int duration, bool isGraded, TestTask testTask, double? coherenceScore, double? lexicalScore, double? grammaticalScore, String? coherenceFeedback, String? lexicalFeedback, String? grammaticalFeedback
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? detailId = freezed,Object? utterances = null,Object? createdAt = null,Object? topics = null,Object? duration = null,Object? isGraded = null,Object? testTask = null,Object? coherenceScore = freezed,Object? lexicalScore = freezed,Object? grammaticalScore = freezed,Object? coherenceFeedback = freezed,Object? lexicalFeedback = freezed,Object? grammaticalFeedback = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,utterances: null == utterances ? _self.utterances : utterances // ignore: cast_nullable_to_non_nullable
as List<SpeakingUtteranceVO>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,coherenceScore: freezed == coherenceScore ? _self.coherenceScore : coherenceScore // ignore: cast_nullable_to_non_nullable
as double?,lexicalScore: freezed == lexicalScore ? _self.lexicalScore : lexicalScore // ignore: cast_nullable_to_non_nullable
as double?,grammaticalScore: freezed == grammaticalScore ? _self.grammaticalScore : grammaticalScore // ignore: cast_nullable_to_non_nullable
as double?,coherenceFeedback: freezed == coherenceFeedback ? _self.coherenceFeedback : coherenceFeedback // ignore: cast_nullable_to_non_nullable
as String?,lexicalFeedback: freezed == lexicalFeedback ? _self.lexicalFeedback : lexicalFeedback // ignore: cast_nullable_to_non_nullable
as String?,grammaticalFeedback: freezed == grammaticalFeedback ? _self.grammaticalFeedback : grammaticalFeedback // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? detailId,  List<SpeakingUtteranceVO> utterances,  DateTime createdAt,  List<PromptTopic> topics,  int duration,  bool isGraded,  TestTask testTask,  double? coherenceScore,  double? lexicalScore,  double? grammaticalScore,  String? coherenceFeedback,  String? lexicalFeedback,  String? grammaticalFeedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakingChatAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.utterances,_that.createdAt,_that.topics,_that.duration,_that.isGraded,_that.testTask,_that.coherenceScore,_that.lexicalScore,_that.grammaticalScore,_that.coherenceFeedback,_that.lexicalFeedback,_that.grammaticalFeedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? detailId,  List<SpeakingUtteranceVO> utterances,  DateTime createdAt,  List<PromptTopic> topics,  int duration,  bool isGraded,  TestTask testTask,  double? coherenceScore,  double? lexicalScore,  double? grammaticalScore,  String? coherenceFeedback,  String? lexicalFeedback,  String? grammaticalFeedback)  $default,) {final _that = this;
switch (_that) {
case _SpeakingChatAnswer():
return $default(_that.id,_that.detailId,_that.utterances,_that.createdAt,_that.topics,_that.duration,_that.isGraded,_that.testTask,_that.coherenceScore,_that.lexicalScore,_that.grammaticalScore,_that.coherenceFeedback,_that.lexicalFeedback,_that.grammaticalFeedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? detailId,  List<SpeakingUtteranceVO> utterances,  DateTime createdAt,  List<PromptTopic> topics,  int duration,  bool isGraded,  TestTask testTask,  double? coherenceScore,  double? lexicalScore,  double? grammaticalScore,  String? coherenceFeedback,  String? lexicalFeedback,  String? grammaticalFeedback)?  $default,) {final _that = this;
switch (_that) {
case _SpeakingChatAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.utterances,_that.createdAt,_that.topics,_that.duration,_that.isGraded,_that.testTask,_that.coherenceScore,_that.lexicalScore,_that.grammaticalScore,_that.coherenceFeedback,_that.lexicalFeedback,_that.grammaticalFeedback);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakingChatAnswer extends SpeakingChatAnswer {
  const _SpeakingChatAnswer({this.id, this.detailId, required final  List<SpeakingUtteranceVO> utterances, required this.createdAt, required final  List<PromptTopic> topics, required this.duration, required this.isGraded, required this.testTask, this.coherenceScore, this.lexicalScore, this.grammaticalScore, this.coherenceFeedback, this.lexicalFeedback, this.grammaticalFeedback}): _utterances = utterances,_topics = topics,super._();
  

@override final  int? id;
@override final  int? detailId;
 final  List<SpeakingUtteranceVO> _utterances;
@override List<SpeakingUtteranceVO> get utterances {
  if (_utterances is EqualUnmodifiableListView) return _utterances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_utterances);
}

@override final  DateTime createdAt;
 final  List<PromptTopic> _topics;
@override List<PromptTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  int duration;
@override final  bool isGraded;
@override final  TestTask testTask;
@override final  double? coherenceScore;
@override final  double? lexicalScore;
@override final  double? grammaticalScore;
@override final  String? coherenceFeedback;
@override final  String? lexicalFeedback;
@override final  String? grammaticalFeedback;

/// Create a copy of SpeakingChatAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakingChatAnswerCopyWith<_SpeakingChatAnswer> get copyWith => __$SpeakingChatAnswerCopyWithImpl<_SpeakingChatAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakingChatAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&const DeepCollectionEquality().equals(other._utterances, _utterances)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.testTask, testTask) || other.testTask == testTask)&&(identical(other.coherenceScore, coherenceScore) || other.coherenceScore == coherenceScore)&&(identical(other.lexicalScore, lexicalScore) || other.lexicalScore == lexicalScore)&&(identical(other.grammaticalScore, grammaticalScore) || other.grammaticalScore == grammaticalScore)&&(identical(other.coherenceFeedback, coherenceFeedback) || other.coherenceFeedback == coherenceFeedback)&&(identical(other.lexicalFeedback, lexicalFeedback) || other.lexicalFeedback == lexicalFeedback)&&(identical(other.grammaticalFeedback, grammaticalFeedback) || other.grammaticalFeedback == grammaticalFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,const DeepCollectionEquality().hash(_utterances),createdAt,const DeepCollectionEquality().hash(_topics),duration,isGraded,testTask,coherenceScore,lexicalScore,grammaticalScore,coherenceFeedback,lexicalFeedback,grammaticalFeedback);

@override
String toString() {
  return 'SpeakingChatAnswer(id: $id, detailId: $detailId, utterances: $utterances, createdAt: $createdAt, topics: $topics, duration: $duration, isGraded: $isGraded, testTask: $testTask, coherenceScore: $coherenceScore, lexicalScore: $lexicalScore, grammaticalScore: $grammaticalScore, coherenceFeedback: $coherenceFeedback, lexicalFeedback: $lexicalFeedback, grammaticalFeedback: $grammaticalFeedback)';
}


}

/// @nodoc
abstract mixin class _$SpeakingChatAnswerCopyWith<$Res> implements $SpeakingChatAnswerCopyWith<$Res> {
  factory _$SpeakingChatAnswerCopyWith(_SpeakingChatAnswer value, $Res Function(_SpeakingChatAnswer) _then) = __$SpeakingChatAnswerCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? detailId, List<SpeakingUtteranceVO> utterances, DateTime createdAt, List<PromptTopic> topics, int duration, bool isGraded, TestTask testTask, double? coherenceScore, double? lexicalScore, double? grammaticalScore, String? coherenceFeedback, String? lexicalFeedback, String? grammaticalFeedback
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? detailId = freezed,Object? utterances = null,Object? createdAt = null,Object? topics = null,Object? duration = null,Object? isGraded = null,Object? testTask = null,Object? coherenceScore = freezed,Object? lexicalScore = freezed,Object? grammaticalScore = freezed,Object? coherenceFeedback = freezed,Object? lexicalFeedback = freezed,Object? grammaticalFeedback = freezed,}) {
  return _then(_SpeakingChatAnswer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,utterances: null == utterances ? _self._utterances : utterances // ignore: cast_nullable_to_non_nullable
as List<SpeakingUtteranceVO>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,testTask: null == testTask ? _self.testTask : testTask // ignore: cast_nullable_to_non_nullable
as TestTask,coherenceScore: freezed == coherenceScore ? _self.coherenceScore : coherenceScore // ignore: cast_nullable_to_non_nullable
as double?,lexicalScore: freezed == lexicalScore ? _self.lexicalScore : lexicalScore // ignore: cast_nullable_to_non_nullable
as double?,grammaticalScore: freezed == grammaticalScore ? _self.grammaticalScore : grammaticalScore // ignore: cast_nullable_to_non_nullable
as double?,coherenceFeedback: freezed == coherenceFeedback ? _self.coherenceFeedback : coherenceFeedback // ignore: cast_nullable_to_non_nullable
as String?,lexicalFeedback: freezed == lexicalFeedback ? _self.lexicalFeedback : lexicalFeedback // ignore: cast_nullable_to_non_nullable
as String?,grammaticalFeedback: freezed == grammaticalFeedback ? _self.grammaticalFeedback : grammaticalFeedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
