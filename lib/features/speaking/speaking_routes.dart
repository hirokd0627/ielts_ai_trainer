import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_part1_answer_input_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_part3_answer_input_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_part2_answer_input_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_part1_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_part2_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_part3_question_generator_screen.dart';

/// Route path for Speaking Part1 Question Generator screen.
final speakingPart1QuestionGeneratorScreenRoutePath =
    '/speaking-topic1/question-generation';

/// Route path for Speaking Part2 Question Generator screen.
final speakingPart2QuestionGeneratorScreenRoutePath =
    '/speaking-topic2/question-generation';

/// Route path for Speaking Part3 Question Generator screen.
final speakingPart3QuestionGeneratorScreenRoutePath =
    '/speaking-topic3/question-generation';

/// Route path for Speaking Part1 Answer Input screen.
final speakingPart1AnswerInputScreenRoutePath = '/speaking-topic1/answer-input';

/// Route path for Speaking Part2 Answer Input screen.
final speakingPart2AnswerInputScreenRoutePath = '/speaking-topic2/answer-input';

/// Route path for Speaking Part3 Answer Input screen.
final speakingPart3AnswerInputScreenRoutePath = '/speaking-topic3/answer-input';

/// Route path for Speaking Part1 Result screen.
final speakingPart1ResultScreenRoutePath = '/speaking-topic1/result';

/// Route path for Speaking Part2 Result screen.
final speakingPart2ResultScreenRoutePath = '/speaking-topic2/result';

/// Route path for Speaking Part3 Result screen.
final speakingPart3ResultScreenRoutePath = '/speaking-topic3/result';

/// GoRoute for Speaking screens.
final speakingRoutes = [
  // Part1
  GoRoute(
    path: speakingPart1QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return SpeakingPart1QuestionGeneratorScreen(
        topics: extra?.getValue('topics'),
        promptText: extra?.getValue('promptText'),
      );
    },
  ),
  GoRoute(
    path: speakingPart1AnswerInputScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, [
        'initialPromptText',
        'topics',
      ]);
      return SpeakingPart1AnswerInputScreen(
        initialPromptText: extra.getValue('initialPromptText'),
        topics: extra.getValue('topics'),
      );
    },
  ),

  // Part2
  GoRoute(
    path: speakingPart2QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return SpeakingPart2QuestionGeneratorScreen(
        topics: extra?.getValue('topics'),
        promptText: extra?.getValue('promptText'),
      );
    },
  ),
  GoRoute(
    path: speakingPart2AnswerInputScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, ['promptText', 'topics']);

      return SpeakingPart2AnswerInputScreen(
        promptText: extra.getValue('promptText'),
        topics: extra.getValue('topics'),
      );
    },
  ),

  // Part3
  GoRoute(
    path: speakingPart3QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return SpeakingPart3QuestionGeneratorScreen(
        topics: extra?.getValue('topics'),
        promptText: extra?.getValue('promptText'),
      );
    },
  ),
  GoRoute(
    path: speakingPart3AnswerInputScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, [
        'initialPromptText',
        'topics',
      ]);
      return SpeakingPart3AnswerInputScreen(
        initialPromptText: extra.getValue('initialPromptText'),
        topics: extra.getValue('topics'),
      );
    },
  ),
];
