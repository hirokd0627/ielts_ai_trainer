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
    bool isPromptGraded = false;
    String answerText = '';
    bool isAnswerGraded = false;
    String? answerAudioUuid;
    for (final row in utteranceRows) {
      if (row.isUser) {
        answerText = row.message;
        answerAudioUuid = row.audioFileUuid;
        isAnswerGraded = row.isGraded;
      } else {
        promptText = row.message;
        isPromptGraded = row.isGraded;
      }
    }

    /// Converts a database query row into a SpeakingAnswer.
    final userAnswer = row.readTable(userAnswersTable);
    final detail = row.readTable(speakingAnswerDetailsTable);
    return SpeakingSpeechAnswer(
      id: userAnswer.id,
      detailId: detail.id,
      createdAt: userAnswer.createdAt,
      topics: topics,
      duration: detail.duration,
      isGraded: detail.isGraded,
      coherenceScore: detail.coherenceScore,
      lexicalScore: detail.lexicalScore,
      grammaticalScore: detail.grammaticalScore,
      coherenceFeedback: detail.coherenceFeedback,
      lexicalFeedback: detail.lexicalFeedback,
      grammaticalFeedback: detail.grammaticalFeedback,
      prompt: SpeakingUtteranceVO(
        order: 1,
        isUser: false,
        text: promptText,
        isGraded: isPromptGraded,
      ),
      answer: SpeakingUtteranceVO(
        order: 2,
        isUser: true,
        isGraded: isAnswerGraded,
        text: answerText,
        audioFileUuid: answerAudioUuid,
      ),
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
          isGraded: row.isGraded,
          text: row.message,
          pronunciationScore: row.pronunciationScore,
          audioFileUuid: row.audioFileUuid,
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
      topics: topics,
      duration: detail.duration,
      isGraded: detail.isGraded,
      testTask: userAnswer.testTask,
      coherenceScore: detail.coherenceScore,
      lexicalScore: detail.lexicalScore,
      grammaticalScore: detail.grammaticalScore,
      coherenceFeedback: detail.coherenceFeedback,
      lexicalFeedback: detail.lexicalFeedback,
      grammaticalFeedback: detail.grammaticalFeedback,
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
            isGraded: Value(answer.utterances[i].isGraded),
            message: Value(answer.utterances[i].text),
            audioFileUuid: answer.utterances[i].audioFileUuid != null
                ? Value(answer.utterances[i].audioFileUuid!)
                : Value.absent(),
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

  /// Saves a utterance in the user's answer for speaking part 1 or Part 3.
  Future<void> saveUtterance(
    int userAnswerId,
    SpeakingUtteranceVO utterance,
  ) async {
    final u = SpeakingUtterancesTableCompanion(
      userAnswerId: Value(userAnswerId),
      order: Value(utterance.order),
      isUser: Value(utterance.isUser),
      isGraded: Value(utterance.isGraded),
      message: Value(utterance.text),
      audioFileUuid: utterance.audioFileUuid != null
          ? Value(utterance.audioFileUuid!)
          : Value.absent(),
      pronunciationScore: Value(utterance.pronunciationScore),
    );
    speakingUtterancesTable.insertOnConflictUpdate(u);
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
            audioFileUuid: Value.absent(),
          ),
          mode: InsertMode.insertOrReplace,
        );

        await into(speakingUtterancesTable).insert(
          SpeakingUtterancesTableCompanion(
            userAnswerId: Value(upId),
            order: Value(2),
            isUser: Value(true),
            message: Value(answer.answer.text),
            audioFileUuid: answer.answer.audioFileUuid != null
                ? Value(answer.answer.audioFileUuid!)
                : Value.absent(),
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
      duration: Value(answer.duration),
      coherenceScore: Value(answer.coherenceScore),
      lexicalScore: Value(answer.lexicalScore),
      grammaticalScore: Value(answer.grammaticalScore),
      isGraded: Value(answer.isGraded),
      coherenceFeedback: Value(answer.coherenceFeedback),
      lexicalFeedback: Value(answer.lexicalFeedback),
      grammaticalFeedback: Value(answer.grammaticalFeedback),
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
      coherenceScore: Value(answer.coherenceScore),
      lexicalScore: Value(answer.lexicalScore),
      grammaticalScore: Value(answer.grammaticalScore),
      isGraded: Value(answer.isGraded),
      coherenceFeedback: Value(answer.coherenceFeedback),
      lexicalFeedback: Value(answer.lexicalFeedback),
      grammaticalFeedback: Value(answer.grammaticalFeedback),
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
