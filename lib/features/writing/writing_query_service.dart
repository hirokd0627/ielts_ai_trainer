// import 'package:drift/drift.dart';
// import 'package:ielts_ai_trainer/shared/database/app_database.dart';

// part 'writing_query_service.g.dart';

// @DriftAccessor(tables: [UserAnswersTable, WritingAnswerDetailsTable])
// class WritingQueryService extends DatabaseAccessor<AppDatabase>
//     with _$WritingQueryServiceMixin {

//   final QuestionListQueryService _questionListQuerySrv;

//   List<Join<HasResultSet, dynamic>> get detailTableJoins {
//     return [
//       leftOuterJoin(
//         writingAnswerDetailsTable,
//         writingAnswerDetailsTable.userPromptHistory.equalsExp(
//           userAnswersTable.id,
//         ),
//       ),
//     ];
//   }

//   WritingQueryService(super.attachedDatabase)
//     : _questionListQuerySrv = QuestionListQueryService(attachedDatabase);

//   Future<WritingUserAnswerVM> selectHistoryById(
//     int id,
//     TestTask testTask,
//   ) async {
//     // Join
//     final joins = <Join<HasResultSet, dynamic>>[];
//     if (testTask == TestTask.writingTask1 ||
//         testTask == TestTask.writingTask2) {
//       joins.add(
//         leftOuterJoin(
//           writingAnswerDetailsTable,
//           writingAnswerDetailsTable.userPromptHistory.equalsExp(
//             userAnswersTable.id,
//           ),
//         ),
//       );
//     }

//     final joinedQuery = select(userAnswersTable).join(joins);

//     // Where
//     joinedQuery.where(userAnswersTable.id.equals(id));

//     // execute
//     final row = await joinedQuery.map((row) {
//       return {
//         'userPromptHistroies': row.readTable(userAnswersTable),
//         'writingHistoryDetails': row.readTableOrNull(writingAnswerDetailsTable),
//       };
//     }).getSingle();

//     final vm = _toWritingUserAnswerVM(
//       row['userPromptHistroies'] as UserAnswersTableData,
//       writingDetailRow:
//           row['writingHistoryDetails'] as WritingAnswerDetailsTableData,
//     );

//     _logger.d("selectHistoryById vm=$vm");
//     return vm;
//   }

//   Future<List<QuestionListViewVM>> selectHistoriesByDateWord({
//     required TestTask testTask,
//     String word = '',
//     int? limit,
//   }) async {
//     return await _questionListQuerySrv.selectHistoriesByDateWord(
//       testTasks: {testTask},
//       word: word,
//       limit: limit,
//     );
//   }

//   WritingUserAnswerVM _toWritingUserAnswerVM(
//     UserAnswersTableData userPromptHistoryRow, {
//     required WritingAnswerDetailsTableData writingDetailRow,
//     // TODO: Speaking
//   }) {
//     return WritingUserAnswerVM(
//       feedback: writingDetailRow.feedback ?? '',
//       promptText: writingDetailRow.promptText,
//       answerText: writingDetailRow.answerText,
//       createdAt: userPromptHistoryRow.createdAt,
//       score: writingDetailRow.isGraded
//           ? WritingScoreVO(
//               achievement: writingDetailRow.achievementScore ?? 0.0,
//               coherence: writingDetailRow.coherenceScore ?? 0.0,
//               lexial: writingDetailRow.lexialScore ?? 0.0,
//               grammatical: writingDetailRow.grammaticalScore ?? 0.0,
//             )
//           : null,
//     );
//   }
// }
