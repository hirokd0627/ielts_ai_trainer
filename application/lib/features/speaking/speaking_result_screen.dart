import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/speaking/chat_row.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_answer_repository.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_api_service.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_result_controller.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:ielts_ai_trainer/shared/views/buttons.dart';
import 'package:ielts_ai_trainer/shared/views/loading_indicator.dart';
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
    _ctrl.evaluateAnswer();
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 5),
            Text(
              score,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
        height: 200,
        width: 600,
        child: !_ctrl.isGraded
            ? Center(child: LoadingIndicator('Evaluating...'))
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
                        const SizedBox(height: 8),
                        Text(
                          _ctrl.bandScore,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCriteriaRow('Coherence', _ctrl.coherenceScore),
                        _buildCriteriaRow(
                          'Lexical Resource',
                          _ctrl.lexicalScore,
                        ),
                        _buildCriteriaRow(
                          'Grammatical Range & Accuracy',
                          _ctrl.grammaticalScore,
                        ),
                        _buildCriteriaRow('Pronanciation', _ctrl.fluencyScore),
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
        child: !_ctrl.isGraded
            ? LoadingIndicator('Evaluating...')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineText('Coherence', level: 2),
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

  /// Builds a widget to show fluency score.
  Widget _buildFluencyScoreWidget(SpeakingUtteranceVO u) {
    if (!u.isGraded) {
      return Text('Grading...');
    }
    return Text('Fluency: ${u.fluency}');
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
                  _buildScore(),
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
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (_ctrl.isRecorded(1))
                                _buildFluencyScoreWidget(_ctrl.speechUtterance),
                              // Play button
                              buildOutlinedButton(
                                _ctrl.getPlayButtonLabelAt(1),
                                onPressed: _ctrl.isPlayButtonEnabledAt(1)
                                    ? () => _onPressedPlay(1)
                                    : null,
                              ),
                            ],
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
                                  // TODO: fluency -> pronanciation
                                  scoreWidget: _ctrl.isRecorded(i)
                                      ? _buildFluencyScoreWidget(u)
                                      : null,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                        SizedBox(height: 20),
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
