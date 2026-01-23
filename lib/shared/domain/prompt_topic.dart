import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompt_topic.freezed.dart';

/// Prompt topic entity.
@freezed
abstract class PromptTopic with _$PromptTopic {
  const factory PromptTopic({required int order, required String title}) =
      _PromptTopic;
}
