import 'package:drift/drift.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';

part 'writing_answer_repository.g.dart';

/// Repository for UserAnswersTable
@DriftAccessor(
  tables: [UserAnswersTable, WritingAnswerDetailsTable, PromptTopicsTable],
)
class WritingAnswerRepository extends DatabaseAccessor<AppDatabase>
    with _$WritingAnswerRepositoryMixin {
  WritingAnswerRepository(super.attachedDatabase);

  /// Saves the user's answer of writing task.
  Future<int> saveUserAnswerWriting(WritingAnswer answer) async {
    return transaction<int>(() async {
      // UserAnswer
      final upId = await into(
        userAnswersTable,
      ).insert(_toUserAnswersTableCompanion(answer));

      // Details
      // WritingTask1HistoryDetails
      await into(writingAnswerDetailsTable).insert(
        _toWritingAnswerDetailsTableCompanion(answer.copyWith(id: upId)),
      );

      // Topics
      for (var i = 0; i < answer.topics.length; i++) {
        await into(
          promptTopicsTable,
        ).insert(_toPromptTopicsTableCompanion(upId, i, answer.topics[i]));
      }

      return upId;
    });
  }

  /// Converts WritingAnswer into UserAnswersTableCompanion.
  UserAnswersTableCompanion _toUserAnswersTableCompanion(WritingAnswer answer) {
    return UserAnswersTableCompanion(
      testTask: Value(answer.testTask),
      createdAt: Value(answer.createdAt.toUtc()),
    );
  }

  /// Converts WritingAnswer into WritingAnswerDetailsTableCompanion .
  WritingAnswerDetailsTableCompanion _toWritingAnswerDetailsTableCompanion(
    WritingAnswer answer,
  ) {
    return WritingAnswerDetailsTableCompanion(
      id: answer.detailId != null
          ? Value(answer.detailId!)
          : const Value.absent(),
      userAnswer: answer.id != null ? Value(answer.id!) : const Value.absent(),
      promptText: Value(answer.promptText),
      answerText: Value(answer.answerText),
      duration: Value(answer.duration),
      score: Value(answer.score),
      achievementScore: Value(answer.achievement),
      coherenceScore: Value(answer.coherence),
      lexialScore: Value(answer.lexial),
      grammaticalScore: Value(answer.grammatical),
      isGraded: Value(answer.isGraded),
      feedback: Value(answer.feedback),
    );
  }

  // Creates PromptTopicsTableCompanion.
  PromptTopicsTableCompanion _toPromptTopicsTableCompanion(
    int answerId,
    int order,
    String topic,
  ) {
    return PromptTopicsTableCompanion(
      userAnswer: Value(answerId),
      order: Value(order),
      title: Value(topic),
    );
  }
}
