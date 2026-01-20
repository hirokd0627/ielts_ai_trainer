import 'package:freezed_annotation/freezed_annotation.dart';

part 'writing_topic.freezed.dart';

/// Prompt topic entity of Writing task.
@freezed
abstract class WritingTopic with _$WritingTopic {
  const factory WritingTopic({
    int? id,
    required int order,
    required String title,
  }) = _WritingTopic;
}
