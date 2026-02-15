// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaking_speech_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeakingSpeechAnswer {

 int? get id; int? get detailId; int? get utteranceId; DateTime get createdAt; SpeakingUtteranceVO get prompt; List<PromptTopic> get topics; SpeakingUtteranceVO get answer; int get duration; bool get isGraded; String? get note; double? get coherenceScore; double? get lexicalScore; double? get grammaticalScore; String? get coherenceFeedback; String? get lexicalFeedback; String? get grammaticalFeedback;
/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakingSpeechAnswerCopyWith<SpeakingSpeechAnswer> get copyWith => _$SpeakingSpeechAnswerCopyWithImpl<SpeakingSpeechAnswer>(this as SpeakingSpeechAnswer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakingSpeechAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&(identical(other.utteranceId, utteranceId) || other.utteranceId == utteranceId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.note, note) || other.note == note)&&(identical(other.coherenceScore, coherenceScore) || other.coherenceScore == coherenceScore)&&(identical(other.lexicalScore, lexicalScore) || other.lexicalScore == lexicalScore)&&(identical(other.grammaticalScore, grammaticalScore) || other.grammaticalScore == grammaticalScore)&&(identical(other.coherenceFeedback, coherenceFeedback) || other.coherenceFeedback == coherenceFeedback)&&(identical(other.lexicalFeedback, lexicalFeedback) || other.lexicalFeedback == lexicalFeedback)&&(identical(other.grammaticalFeedback, grammaticalFeedback) || other.grammaticalFeedback == grammaticalFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,utteranceId,createdAt,prompt,const DeepCollectionEquality().hash(topics),answer,duration,isGraded,note,coherenceScore,lexicalScore,grammaticalScore,coherenceFeedback,lexicalFeedback,grammaticalFeedback);

@override
String toString() {
  return 'SpeakingSpeechAnswer(id: $id, detailId: $detailId, utteranceId: $utteranceId, createdAt: $createdAt, prompt: $prompt, topics: $topics, answer: $answer, duration: $duration, isGraded: $isGraded, note: $note, coherenceScore: $coherenceScore, lexicalScore: $lexicalScore, grammaticalScore: $grammaticalScore, coherenceFeedback: $coherenceFeedback, lexicalFeedback: $lexicalFeedback, grammaticalFeedback: $grammaticalFeedback)';
}


}

