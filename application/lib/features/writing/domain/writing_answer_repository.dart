import 'package:drift/drift.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_answer.dart';
import 'package:ielts_ai_trainer/features/writing/domain/writing_prompt_vo.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';
import 'package:ielts_ai_trainer/shared/enums/writing_prompt_type.dart';

part 'writing_answer_repository.g.dart';

/// Repository for the writing UserAnswersTable.
@DriftAccessor(
  tables: [UserAnswersTable, WritingAnswerDetailsTable, PromptTopicsTable],
)
class WritingAnswerRepository extends DatabaseAccessor<AppDatabase>
    with _$WritingAnswerRepositoryMixin {
  WritingAnswerRepository(super.attachedDatabase);

  /// Selects an answer for the given id.
  Future<WritingAnswer> selectAnswerById(int id) async {
    // Join
    final joins = <Join<HasResultSet, dynamic>>[];
    joins.add(
      leftOuterJoin(
        writingAnswerDetailsTable,
        writingAnswerDetailsTable.userAnswerId.equalsExp(userAnswersTable.id),
      ),
    );

    final joinedQuery = select(userAnswersTable).join(joins);

    // Where
    joinedQuery.where(userAnswersTable.id.equals(id));

    // UserAnswers and Details
    final row = await joinedQuery.getSingle();

    // Topics
    final topicsRows =
        await (select(promptTopicsTable)
              ..where((t) => t.userAnswerId.equals(id))
              ..orderBy([
                (t) => OrderingTerm.asc(t.userAnswerId),
                (t) => OrderingTerm.asc(t.order),
              ]))
            .get();
    final topics = topicsRows
        .map((row) => PromptTopic(order: row.order, title: row.title))
        .toList();

    /// Converts a database query row into a WritingAnswer.
    final userAnswer = row.readTable(userAnswersTable);
    final detail = row.readTable(writingAnswerDetailsTable);
    return WritingAnswer(
      id: userAnswer.id,
      detailId: detail.id,
      testTask: userAnswer.testTask,
      createdAt: userAnswer.createdAt,
      updatedAt: detail.updatedAt,
      promptType: WritingPromptType.fromString(detail.promptType),
      writingPrompt: WritingPromptVo(
        taskContext: detail.taskContext,
        taskInstruction: detail.taskInstruction,
        diagramDescription: detail.diagramDescription,
        diagramUuid: detail.diagramFileUuid,
      ),
      topics: topics,
      answerText: detail.answerText,
      duration: detail.duration,
      isGraded: detail.isGraded,
      taskScore: detail.taskScore,
      coherenceScore: detail.coherenceScore,
      lexialScore: detail.lexialScore,
      grammaticalScore: detail.grammaticalScore,
      bandScore: detail.bandScore,
      taskFeedback: detail.taskFeedback,
      coherenceFeedback: detail.coherencekFeedback,
      lexialFeedback: detail.lexialFeedback,
      grammaticalFeedback: detail.grammaticalFeedback,
    );
  }

  /// Saves a user's answer for writing task.
  Future<int> saveUserAnswerWriting(WritingAnswer answer) async {
    return transaction<int>(() async {
      // UserAnswer
      final upId = await into(userAnswersTable).insert(
        _toUserAnswersTableCompanion(answer),
        mode: InsertMode.insertOrReplace,
      );

      // Details
      // WritingTask1HistoryDetails
      await into(writingAnswerDetailsTable).insert(
        _toWritingAnswerDetailsTableCompanion(answer.copyWith(id: upId)),
        mode: InsertMode.insertOrReplace,
      );

      // Topics
      for (var i = 0; i < answer.topics.length; i++) {
        await into(promptTopicsTable).insert(
          _toPromptTopicsTableCompanion(upId, answer.topics[i]),

          mode: InsertMode.insertOrReplace,
        );
      }

      return upId;
    });
  }

  /// Converts WritingAnswer into UserAnswersTableCompanion.
  UserAnswersTableCompanion _toUserAnswersTableCompanion(WritingAnswer answer) {
    return UserAnswersTableCompanion(
      id: answer.id != null ? Value(answer.id!) : const Value.absent(),
      testTask: Value(answer.testTask),
      createdAt: Value(answer.createdAt.toUtc()),
    );
  }

  /// Converts WritingAnswer into WritingAnswerDetailsTableCompanion.
  WritingAnswerDetailsTableCompanion _toWritingAnswerDetailsTableCompanion(
    WritingAnswer answer,
  ) {
    return WritingAnswerDetailsTableCompanion(
      id: answer.detailId != null
          ? Value(answer.detailId!)
          : const Value.absent(),
      userAnswerId: answer.id != null
          ? Value(answer.id!)
          : const Value.absent(),
      taskContext: Value(answer.writingPrompt.taskContext),
      taskInstruction: Value(answer.writingPrompt.taskInstruction),
      diagramDescription: Value(answer.writingPrompt.diagramDescription),
      diagramFileUuid: Value(answer.writingPrompt.diagramUuid),
      promptType: Value(answer.promptType.name),
      answerText: Value(answer.answerText),
      duration: Value(answer.duration),
      bandScore: Value(answer.bandScore),
      taskScore: Value(answer.taskScore),
      coherenceScore: Value(answer.coherenceScore),
      lexialScore: Value(answer.lexialScore),
      grammaticalScore: Value(answer.grammaticalScore),
      isGraded: Value(answer.isGraded),
      taskFeedback: Value(answer.taskFeedback),
      coherencekFeedback: Value(answer.coherenceFeedback),
      lexialFeedback: Value(answer.lexialFeedback),
      grammaticalFeedback: Value(answer.grammaticalFeedback),
      updatedAt: Value(answer.updatedAt.toUtc()),
    );
  }

  // Creates a PromptTopicsTableCompanion for the given answer id and topic.
  PromptTopicsTableCompanion _toPromptTopicsTableCompanion(
    int answerId,
    PromptTopic topic,
  ) {
    return PromptTopicsTableCompanion(
      userAnswerId: Value(answerId),
      order: Value(topic.order),
      title: Value(topic.title),
    );
  }
}
