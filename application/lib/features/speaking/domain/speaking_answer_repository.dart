import 'package:drift/drift.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_chat_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_speech_answer.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_id_vo.dart';
import 'package:ielts_ai_trainer/features/speaking/domain/speaking_utterance_vo.dart';
import 'package:ielts_ai_trainer/shared/database/app_database.dart';
import 'package:ielts_ai_trainer/shared/domain/prompt_topic.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

part 'speaking_answer_repository.g.dart';

/// Repository for the speaking UserAnswersTable.
@DriftAccessor(
  tables: [
    UserAnswersTable,
    SpeakingAnswerDetailsTable,
    PromptTopicsTable,
    SpeakingUtterancesTable,
  ],
)
class SpeakingAnswerRepository extends DatabaseAccessor<AppDatabase>
    with _$SpeakingAnswerRepositoryMixin {
  SpeakingAnswerRepository(super.attachedDatabase);

  /// Selects an answer in Part 2 for the given id.
  Future<SpeakingSpeechAnswer> selectPart2AnswerById(int id) async {
    // Join
    final joins = <Join<HasResultSet, dynamic>>[];
    joins.addAll([
      leftOuterJoin(
        speakingAnswerDetailsTable,
        speakingAnswerDetailsTable.userAnswerId.equalsExp(userAnswersTable.id),
      ),
    ]);

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

    // Utterances
    final utteranceRows = await (select(
      speakingUtterancesTable,
    )..where((u) => u.userAnswerId.equals(id))).get();
    String promptText = '';
    String answerText = '';
    for (final row in utteranceRows) {
      if (row.isUser) {
        answerText = row.message;
      } else {
        promptText = row.message;
      }
    }

    /// Converts a database query row into a SpeakingAnswer.
    final userAnswer = row.readTable(userAnswersTable);
    final detail = row.readTable(speakingAnswerDetailsTable);
    return SpeakingSpeechAnswer(
      id: userAnswer.id,
      detailId: detail.id,
      createdAt: userAnswer.createdAt,
      updatedAt: detail.updatedAt,
      topics: topics,
      duration: detail.duration,
      isGraded: detail.isGraded,
      coherence: detail.coherenceScore,
      lexial: detail.lexialScore,
      grammatical: detail.grammaticalScore,
      fluency: detail.fluencyScore,
      score: detail.score,
      feedback: detail.feedback,
      prompt: SpeakingUtteranceVO(order: 1, isUser: false, text: promptText),
      answer: SpeakingUtteranceVO(order: 2, isUser: true, text: answerText),
      note: detail.note,
    );
  }

  /// Selects an answer in Part 1 or Part 3 for the given id.
  Future<SpeakingChatAnswer> selectPart13AnswerById(int id) async {
    // Join
    final joins = <Join<HasResultSet, dynamic>>[];
    joins.addAll([
      leftOuterJoin(
        speakingAnswerDetailsTable,
        speakingAnswerDetailsTable.userAnswerId.equalsExp(userAnswersTable.id),
      ),
    ]);

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

    // Utterances
    final utteranceRows = await (select(
      speakingUtterancesTable,
    )..where((u) => u.userAnswerId.equals(id))).get();
    final utterances = <SpeakingUtteranceVO>[];
    for (final row in utteranceRows) {
      utterances.add(
        SpeakingUtteranceVO(
          order: row.order,
          isUser: row.isUser,
          text: row.message,
          fluency: row.fluencyScore,
        ),
      );
    }

    /// Converts a database query row into a SpeakingAnswer.
    final userAnswer = row.readTable(userAnswersTable);
    final detail = row.readTable(speakingAnswerDetailsTable);
    return SpeakingChatAnswer(
      id: userAnswer.id,
      detailId: detail.id,
      utterances: utterances,
      createdAt: userAnswer.createdAt,
      updatedAt: detail.updatedAt,
      topics: topics,
      duration: detail.duration,
      isGraded: detail.isGraded,
      testTask: userAnswer.testTask,
      coherence: detail.coherenceScore,
      lexial: detail.lexialScore,
      grammatical: detail.grammaticalScore,
      fluency: detail.fluencyScore,
      score: detail.score,
      feedback: detail.feedback,
    );
  }

  /// Saves a user's answer for speaking part 1 or Part 3.
  Future<({int id, List<SpeakingUtteranceIdVO> utteranceIds})>
  saveSpeakingChatAnswer(SpeakingChatAnswer answer) async {
    return await transaction<
      ({int id, List<SpeakingUtteranceIdVO> utteranceIds})
    >(() async {
      // UserAnswer
      final upId = await into(userAnswersTable).insert(
        _convertChatAnswerIntoUserAnswersTableCompanion(answer),
        mode: InsertMode.insertOrReplace,
      );

      // Details
      // SpeakingTask1HistoryDetails
      await into(speakingAnswerDetailsTable).insert(
        _convertChatAnswerIntoSpeakingAnswerDetailsTableCompanion(
          answer.copyWith(id: upId),
        ),
        mode: InsertMode.insertOrReplace,
      );

      // Topics
      final topicCompanions = answer.topics.map((topic) {
        return _toPromptTopicsTableCompanion(upId, topic);
      }).toList();
      await batch((b) {
        b.insertAllOnConflictUpdate(promptTopicsTable, topicCompanions);
      });

      // Utterances
      final utteranceCompanions = <SpeakingUtterancesTableCompanion>[];
      final utteranceIds = <SpeakingUtteranceIdVO>[];
      for (var i = 0; i < answer.utterances.length; i++) {
        utteranceCompanions.add(
          SpeakingUtterancesTableCompanion(
            userAnswerId: Value(upId),
            order: Value(answer.utterances[i].order),
            isUser: Value(answer.utterances[i].isUser),
            message: Value(answer.utterances[i].text),
          ),
        );
        utteranceIds.add(
          SpeakingUtteranceIdVO(userAnswerId: upId, order: i + 1),
        );
      }
      await batch((b) {
        b.insertAllOnConflictUpdate(
          speakingUtterancesTable,
          utteranceCompanions,
        );
      });

      return (id: upId, utteranceIds: utteranceIds);
    });
  }

  /// Saves a user's answer for speaking part 2.
  Future<({int id, SpeakingUtteranceIdVO utteranceId})>
  saveSpeakingSpeechAnswer(SpeakingSpeechAnswer answer) async {
    return await transaction<({int id, SpeakingUtteranceIdVO utteranceId})>(
      () async {
        // UserAnswer
        final upId = await into(userAnswersTable).insert(
          _convertSpeechAnswerIntoUserAnswersTableCompanion(answer),
          mode: InsertMode.insertOrReplace,
        );

        // Details
        // SpeakingTask1HistoryDetails
        await into(speakingAnswerDetailsTable).insert(
          _convertSpeechAnswerIntoSpeakingAnswerDetailsTableCompanion(
            answer.copyWith(id: upId),
          ),
          mode: InsertMode.insertOrReplace,
        );

        // Topics
        final topicCompanions = answer.topics.map((topic) {
          return _toPromptTopicsTableCompanion(upId, topic);
        }).toList();
        await batch((b) {
          b.insertAllOnConflictUpdate(promptTopicsTable, topicCompanions);
        });

        // Utterances
        await into(speakingUtterancesTable).insert(
          SpeakingUtterancesTableCompanion(
            userAnswerId: Value(upId),
            order: Value(1),
            isUser: Value(false),
            message: Value(answer.prompt.text),
          ),
          mode: InsertMode.insertOrReplace,
        );

        await into(speakingUtterancesTable).insert(
          SpeakingUtterancesTableCompanion(
            userAnswerId: Value(upId),
            order: Value(2),
            isUser: Value(true),
            message: Value(answer.answer.text),
          ),
          mode: InsertMode.insertOrReplace,
        );

        return (
          id: upId,
          utteranceId: SpeakingUtteranceIdVO(userAnswerId: upId, order: 2),
        );
      },
    );
  }

  /// Deletes a user's answer for speaking part.
  Future<void> deleteSpeakingUserAnswer(int id) async {
    await transaction<void>(() async {
      // UserAnswer
      await (delete(userAnswersTable)..where((t) => t.id.equals(id))).go();

      // Details
      await (delete(
        speakingAnswerDetailsTable,
      )..where((t) => t.userAnswerId.equals(id))).go();

      // Topics
      await (delete(
        promptTopicsTable,
      )..where((t) => t.userAnswerId.equals(id))).go();

      // Utterances
      await (delete(
        speakingUtterancesTable,
      )..where((t) => t.userAnswerId.equals(id))).go();
    });
  }

  /// Converts SpeakingChatAnswer into UserAnswersTableCompanion.
  UserAnswersTableCompanion _convertChatAnswerIntoUserAnswersTableCompanion(
    SpeakingChatAnswer answer,
  ) {
    return UserAnswersTableCompanion(
      id: answer.id != null ? Value(answer.id!) : const Value.absent(),
      testTask: Value(answer.testTask),
      createdAt: Value(answer.createdAt.toUtc()),
    );
  }

  /// Converts SpeakingSpeechAnswer into UserAnswersTableCompanion.
  UserAnswersTableCompanion _convertSpeechAnswerIntoUserAnswersTableCompanion(
    SpeakingSpeechAnswer answer,
  ) {
    return UserAnswersTableCompanion(
      id: answer.id != null ? Value(answer.id!) : const Value.absent(),
      testTask: Value(TestTask.speakingPart2),
      createdAt: Value(answer.createdAt.toUtc()),
    );
  }

  /// Converts SpeakingChatAnswer into SpeakingAnswerDetailsTableCompanion.
  SpeakingAnswerDetailsTableCompanion
  _convertChatAnswerIntoSpeakingAnswerDetailsTableCompanion(
    SpeakingChatAnswer answer,
  ) {
    return SpeakingAnswerDetailsTableCompanion(
      id: answer.detailId != null
          ? Value(answer.detailId!)
          : const Value.absent(),
      userAnswerId: answer.id != null
          ? Value(answer.id!)
          : const Value.absent(),
      score: Value(answer.score),
      duration: Value(answer.duration),
      fluencyScore: Value(answer.fluency),
      coherenceScore: Value(answer.coherence),
      lexialScore: Value(answer.lexial),
      grammaticalScore: Value(answer.grammatical),
      isGraded: Value(answer.isGraded),
      feedback: Value(answer.feedback),
      updatedAt: Value(answer.updatedAt.toUtc()),
    );
  }

  /// Converts SpeakingSpeechAnswer into SpeakingAnswerDetailsTableCompanion.
  SpeakingAnswerDetailsTableCompanion
  _convertSpeechAnswerIntoSpeakingAnswerDetailsTableCompanion(
    SpeakingSpeechAnswer answer,
  ) {
    return SpeakingAnswerDetailsTableCompanion(
      id: answer.detailId != null
          ? Value(answer.detailId!)
          : const Value.absent(),
      userAnswerId: answer.id != null
          ? Value(answer.id!)
          : const Value.absent(),
      duration: Value(answer.duration),
      score: Value(answer.score),
      fluencyScore: Value(answer.fluency),
      coherenceScore: Value(answer.coherence),
      lexialScore: Value(answer.lexial),
      grammaticalScore: Value(answer.grammatical),
      isGraded: Value(answer.isGraded),
      feedback: Value(answer.feedback),
      updatedAt: Value(answer.updatedAt.toUtc()),
      note: Value(answer.note),
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
