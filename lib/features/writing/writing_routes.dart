import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task1_question_generator_screen.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task2_question_generator_screen.dart';

/// Route path for Writing Task1 Question Generator screen.
final writingTask1QuestionGeneratorScreenRoutePath =
    '/writing-task1/question-generation';

/// Route path for Writing Task2 Question Generator screen.
final writingTask2QuestionGeneratorScreenRoutePath =
    '/writing-task2/question-generation';

/// GoRoute for Writing screens.
final writingRoutes = [
  // Task1
  GoRoute(
    path: writingTask1QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      return const WritingTask1QuestionGeneratorScreen();
    },
  ),
  // Task2
  GoRoute(
    path: writingTask2QuestionGeneratorScreenRoutePath,
    builder: (BuildContext context, GoRouterState state) {
      return const WritingTask2QuestionGeneratorScreen();
    },
  ),
];
