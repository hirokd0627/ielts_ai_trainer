import 'dart:convert';
import 'dart:io';
import 'package:faker/faker.dart';
import 'package:ielts_ai_trainer/shared/enums/test_task.dart';

/// Number of seed data records
final recordCount = 100;

/// Script to generate seed data and output it in JSON format.
void main() {
  final faker = Faker();
  final seedFilePath = 'assets_dev/seeds/test_$recordCount.json';

  List<Map<String, dynamic>> data = List.generate(
    recordCount,
    (_) => {
      'testTask': faker.randomGenerator.element(TestTask.values).name,
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
