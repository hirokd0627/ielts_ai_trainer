import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task1_answer_input_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task1_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task2_answer_input_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task2_question_generator_screen.dart';

/// Route path for Writing Task1 Question Generator screen.
final writingTask1QuestionGeneratorScreenRoutePath =
    '/writing-task1/question-generation';

/// Route path for Writing Task2 Question Generator screen.
final writingTask2QuestionGeneratorScreenRoutePath =
    '/writing-task2/question-generation';

/// Route path for Writing Task1 Answer Input screen.
final writingTask1AnswerInputScreenRoutePath = '/writing-task1/answer-input';

/// Route path for Writing Task2 Answer Input screen.
final writingTask2AnswerInputScreenRoutePath = '/writing-task2/answer-input';

/// GoRoute for Writing screens.
final writingRoutes = [
  // Task1
  GoRoute(
    path: writingTask1QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return WritingTask1QuestionGeneratorScreen(
        promptText: extra?.getValue('promptText'),
        topics: extra?.getValue('topics'),
        questionType: extra?.getValue('questionType'),
      );
    },
  ),
  GoRoute(
    path: writingTask1AnswerInputScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, [
        'promptText',
        'topics',
        'questionType',
      ]);

      return WritingTask1AnswerInputScreen(
        promptText: extra.getValue('promptText'),
        topics: extra.getValue('topics'),
        questionType: extra.getValue('questionType'),
      );
    },
  ),
  // Task2
  GoRoute(
    path: writingTask2QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return WritingTask2QuestionGeneratorScreen(
        promptText: extra?.getValue('promptText'),
        topics: extra?.getValue('topics'),
        essayType: extra?.getValue('essayType'),
      );
    },
  ),
  GoRoute(
    path: writingTask2AnswerInputScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, [
        'promptText',
        'topics',
        'essayType',
      ]);

      return WritingTask2AnswerInputScreen(
        promptText: extra.getValue('promptText'),
        topics: extra.getValue('topics'),
        essayType: extra.getValue('essayType'),
      );
    },
  ),
];
