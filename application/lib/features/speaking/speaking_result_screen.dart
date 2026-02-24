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
import 'package:ielts_ai_trainer/shared/logging/logger.dart';
import 'package:ielts_ai_trainer/shared/utils/dialog.dart';
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
  final _logger = createLogger('_SpeakingResultScreenState');

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
    try {
      await _ctrl.loadData(widget.userAnswerId);

      // Grades the answer if it is not graded.
      await _ctrl.evaluateAnswer();
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      if (mounted) {
        showAlertDialog(context, 'Failed to load data');
      }
    }
  }

  /// Called when the Play button is pressed.
  void _onPressedPlay(int index) async {
    try {
      if (_ctrl.isPlaying) {
        await _ctrl.stopPlaying();
      } else {
        if (widget.testTask == TestTask.speakingPart2) {
          await _ctrl.startPlayingSpeechAudio();
        } else {
          await _ctrl.startPlayingChatAudio(index);
        }
      }
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      if (mounted) {
        showAlertDialog(context, 'Failed to sart playback');
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
                          _ctrl.isEvaluationFailed ? '-' : _ctrl.bandScore,
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
                          _ctrl.isEvaluatedPronunciation
                              ? 'Fluency and Coherence'
                              : 'Coherence',
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
                        _buildCriteriaRow(
                          'Pronunciation',
                          _ctrl.isEvaluationFailed
                              ? '-'
                              : _ctrl.pronunciationScore,
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
  /// Fluency and Pronunciation feedback cannnot show
  /// because Azure Speech Service does not have these features.
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
                  HeadlineText('Coherence', level: 2),
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

  /// Builds a widget to show pronunciation score.
  Widget _buildPronunciationScoreWidget(SpeakingUtteranceVO u) {
    if (!u.isGraded && !_ctrl.isUtteranceEvaluationFailed(u.order - 1)) {
      return LoadingIndicator('Reviewing...');
    }
    final evaluationFailed = _ctrl.isUtteranceEvaluationFailed(u.order - 1);
    final pronunciationScore = evaluationFailed ? '-' : u.pronunciationScore;
    final fluencyScore = evaluationFailed ? '-' : u.pronunciationScore;
    return Wrap(
      spacing: 10.0,
      children: [
        Text('Pronunciation: $pronunciationScore'),
        Text('Fluency: $fluencyScore'),
      ],
    );
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
                          SizedBox(height: 20),
                          Text(_ctrl.promptText),
                          SizedBox(height: 40),
                          // Note
                          HeadlineText("Note"),
                          SizedBox(height: 20),
                          Text(_ctrl.note),
                          SizedBox(height: 40),
                          // Answer
                          HeadlineText("Answer"),
                          SizedBox(height: 20),
                          Text(_ctrl.answerText),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.end,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (_ctrl.isRecorded(1))
                                _buildPronunciationScoreWidget(
                                  _ctrl.speechUtterance,
                                ),
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
                          SizedBox(height: 20),
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
                                  scoreWidget: _ctrl.isRecorded(i)
                                      ? _buildPronunciationScoreWidget(u)
                                      : null,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
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
