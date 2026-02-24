import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer_repository.dart';
import 'package:ielts_ai_trainer/features/writing/writing_api_service.dart';
import 'package:ielts_ai_trainer/features/writing/writing_result_controller.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/logging/logger.dart';
import 'package:ielts_ai_trainer/shared/utils/dialog.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:ielts_ai_trainer/shared/views/loading_indicator.dart';
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
  final _logger = createLogger('_WritingResultScreenState');
  late final WritingResultController _ctrl;

  /// Returns the screen title based on the task type.
  String get _screenTitle {
    return widget.testTask == TestTask.writingTask1
        ? 'Writing Task 1 Result'
        : 'Writing Task 2 Result';
  }

  /// Returns the task criteria label.
  String get _taskCriteriaLabel {
    return widget.testTask == TestTask.writingTask1
        ? 'Task Achievement'
        : 'Task Response';
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
    try {
      await _ctrl.loadData(widget.userAnswerId);

      // Grades the answer if it is not graded.
      if (!_ctrl.isGraded) {
        await _ctrl.evaluateAnswer();
      }
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      if (mounted) {
        showAlertDialog(context, 'Failed to load data');
      }
    }
  }

  /// Builds a widget to show each criteria score.
  Widget _buildCriteriaRow(String label, String score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "$label:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 5),
            Text(
              score,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }

  /// Builds a widget to show the scores.
  Widget _buildScore() {
    return Center(
      child: SizedBox(
        height: 160,
        width: 600,
        child: !_ctrl.isGraded && !_ctrl.isEvaluationFailed
            ? Center(child: LoadingIndicator('Reviewing...'))
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Band Score',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          _ctrl.bandScore,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCriteriaRow(
                          _taskCriteriaLabel,
                          _ctrl.isEvaluationFailed ? '-' : _ctrl.taskScore,
                        ),
                        _buildCriteriaRow(
                          'Coherence & Cohesion',
                          _ctrl.isEvaluationFailed ? '-' : _ctrl.coherenceScore,
                        ),
                        _buildCriteriaRow(
                          'Lexical Resource',
                          _ctrl.isEvaluationFailed ? '-' : _ctrl.lexicalScore,
                        ),
                        _buildCriteriaRow(
                          'Grammatical Range & Accuracy',
                          _ctrl.isEvaluationFailed
                              ? '-'
                              : _ctrl.grammaticalScore,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// Builds widgets to show feedback for the answer.
  List<Widget> _buildFeedback() {
    return [
      HeadlineText("Feedback"),
      SizedBox(height: 20),
      ConstrainedBox(
        constraints: BoxConstraints(minHeight: 60),
        child: _ctrl.isEvaluationFailed
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineText(_taskCriteriaLabel, level: 2),
                  Text('-'),
                  SizedBox(height: 20),
                  HeadlineText('Coherence & Cohesion', level: 2),
                  Text('-'),
                  SizedBox(height: 20),
                  HeadlineText('Lexical Resource', level: 2),
                  Text('-'),
                  SizedBox(height: 20),
                  HeadlineText('Grammatical Range & Accuracy', level: 2),
                  Text('-'),
                ],
              )
            : !_ctrl.isGraded
            ? LoadingIndicator('Reviewing...')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineText(_taskCriteriaLabel, level: 2),
                  Text(_ctrl.taskFeedback),
                  SizedBox(height: 20),
                  HeadlineText('Coherence & Cohesion', level: 2),
                  Text(_ctrl.coherenceFeedback),
                  SizedBox(height: 20),
                  HeadlineText('Lexical Resource', level: 2),
                  Text(_ctrl.lexicalFeedback),
                  SizedBox(height: 20),
                  HeadlineText('Grammatical Range & Accuracy', level: 2),
                  Text(_ctrl.grammaticalFeedback),
                ],
              ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return BaseScreenScaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppStyles.screenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  // Title
                  Text(
                    _screenTitle,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 20),
                  // Score
                  _buildScore(),
                  SizedBox(height: 20),
                  // Question, Answer, Feedback
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question
                        HeadlineText("Question"),
                        SizedBox(height: 20),
                        if (widget.testTask == TestTask.writingTask1) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_ctrl.taskContext),
                              if (_ctrl.existsDiagramFile)
                                Container(
                                  alignment: AlignmentGeometry.center,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Image.file(
                                    File(_ctrl.diagramPath),
                                    width: 500,
                                  ),
                                ),
                              Text(_ctrl.taskInstruction),
                            ],
                          ),
                        ],
                        if (widget.testTask == TestTask.writingTask2) ...[
                          Text(_ctrl.task2PromptText),
                        ],
                        SizedBox(height: 40),
                        // Answer
                        HeadlineText("Answer"),
                        SizedBox(height: 20),
                        Text(_ctrl.answerText),
                        SizedBox(height: 40),
                        // Feedback
                        ..._buildFeedback(),

                        SizedBox(height: AppStyles.screenBottomPadding),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
