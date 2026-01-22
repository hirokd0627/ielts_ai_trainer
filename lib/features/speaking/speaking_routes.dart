import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_topic1_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_topic2_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_topic3_question_generator_screen.dart';

/// Route path for Speaking Topic1 Question Generator screen.
final speakingTopic1QuestionGeneratorScreenRoutePath =
    '/speaking-topic1/question-generation';

/// Route path for Speaking Topic2 Question Generator screen.
final speakingTopic2QuestionGeneratorScreenRoutePath =
    '/speaking-topic2/question-generation';

/// Route path for Speaking Topic3 Question Generator screen.
final speakingTopic3QuestionGeneratorScreenRoutePath =
    '/speaking-topic3/question-generation';

/// Route path for Speaking Topic1 Answer Input screen.
final speakingTopic1AnswerInputScreenRoutePath =
    '/speaking-topic1/answer-input';

/// Route path for Speaking Topic2 Answer Input screen.
final speakingTopic2AnswerInputScreenRoutePath =
    '/speaking-topic2/answer-input';

/// Route path for Speaking Topic3 Answer Input screen.
final speakingTopic3AnswerInputScreenRoutePath =
    '/speaking-topic3/answer-input';

/// Route path for Speaking Topic1 Result screen.
final speakingTopic1ResultScreenRoutePath = '/speaking-topic1/result';

/// Route path for Speaking Topic2 Result screen.
final speakingTopic2ResultScreenRoutePath = '/speaking-topic2/result';

/// Route path for Speaking Topic3 Result screen.
final speakingTopic3ResultScreenRoutePath = '/speaking-topic3/result';

/// GoRoute for Speaking screens.
final speakingRoutes = [
  // Topic1
  GoRoute(
    path: speakingTopic1QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return SpeakingTopic1QuestionGeneratorScreen(
        topics: extra?.getValue('topics'),
        promptText: extra?.getValue('promptText'),
      );
    },
  ),
  // Topic2
  GoRoute(
    path: speakingTopic2QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return SpeakingTopic2QuestionGeneratorScreen(
        topics: extra?.getValue('topics'),
        promptText: extra?.getValue('promptText'),
      );
    },
  ),
  // Topic3
  GoRoute(
    path: speakingTopic3QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return SpeakingTopic3QuestionGeneratorScreen(
        topics: extra?.getValue('topics'),
        promptText: extra?.getValue('promptText'),
      );
    },
  ),
];
