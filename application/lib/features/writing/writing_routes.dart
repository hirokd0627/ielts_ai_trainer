import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/app/router_extra.dart';
import 'package:ielts_ai_trainer/features/writing/writing_result_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task1_answer_input_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task1_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task2_answer_input_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task2_question_generator_screen.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

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

/// Route path for Writing Task1 Result screen.
final writingTask1ResultScreenRoutePath = '/writing-task1/result';

/// Route path for Writing Task2 Result screen.
final writingTask2ResultScreenRoutePath = '/writing-task2/result';

/// GoRoute for Writing screens.
final writingRoutes = [
  // Task1
  GoRoute(
    path: writingTask1QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return WritingTask1QuestionGeneratorScreen(
        writingPrompt: extra?.getValue('writingPrompt'),
        topics: extra?.getValue('topics'),
        promptType: extra?.getValue('promptType'),
      );
    },
  ),
  GoRoute(
    path: writingTask1AnswerInputScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, [
        'writingPrompt',
        'topics',
        'promptType',
      ]);

      return WritingTask1AnswerInputScreen(
        writingPrompt: extra.getValue('writingPrompt'),
        topics: extra.getValue('topics'),
        promptType: extra.getValue('promptType'),
      );
    },
  ),
  GoRoute(
    path: writingTask1ResultScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, ['id']);
      return WritingResultScreen(
        testTask: TestTask.writingTask1,
        userAnswerId: extra.getValue('id'),
      );
    },
  ),
  // Task2
  GoRoute(
    path: writingTask2QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as RouterExtra?;
      return WritingTask2QuestionGeneratorScreen(
        writingPrompt: extra?.getValue('writingPrompt'),
        topics: extra?.getValue('topics'),
        promptType: extra?.getValue('promptType'),
      );
    },
  ),
  GoRoute(
    path: writingTask2AnswerInputScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, [
        'writingPrompt',
        'topics',
        'promptType',
      ]);

      return WritingTask2AnswerInputScreen(
        writingPrompt: extra.getValue('writingPrompt'),
        topics: extra.getValue('topics'),
        promptType: extra.getValue('promptType'),
      );
    },
  ),
  GoRoute(
    path: writingTask2ResultScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      final extra = RouterExtra.validate(state, ['id']);
      return WritingResultScreen(
        testTask: TestTask.writingTask2,
        userAnswerId: extra.getValue('id'),
      );
    },
  ),
];