/// @nodoc
abstract mixin class $SpeakingSpeechAnswerCopyWith<$Res>  {
  factory $SpeakingSpeechAnswerCopyWith(SpeakingSpeechAnswer value, $Res Function(SpeakingSpeechAnswer) _then) = _$SpeakingSpeechAnswerCopyWithImpl;
@useResult
$Res call({
 int? id, int? detailId, int? utteranceId, DateTime createdAt, SpeakingUtteranceVO prompt, List<PromptTopic> topics, SpeakingUtteranceVO answer, int duration, bool isGraded, String? note, double? coherenceScore, double? lexicalScore, double? grammaticalScore, String? coherenceFeedback, String? lexicalFeedback, String? grammaticalFeedback
});


$SpeakingUtteranceVOCopyWith<$Res> get prompt;$SpeakingUtteranceVOCopyWith<$Res> get answer;

}
/// @nodoc
class _$SpeakingSpeechAnswerCopyWithImpl<$Res>
    implements $SpeakingSpeechAnswerCopyWith<$Res> {
  _$SpeakingSpeechAnswerCopyWithImpl(this._self, this._then);

  final SpeakingSpeechAnswer _self;
  final $Res Function(SpeakingSpeechAnswer) _then;

/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? detailId = freezed,Object? utteranceId = freezed,Object? createdAt = null,Object? prompt = null,Object? topics = null,Object? answer = null,Object? duration = null,Object? isGraded = null,Object? note = freezed,Object? coherenceScore = freezed,Object? lexicalScore = freezed,Object? grammaticalScore = freezed,Object? coherenceFeedback = freezed,Object? lexicalFeedback = freezed,Object? grammaticalFeedback = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,utteranceId: freezed == utteranceId ? _self.utteranceId : utteranceId // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as SpeakingUtteranceVO,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as SpeakingUtteranceVO,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,coherenceScore: freezed == coherenceScore ? _self.coherenceScore : coherenceScore // ignore: cast_nullable_to_non_nullable
as double?,lexicalScore: freezed == lexicalScore ? _self.lexicalScore : lexicalScore // ignore: cast_nullable_to_non_nullable
as double?,grammaticalScore: freezed == grammaticalScore ? _self.grammaticalScore : grammaticalScore // ignore: cast_nullable_to_non_nullable
as double?,coherenceFeedback: freezed == coherenceFeedback ? _self.coherenceFeedback : coherenceFeedback // ignore: cast_nullable_to_non_nullable
as String?,lexicalFeedback: freezed == lexicalFeedback ? _self.lexicalFeedback : lexicalFeedback // ignore: cast_nullable_to_non_nullable
as String?,grammaticalFeedback: freezed == grammaticalFeedback ? _self.grammaticalFeedback : grammaticalFeedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakingUtteranceVOCopyWith<$Res> get prompt {
  
  return $SpeakingUtteranceVOCopyWith<$Res>(_self.prompt, (value) {
    return _then(_self.copyWith(prompt: value));
  });
}/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakingUtteranceVOCopyWith<$Res> get answer {
  
  return $SpeakingUtteranceVOCopyWith<$Res>(_self.answer, (value) {
    return _then(_self.copyWith(answer: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpeakingSpeechAnswer].
extension SpeakingSpeechAnswerPatterns on SpeakingSpeechAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakingSpeechAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakingSpeechAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakingSpeechAnswer value)  $default,){
final _that = this;
switch (_that) {
case _SpeakingSpeechAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakingSpeechAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakingSpeechAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? detailId,  int? utteranceId,  DateTime createdAt,  SpeakingUtteranceVO prompt,  List<PromptTopic> topics,  SpeakingUtteranceVO answer,  int duration,  bool isGraded,  String? note,  double? coherenceScore,  double? lexicalScore,  double? grammaticalScore,  String? coherenceFeedback,  String? lexicalFeedback,  String? grammaticalFeedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakingSpeechAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.utteranceId,_that.createdAt,_that.prompt,_that.topics,_that.answer,_that.duration,_that.isGraded,_that.note,_that.coherenceScore,_that.lexicalScore,_that.grammaticalScore,_that.coherenceFeedback,_that.lexicalFeedback,_that.grammaticalFeedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? detailId,  int? utteranceId,  DateTime createdAt,  SpeakingUtteranceVO prompt,  List<PromptTopic> topics,  SpeakingUtteranceVO answer,  int duration,  bool isGraded,  String? note,  double? coherenceScore,  double? lexicalScore,  double? grammaticalScore,  String? coherenceFeedback,  String? lexicalFeedback,  String? grammaticalFeedback)  $default,) {final _that = this;
switch (_that) {
case _SpeakingSpeechAnswer():
return $default(_that.id,_that.detailId,_that.utteranceId,_that.createdAt,_that.prompt,_that.topics,_that.answer,_that.duration,_that.isGraded,_that.note,_that.coherenceScore,_that.lexicalScore,_that.grammaticalScore,_that.coherenceFeedback,_that.lexicalFeedback,_that.grammaticalFeedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? detailId,  int? utteranceId,  DateTime createdAt,  SpeakingUtteranceVO prompt,  List<PromptTopic> topics,  SpeakingUtteranceVO answer,  int duration,  bool isGraded,  String? note,  double? coherenceScore,  double? lexicalScore,  double? grammaticalScore,  String? coherenceFeedback,  String? lexicalFeedback,  String? grammaticalFeedback)?  $default,) {final _that = this;
switch (_that) {
case _SpeakingSpeechAnswer() when $default != null:
return $default(_that.id,_that.detailId,_that.utteranceId,_that.createdAt,_that.prompt,_that.topics,_that.answer,_that.duration,_that.isGraded,_that.note,_that.coherenceScore,_that.lexicalScore,_that.grammaticalScore,_that.coherenceFeedback,_that.lexicalFeedback,_that.grammaticalFeedback);case _:
  return null;

}
}

}

/// @nodoc


class _SpeakingSpeechAnswer extends SpeakingSpeechAnswer {
  const _SpeakingSpeechAnswer({this.id, this.detailId, this.utteranceId, required this.createdAt, required this.prompt, required final  List<PromptTopic> topics, required this.answer, required this.duration, required this.isGraded, this.note, this.coherenceScore, this.lexicalScore, this.grammaticalScore, this.coherenceFeedback, this.lexicalFeedback, this.grammaticalFeedback}): _topics = topics,super._();
  

@override final  int? id;
@override final  int? detailId;
@override final  int? utteranceId;
@override final  DateTime createdAt;
@override final  SpeakingUtteranceVO prompt;
 final  List<PromptTopic> _topics;
@override List<PromptTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  SpeakingUtteranceVO answer;
@override final  int duration;
@override final  bool isGraded;
@override final  String? note;
@override final  double? coherenceScore;
@override final  double? lexicalScore;
@override final  double? grammaticalScore;
@override final  String? coherenceFeedback;
@override final  String? lexicalFeedback;
@override final  String? grammaticalFeedback;

/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakingSpeechAnswerCopyWith<_SpeakingSpeechAnswer> get copyWith => __$SpeakingSpeechAnswerCopyWithImpl<_SpeakingSpeechAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakingSpeechAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.detailId, detailId) || other.detailId == detailId)&&(identical(other.utteranceId, utteranceId) || other.utteranceId == utteranceId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isGraded, isGraded) || other.isGraded == isGraded)&&(identical(other.note, note) || other.note == note)&&(identical(other.coherenceScore, coherenceScore) || other.coherenceScore == coherenceScore)&&(identical(other.lexicalScore, lexicalScore) || other.lexicalScore == lexicalScore)&&(identical(other.grammaticalScore, grammaticalScore) || other.grammaticalScore == grammaticalScore)&&(identical(other.coherenceFeedback, coherenceFeedback) || other.coherenceFeedback == coherenceFeedback)&&(identical(other.lexicalFeedback, lexicalFeedback) || other.lexicalFeedback == lexicalFeedback)&&(identical(other.grammaticalFeedback, grammaticalFeedback) || other.grammaticalFeedback == grammaticalFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,id,detailId,utteranceId,createdAt,prompt,const DeepCollectionEquality().hash(_topics),answer,duration,isGraded,note,coherenceScore,lexicalScore,grammaticalScore,coherenceFeedback,lexicalFeedback,grammaticalFeedback);

@override
String toString() {
  return 'SpeakingSpeechAnswer(id: $id, detailId: $detailId, utteranceId: $utteranceId, createdAt: $createdAt, prompt: $prompt, topics: $topics, answer: $answer, duration: $duration, isGraded: $isGraded, note: $note, coherenceScore: $coherenceScore, lexicalScore: $lexicalScore, grammaticalScore: $grammaticalScore, coherenceFeedback: $coherenceFeedback, lexicalFeedback: $lexicalFeedback, grammaticalFeedback: $grammaticalFeedback)';
}


}

