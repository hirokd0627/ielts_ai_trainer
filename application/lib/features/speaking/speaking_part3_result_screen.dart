import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/features/speaking/speaking_result_screen.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Speaking Part 3 Result Screen.
class SpeakingPart3ResultScreen extends StatelessWidget {
  /// The id of the user answer to display.
  final int userAnswerId;

  const SpeakingPart3ResultScreen({super.key, required this.userAnswerId});

  @override
  Widget build(BuildContext context) {
    return SpeakingResultScreen(
      userAnswerId: userAnswerId,
      testTask: TestTask.speakingPart3,
    );
  }
}
