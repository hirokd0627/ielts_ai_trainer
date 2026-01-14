import 'dart:convert';
import 'dart:io';
import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Number of seed data records
final recordCount = 100;

double _roundScore(double value) {
  return (value * 2).round() / 2;
}

/// Script to generate seed data and output it in JSON format.
void main() {
  final faker = Faker();
  final seedFilePath = 'assets_dev/seeds/test_$recordCount.json';

  List<Map<String, dynamic>> data = List.generate(
    recordCount,
    (_) => {
      'testTask': faker.randomGenerator.element(TestTask.values).name,
      'promptText': faker.lorem.sentences(3).join("\n"),
      'answerText': faker.lorem.sentences(15).join("\n"),
      'achievementScore': _roundScore(
        faker.randomGenerator.decimal(min: 0, scale: 9),
      ),
      'coherenceScore': _roundScore(
        faker.randomGenerator.decimal(min: 0, scale: 9),
      ),
      'lexialScore': _roundScore(
        faker.randomGenerator.decimal(min: 0, scale: 9),
      ),
      'grammaticalScore': _roundScore(
        faker.randomGenerator.decimal(min: 0, scale: 9),
      ),
      'duration': faker.randomGenerator.integer((20 * 60), min: 1),
      'feedback': faker.lorem.sentences(3).join("\n"),
      'topics': faker.lorem.words(3),
      'createdAt': faker.date
          .dateTime(minYear: 2024, maxYear: 2026)
          .toUtc()
          .toIso8601String(),
    },
  );

  // to pretty print
  const encoder = JsonEncoder.withIndent('  ');
  final prettyJson = encoder.convert(data);

  File(seedFilePath).writeAsStringSync(prettyJson);
}