/// @nodoc
abstract mixin class _$SpeakingSpeechAnswerCopyWith<$Res> implements $SpeakingSpeechAnswerCopyWith<$Res> {
  factory _$SpeakingSpeechAnswerCopyWith(_SpeakingSpeechAnswer value, $Res Function(_SpeakingSpeechAnswer) _then) = __$SpeakingSpeechAnswerCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? detailId, int? utteranceId, DateTime createdAt, SpeakingUtteranceVO prompt, List<PromptTopic> topics, SpeakingUtteranceVO answer, int duration, bool isGraded, String? note, double? coherenceScore, double? lexicalScore, double? grammaticalScore, String? coherenceFeedback, String? lexicalFeedback, String? grammaticalFeedback
});


@override $SpeakingUtteranceVOCopyWith<$Res> get prompt;@override $SpeakingUtteranceVOCopyWith<$Res> get answer;

}
/// @nodoc
class __$SpeakingSpeechAnswerCopyWithImpl<$Res>
    implements _$SpeakingSpeechAnswerCopyWith<$Res> {
  __$SpeakingSpeechAnswerCopyWithImpl(this._self, this._then);

  final _SpeakingSpeechAnswer _self;
  final $Res Function(_SpeakingSpeechAnswer) _then;

/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? detailId = freezed,Object? utteranceId = freezed,Object? createdAt = null,Object? prompt = null,Object? topics = null,Object? answer = null,Object? duration = null,Object? isGraded = null,Object? note = freezed,Object? coherenceScore = freezed,Object? lexicalScore = freezed,Object? grammaticalScore = freezed,Object? coherenceFeedback = freezed,Object? lexicalFeedback = freezed,Object? grammaticalFeedback = freezed,}) {
  return _then(_SpeakingSpeechAnswer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,detailId: freezed == detailId ? _self.detailId : detailId // ignore: cast_nullable_to_non_nullable
as int?,utteranceId: freezed == utteranceId ? _self.utteranceId : utteranceId // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as SpeakingUtteranceVO,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<PromptTopic>,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as SpeakingUtteranceVO,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isGraded: null == isGraded ? _self.isGraded : isGraded // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,coherenceScore: freezed == coherenceScore ? _self.coherenceScore : coherenceScore // ignore: cast_nullable_to_non_nullable
as double?,lexicalScore: freezed == lexicalScore ? _self.lexicalScore : lexicalScore // ignore: cast_nullable_to_non_nullable
as double?,grammaticalScore: freezed == grammaticalScore ? _self.grammaticalScore : grammaticalScore // ignore: cast_nullable_to_non_nullable
as double?,coherenceFeedback: freezed == coherenceFeedback ? _self.coherenceFeedback : coherenceFeedback // ignore: cast_nullable_to_non_nullable
as String?,lexicalFeedback: freezed == lexicalFeedback ? _self.lexicalFeedback : lexicalFeedback // ignore: cast_nullable_to_non_nullable
as String?,grammaticalFeedback: freezed == grammaticalFeedback ? _self.grammaticalFeedback : grammaticalFeedback // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakingUtteranceVOCopyWith<$Res> get prompt {
  
  return $SpeakingUtteranceVOCopyWith<$Res>(_self.prompt, (value) {
    return _then(_self.copyWith(prompt: value));
  });
}/// Create a copy of SpeakingSpeechAnswer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpeakingUtteranceVOCopyWith<$Res> get answer {
  
  return $SpeakingUtteranceVOCopyWith<$Res>(_self.answer, (value) {
    return _then(_self.copyWith(answer: value));
  });
}
}

// dart format on
