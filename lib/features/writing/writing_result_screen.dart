import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer_repository.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_result_controller.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:provider/provider.dart';

/// Writing Result Screen for Task 1 and 2 that displays the grading resutls and feedback.
class WritingResultScreen extends StatefulWidget {
  /// The id of the user answer to display.
  final int userAnswerId;

  /// The task type.
  final TestTask testTask;

  const WritingResultScreen({
    super.key,
    required this.userAnswerId,
    required this.testTask,
  });

  @override
  State<WritingResultScreen> createState() => _WritingResultScreenState();
}

/// State for WritingResultScreen.
class _WritingResultScreenState extends State<WritingResultScreen> {
  late final WritingResultController _ctrl;

  /// Returns the screen title based on the task type.
  String get _screenTitle {
    return widget.testTask == TestTask.writingTask1
        ? 'Writing Task 1 Result'
        : 'Writing Task 2 Result';
  }

  @override
  void initState() {
    super.initState();

    _ctrl = WritingResultController(
      repo: WritingAnswerRepository(context.read<AppDatabase>()),
      apiSrv: WritingApiService(),
    );

    _loadInitialDate();
  }

  /// Loads the initial data.
  Future<void> _loadInitialDate() async {
    await _ctrl.loadData(widget.userAnswerId);

    // Grades the answer if it is not graded.
    if (!_ctrl.isGraded) {
      _ctrl.grade();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return BaseScreenScaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _screenTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                // Score
                SizedBox(
                  height: 400,
                  child: Row(
                    children: [
                      // one cell at left
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.blue,
                          child: Center(child: Text(_ctrl.overallScore)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Four cells at right
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(_ctrl.achievementScore),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(_ctrl.coherenceScore),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(_ctrl.grammaticalScore),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(_ctrl.lexialScore),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Question
                HeadlineText("Question"),
                Text(_ctrl.promptText),
                // Answer
                HeadlineText("Answer"),
                Text(_ctrl.answerText),
                // Feedback
                HeadlineText("Feedback"),
                Text(_ctrl.feedbackText),
              ],
            ),
          ),
        );
      },
    );
  }
}
