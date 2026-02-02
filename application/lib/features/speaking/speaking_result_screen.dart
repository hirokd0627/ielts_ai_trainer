import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/speaking/chat_row.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_answer_repository.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_result_controller.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:provider/provider.dart';

/// Speaking Result Screen for Part 1, Part 2 and Part 3 that displays the grading resutls and feedback.
class SpeakingResultScreen extends StatefulWidget {
  /// The id of the user answer to display.
  final int userAnswerId;

  /// The task type.
  final TestTask testTask;

  const SpeakingResultScreen({
    super.key,
    required this.userAnswerId,
    required this.testTask,
  });

  @override
  State<SpeakingResultScreen> createState() => _SpeakingResultScreenState();
}

/// State for SpeakingResultScreen.
class _SpeakingResultScreenState extends State<SpeakingResultScreen> {
  late final SpeakingResultController _ctrl;

  /// Returns the screen title based on the part.
  String get _screenTitle {
    if (widget.testTask == TestTask.speakingPart1) {
      return 'Speaking Task 1 Result';
    } else if (widget.testTask == TestTask.speakingPart2) {
      return 'Speaking Task 2 Result';
    }
    return 'Speaking Task 3 Result';
  }

  @override
  void initState() {
    super.initState();

    _ctrl = SpeakingResultController(
      repo: SpeakingAnswerRepository(context.read<AppDatabase>()),
      apiSrv: SpeakingApiService(),
      testTask: widget.testTask,
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

  /// Returns a widget that shows score label and value.
  Widget _scoreCellBuilder(
    BuildContext context,
    String title,
    String value,
    bool small,
  ) {
    final titleStyle = small
        ? TextStyle(fontSize: 15, fontWeight: FontWeight.w400)
        : TextStyle(fontSize: 22, fontWeight: FontWeight.w400);
    final valueStyle = small
        ? TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
        : TextStyle(fontSize: 40, fontWeight: FontWeight.w500);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: titleStyle),
          const SizedBox(height: 8),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }

  /// Called when the Play button is pressed.
  void _onPressedPlay(int index) async {
    if (_ctrl.isPlaying) {
      await _ctrl.stopPlaying();
    } else {
      if (widget.testTask == TestTask.speakingPart2) {
        await _ctrl.startPlayingSpeechAudio();
      } else {
        await _ctrl.startPlayingChatAudio(index);
      }
    }
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
                  // Score
                  Center(
                    child: SizedBox(
                      height: 200,
                      width: 500,
                      child: !_ctrl.isGraded
                          ? Center(child: const Text('grading...'))
                          : Row(
                              children: [
                                // one cell at left
                                Expanded(
                                  flex: 3,
                                  child: _scoreCellBuilder(
                                    context,
                                    'Overall',
                                    _ctrl.overallScore,
                                    false,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Four cells at right
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: _scoreCellBuilder(
                                                context,
                                                'Fluency',
                                                _ctrl.fluencyScore,
                                                true,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: _scoreCellBuilder(
                                                context,
                                                'Coherence',
                                                _ctrl.coherenceScore,
                                                true,
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
                                              child: _scoreCellBuilder(
                                                context,
                                                'Grammatical',
                                                _ctrl.grammaticalScore,
                                                true,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: _scoreCellBuilder(
                                                context,
                                                'Lexial',
                                                _ctrl.lexialScore,
                                                true,
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
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question and answers
                        if (widget.testTask == TestTask.speakingPart2) ...[
                          // Part 2 result details
                          // Question
                          HeadlineText("Question"),
                          SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 60),
                            child: Text(_ctrl.promptText),
                          ),
                          SizedBox(height: 20),
                          // Note
                          HeadlineText("Note"),
                          SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 60),
                            child: Text(_ctrl.note),
                          ),
                          SizedBox(height: 20),
                          // Answer
                          HeadlineText("Answer"),
                          SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 60),
                            child: Text(_ctrl.answerText),
                          ),
                          // Play button
                          OutlinedButton(
                            onPressed: _ctrl.isPlayButtonEnabledAt(1)
                                ? () => _onPressedPlay(1)
                                : null,
                            style: ButtonStyle(
                              side: WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.hovered)) {
                                  return BorderSide(
                                    color: AppColors.focusColor,
                                    width: 1,
                                  );
                                }
                                return BorderSide(
                                  color: AppColors.checkboxBorderColor,
                                  width: 1,
                                );
                              }),
                            ),
                            child: Text(_ctrl.getPlayButtonLabelAt(1)),
                          ),
                        ] else ...[
                          // Part 1 or Part 3
                          // Conversation
                          HeadlineText("Conversation"),
                          SizedBox(height: 16),
                          Column(
                            children: _ctrl.utterances.mapIndexed((i, u) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ChatRow(
                                  isUser: u.isUser,
                                  text: u.text,
                                  isResultView: true,
                                  index: i,
                                  onPressedPlay: _ctrl.isPlayButtonEnabledAt(i)
                                      ? _onPressedPlay
                                      : null,
                                  showPlayButton: true,
                                  playingButtonLabel: _ctrl
                                      .getPlayButtonLabelAt(i),
                                  fluencyScore:
                                      _ctrl.isGraded && _ctrl.isRecorded(i)
                                      ? u.fluency
                                      : null,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                        SizedBox(height: 20),
                        // Feedback
                        HeadlineText("Feedback"),
                        SizedBox(height: 4),
                        ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 60),
                          child: !_ctrl.isGraded
                              ? Text('grading...')
                              : Text(_ctrl.feedbackText),
                        ),

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
