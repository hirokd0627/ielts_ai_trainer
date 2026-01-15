import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_ai_trainer/features/writing/writing_task1_question_generator_screen.dart';

/// Route path for Writing Task1 Question Generator screen
final writingTask1QuestionGeneratorScreenRoutPath =
    '/writing-task1/question-generation';

/// GoRoute for Writing screens
final writingRoutes = [
  // Task1
  GoRoute(
    path: writingTask1QuestionGeneratorScreenRoutPath,
    builder: (BuildContext context, GoRouterState state) {
      return const WritingTask1QuestionGeneratorScreen();
    },
  ),
];
