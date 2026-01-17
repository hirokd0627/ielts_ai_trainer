// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserAnswersTableTable extends UserAnswersTable
    with TableInfo<$UserAnswersTableTable, UserAnswersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAnswersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TestTask, String> testTask =
      GeneratedColumn<String>(
        'test_task',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TestTask>($UserAnswersTableTable.$convertertestTask);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, testTask, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAnswersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAnswersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAnswersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      testTask: $UserAnswersTableTable.$convertertestTask.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}test_task'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserAnswersTableTable createAlias(String alias) {
    return $UserAnswersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TestTask, String, String> $convertertestTask =
      const EnumNameConverter<TestTask>(TestTask.values);
}

class UserAnswersTableData extends DataClass
    implements Insertable<UserAnswersTableData> {
  final int id;
  final TestTask testTask;
  final DateTime createdAt;
  const UserAnswersTableData({
    required this.id,
    required this.testTask,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['test_task'] = Variable<String>(
        $UserAnswersTableTable.$convertertestTask.toSql(testTask),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserAnswersTableCompanion toCompanion(bool nullToAbsent) {
    return UserAnswersTableCompanion(
      id: Value(id),
      testTask: Value(testTask),
      createdAt: Value(createdAt),
    );
  }

  factory UserAnswersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAnswersTableData(
      id: serializer.fromJson<int>(json['id']),
      testTask: $UserAnswersTableTable.$convertertestTask.fromJson(
        serializer.fromJson<String>(json['testTask']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'testTask': serializer.toJson<String>(
        $UserAnswersTableTable.$convertertestTask.toJson(testTask),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserAnswersTableData copyWith({
    int? id,
    TestTask? testTask,
    DateTime? createdAt,
  }) => UserAnswersTableData(
    id: id ?? this.id,
    testTask: testTask ?? this.testTask,
    createdAt: createdAt ?? this.createdAt,
  );
  UserAnswersTableData copyWithCompanion(UserAnswersTableCompanion data) {
    return UserAnswersTableData(
      id: data.id.present ? data.id.value : this.id,
      testTask: data.testTask.present ? data.testTask.value : this.testTask,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAnswersTableData(')
          ..write('id: $id, ')
          ..write('testTask: $testTask, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, testTask, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAnswersTableData &&
          other.id == this.id &&
          other.testTask == this.testTask &&
          other.createdAt == this.createdAt);
}

class UserAnswersTableCompanion extends UpdateCompanion<UserAnswersTableData> {
  final Value<int> id;
  final Value<TestTask> testTask;
  final Value<DateTime> createdAt;
  const UserAnswersTableCompanion({
    this.id = const Value.absent(),
    this.testTask = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserAnswersTableCompanion.insert({
    this.id = const Value.absent(),
    required TestTask testTask,
    this.createdAt = const Value.absent(),
  }) : testTask = Value(testTask);
  static Insertable<UserAnswersTableData> custom({
    Expression<int>? id,
    Expression<String>? testTask,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testTask != null) 'test_task': testTask,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserAnswersTableCompanion copyWith({
    Value<int>? id,
    Value<TestTask>? testTask,
    Value<DateTime>? createdAt,
  }) {
    return UserAnswersTableCompanion(
      id: id ?? this.id,
      testTask: testTask ?? this.testTask,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (testTask.present) {
      map['test_task'] = Variable<String>(
        $UserAnswersTableTable.$convertertestTask.toSql(testTask.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAnswersTableCompanion(')
          ..write('id: $id, ')
          ..write('testTask: $testTask, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WritingAnswerDetailsTableTable extends WritingAnswerDetailsTable
    with
        TableInfo<
          $WritingAnswerDetailsTableTable,
          WritingAnswerDetailsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WritingAnswerDetailsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userAnswerMeta = const VerificationMeta(
    'userAnswer',
  );
  @override
  late final GeneratedColumn<int> userAnswer = GeneratedColumn<int>(
    'user_answer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_answers (id)',
    ),
  );
  static const VerificationMeta _promptTypeMeta = const VerificationMeta(
    'promptType',
  );
  @override
  late final GeneratedColumn<String> promptType = GeneratedColumn<String>(
    'prompt_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptTextMeta = const VerificationMeta(
    'promptText',
  );
  @override
  late final GeneratedColumn<String> promptText = GeneratedColumn<String>(
    'prompt_text',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerTextMeta = const VerificationMeta(
    'answerText',
  );
  @override
  late final GeneratedColumn<String> answerText = GeneratedColumn<String>(
    'answer_text',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _achievementScoreMeta = const VerificationMeta(
    'achievementScore',
  );
  @override
  late final GeneratedColumn<double> achievementScore = GeneratedColumn<double>(
    'achievement_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coherenceScoreMeta = const VerificationMeta(
    'coherenceScore',
  );
  @override
  late final GeneratedColumn<double> coherenceScore = GeneratedColumn<double>(
    'coherence_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lexialScoreMeta = const VerificationMeta(
    'lexialScore',
  );
  @override
  late final GeneratedColumn<double> lexialScore = GeneratedColumn<double>(
    'lexial_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grammaticalScoreMeta = const VerificationMeta(
    'grammaticalScore',
  );
  @override
  late final GeneratedColumn<double> grammaticalScore = GeneratedColumn<double>(
    'grammatical_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isGradedMeta = const VerificationMeta(
    'isGraded',
  );
  @override
  late final GeneratedColumn<bool> isGraded = GeneratedColumn<bool>(
    'is_graded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_graded" IN (0, 1))',
    ),
  );
  static const VerificationMeta _feedbackMeta = const VerificationMeta(
    'feedback',
  );
  @override
  late final GeneratedColumn<String> feedback = GeneratedColumn<String>(
    'feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userAnswer,
    promptType,
    promptText,
    answerText,
    duration,
    score,
    achievementScore,
    coherenceScore,
    lexialScore,
    grammaticalScore,
    isGraded,
    feedback,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'writing_answer_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<WritingAnswerDetailsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_answer')) {
      context.handle(
        _userAnswerMeta,
        userAnswer.isAcceptableOrUnknown(data['user_answer']!, _userAnswerMeta),
      );
    } else if (isInserting) {
      context.missing(_userAnswerMeta);
    }
    if (data.containsKey('prompt_type')) {
      context.handle(
        _promptTypeMeta,
        promptType.isAcceptableOrUnknown(data['prompt_type']!, _promptTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_promptTypeMeta);
    }
    if (data.containsKey('prompt_text')) {
      context.handle(
        _promptTextMeta,
        promptText.isAcceptableOrUnknown(data['prompt_text']!, _promptTextMeta),
      );
    } else if (isInserting) {
      context.missing(_promptTextMeta);
    }
    if (data.containsKey('answer_text')) {
      context.handle(
        _answerTextMeta,
        answerText.isAcceptableOrUnknown(data['answer_text']!, _answerTextMeta),
      );
    } else if (isInserting) {
      context.missing(_answerTextMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    if (data.containsKey('achievement_score')) {
      context.handle(
        _achievementScoreMeta,
        achievementScore.isAcceptableOrUnknown(
          data['achievement_score']!,
          _achievementScoreMeta,
        ),
      );
    }
    if (data.containsKey('coherence_score')) {
      context.handle(
        _coherenceScoreMeta,
        coherenceScore.isAcceptableOrUnknown(
          data['coherence_score']!,
          _coherenceScoreMeta,
        ),
      );
    }
    if (data.containsKey('lexial_score')) {
      context.handle(
        _lexialScoreMeta,
        lexialScore.isAcceptableOrUnknown(
          data['lexial_score']!,
          _lexialScoreMeta,
        ),
      );
    }
    if (data.containsKey('grammatical_score')) {
      context.handle(
        _grammaticalScoreMeta,
        grammaticalScore.isAcceptableOrUnknown(
          data['grammatical_score']!,
          _grammaticalScoreMeta,
        ),
      );
    }
    if (data.containsKey('is_graded')) {
      context.handle(
        _isGradedMeta,
        isGraded.isAcceptableOrUnknown(data['is_graded']!, _isGradedMeta),
      );
    } else if (isInserting) {
      context.missing(_isGradedMeta);
    }
    if (data.containsKey('feedback')) {
      context.handle(
        _feedbackMeta,
        feedback.isAcceptableOrUnknown(data['feedback']!, _feedbackMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WritingAnswerDetailsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WritingAnswerDetailsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_answer'],
      )!,
      promptType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_type'],
      )!,
      promptText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_text'],
      )!,
      answerText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_text'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      ),
      achievementScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}achievement_score'],
      ),
      coherenceScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coherence_score'],
      ),
      lexialScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lexial_score'],
      ),
      grammaticalScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grammatical_score'],
      ),
      isGraded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_graded'],
      )!,
      feedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WritingAnswerDetailsTableTable createAlias(String alias) {
    return $WritingAnswerDetailsTableTable(attachedDatabase, alias);
  }
}

class WritingAnswerDetailsTableData extends DataClass
    implements Insertable<WritingAnswerDetailsTableData> {
  final int id;
  final int userAnswer;
  final String promptType;
  final String promptText;
  final String answerText;
  final int duration;
  final double? score;
  final double? achievementScore;
  final double? coherenceScore;
  final double? lexialScore;
  final double? grammaticalScore;
  final bool isGraded;
  final String? feedback;
  final DateTime updatedAt;
  const WritingAnswerDetailsTableData({
    required this.id,
    required this.userAnswer,
    required this.promptType,
    required this.promptText,
    required this.answerText,
    required this.duration,
    this.score,
    this.achievementScore,
    this.coherenceScore,
    this.lexialScore,
    this.grammaticalScore,
    required this.isGraded,
    this.feedback,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_answer'] = Variable<int>(userAnswer);
    map['prompt_type'] = Variable<String>(promptType);
    map['prompt_text'] = Variable<String>(promptText);
    map['answer_text'] = Variable<String>(answerText);
    map['duration'] = Variable<int>(duration);
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
    if (!nullToAbsent || achievementScore != null) {
      map['achievement_score'] = Variable<double>(achievementScore);
    }
    if (!nullToAbsent || coherenceScore != null) {
      map['coherence_score'] = Variable<double>(coherenceScore);
    }
    if (!nullToAbsent || lexialScore != null) {
      map['lexial_score'] = Variable<double>(lexialScore);
    }
    if (!nullToAbsent || grammaticalScore != null) {
      map['grammatical_score'] = Variable<double>(grammaticalScore);
    }
    map['is_graded'] = Variable<bool>(isGraded);
    if (!nullToAbsent || feedback != null) {
      map['feedback'] = Variable<String>(feedback);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WritingAnswerDetailsTableCompanion toCompanion(bool nullToAbsent) {
    return WritingAnswerDetailsTableCompanion(
      id: Value(id),
      userAnswer: Value(userAnswer),
      promptType: Value(promptType),
      promptText: Value(promptText),
      answerText: Value(answerText),
      duration: Value(duration),
      score: score == null && nullToAbsent
          ? const Value.absent()
          : Value(score),
      achievementScore: achievementScore == null && nullToAbsent
          ? const Value.absent()
          : Value(achievementScore),
      coherenceScore: coherenceScore == null && nullToAbsent
          ? const Value.absent()
          : Value(coherenceScore),
      lexialScore: lexialScore == null && nullToAbsent
          ? const Value.absent()
          : Value(lexialScore),
      grammaticalScore: grammaticalScore == null && nullToAbsent
          ? const Value.absent()
          : Value(grammaticalScore),
      isGraded: Value(isGraded),
      feedback: feedback == null && nullToAbsent
          ? const Value.absent()
          : Value(feedback),
      updatedAt: Value(updatedAt),
    );
  }

  factory WritingAnswerDetailsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WritingAnswerDetailsTableData(
      id: serializer.fromJson<int>(json['id']),
      userAnswer: serializer.fromJson<int>(json['userAnswer']),
      promptType: serializer.fromJson<String>(json['promptType']),
      promptText: serializer.fromJson<String>(json['promptText']),
      answerText: serializer.fromJson<String>(json['answerText']),
      duration: serializer.fromJson<int>(json['duration']),
      score: serializer.fromJson<double?>(json['score']),
      achievementScore: serializer.fromJson<double?>(json['achievementScore']),
      coherenceScore: serializer.fromJson<double?>(json['coherenceScore']),
      lexialScore: serializer.fromJson<double?>(json['lexialScore']),
      grammaticalScore: serializer.fromJson<double?>(json['grammaticalScore']),
      isGraded: serializer.fromJson<bool>(json['isGraded']),
      feedback: serializer.fromJson<String?>(json['feedback']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userAnswer': serializer.toJson<int>(userAnswer),
      'promptType': serializer.toJson<String>(promptType),
      'promptText': serializer.toJson<String>(promptText),
      'answerText': serializer.toJson<String>(answerText),
      'duration': serializer.toJson<int>(duration),
      'score': serializer.toJson<double?>(score),
      'achievementScore': serializer.toJson<double?>(achievementScore),
      'coherenceScore': serializer.toJson<double?>(coherenceScore),
      'lexialScore': serializer.toJson<double?>(lexialScore),
      'grammaticalScore': serializer.toJson<double?>(grammaticalScore),
      'isGraded': serializer.toJson<bool>(isGraded),
      'feedback': serializer.toJson<String?>(feedback),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WritingAnswerDetailsTableData copyWith({
    int? id,
    int? userAnswer,
    String? promptType,
    String? promptText,
    String? answerText,
    int? duration,
    Value<double?> score = const Value.absent(),
    Value<double?> achievementScore = const Value.absent(),
    Value<double?> coherenceScore = const Value.absent(),
    Value<double?> lexialScore = const Value.absent(),
    Value<double?> grammaticalScore = const Value.absent(),
    bool? isGraded,
    Value<String?> feedback = const Value.absent(),
    DateTime? updatedAt,
  }) => WritingAnswerDetailsTableData(
    id: id ?? this.id,
    userAnswer: userAnswer ?? this.userAnswer,
    promptType: promptType ?? this.promptType,
    promptText: promptText ?? this.promptText,
    answerText: answerText ?? this.answerText,
    duration: duration ?? this.duration,
    score: score.present ? score.value : this.score,
    achievementScore: achievementScore.present
        ? achievementScore.value
        : this.achievementScore,
    coherenceScore: coherenceScore.present
        ? coherenceScore.value
        : this.coherenceScore,
    lexialScore: lexialScore.present ? lexialScore.value : this.lexialScore,
    grammaticalScore: grammaticalScore.present
        ? grammaticalScore.value
        : this.grammaticalScore,
    isGraded: isGraded ?? this.isGraded,
    feedback: feedback.present ? feedback.value : this.feedback,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WritingAnswerDetailsTableData copyWithCompanion(
    WritingAnswerDetailsTableCompanion data,
  ) {
    return WritingAnswerDetailsTableData(
      id: data.id.present ? data.id.value : this.id,
      userAnswer: data.userAnswer.present
          ? data.userAnswer.value
          : this.userAnswer,
      promptType: data.promptType.present
          ? data.promptType.value
          : this.promptType,
      promptText: data.promptText.present
          ? data.promptText.value
          : this.promptText,
      answerText: data.answerText.present
          ? data.answerText.value
          : this.answerText,
      duration: data.duration.present ? data.duration.value : this.duration,
      score: data.score.present ? data.score.value : this.score,
      achievementScore: data.achievementScore.present
          ? data.achievementScore.value
          : this.achievementScore,
      coherenceScore: data.coherenceScore.present
          ? data.coherenceScore.value
          : this.coherenceScore,
      lexialScore: data.lexialScore.present
          ? data.lexialScore.value
          : this.lexialScore,
      grammaticalScore: data.grammaticalScore.present
          ? data.grammaticalScore.value
          : this.grammaticalScore,
      isGraded: data.isGraded.present ? data.isGraded.value : this.isGraded,
      feedback: data.feedback.present ? data.feedback.value : this.feedback,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WritingAnswerDetailsTableData(')
          ..write('id: $id, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('promptType: $promptType, ')
          ..write('promptText: $promptText, ')
          ..write('answerText: $answerText, ')
          ..write('duration: $duration, ')
          ..write('score: $score, ')
          ..write('achievementScore: $achievementScore, ')
          ..write('coherenceScore: $coherenceScore, ')
          ..write('lexialScore: $lexialScore, ')
          ..write('grammaticalScore: $grammaticalScore, ')
          ..write('isGraded: $isGraded, ')
          ..write('feedback: $feedback, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userAnswer,
    promptType,
    promptText,
    answerText,
    duration,
    score,
    achievementScore,
    coherenceScore,
    lexialScore,
    grammaticalScore,
    isGraded,
    feedback,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WritingAnswerDetailsTableData &&
          other.id == this.id &&
          other.userAnswer == this.userAnswer &&
          other.promptType == this.promptType &&
          other.promptText == this.promptText &&
          other.answerText == this.answerText &&
          other.duration == this.duration &&
          other.score == this.score &&
          other.achievementScore == this.achievementScore &&
          other.coherenceScore == this.coherenceScore &&
          other.lexialScore == this.lexialScore &&
          other.grammaticalScore == this.grammaticalScore &&
          other.isGraded == this.isGraded &&
          other.feedback == this.feedback &&
          other.updatedAt == this.updatedAt);
}

class WritingAnswerDetailsTableCompanion
    extends UpdateCompanion<WritingAnswerDetailsTableData> {
  final Value<int> id;
  final Value<int> userAnswer;
  final Value<String> promptType;
  final Value<String> promptText;
  final Value<String> answerText;
  final Value<int> duration;
  final Value<double?> score;
  final Value<double?> achievementScore;
  final Value<double?> coherenceScore;
  final Value<double?> lexialScore;
  final Value<double?> grammaticalScore;
  final Value<bool> isGraded;
  final Value<String?> feedback;
  final Value<DateTime> updatedAt;
  const WritingAnswerDetailsTableCompanion({
    this.id = const Value.absent(),
    this.userAnswer = const Value.absent(),
    this.promptType = const Value.absent(),
    this.promptText = const Value.absent(),
    this.answerText = const Value.absent(),
    this.duration = const Value.absent(),
    this.score = const Value.absent(),
    this.achievementScore = const Value.absent(),
    this.coherenceScore = const Value.absent(),
    this.lexialScore = const Value.absent(),
    this.grammaticalScore = const Value.absent(),
    this.isGraded = const Value.absent(),
    this.feedback = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WritingAnswerDetailsTableCompanion.insert({
    this.id = const Value.absent(),
    required int userAnswer,
    required String promptType,
    required String promptText,
    required String answerText,
    required int duration,
    this.score = const Value.absent(),
    this.achievementScore = const Value.absent(),
    this.coherenceScore = const Value.absent(),
    this.lexialScore = const Value.absent(),
    this.grammaticalScore = const Value.absent(),
    required bool isGraded,
    this.feedback = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userAnswer = Value(userAnswer),
       promptType = Value(promptType),
       promptText = Value(promptText),
       answerText = Value(answerText),
       duration = Value(duration),
       isGraded = Value(isGraded);
  static Insertable<WritingAnswerDetailsTableData> custom({
    Expression<int>? id,
    Expression<int>? userAnswer,
    Expression<String>? promptType,
    Expression<String>? promptText,
    Expression<String>? answerText,
    Expression<int>? duration,
    Expression<double>? score,
    Expression<double>? achievementScore,
    Expression<double>? coherenceScore,
    Expression<double>? lexialScore,
    Expression<double>? grammaticalScore,
    Expression<bool>? isGraded,
    Expression<String>? feedback,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userAnswer != null) 'user_answer': userAnswer,
      if (promptType != null) 'prompt_type': promptType,
      if (promptText != null) 'prompt_text': promptText,
      if (answerText != null) 'answer_text': answerText,
      if (duration != null) 'duration': duration,
      if (score != null) 'score': score,
      if (achievementScore != null) 'achievement_score': achievementScore,
      if (coherenceScore != null) 'coherence_score': coherenceScore,
      if (lexialScore != null) 'lexial_score': lexialScore,
      if (grammaticalScore != null) 'grammatical_score': grammaticalScore,
      if (isGraded != null) 'is_graded': isGraded,
      if (feedback != null) 'feedback': feedback,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WritingAnswerDetailsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userAnswer,
    Value<String>? promptType,
    Value<String>? promptText,
    Value<String>? answerText,
    Value<int>? duration,
    Value<double?>? score,
    Value<double?>? achievementScore,
    Value<double?>? coherenceScore,
    Value<double?>? lexialScore,
    Value<double?>? grammaticalScore,
    Value<bool>? isGraded,
    Value<String?>? feedback,
    Value<DateTime>? updatedAt,
  }) {
    return WritingAnswerDetailsTableCompanion(
      id: id ?? this.id,
      userAnswer: userAnswer ?? this.userAnswer,
      promptType: promptType ?? this.promptType,
      promptText: promptText ?? this.promptText,
      answerText: answerText ?? this.answerText,
      duration: duration ?? this.duration,
      score: score ?? this.score,
      achievementScore: achievementScore ?? this.achievementScore,
      coherenceScore: coherenceScore ?? this.coherenceScore,
      lexialScore: lexialScore ?? this.lexialScore,
      grammaticalScore: grammaticalScore ?? this.grammaticalScore,
      isGraded: isGraded ?? this.isGraded,
      feedback: feedback ?? this.feedback,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<int>(userAnswer.value);
    }
    if (promptType.present) {
      map['prompt_type'] = Variable<String>(promptType.value);
    }
    if (promptText.present) {
      map['prompt_text'] = Variable<String>(promptText.value);
    }
    if (answerText.present) {
      map['answer_text'] = Variable<String>(answerText.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (achievementScore.present) {
      map['achievement_score'] = Variable<double>(achievementScore.value);
    }
    if (coherenceScore.present) {
      map['coherence_score'] = Variable<double>(coherenceScore.value);
    }
    if (lexialScore.present) {
      map['lexial_score'] = Variable<double>(lexialScore.value);
    }
    if (grammaticalScore.present) {
      map['grammatical_score'] = Variable<double>(grammaticalScore.value);
    }
    if (isGraded.present) {
      map['is_graded'] = Variable<bool>(isGraded.value);
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(feedback.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WritingAnswerDetailsTableCompanion(')
          ..write('id: $id, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('promptType: $promptType, ')
          ..write('promptText: $promptText, ')
          ..write('answerText: $answerText, ')
          ..write('duration: $duration, ')
          ..write('score: $score, ')
          ..write('achievementScore: $achievementScore, ')
          ..write('coherenceScore: $coherenceScore, ')
          ..write('lexialScore: $lexialScore, ')
          ..write('grammaticalScore: $grammaticalScore, ')
          ..write('isGraded: $isGraded, ')
          ..write('feedback: $feedback, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PromptTopicsTableTable extends PromptTopicsTable
    with TableInfo<$PromptTopicsTableTable, PromptTopicsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptTopicsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userAnswerMeta = const VerificationMeta(
    'userAnswer',
  );
  @override
  late final GeneratedColumn<int> userAnswer = GeneratedColumn<int>(
    'user_answer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_answers (id)',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userAnswer, order, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prompt_topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<PromptTopicsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_answer')) {
      context.handle(
        _userAnswerMeta,
        userAnswer.isAcceptableOrUnknown(data['user_answer']!, _userAnswerMeta),
      );
    } else if (isInserting) {
      context.missing(_userAnswerMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PromptTopicsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromptTopicsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_answer'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
    );
  }

  @override
  $PromptTopicsTableTable createAlias(String alias) {
    return $PromptTopicsTableTable(attachedDatabase, alias);
  }
}

class PromptTopicsTableData extends DataClass
    implements Insertable<PromptTopicsTableData> {
  final int id;
  final int userAnswer;
  final int order;
  final String title;
  const PromptTopicsTableData({
    required this.id,
    required this.userAnswer,
    required this.order,
    required this.title,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_answer'] = Variable<int>(userAnswer);
    map['order'] = Variable<int>(order);
    map['title'] = Variable<String>(title);
    return map;
  }

  PromptTopicsTableCompanion toCompanion(bool nullToAbsent) {
    return PromptTopicsTableCompanion(
      id: Value(id),
      userAnswer: Value(userAnswer),
      order: Value(order),
      title: Value(title),
    );
  }

  factory PromptTopicsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PromptTopicsTableData(
      id: serializer.fromJson<int>(json['id']),
      userAnswer: serializer.fromJson<int>(json['userAnswer']),
      order: serializer.fromJson<int>(json['order']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userAnswer': serializer.toJson<int>(userAnswer),
      'order': serializer.toJson<int>(order),
      'title': serializer.toJson<String>(title),
    };
  }

  PromptTopicsTableData copyWith({
    int? id,
    int? userAnswer,
    int? order,
    String? title,
  }) => PromptTopicsTableData(
    id: id ?? this.id,
    userAnswer: userAnswer ?? this.userAnswer,
    order: order ?? this.order,
    title: title ?? this.title,
  );
  PromptTopicsTableData copyWithCompanion(PromptTopicsTableCompanion data) {
    return PromptTopicsTableData(
      id: data.id.present ? data.id.value : this.id,
      userAnswer: data.userAnswer.present
          ? data.userAnswer.value
          : this.userAnswer,
      order: data.order.present ? data.order.value : this.order,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PromptTopicsTableData(')
          ..write('id: $id, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('order: $order, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userAnswer, order, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromptTopicsTableData &&
          other.id == this.id &&
          other.userAnswer == this.userAnswer &&
          other.order == this.order &&
          other.title == this.title);
}

class PromptTopicsTableCompanion
    extends UpdateCompanion<PromptTopicsTableData> {
  final Value<int> id;
  final Value<int> userAnswer;
  final Value<int> order;
  final Value<String> title;
  const PromptTopicsTableCompanion({
    this.id = const Value.absent(),
    this.userAnswer = const Value.absent(),
    this.order = const Value.absent(),
    this.title = const Value.absent(),
  });
  PromptTopicsTableCompanion.insert({
    this.id = const Value.absent(),
    required int userAnswer,
    required int order,
    required String title,
  }) : userAnswer = Value(userAnswer),
       order = Value(order),
       title = Value(title);
  static Insertable<PromptTopicsTableData> custom({
    Expression<int>? id,
    Expression<int>? userAnswer,
    Expression<int>? order,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userAnswer != null) 'user_answer': userAnswer,
      if (order != null) 'order': order,
      if (title != null) 'title': title,
    });
  }

  PromptTopicsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userAnswer,
    Value<int>? order,
    Value<String>? title,
  }) {
    return PromptTopicsTableCompanion(
      id: id ?? this.id,
      userAnswer: userAnswer ?? this.userAnswer,
      order: order ?? this.order,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<int>(userAnswer.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptTopicsTableCompanion(')
          ..write('id: $id, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('order: $order, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserAnswersTableTable userAnswersTable = $UserAnswersTableTable(
    this,
  );
  late final $WritingAnswerDetailsTableTable writingAnswerDetailsTable =
      $WritingAnswerDetailsTableTable(this);
  late final $PromptTopicsTableTable promptTopicsTable =
      $PromptTopicsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userAnswersTable,
    writingAnswerDetailsTable,
    promptTopicsTable,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$UserAnswersTableTableCreateCompanionBuilder =
    UserAnswersTableCompanion Function({
      Value<int> id,
      required TestTask testTask,
      Value<DateTime> createdAt,
    });
typedef $$UserAnswersTableTableUpdateCompanionBuilder =
    UserAnswersTableCompanion Function({
      Value<int> id,
      Value<TestTask> testTask,
      Value<DateTime> createdAt,
    });

final class $$UserAnswersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserAnswersTableTable,
          UserAnswersTableData
        > {
  $$UserAnswersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $WritingAnswerDetailsTableTable,
    List<WritingAnswerDetailsTableData>
  >
  _writingAnswerDetailsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.writingAnswerDetailsTable,
        aliasName: $_aliasNameGenerator(
          db.userAnswersTable.id,
          db.writingAnswerDetailsTable.userAnswer,
        ),
      );

  $$WritingAnswerDetailsTableTableProcessedTableManager
  get writingAnswerDetailsTableRefs {
    final manager = $$WritingAnswerDetailsTableTableTableManager(
      $_db,
      $_db.writingAnswerDetailsTable,
    ).filter((f) => f.userAnswer.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _writingAnswerDetailsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PromptTopicsTableTable,
    List<PromptTopicsTableData>
  >
  _promptTopicsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.promptTopicsTable,
        aliasName: $_aliasNameGenerator(
          db.userAnswersTable.id,
          db.promptTopicsTable.userAnswer,
        ),
      );

  $$PromptTopicsTableTableProcessedTableManager get promptTopicsTableRefs {
    final manager = $$PromptTopicsTableTableTableManager(
      $_db,
      $_db.promptTopicsTable,
    ).filter((f) => f.userAnswer.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _promptTopicsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserAnswersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserAnswersTableTable> {
  $$UserAnswersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TestTask, TestTask, String> get testTask =>
      $composableBuilder(
        column: $table.testTask,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> writingAnswerDetailsTableRefs(
    Expression<bool> Function($$WritingAnswerDetailsTableTableFilterComposer f)
    f,
  ) {
    final $$WritingAnswerDetailsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.writingAnswerDetailsTable,
          getReferencedColumn: (t) => t.userAnswer,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WritingAnswerDetailsTableTableFilterComposer(
                $db: $db,
                $table: $db.writingAnswerDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> promptTopicsTableRefs(
    Expression<bool> Function($$PromptTopicsTableTableFilterComposer f) f,
  ) {
    final $$PromptTopicsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.promptTopicsTable,
      getReferencedColumn: (t) => t.userAnswer,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PromptTopicsTableTableFilterComposer(
            $db: $db,
            $table: $db.promptTopicsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserAnswersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAnswersTableTable> {
  $$UserAnswersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testTask => $composableBuilder(
    column: $table.testTask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserAnswersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAnswersTableTable> {
  $$UserAnswersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TestTask, String> get testTask =>
      $composableBuilder(column: $table.testTask, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> writingAnswerDetailsTableRefs<T extends Object>(
    Expression<T> Function($$WritingAnswerDetailsTableTableAnnotationComposer a)
    f,
  ) {
    final $$WritingAnswerDetailsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.writingAnswerDetailsTable,
          getReferencedColumn: (t) => t.userAnswer,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WritingAnswerDetailsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.writingAnswerDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> promptTopicsTableRefs<T extends Object>(
    Expression<T> Function($$PromptTopicsTableTableAnnotationComposer a) f,
  ) {
    final $$PromptTopicsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.promptTopicsTable,
          getReferencedColumn: (t) => t.userAnswer,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PromptTopicsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.promptTopicsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UserAnswersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAnswersTableTable,
          UserAnswersTableData,
          $$UserAnswersTableTableFilterComposer,
          $$UserAnswersTableTableOrderingComposer,
          $$UserAnswersTableTableAnnotationComposer,
          $$UserAnswersTableTableCreateCompanionBuilder,
          $$UserAnswersTableTableUpdateCompanionBuilder,
          (UserAnswersTableData, $$UserAnswersTableTableReferences),
          UserAnswersTableData,
          PrefetchHooks Function({
            bool writingAnswerDetailsTableRefs,
            bool promptTopicsTableRefs,
          })
        > {
  $$UserAnswersTableTableTableManager(
    _$AppDatabase db,
    $UserAnswersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAnswersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAnswersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAnswersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<TestTask> testTask = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserAnswersTableCompanion(
                id: id,
                testTask: testTask,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required TestTask testTask,
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserAnswersTableCompanion.insert(
                id: id,
                testTask: testTask,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserAnswersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                writingAnswerDetailsTableRefs = false,
                promptTopicsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (writingAnswerDetailsTableRefs)
                      db.writingAnswerDetailsTable,
                    if (promptTopicsTableRefs) db.promptTopicsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (writingAnswerDetailsTableRefs)
                        await $_getPrefetchedData<
                          UserAnswersTableData,
                          $UserAnswersTableTable,
                          WritingAnswerDetailsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserAnswersTableTableReferences
                              ._writingAnswerDetailsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserAnswersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).writingAnswerDetailsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userAnswer == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (promptTopicsTableRefs)
                        await $_getPrefetchedData<
                          UserAnswersTableData,
                          $UserAnswersTableTable,
                          PromptTopicsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserAnswersTableTableReferences
                              ._promptTopicsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserAnswersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).promptTopicsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userAnswer == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UserAnswersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAnswersTableTable,
      UserAnswersTableData,
      $$UserAnswersTableTableFilterComposer,
      $$UserAnswersTableTableOrderingComposer,
      $$UserAnswersTableTableAnnotationComposer,
      $$UserAnswersTableTableCreateCompanionBuilder,
      $$UserAnswersTableTableUpdateCompanionBuilder,
      (UserAnswersTableData, $$UserAnswersTableTableReferences),
      UserAnswersTableData,
      PrefetchHooks Function({
        bool writingAnswerDetailsTableRefs,
        bool promptTopicsTableRefs,
      })
    >;
typedef $$WritingAnswerDetailsTableTableCreateCompanionBuilder =
    WritingAnswerDetailsTableCompanion Function({
      Value<int> id,
      required int userAnswer,
      required String promptType,
      required String promptText,
      required String answerText,
      required int duration,
      Value<double?> score,
      Value<double?> achievementScore,
      Value<double?> coherenceScore,
      Value<double?> lexialScore,
      Value<double?> grammaticalScore,
      required bool isGraded,
      Value<String?> feedback,
      Value<DateTime> updatedAt,
    });
typedef $$WritingAnswerDetailsTableTableUpdateCompanionBuilder =
    WritingAnswerDetailsTableCompanion Function({
      Value<int> id,
      Value<int> userAnswer,
      Value<String> promptType,
      Value<String> promptText,
      Value<String> answerText,
      Value<int> duration,
      Value<double?> score,
      Value<double?> achievementScore,
      Value<double?> coherenceScore,
      Value<double?> lexialScore,
      Value<double?> grammaticalScore,
      Value<bool> isGraded,
      Value<String?> feedback,
      Value<DateTime> updatedAt,
    });

final class $$WritingAnswerDetailsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WritingAnswerDetailsTableTable,
          WritingAnswerDetailsTableData
        > {
  $$WritingAnswerDetailsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserAnswersTableTable _userAnswerTable(_$AppDatabase db) =>
      db.userAnswersTable.createAlias(
        $_aliasNameGenerator(
          db.writingAnswerDetailsTable.userAnswer,
          db.userAnswersTable.id,
        ),
      );

  $$UserAnswersTableTableProcessedTableManager get userAnswer {
    final $_column = $_itemColumn<int>('user_answer')!;

    final manager = $$UserAnswersTableTableTableManager(
      $_db,
      $_db.userAnswersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userAnswerTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WritingAnswerDetailsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WritingAnswerDetailsTableTable> {
  $$WritingAnswerDetailsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptType => $composableBuilder(
    column: $table.promptType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptText => $composableBuilder(
    column: $table.promptText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerText => $composableBuilder(
    column: $table.answerText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get achievementScore => $composableBuilder(
    column: $table.achievementScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coherenceScore => $composableBuilder(
    column: $table.coherenceScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lexialScore => $composableBuilder(
    column: $table.lexialScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grammaticalScore => $composableBuilder(
    column: $table.grammaticalScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGraded => $composableBuilder(
    column: $table.isGraded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserAnswersTableTableFilterComposer get userAnswer {
    final $$UserAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswer,
      referencedTable: $db.userAnswersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableTableFilterComposer(
            $db: $db,
            $table: $db.userAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WritingAnswerDetailsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WritingAnswerDetailsTableTable> {
  $$WritingAnswerDetailsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptType => $composableBuilder(
    column: $table.promptType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptText => $composableBuilder(
    column: $table.promptText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerText => $composableBuilder(
    column: $table.answerText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get achievementScore => $composableBuilder(
    column: $table.achievementScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coherenceScore => $composableBuilder(
    column: $table.coherenceScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lexialScore => $composableBuilder(
    column: $table.lexialScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grammaticalScore => $composableBuilder(
    column: $table.grammaticalScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGraded => $composableBuilder(
    column: $table.isGraded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserAnswersTableTableOrderingComposer get userAnswer {
    final $$UserAnswersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswer,
      referencedTable: $db.userAnswersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableTableOrderingComposer(
            $db: $db,
            $table: $db.userAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WritingAnswerDetailsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WritingAnswerDetailsTableTable> {
  $$WritingAnswerDetailsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get promptType => $composableBuilder(
    column: $table.promptType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promptText => $composableBuilder(
    column: $table.promptText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerText => $composableBuilder(
    column: $table.answerText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<double> get achievementScore => $composableBuilder(
    column: $table.achievementScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get coherenceScore => $composableBuilder(
    column: $table.coherenceScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lexialScore => $composableBuilder(
    column: $table.lexialScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get grammaticalScore => $composableBuilder(
    column: $table.grammaticalScore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isGraded =>
      $composableBuilder(column: $table.isGraded, builder: (column) => column);

  GeneratedColumn<String> get feedback =>
      $composableBuilder(column: $table.feedback, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UserAnswersTableTableAnnotationComposer get userAnswer {
    final $$UserAnswersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswer,
      referencedTable: $db.userAnswersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WritingAnswerDetailsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WritingAnswerDetailsTableTable,
          WritingAnswerDetailsTableData,
          $$WritingAnswerDetailsTableTableFilterComposer,
          $$WritingAnswerDetailsTableTableOrderingComposer,
          $$WritingAnswerDetailsTableTableAnnotationComposer,
          $$WritingAnswerDetailsTableTableCreateCompanionBuilder,
          $$WritingAnswerDetailsTableTableUpdateCompanionBuilder,
          (
            WritingAnswerDetailsTableData,
            $$WritingAnswerDetailsTableTableReferences,
          ),
          WritingAnswerDetailsTableData,
          PrefetchHooks Function({bool userAnswer})
        > {
  $$WritingAnswerDetailsTableTableTableManager(
    _$AppDatabase db,
    $WritingAnswerDetailsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WritingAnswerDetailsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$WritingAnswerDetailsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WritingAnswerDetailsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userAnswer = const Value.absent(),
                Value<String> promptType = const Value.absent(),
                Value<String> promptText = const Value.absent(),
                Value<String> answerText = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<double?> score = const Value.absent(),
                Value<double?> achievementScore = const Value.absent(),
                Value<double?> coherenceScore = const Value.absent(),
                Value<double?> lexialScore = const Value.absent(),
                Value<double?> grammaticalScore = const Value.absent(),
                Value<bool> isGraded = const Value.absent(),
                Value<String?> feedback = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WritingAnswerDetailsTableCompanion(
                id: id,
                userAnswer: userAnswer,
                promptType: promptType,
                promptText: promptText,
                answerText: answerText,
                duration: duration,
                score: score,
                achievementScore: achievementScore,
                coherenceScore: coherenceScore,
                lexialScore: lexialScore,
                grammaticalScore: grammaticalScore,
                isGraded: isGraded,
                feedback: feedback,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userAnswer,
                required String promptType,
                required String promptText,
                required String answerText,
                required int duration,
                Value<double?> score = const Value.absent(),
                Value<double?> achievementScore = const Value.absent(),
                Value<double?> coherenceScore = const Value.absent(),
                Value<double?> lexialScore = const Value.absent(),
                Value<double?> grammaticalScore = const Value.absent(),
                required bool isGraded,
                Value<String?> feedback = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WritingAnswerDetailsTableCompanion.insert(
                id: id,
                userAnswer: userAnswer,
                promptType: promptType,
                promptText: promptText,
                answerText: answerText,
                duration: duration,
                score: score,
                achievementScore: achievementScore,
                coherenceScore: coherenceScore,
                lexialScore: lexialScore,
                grammaticalScore: grammaticalScore,
                isGraded: isGraded,
                feedback: feedback,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WritingAnswerDetailsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userAnswer = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userAnswer) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userAnswer,
                                referencedTable:
                                    $$WritingAnswerDetailsTableTableReferences
                                        ._userAnswerTable(db),
                                referencedColumn:
                                    $$WritingAnswerDetailsTableTableReferences
                                        ._userAnswerTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WritingAnswerDetailsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WritingAnswerDetailsTableTable,
      WritingAnswerDetailsTableData,
      $$WritingAnswerDetailsTableTableFilterComposer,
      $$WritingAnswerDetailsTableTableOrderingComposer,
      $$WritingAnswerDetailsTableTableAnnotationComposer,
      $$WritingAnswerDetailsTableTableCreateCompanionBuilder,
      $$WritingAnswerDetailsTableTableUpdateCompanionBuilder,
      (
        WritingAnswerDetailsTableData,
        $$WritingAnswerDetailsTableTableReferences,
      ),
      WritingAnswerDetailsTableData,
      PrefetchHooks Function({bool userAnswer})
    >;
typedef $$PromptTopicsTableTableCreateCompanionBuilder =
    PromptTopicsTableCompanion Function({
      Value<int> id,
      required int userAnswer,
      required int order,
      required String title,
    });
typedef $$PromptTopicsTableTableUpdateCompanionBuilder =
    PromptTopicsTableCompanion Function({
      Value<int> id,
      Value<int> userAnswer,
      Value<int> order,
      Value<String> title,
    });

final class $$PromptTopicsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PromptTopicsTableTable,
          PromptTopicsTableData
        > {
  $$PromptTopicsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserAnswersTableTable _userAnswerTable(_$AppDatabase db) =>
      db.userAnswersTable.createAlias(
        $_aliasNameGenerator(
          db.promptTopicsTable.userAnswer,
          db.userAnswersTable.id,
        ),
      );

  $$UserAnswersTableTableProcessedTableManager get userAnswer {
    final $_column = $_itemColumn<int>('user_answer')!;

    final manager = $$UserAnswersTableTableTableManager(
      $_db,
      $_db.userAnswersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userAnswerTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PromptTopicsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PromptTopicsTableTable> {
  $$PromptTopicsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  $$UserAnswersTableTableFilterComposer get userAnswer {
    final $$UserAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswer,
      referencedTable: $db.userAnswersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableTableFilterComposer(
            $db: $db,
            $table: $db.userAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptTopicsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PromptTopicsTableTable> {
  $$PromptTopicsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserAnswersTableTableOrderingComposer get userAnswer {
    final $$UserAnswersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswer,
      referencedTable: $db.userAnswersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableTableOrderingComposer(
            $db: $db,
            $table: $db.userAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptTopicsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PromptTopicsTableTable> {
  $$PromptTopicsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  $$UserAnswersTableTableAnnotationComposer get userAnswer {
    final $$UserAnswersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswer,
      referencedTable: $db.userAnswersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAnswersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userAnswersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PromptTopicsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PromptTopicsTableTable,
          PromptTopicsTableData,
          $$PromptTopicsTableTableFilterComposer,
          $$PromptTopicsTableTableOrderingComposer,
          $$PromptTopicsTableTableAnnotationComposer,
          $$PromptTopicsTableTableCreateCompanionBuilder,
          $$PromptTopicsTableTableUpdateCompanionBuilder,
          (PromptTopicsTableData, $$PromptTopicsTableTableReferences),
          PromptTopicsTableData,
          PrefetchHooks Function({bool userAnswer})
        > {
  $$PromptTopicsTableTableTableManager(
    _$AppDatabase db,
    $PromptTopicsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromptTopicsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromptTopicsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromptTopicsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userAnswer = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String> title = const Value.absent(),
              }) => PromptTopicsTableCompanion(
                id: id,
                userAnswer: userAnswer,
                order: order,
                title: title,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userAnswer,
                required int order,
                required String title,
              }) => PromptTopicsTableCompanion.insert(
                id: id,
                userAnswer: userAnswer,
                order: order,
                title: title,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PromptTopicsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userAnswer = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userAnswer) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userAnswer,
                                referencedTable:
                                    $$PromptTopicsTableTableReferences
                                        ._userAnswerTable(db),
                                referencedColumn:
                                    $$PromptTopicsTableTableReferences
                                        ._userAnswerTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PromptTopicsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PromptTopicsTableTable,
      PromptTopicsTableData,
      $$PromptTopicsTableTableFilterComposer,
      $$PromptTopicsTableTableOrderingComposer,
      $$PromptTopicsTableTableAnnotationComposer,
      $$PromptTopicsTableTableCreateCompanionBuilder,
      $$PromptTopicsTableTableUpdateCompanionBuilder,
      (PromptTopicsTableData, $$PromptTopicsTableTableReferences),
      PromptTopicsTableData,
      PrefetchHooks Function({bool userAnswer})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserAnswersTableTableTableManager get userAnswersTable =>
      $$UserAnswersTableTableTableManager(_db, _db.userAnswersTable);
  $$WritingAnswerDetailsTableTableTableManager get writingAnswerDetailsTable =>
      $$WritingAnswerDetailsTableTableTableManager(
        _db,
        _db.writingAnswerDetailsTable,
      );
  $$PromptTopicsTableTableTableManager get promptTopicsTable =>
      $$PromptTopicsTableTableTableManager(_db, _db.promptTopicsTable);
}
