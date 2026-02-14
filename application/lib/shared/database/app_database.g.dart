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
  static const VerificationMeta _userAnswerIdMeta = const VerificationMeta(
    'userAnswerId',
  );
  @override
  late final GeneratedColumn<int> userAnswerId = GeneratedColumn<int>(
    'user_answer_id',
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
  static const VerificationMeta _taskContextMeta = const VerificationMeta(
    'taskContext',
  );
  @override
  late final GeneratedColumn<String> taskContext = GeneratedColumn<String>(
    'task_context',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskInstructionMeta = const VerificationMeta(
    'taskInstruction',
  );
  @override
  late final GeneratedColumn<String> taskInstruction = GeneratedColumn<String>(
    'task_instruction',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diagramDescriptionMeta =
      const VerificationMeta('diagramDescription');
  @override
  late final GeneratedColumn<String> diagramDescription =
      GeneratedColumn<String>(
        'diagram_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _diagramFileUuidMeta = const VerificationMeta(
    'diagramFileUuid',
  );
  @override
  late final GeneratedColumn<String> diagramFileUuid = GeneratedColumn<String>(
    'diagram_file_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _bandScoreMeta = const VerificationMeta(
    'bandScore',
  );
  @override
  late final GeneratedColumn<double> bandScore = GeneratedColumn<double>(
    'band_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taskScoreMeta = const VerificationMeta(
    'taskScore',
  );
  @override
  late final GeneratedColumn<double> taskScore = GeneratedColumn<double>(
    'task_score',
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
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_graded" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _taskFeedbackMeta = const VerificationMeta(
    'taskFeedback',
  );
  @override
  late final GeneratedColumn<String> taskFeedback = GeneratedColumn<String>(
    'task_feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coherencekFeedbackMeta =
      const VerificationMeta('coherencekFeedback');
  @override
  late final GeneratedColumn<String> coherencekFeedback =
      GeneratedColumn<String>(
        'coherencek_feedback',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lexialFeedbackMeta = const VerificationMeta(
    'lexialFeedback',
  );
  @override
  late final GeneratedColumn<String> lexialFeedback = GeneratedColumn<String>(
    'lexial_feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grammaticalFeedbackMeta =
      const VerificationMeta('grammaticalFeedback');
  @override
  late final GeneratedColumn<String> grammaticalFeedback =
      GeneratedColumn<String>(
        'grammatical_feedback',
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
    userAnswerId,
    promptType,
    taskContext,
    taskInstruction,
    diagramDescription,
    diagramFileUuid,
    answerText,
    duration,
    bandScore,
    taskScore,
    coherenceScore,
    lexialScore,
    grammaticalScore,
    isGraded,
    taskFeedback,
    coherencekFeedback,
    lexialFeedback,
    grammaticalFeedback,
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
    if (data.containsKey('user_answer_id')) {
      context.handle(
        _userAnswerIdMeta,
        userAnswerId.isAcceptableOrUnknown(
          data['user_answer_id']!,
          _userAnswerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userAnswerIdMeta);
    }
    if (data.containsKey('prompt_type')) {
      context.handle(
        _promptTypeMeta,
        promptType.isAcceptableOrUnknown(data['prompt_type']!, _promptTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_promptTypeMeta);
    }
    if (data.containsKey('task_context')) {
      context.handle(
        _taskContextMeta,
        taskContext.isAcceptableOrUnknown(
          data['task_context']!,
          _taskContextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taskContextMeta);
    }
    if (data.containsKey('task_instruction')) {
      context.handle(
        _taskInstructionMeta,
        taskInstruction.isAcceptableOrUnknown(
          data['task_instruction']!,
          _taskInstructionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taskInstructionMeta);
    }
    if (data.containsKey('diagram_description')) {
      context.handle(
        _diagramDescriptionMeta,
        diagramDescription.isAcceptableOrUnknown(
          data['diagram_description']!,
          _diagramDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('diagram_file_uuid')) {
      context.handle(
        _diagramFileUuidMeta,
        diagramFileUuid.isAcceptableOrUnknown(
          data['diagram_file_uuid']!,
          _diagramFileUuidMeta,
        ),
      );
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
    if (data.containsKey('band_score')) {
      context.handle(
        _bandScoreMeta,
        bandScore.isAcceptableOrUnknown(data['band_score']!, _bandScoreMeta),
      );
    }
    if (data.containsKey('task_score')) {
      context.handle(
        _taskScoreMeta,
        taskScore.isAcceptableOrUnknown(data['task_score']!, _taskScoreMeta),
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
    }
    if (data.containsKey('task_feedback')) {
      context.handle(
        _taskFeedbackMeta,
        taskFeedback.isAcceptableOrUnknown(
          data['task_feedback']!,
          _taskFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('coherencek_feedback')) {
      context.handle(
        _coherencekFeedbackMeta,
        coherencekFeedback.isAcceptableOrUnknown(
          data['coherencek_feedback']!,
          _coherencekFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('lexial_feedback')) {
      context.handle(
        _lexialFeedbackMeta,
        lexialFeedback.isAcceptableOrUnknown(
          data['lexial_feedback']!,
          _lexialFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('grammatical_feedback')) {
      context.handle(
        _grammaticalFeedbackMeta,
        grammaticalFeedback.isAcceptableOrUnknown(
          data['grammatical_feedback']!,
          _grammaticalFeedbackMeta,
        ),
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
      userAnswerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_answer_id'],
      )!,
      promptType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_type'],
      )!,
      taskContext: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_context'],
      )!,
      taskInstruction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_instruction'],
      )!,
      diagramDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diagram_description'],
      ),
      diagramFileUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diagram_file_uuid'],
      ),
      answerText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_text'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      bandScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}band_score'],
      ),
      taskScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}task_score'],
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
      taskFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_feedback'],
      ),
      coherencekFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coherencek_feedback'],
      ),
      lexialFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lexial_feedback'],
      ),
      grammaticalFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammatical_feedback'],
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
  final int userAnswerId;
  final String promptType;
  final String taskContext;
  final String taskInstruction;
  final String? diagramDescription;
  final String? diagramFileUuid;
  final String answerText;
  final int duration;
  final double? bandScore;
  final double? taskScore;
  final double? coherenceScore;
  final double? lexialScore;
  final double? grammaticalScore;
  final bool isGraded;
  final String? taskFeedback;
  final String? coherencekFeedback;
  final String? lexialFeedback;
  final String? grammaticalFeedback;
  final DateTime updatedAt;
  const WritingAnswerDetailsTableData({
    required this.id,
    required this.userAnswerId,
    required this.promptType,
    required this.taskContext,
    required this.taskInstruction,
    this.diagramDescription,
    this.diagramFileUuid,
    required this.answerText,
    required this.duration,
    this.bandScore,
    this.taskScore,
    this.coherenceScore,
    this.lexialScore,
    this.grammaticalScore,
    required this.isGraded,
    this.taskFeedback,
    this.coherencekFeedback,
    this.lexialFeedback,
    this.grammaticalFeedback,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_answer_id'] = Variable<int>(userAnswerId);
    map['prompt_type'] = Variable<String>(promptType);
    map['task_context'] = Variable<String>(taskContext);
    map['task_instruction'] = Variable<String>(taskInstruction);
    if (!nullToAbsent || diagramDescription != null) {
      map['diagram_description'] = Variable<String>(diagramDescription);
    }
    if (!nullToAbsent || diagramFileUuid != null) {
      map['diagram_file_uuid'] = Variable<String>(diagramFileUuid);
    }
    map['answer_text'] = Variable<String>(answerText);
    map['duration'] = Variable<int>(duration);
    if (!nullToAbsent || bandScore != null) {
      map['band_score'] = Variable<double>(bandScore);
    }
    if (!nullToAbsent || taskScore != null) {
      map['task_score'] = Variable<double>(taskScore);
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
    if (!nullToAbsent || taskFeedback != null) {
      map['task_feedback'] = Variable<String>(taskFeedback);
    }
    if (!nullToAbsent || coherencekFeedback != null) {
      map['coherencek_feedback'] = Variable<String>(coherencekFeedback);
    }
    if (!nullToAbsent || lexialFeedback != null) {
      map['lexial_feedback'] = Variable<String>(lexialFeedback);
    }
    if (!nullToAbsent || grammaticalFeedback != null) {
      map['grammatical_feedback'] = Variable<String>(grammaticalFeedback);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WritingAnswerDetailsTableCompanion toCompanion(bool nullToAbsent) {
    return WritingAnswerDetailsTableCompanion(
      id: Value(id),
      userAnswerId: Value(userAnswerId),
      promptType: Value(promptType),
      taskContext: Value(taskContext),
      taskInstruction: Value(taskInstruction),
      diagramDescription: diagramDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(diagramDescription),
      diagramFileUuid: diagramFileUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(diagramFileUuid),
      answerText: Value(answerText),
      duration: Value(duration),
      bandScore: bandScore == null && nullToAbsent
          ? const Value.absent()
          : Value(bandScore),
      taskScore: taskScore == null && nullToAbsent
          ? const Value.absent()
          : Value(taskScore),
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
      taskFeedback: taskFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(taskFeedback),
      coherencekFeedback: coherencekFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(coherencekFeedback),
      lexialFeedback: lexialFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(lexialFeedback),
      grammaticalFeedback: grammaticalFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(grammaticalFeedback),
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
      userAnswerId: serializer.fromJson<int>(json['userAnswerId']),
      promptType: serializer.fromJson<String>(json['promptType']),
      taskContext: serializer.fromJson<String>(json['taskContext']),
      taskInstruction: serializer.fromJson<String>(json['taskInstruction']),
      diagramDescription: serializer.fromJson<String?>(
        json['diagramDescription'],
      ),
      diagramFileUuid: serializer.fromJson<String?>(json['diagramFileUuid']),
      answerText: serializer.fromJson<String>(json['answerText']),
      duration: serializer.fromJson<int>(json['duration']),
      bandScore: serializer.fromJson<double?>(json['bandScore']),
      taskScore: serializer.fromJson<double?>(json['taskScore']),
      coherenceScore: serializer.fromJson<double?>(json['coherenceScore']),
      lexialScore: serializer.fromJson<double?>(json['lexialScore']),
      grammaticalScore: serializer.fromJson<double?>(json['grammaticalScore']),
      isGraded: serializer.fromJson<bool>(json['isGraded']),
      taskFeedback: serializer.fromJson<String?>(json['taskFeedback']),
      coherencekFeedback: serializer.fromJson<String?>(
        json['coherencekFeedback'],
      ),
      lexialFeedback: serializer.fromJson<String?>(json['lexialFeedback']),
      grammaticalFeedback: serializer.fromJson<String?>(
        json['grammaticalFeedback'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userAnswerId': serializer.toJson<int>(userAnswerId),
      'promptType': serializer.toJson<String>(promptType),
      'taskContext': serializer.toJson<String>(taskContext),
      'taskInstruction': serializer.toJson<String>(taskInstruction),
      'diagramDescription': serializer.toJson<String?>(diagramDescription),
      'diagramFileUuid': serializer.toJson<String?>(diagramFileUuid),
      'answerText': serializer.toJson<String>(answerText),
      'duration': serializer.toJson<int>(duration),
      'bandScore': serializer.toJson<double?>(bandScore),
      'taskScore': serializer.toJson<double?>(taskScore),
      'coherenceScore': serializer.toJson<double?>(coherenceScore),
      'lexialScore': serializer.toJson<double?>(lexialScore),
      'grammaticalScore': serializer.toJson<double?>(grammaticalScore),
      'isGraded': serializer.toJson<bool>(isGraded),
      'taskFeedback': serializer.toJson<String?>(taskFeedback),
      'coherencekFeedback': serializer.toJson<String?>(coherencekFeedback),
      'lexialFeedback': serializer.toJson<String?>(lexialFeedback),
      'grammaticalFeedback': serializer.toJson<String?>(grammaticalFeedback),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WritingAnswerDetailsTableData copyWith({
    int? id,
    int? userAnswerId,
    String? promptType,
    String? taskContext,
    String? taskInstruction,
    Value<String?> diagramDescription = const Value.absent(),
    Value<String?> diagramFileUuid = const Value.absent(),
    String? answerText,
    int? duration,
    Value<double?> bandScore = const Value.absent(),
    Value<double?> taskScore = const Value.absent(),
    Value<double?> coherenceScore = const Value.absent(),
    Value<double?> lexialScore = const Value.absent(),
    Value<double?> grammaticalScore = const Value.absent(),
    bool? isGraded,
    Value<String?> taskFeedback = const Value.absent(),
    Value<String?> coherencekFeedback = const Value.absent(),
    Value<String?> lexialFeedback = const Value.absent(),
    Value<String?> grammaticalFeedback = const Value.absent(),
    DateTime? updatedAt,
  }) => WritingAnswerDetailsTableData(
    id: id ?? this.id,
    userAnswerId: userAnswerId ?? this.userAnswerId,
    promptType: promptType ?? this.promptType,
    taskContext: taskContext ?? this.taskContext,
    taskInstruction: taskInstruction ?? this.taskInstruction,
    diagramDescription: diagramDescription.present
        ? diagramDescription.value
        : this.diagramDescription,
    diagramFileUuid: diagramFileUuid.present
        ? diagramFileUuid.value
        : this.diagramFileUuid,
    answerText: answerText ?? this.answerText,
    duration: duration ?? this.duration,
    bandScore: bandScore.present ? bandScore.value : this.bandScore,
    taskScore: taskScore.present ? taskScore.value : this.taskScore,
    coherenceScore: coherenceScore.present
        ? coherenceScore.value
        : this.coherenceScore,
    lexialScore: lexialScore.present ? lexialScore.value : this.lexialScore,
    grammaticalScore: grammaticalScore.present
        ? grammaticalScore.value
        : this.grammaticalScore,
    isGraded: isGraded ?? this.isGraded,
    taskFeedback: taskFeedback.present ? taskFeedback.value : this.taskFeedback,
    coherencekFeedback: coherencekFeedback.present
        ? coherencekFeedback.value
        : this.coherencekFeedback,
    lexialFeedback: lexialFeedback.present
        ? lexialFeedback.value
        : this.lexialFeedback,
    grammaticalFeedback: grammaticalFeedback.present
        ? grammaticalFeedback.value
        : this.grammaticalFeedback,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WritingAnswerDetailsTableData copyWithCompanion(
    WritingAnswerDetailsTableCompanion data,
  ) {
    return WritingAnswerDetailsTableData(
      id: data.id.present ? data.id.value : this.id,
      userAnswerId: data.userAnswerId.present
          ? data.userAnswerId.value
          : this.userAnswerId,
      promptType: data.promptType.present
          ? data.promptType.value
          : this.promptType,
      taskContext: data.taskContext.present
          ? data.taskContext.value
          : this.taskContext,
      taskInstruction: data.taskInstruction.present
          ? data.taskInstruction.value
          : this.taskInstruction,
      diagramDescription: data.diagramDescription.present
          ? data.diagramDescription.value
          : this.diagramDescription,
      diagramFileUuid: data.diagramFileUuid.present
          ? data.diagramFileUuid.value
          : this.diagramFileUuid,
      answerText: data.answerText.present
          ? data.answerText.value
          : this.answerText,
      duration: data.duration.present ? data.duration.value : this.duration,
      bandScore: data.bandScore.present ? data.bandScore.value : this.bandScore,
      taskScore: data.taskScore.present ? data.taskScore.value : this.taskScore,
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
      taskFeedback: data.taskFeedback.present
          ? data.taskFeedback.value
          : this.taskFeedback,
      coherencekFeedback: data.coherencekFeedback.present
          ? data.coherencekFeedback.value
          : this.coherencekFeedback,
      lexialFeedback: data.lexialFeedback.present
          ? data.lexialFeedback.value
          : this.lexialFeedback,
      grammaticalFeedback: data.grammaticalFeedback.present
          ? data.grammaticalFeedback.value
          : this.grammaticalFeedback,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WritingAnswerDetailsTableData(')
          ..write('id: $id, ')
          ..write('userAnswerId: $userAnswerId, ')
          ..write('promptType: $promptType, ')
          ..write('taskContext: $taskContext, ')
          ..write('taskInstruction: $taskInstruction, ')
          ..write('diagramDescription: $diagramDescription, ')
          ..write('diagramFileUuid: $diagramFileUuid, ')
          ..write('answerText: $answerText, ')
          ..write('duration: $duration, ')
          ..write('bandScore: $bandScore, ')
          ..write('taskScore: $taskScore, ')
          ..write('coherenceScore: $coherenceScore, ')
          ..write('lexialScore: $lexialScore, ')
          ..write('grammaticalScore: $grammaticalScore, ')
          ..write('isGraded: $isGraded, ')
          ..write('taskFeedback: $taskFeedback, ')
          ..write('coherencekFeedback: $coherencekFeedback, ')
          ..write('lexialFeedback: $lexialFeedback, ')
          ..write('grammaticalFeedback: $grammaticalFeedback, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userAnswerId,
    promptType,
    taskContext,
    taskInstruction,
    diagramDescription,
    diagramFileUuid,
    answerText,
    duration,
    bandScore,
    taskScore,
    coherenceScore,
    lexialScore,
    grammaticalScore,
    isGraded,
    taskFeedback,
    coherencekFeedback,
    lexialFeedback,
    grammaticalFeedback,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WritingAnswerDetailsTableData &&
          other.id == this.id &&
          other.userAnswerId == this.userAnswerId &&
          other.promptType == this.promptType &&
          other.taskContext == this.taskContext &&
          other.taskInstruction == this.taskInstruction &&
          other.diagramDescription == this.diagramDescription &&
          other.diagramFileUuid == this.diagramFileUuid &&
          other.answerText == this.answerText &&
          other.duration == this.duration &&
          other.bandScore == this.bandScore &&
          other.taskScore == this.taskScore &&
          other.coherenceScore == this.coherenceScore &&
          other.lexialScore == this.lexialScore &&
          other.grammaticalScore == this.grammaticalScore &&
          other.isGraded == this.isGraded &&
          other.taskFeedback == this.taskFeedback &&
          other.coherencekFeedback == this.coherencekFeedback &&
          other.lexialFeedback == this.lexialFeedback &&
          other.grammaticalFeedback == this.grammaticalFeedback &&
          other.updatedAt == this.updatedAt);
}

class WritingAnswerDetailsTableCompanion
    extends UpdateCompanion<WritingAnswerDetailsTableData> {
  final Value<int> id;
  final Value<int> userAnswerId;
  final Value<String> promptType;
  final Value<String> taskContext;
  final Value<String> taskInstruction;
  final Value<String?> diagramDescription;
  final Value<String?> diagramFileUuid;
  final Value<String> answerText;
  final Value<int> duration;
  final Value<double?> bandScore;
  final Value<double?> taskScore;
  final Value<double?> coherenceScore;
  final Value<double?> lexialScore;
  final Value<double?> grammaticalScore;
  final Value<bool> isGraded;
  final Value<String?> taskFeedback;
  final Value<String?> coherencekFeedback;
  final Value<String?> lexialFeedback;
  final Value<String?> grammaticalFeedback;
  final Value<DateTime> updatedAt;
  const WritingAnswerDetailsTableCompanion({
    this.id = const Value.absent(),
    this.userAnswerId = const Value.absent(),
    this.promptType = const Value.absent(),
    this.taskContext = const Value.absent(),
    this.taskInstruction = const Value.absent(),
    this.diagramDescription = const Value.absent(),
    this.diagramFileUuid = const Value.absent(),
    this.answerText = const Value.absent(),
    this.duration = const Value.absent(),
    this.bandScore = const Value.absent(),
    this.taskScore = const Value.absent(),
    this.coherenceScore = const Value.absent(),
    this.lexialScore = const Value.absent(),
    this.grammaticalScore = const Value.absent(),
    this.isGraded = const Value.absent(),
    this.taskFeedback = const Value.absent(),
    this.coherencekFeedback = const Value.absent(),
    this.lexialFeedback = const Value.absent(),
    this.grammaticalFeedback = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WritingAnswerDetailsTableCompanion.insert({
    this.id = const Value.absent(),
    required int userAnswerId,
    required String promptType,
    required String taskContext,
    required String taskInstruction,
    this.diagramDescription = const Value.absent(),
    this.diagramFileUuid = const Value.absent(),
    required String answerText,
    required int duration,
    this.bandScore = const Value.absent(),
    this.taskScore = const Value.absent(),
    this.coherenceScore = const Value.absent(),
    this.lexialScore = const Value.absent(),
    this.grammaticalScore = const Value.absent(),
    this.isGraded = const Value.absent(),
    this.taskFeedback = const Value.absent(),
    this.coherencekFeedback = const Value.absent(),
    this.lexialFeedback = const Value.absent(),
    this.grammaticalFeedback = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userAnswerId = Value(userAnswerId),
       promptType = Value(promptType),
       taskContext = Value(taskContext),
       taskInstruction = Value(taskInstruction),
       answerText = Value(answerText),
       duration = Value(duration);
  static Insertable<WritingAnswerDetailsTableData> custom({
    Expression<int>? id,
    Expression<int>? userAnswerId,
    Expression<String>? promptType,
    Expression<String>? taskContext,
    Expression<String>? taskInstruction,
    Expression<String>? diagramDescription,
    Expression<String>? diagramFileUuid,
    Expression<String>? answerText,
    Expression<int>? duration,
    Expression<double>? bandScore,
    Expression<double>? taskScore,
    Expression<double>? coherenceScore,
    Expression<double>? lexialScore,
    Expression<double>? grammaticalScore,
    Expression<bool>? isGraded,
    Expression<String>? taskFeedback,
    Expression<String>? coherencekFeedback,
    Expression<String>? lexialFeedback,
    Expression<String>? grammaticalFeedback,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userAnswerId != null) 'user_answer_id': userAnswerId,
      if (promptType != null) 'prompt_type': promptType,
      if (taskContext != null) 'task_context': taskContext,
      if (taskInstruction != null) 'task_instruction': taskInstruction,
      if (diagramDescription != null) 'diagram_description': diagramDescription,
      if (diagramFileUuid != null) 'diagram_file_uuid': diagramFileUuid,
      if (answerText != null) 'answer_text': answerText,
      if (duration != null) 'duration': duration,
      if (bandScore != null) 'band_score': bandScore,
      if (taskScore != null) 'task_score': taskScore,
      if (coherenceScore != null) 'coherence_score': coherenceScore,
      if (lexialScore != null) 'lexial_score': lexialScore,
      if (grammaticalScore != null) 'grammatical_score': grammaticalScore,
      if (isGraded != null) 'is_graded': isGraded,
      if (taskFeedback != null) 'task_feedback': taskFeedback,
      if (coherencekFeedback != null) 'coherencek_feedback': coherencekFeedback,
      if (lexialFeedback != null) 'lexial_feedback': lexialFeedback,
      if (grammaticalFeedback != null)
        'grammatical_feedback': grammaticalFeedback,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WritingAnswerDetailsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userAnswerId,
    Value<String>? promptType,
    Value<String>? taskContext,
    Value<String>? taskInstruction,
    Value<String?>? diagramDescription,
    Value<String?>? diagramFileUuid,
    Value<String>? answerText,
    Value<int>? duration,
    Value<double?>? bandScore,
    Value<double?>? taskScore,
    Value<double?>? coherenceScore,
    Value<double?>? lexialScore,
    Value<double?>? grammaticalScore,
    Value<bool>? isGraded,
    Value<String?>? taskFeedback,
    Value<String?>? coherencekFeedback,
    Value<String?>? lexialFeedback,
    Value<String?>? grammaticalFeedback,
    Value<DateTime>? updatedAt,
  }) {
    return WritingAnswerDetailsTableCompanion(
      id: id ?? this.id,
      userAnswerId: userAnswerId ?? this.userAnswerId,
      promptType: promptType ?? this.promptType,
      taskContext: taskContext ?? this.taskContext,
      taskInstruction: taskInstruction ?? this.taskInstruction,
      diagramDescription: diagramDescription ?? this.diagramDescription,
      diagramFileUuid: diagramFileUuid ?? this.diagramFileUuid,
      answerText: answerText ?? this.answerText,
      duration: duration ?? this.duration,
      bandScore: bandScore ?? this.bandScore,
      taskScore: taskScore ?? this.taskScore,
      coherenceScore: coherenceScore ?? this.coherenceScore,
      lexialScore: lexialScore ?? this.lexialScore,
      grammaticalScore: grammaticalScore ?? this.grammaticalScore,
      isGraded: isGraded ?? this.isGraded,
      taskFeedback: taskFeedback ?? this.taskFeedback,
      coherencekFeedback: coherencekFeedback ?? this.coherencekFeedback,
      lexialFeedback: lexialFeedback ?? this.lexialFeedback,
      grammaticalFeedback: grammaticalFeedback ?? this.grammaticalFeedback,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userAnswerId.present) {
      map['user_answer_id'] = Variable<int>(userAnswerId.value);
    }
    if (promptType.present) {
      map['prompt_type'] = Variable<String>(promptType.value);
    }
    if (taskContext.present) {
      map['task_context'] = Variable<String>(taskContext.value);
    }
    if (taskInstruction.present) {
      map['task_instruction'] = Variable<String>(taskInstruction.value);
    }
    if (diagramDescription.present) {
      map['diagram_description'] = Variable<String>(diagramDescription.value);
    }
    if (diagramFileUuid.present) {
      map['diagram_file_uuid'] = Variable<String>(diagramFileUuid.value);
    }
    if (answerText.present) {
      map['answer_text'] = Variable<String>(answerText.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (bandScore.present) {
      map['band_score'] = Variable<double>(bandScore.value);
    }
    if (taskScore.present) {
      map['task_score'] = Variable<double>(taskScore.value);
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
    if (taskFeedback.present) {
      map['task_feedback'] = Variable<String>(taskFeedback.value);
    }
    if (coherencekFeedback.present) {
      map['coherencek_feedback'] = Variable<String>(coherencekFeedback.value);
    }
    if (lexialFeedback.present) {
      map['lexial_feedback'] = Variable<String>(lexialFeedback.value);
    }
    if (grammaticalFeedback.present) {
      map['grammatical_feedback'] = Variable<String>(grammaticalFeedback.value);
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
          ..write('userAnswerId: $userAnswerId, ')
          ..write('promptType: $promptType, ')
          ..write('taskContext: $taskContext, ')
          ..write('taskInstruction: $taskInstruction, ')
          ..write('diagramDescription: $diagramDescription, ')
          ..write('diagramFileUuid: $diagramFileUuid, ')
          ..write('answerText: $answerText, ')
          ..write('duration: $duration, ')
          ..write('bandScore: $bandScore, ')
          ..write('taskScore: $taskScore, ')
          ..write('coherenceScore: $coherenceScore, ')
          ..write('lexialScore: $lexialScore, ')
          ..write('grammaticalScore: $grammaticalScore, ')
          ..write('isGraded: $isGraded, ')
          ..write('taskFeedback: $taskFeedback, ')
          ..write('coherencekFeedback: $coherencekFeedback, ')
          ..write('lexialFeedback: $lexialFeedback, ')
          ..write('grammaticalFeedback: $grammaticalFeedback, ')
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
  static const VerificationMeta _userAnswerIdMeta = const VerificationMeta(
    'userAnswerId',
  );
  @override
  late final GeneratedColumn<int> userAnswerId = GeneratedColumn<int>(
    'user_answer_id',
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
  List<GeneratedColumn> get $columns => [userAnswerId, order, title];
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
    if (data.containsKey('user_answer_id')) {
      context.handle(
        _userAnswerIdMeta,
        userAnswerId.isAcceptableOrUnknown(
          data['user_answer_id']!,
          _userAnswerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userAnswerIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {userAnswerId, order};
  @override
  PromptTopicsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromptTopicsTableData(
      userAnswerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_answer_id'],
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
  final int userAnswerId;
  final int order;
  final String title;
  const PromptTopicsTableData({
    required this.userAnswerId,
    required this.order,
    required this.title,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_answer_id'] = Variable<int>(userAnswerId);
    map['order'] = Variable<int>(order);
    map['title'] = Variable<String>(title);
    return map;
  }

  PromptTopicsTableCompanion toCompanion(bool nullToAbsent) {
    return PromptTopicsTableCompanion(
      userAnswerId: Value(userAnswerId),
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
      userAnswerId: serializer.fromJson<int>(json['userAnswerId']),
      order: serializer.fromJson<int>(json['order']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userAnswerId': serializer.toJson<int>(userAnswerId),
      'order': serializer.toJson<int>(order),
      'title': serializer.toJson<String>(title),
    };
  }

  PromptTopicsTableData copyWith({
    int? userAnswerId,
    int? order,
    String? title,
  }) => PromptTopicsTableData(
    userAnswerId: userAnswerId ?? this.userAnswerId,
    order: order ?? this.order,
    title: title ?? this.title,
  );
  PromptTopicsTableData copyWithCompanion(PromptTopicsTableCompanion data) {
    return PromptTopicsTableData(
      userAnswerId: data.userAnswerId.present
          ? data.userAnswerId.value
          : this.userAnswerId,
      order: data.order.present ? data.order.value : this.order,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PromptTopicsTableData(')
          ..write('userAnswerId: $userAnswerId, ')
          ..write('order: $order, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userAnswerId, order, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromptTopicsTableData &&
          other.userAnswerId == this.userAnswerId &&
          other.order == this.order &&
          other.title == this.title);
}

class PromptTopicsTableCompanion
    extends UpdateCompanion<PromptTopicsTableData> {
  final Value<int> userAnswerId;
  final Value<int> order;
  final Value<String> title;
  final Value<int> rowid;
  const PromptTopicsTableCompanion({
    this.userAnswerId = const Value.absent(),
    this.order = const Value.absent(),
    this.title = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PromptTopicsTableCompanion.insert({
    required int userAnswerId,
    required int order,
    required String title,
    this.rowid = const Value.absent(),
  }) : userAnswerId = Value(userAnswerId),
       order = Value(order),
       title = Value(title);
  static Insertable<PromptTopicsTableData> custom({
    Expression<int>? userAnswerId,
    Expression<int>? order,
    Expression<String>? title,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userAnswerId != null) 'user_answer_id': userAnswerId,
      if (order != null) 'order': order,
      if (title != null) 'title': title,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PromptTopicsTableCompanion copyWith({
    Value<int>? userAnswerId,
    Value<int>? order,
    Value<String>? title,
    Value<int>? rowid,
  }) {
    return PromptTopicsTableCompanion(
      userAnswerId: userAnswerId ?? this.userAnswerId,
      order: order ?? this.order,
      title: title ?? this.title,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userAnswerId.present) {
      map['user_answer_id'] = Variable<int>(userAnswerId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptTopicsTableCompanion(')
          ..write('userAnswerId: $userAnswerId, ')
          ..write('order: $order, ')
          ..write('title: $title, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpeakingAnswerDetailsTableTable extends SpeakingAnswerDetailsTable
    with
        TableInfo<
          $SpeakingAnswerDetailsTableTable,
          SpeakingAnswerDetailsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeakingAnswerDetailsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userAnswerIdMeta = const VerificationMeta(
    'userAnswerId',
  );
  @override
  late final GeneratedColumn<int> userAnswerId = GeneratedColumn<int>(
    'user_answer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_answers (id)',
    ),
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
  static const VerificationMeta _bandScoreMeta = const VerificationMeta(
    'bandScore',
  );
  @override
  late final GeneratedColumn<double> bandScore = GeneratedColumn<double>(
    'band_score',
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
  static const VerificationMeta _fluencyScoreMeta = const VerificationMeta(
    'fluencyScore',
  );
  @override
  late final GeneratedColumn<double> fluencyScore = GeneratedColumn<double>(
    'fluency_score',
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
  static const VerificationMeta _coherenceFeedbackMeta = const VerificationMeta(
    'coherenceFeedback',
  );
  @override
  late final GeneratedColumn<String> coherenceFeedback =
      GeneratedColumn<String>(
        'coherence_feedback',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lexicalFeedbackMeta = const VerificationMeta(
    'lexicalFeedback',
  );
  @override
  late final GeneratedColumn<String> lexicalFeedback = GeneratedColumn<String>(
    'lexical_feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grammaticalFeedbackMeta =
      const VerificationMeta('grammaticalFeedback');
  @override
  late final GeneratedColumn<String> grammaticalFeedback =
      GeneratedColumn<String>(
        'grammatical_feedback',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _fluencyFeedbackMeta = const VerificationMeta(
    'fluencyFeedback',
  );
  @override
  late final GeneratedColumn<String> fluencyFeedback = GeneratedColumn<String>(
    'fluency_feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
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
    userAnswerId,
    duration,
    bandScore,
    coherenceScore,
    lexialScore,
    grammaticalScore,
    fluencyScore,
    isGraded,
    coherenceFeedback,
    lexicalFeedback,
    grammaticalFeedback,
    fluencyFeedback,
    note,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'speaking_answer_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeakingAnswerDetailsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_answer_id')) {
      context.handle(
        _userAnswerIdMeta,
        userAnswerId.isAcceptableOrUnknown(
          data['user_answer_id']!,
          _userAnswerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userAnswerIdMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('band_score')) {
      context.handle(
        _bandScoreMeta,
        bandScore.isAcceptableOrUnknown(data['band_score']!, _bandScoreMeta),
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
    if (data.containsKey('fluency_score')) {
      context.handle(
        _fluencyScoreMeta,
        fluencyScore.isAcceptableOrUnknown(
          data['fluency_score']!,
          _fluencyScoreMeta,
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
    if (data.containsKey('coherence_feedback')) {
      context.handle(
        _coherenceFeedbackMeta,
        coherenceFeedback.isAcceptableOrUnknown(
          data['coherence_feedback']!,
          _coherenceFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('lexical_feedback')) {
      context.handle(
        _lexicalFeedbackMeta,
        lexicalFeedback.isAcceptableOrUnknown(
          data['lexical_feedback']!,
          _lexicalFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('grammatical_feedback')) {
      context.handle(
        _grammaticalFeedbackMeta,
        grammaticalFeedback.isAcceptableOrUnknown(
          data['grammatical_feedback']!,
          _grammaticalFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('fluency_feedback')) {
      context.handle(
        _fluencyFeedbackMeta,
        fluencyFeedback.isAcceptableOrUnknown(
          data['fluency_feedback']!,
          _fluencyFeedbackMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
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
  SpeakingAnswerDetailsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeakingAnswerDetailsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userAnswerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_answer_id'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      bandScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}band_score'],
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
      fluencyScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fluency_score'],
      ),
      isGraded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_graded'],
      )!,
      coherenceFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coherence_feedback'],
      ),
      lexicalFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lexical_feedback'],
      ),
      grammaticalFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammatical_feedback'],
      ),
      fluencyFeedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fluency_feedback'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SpeakingAnswerDetailsTableTable createAlias(String alias) {
    return $SpeakingAnswerDetailsTableTable(attachedDatabase, alias);
  }
}

class SpeakingAnswerDetailsTableData extends DataClass
    implements Insertable<SpeakingAnswerDetailsTableData> {
  final int id;
  final int userAnswerId;
  final int duration;
  final double? bandScore;
  final double? coherenceScore;
  final double? lexialScore;
  final double? grammaticalScore;
  final double? fluencyScore;
  final bool isGraded;
  final String? coherenceFeedback;
  final String? lexicalFeedback;
  final String? grammaticalFeedback;
  final String? fluencyFeedback;
  final String? note;
  final DateTime updatedAt;
  const SpeakingAnswerDetailsTableData({
    required this.id,
    required this.userAnswerId,
    required this.duration,
    this.bandScore,
    this.coherenceScore,
    this.lexialScore,
    this.grammaticalScore,
    this.fluencyScore,
    required this.isGraded,
    this.coherenceFeedback,
    this.lexicalFeedback,
    this.grammaticalFeedback,
    this.fluencyFeedback,
    this.note,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_answer_id'] = Variable<int>(userAnswerId);
    map['duration'] = Variable<int>(duration);
    if (!nullToAbsent || bandScore != null) {
      map['band_score'] = Variable<double>(bandScore);
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
    if (!nullToAbsent || fluencyScore != null) {
      map['fluency_score'] = Variable<double>(fluencyScore);
    }
    map['is_graded'] = Variable<bool>(isGraded);
    if (!nullToAbsent || coherenceFeedback != null) {
      map['coherence_feedback'] = Variable<String>(coherenceFeedback);
    }
    if (!nullToAbsent || lexicalFeedback != null) {
      map['lexical_feedback'] = Variable<String>(lexicalFeedback);
    }
    if (!nullToAbsent || grammaticalFeedback != null) {
      map['grammatical_feedback'] = Variable<String>(grammaticalFeedback);
    }
    if (!nullToAbsent || fluencyFeedback != null) {
      map['fluency_feedback'] = Variable<String>(fluencyFeedback);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SpeakingAnswerDetailsTableCompanion toCompanion(bool nullToAbsent) {
    return SpeakingAnswerDetailsTableCompanion(
      id: Value(id),
      userAnswerId: Value(userAnswerId),
      duration: Value(duration),
      bandScore: bandScore == null && nullToAbsent
          ? const Value.absent()
          : Value(bandScore),
      coherenceScore: coherenceScore == null && nullToAbsent
          ? const Value.absent()
          : Value(coherenceScore),
      lexialScore: lexialScore == null && nullToAbsent
          ? const Value.absent()
          : Value(lexialScore),
      grammaticalScore: grammaticalScore == null && nullToAbsent
          ? const Value.absent()
          : Value(grammaticalScore),
      fluencyScore: fluencyScore == null && nullToAbsent
          ? const Value.absent()
          : Value(fluencyScore),
      isGraded: Value(isGraded),
      coherenceFeedback: coherenceFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(coherenceFeedback),
      lexicalFeedback: lexicalFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(lexicalFeedback),
      grammaticalFeedback: grammaticalFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(grammaticalFeedback),
      fluencyFeedback: fluencyFeedback == null && nullToAbsent
          ? const Value.absent()
          : Value(fluencyFeedback),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      updatedAt: Value(updatedAt),
    );
  }

  factory SpeakingAnswerDetailsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeakingAnswerDetailsTableData(
      id: serializer.fromJson<int>(json['id']),
      userAnswerId: serializer.fromJson<int>(json['userAnswerId']),
      duration: serializer.fromJson<int>(json['duration']),
      bandScore: serializer.fromJson<double?>(json['bandScore']),
      coherenceScore: serializer.fromJson<double?>(json['coherenceScore']),
      lexialScore: serializer.fromJson<double?>(json['lexialScore']),
      grammaticalScore: serializer.fromJson<double?>(json['grammaticalScore']),
      fluencyScore: serializer.fromJson<double?>(json['fluencyScore']),
      isGraded: serializer.fromJson<bool>(json['isGraded']),
      coherenceFeedback: serializer.fromJson<String?>(
        json['coherenceFeedback'],
      ),
      lexicalFeedback: serializer.fromJson<String?>(json['lexicalFeedback']),
      grammaticalFeedback: serializer.fromJson<String?>(
        json['grammaticalFeedback'],
      ),
      fluencyFeedback: serializer.fromJson<String?>(json['fluencyFeedback']),
      note: serializer.fromJson<String?>(json['note']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userAnswerId': serializer.toJson<int>(userAnswerId),
      'duration': serializer.toJson<int>(duration),
      'bandScore': serializer.toJson<double?>(bandScore),
      'coherenceScore': serializer.toJson<double?>(coherenceScore),
      'lexialScore': serializer.toJson<double?>(lexialScore),
      'grammaticalScore': serializer.toJson<double?>(grammaticalScore),
      'fluencyScore': serializer.toJson<double?>(fluencyScore),
      'isGraded': serializer.toJson<bool>(isGraded),
      'coherenceFeedback': serializer.toJson<String?>(coherenceFeedback),
      'lexicalFeedback': serializer.toJson<String?>(lexicalFeedback),
      'grammaticalFeedback': serializer.toJson<String?>(grammaticalFeedback),
      'fluencyFeedback': serializer.toJson<String?>(fluencyFeedback),
      'note': serializer.toJson<String?>(note),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SpeakingAnswerDetailsTableData copyWith({
    int? id,
    int? userAnswerId,
    int? duration,
    Value<double?> bandScore = const Value.absent(),
    Value<double?> coherenceScore = const Value.absent(),
    Value<double?> lexialScore = const Value.absent(),
    Value<double?> grammaticalScore = const Value.absent(),
    Value<double?> fluencyScore = const Value.absent(),
    bool? isGraded,
    Value<String?> coherenceFeedback = const Value.absent(),
    Value<String?> lexicalFeedback = const Value.absent(),
    Value<String?> grammaticalFeedback = const Value.absent(),
    Value<String?> fluencyFeedback = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? updatedAt,
  }) => SpeakingAnswerDetailsTableData(
    id: id ?? this.id,
    userAnswerId: userAnswerId ?? this.userAnswerId,
    duration: duration ?? this.duration,
    bandScore: bandScore.present ? bandScore.value : this.bandScore,
    coherenceScore: coherenceScore.present
        ? coherenceScore.value
        : this.coherenceScore,
    lexialScore: lexialScore.present ? lexialScore.value : this.lexialScore,
    grammaticalScore: grammaticalScore.present
        ? grammaticalScore.value
        : this.grammaticalScore,
    fluencyScore: fluencyScore.present ? fluencyScore.value : this.fluencyScore,
    isGraded: isGraded ?? this.isGraded,
    coherenceFeedback: coherenceFeedback.present
        ? coherenceFeedback.value
        : this.coherenceFeedback,
    lexicalFeedback: lexicalFeedback.present
        ? lexicalFeedback.value
        : this.lexicalFeedback,
    grammaticalFeedback: grammaticalFeedback.present
        ? grammaticalFeedback.value
        : this.grammaticalFeedback,
    fluencyFeedback: fluencyFeedback.present
        ? fluencyFeedback.value
        : this.fluencyFeedback,
    note: note.present ? note.value : this.note,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SpeakingAnswerDetailsTableData copyWithCompanion(
    SpeakingAnswerDetailsTableCompanion data,
  ) {
    return SpeakingAnswerDetailsTableData(
      id: data.id.present ? data.id.value : this.id,
      userAnswerId: data.userAnswerId.present
          ? data.userAnswerId.value
          : this.userAnswerId,
      duration: data.duration.present ? data.duration.value : this.duration,
      bandScore: data.bandScore.present ? data.bandScore.value : this.bandScore,
      coherenceScore: data.coherenceScore.present
          ? data.coherenceScore.value
          : this.coherenceScore,
      lexialScore: data.lexialScore.present
          ? data.lexialScore.value
          : this.lexialScore,
      grammaticalScore: data.grammaticalScore.present
          ? data.grammaticalScore.value
          : this.grammaticalScore,
      fluencyScore: data.fluencyScore.present
          ? data.fluencyScore.value
          : this.fluencyScore,
      isGraded: data.isGraded.present ? data.isGraded.value : this.isGraded,
      coherenceFeedback: data.coherenceFeedback.present
          ? data.coherenceFeedback.value
          : this.coherenceFeedback,
      lexicalFeedback: data.lexicalFeedback.present
          ? data.lexicalFeedback.value
          : this.lexicalFeedback,
      grammaticalFeedback: data.grammaticalFeedback.present
          ? data.grammaticalFeedback.value
          : this.grammaticalFeedback,
      fluencyFeedback: data.fluencyFeedback.present
          ? data.fluencyFeedback.value
          : this.fluencyFeedback,
      note: data.note.present ? data.note.value : this.note,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeakingAnswerDetailsTableData(')
          ..write('id: $id, ')
          ..write('userAnswerId: $userAnswerId, ')
          ..write('duration: $duration, ')
          ..write('bandScore: $bandScore, ')
          ..write('coherenceScore: $coherenceScore, ')
          ..write('lexialScore: $lexialScore, ')
          ..write('grammaticalScore: $grammaticalScore, ')
          ..write('fluencyScore: $fluencyScore, ')
          ..write('isGraded: $isGraded, ')
          ..write('coherenceFeedback: $coherenceFeedback, ')
          ..write('lexicalFeedback: $lexicalFeedback, ')
          ..write('grammaticalFeedback: $grammaticalFeedback, ')
          ..write('fluencyFeedback: $fluencyFeedback, ')
          ..write('note: $note, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userAnswerId,
    duration,
    bandScore,
    coherenceScore,
    lexialScore,
    grammaticalScore,
    fluencyScore,
    isGraded,
    coherenceFeedback,
    lexicalFeedback,
    grammaticalFeedback,
    fluencyFeedback,
    note,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeakingAnswerDetailsTableData &&
          other.id == this.id &&
          other.userAnswerId == this.userAnswerId &&
          other.duration == this.duration &&
          other.bandScore == this.bandScore &&
          other.coherenceScore == this.coherenceScore &&
          other.lexialScore == this.lexialScore &&
          other.grammaticalScore == this.grammaticalScore &&
          other.fluencyScore == this.fluencyScore &&
          other.isGraded == this.isGraded &&
          other.coherenceFeedback == this.coherenceFeedback &&
          other.lexicalFeedback == this.lexicalFeedback &&
          other.grammaticalFeedback == this.grammaticalFeedback &&
          other.fluencyFeedback == this.fluencyFeedback &&
          other.note == this.note &&
          other.updatedAt == this.updatedAt);
}

class SpeakingAnswerDetailsTableCompanion
    extends UpdateCompanion<SpeakingAnswerDetailsTableData> {
  final Value<int> id;
  final Value<int> userAnswerId;
  final Value<int> duration;
  final Value<double?> bandScore;
  final Value<double?> coherenceScore;
  final Value<double?> lexialScore;
  final Value<double?> grammaticalScore;
  final Value<double?> fluencyScore;
  final Value<bool> isGraded;
  final Value<String?> coherenceFeedback;
  final Value<String?> lexicalFeedback;
  final Value<String?> grammaticalFeedback;
  final Value<String?> fluencyFeedback;
  final Value<String?> note;
  final Value<DateTime> updatedAt;
  const SpeakingAnswerDetailsTableCompanion({
    this.id = const Value.absent(),
    this.userAnswerId = const Value.absent(),
    this.duration = const Value.absent(),
    this.bandScore = const Value.absent(),
    this.coherenceScore = const Value.absent(),
    this.lexialScore = const Value.absent(),
    this.grammaticalScore = const Value.absent(),
    this.fluencyScore = const Value.absent(),
    this.isGraded = const Value.absent(),
    this.coherenceFeedback = const Value.absent(),
    this.lexicalFeedback = const Value.absent(),
    this.grammaticalFeedback = const Value.absent(),
    this.fluencyFeedback = const Value.absent(),
    this.note = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SpeakingAnswerDetailsTableCompanion.insert({
    this.id = const Value.absent(),
    required int userAnswerId,
    required int duration,
    this.bandScore = const Value.absent(),
    this.coherenceScore = const Value.absent(),
    this.lexialScore = const Value.absent(),
    this.grammaticalScore = const Value.absent(),
    this.fluencyScore = const Value.absent(),
    required bool isGraded,
    this.coherenceFeedback = const Value.absent(),
    this.lexicalFeedback = const Value.absent(),
    this.grammaticalFeedback = const Value.absent(),
    this.fluencyFeedback = const Value.absent(),
    this.note = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userAnswerId = Value(userAnswerId),
       duration = Value(duration),
       isGraded = Value(isGraded);
  static Insertable<SpeakingAnswerDetailsTableData> custom({
    Expression<int>? id,
    Expression<int>? userAnswerId,
    Expression<int>? duration,
    Expression<double>? bandScore,
    Expression<double>? coherenceScore,
    Expression<double>? lexialScore,
    Expression<double>? grammaticalScore,
    Expression<double>? fluencyScore,
    Expression<bool>? isGraded,
    Expression<String>? coherenceFeedback,
    Expression<String>? lexicalFeedback,
    Expression<String>? grammaticalFeedback,
    Expression<String>? fluencyFeedback,
    Expression<String>? note,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userAnswerId != null) 'user_answer_id': userAnswerId,
      if (duration != null) 'duration': duration,
      if (bandScore != null) 'band_score': bandScore,
      if (coherenceScore != null) 'coherence_score': coherenceScore,
      if (lexialScore != null) 'lexial_score': lexialScore,
      if (grammaticalScore != null) 'grammatical_score': grammaticalScore,
      if (fluencyScore != null) 'fluency_score': fluencyScore,
      if (isGraded != null) 'is_graded': isGraded,
      if (coherenceFeedback != null) 'coherence_feedback': coherenceFeedback,
      if (lexicalFeedback != null) 'lexical_feedback': lexicalFeedback,
      if (grammaticalFeedback != null)
        'grammatical_feedback': grammaticalFeedback,
      if (fluencyFeedback != null) 'fluency_feedback': fluencyFeedback,
      if (note != null) 'note': note,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SpeakingAnswerDetailsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userAnswerId,
    Value<int>? duration,
    Value<double?>? bandScore,
    Value<double?>? coherenceScore,
    Value<double?>? lexialScore,
    Value<double?>? grammaticalScore,
    Value<double?>? fluencyScore,
    Value<bool>? isGraded,
    Value<String?>? coherenceFeedback,
    Value<String?>? lexicalFeedback,
    Value<String?>? grammaticalFeedback,
    Value<String?>? fluencyFeedback,
    Value<String?>? note,
    Value<DateTime>? updatedAt,
  }) {
    return SpeakingAnswerDetailsTableCompanion(
      id: id ?? this.id,
      userAnswerId: userAnswerId ?? this.userAnswerId,
      duration: duration ?? this.duration,
      bandScore: bandScore ?? this.bandScore,
      coherenceScore: coherenceScore ?? this.coherenceScore,
      lexialScore: lexialScore ?? this.lexialScore,
      grammaticalScore: grammaticalScore ?? this.grammaticalScore,
      fluencyScore: fluencyScore ?? this.fluencyScore,
      isGraded: isGraded ?? this.isGraded,
      coherenceFeedback: coherenceFeedback ?? this.coherenceFeedback,
      lexicalFeedback: lexicalFeedback ?? this.lexicalFeedback,
      grammaticalFeedback: grammaticalFeedback ?? this.grammaticalFeedback,
      fluencyFeedback: fluencyFeedback ?? this.fluencyFeedback,
      note: note ?? this.note,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userAnswerId.present) {
      map['user_answer_id'] = Variable<int>(userAnswerId.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (bandScore.present) {
      map['band_score'] = Variable<double>(bandScore.value);
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
    if (fluencyScore.present) {
      map['fluency_score'] = Variable<double>(fluencyScore.value);
    }
    if (isGraded.present) {
      map['is_graded'] = Variable<bool>(isGraded.value);
    }
    if (coherenceFeedback.present) {
      map['coherence_feedback'] = Variable<String>(coherenceFeedback.value);
    }
    if (lexicalFeedback.present) {
      map['lexical_feedback'] = Variable<String>(lexicalFeedback.value);
    }
    if (grammaticalFeedback.present) {
      map['grammatical_feedback'] = Variable<String>(grammaticalFeedback.value);
    }
    if (fluencyFeedback.present) {
      map['fluency_feedback'] = Variable<String>(fluencyFeedback.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeakingAnswerDetailsTableCompanion(')
          ..write('id: $id, ')
          ..write('userAnswerId: $userAnswerId, ')
          ..write('duration: $duration, ')
          ..write('bandScore: $bandScore, ')
          ..write('coherenceScore: $coherenceScore, ')
          ..write('lexialScore: $lexialScore, ')
          ..write('grammaticalScore: $grammaticalScore, ')
          ..write('fluencyScore: $fluencyScore, ')
          ..write('isGraded: $isGraded, ')
          ..write('coherenceFeedback: $coherenceFeedback, ')
          ..write('lexicalFeedback: $lexicalFeedback, ')
          ..write('grammaticalFeedback: $grammaticalFeedback, ')
          ..write('fluencyFeedback: $fluencyFeedback, ')
          ..write('note: $note, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SpeakingUtterancesTableTable extends SpeakingUtterancesTable
    with TableInfo<$SpeakingUtterancesTableTable, SpeakingUtterancesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeakingUtterancesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userAnswerIdMeta = const VerificationMeta(
    'userAnswerId',
  );
  @override
  late final GeneratedColumn<int> userAnswerId = GeneratedColumn<int>(
    'user_answer_id',
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
  static const VerificationMeta _isUserMeta = const VerificationMeta('isUser');
  @override
  late final GeneratedColumn<bool> isUser = GeneratedColumn<bool>(
    'is_user',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user" IN (0, 1))',
    ),
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioFileUuidMeta = const VerificationMeta(
    'audioFileUuid',
  );
  @override
  late final GeneratedColumn<String> audioFileUuid = GeneratedColumn<String>(
    'audio_file_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fluencyScoreMeta = const VerificationMeta(
    'fluencyScore',
  );
  @override
  late final GeneratedColumn<double> fluencyScore = GeneratedColumn<double>(
    'fluency_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
    userAnswerId,
    order,
    isUser,
    message,
    audioFileUuid,
    fluencyScore,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'speaking_utterances';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeakingUtterancesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_answer_id')) {
      context.handle(
        _userAnswerIdMeta,
        userAnswerId.isAcceptableOrUnknown(
          data['user_answer_id']!,
          _userAnswerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userAnswerIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('is_user')) {
      context.handle(
        _isUserMeta,
        isUser.isAcceptableOrUnknown(data['is_user']!, _isUserMeta),
      );
    } else if (isInserting) {
      context.missing(_isUserMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('audio_file_uuid')) {
      context.handle(
        _audioFileUuidMeta,
        audioFileUuid.isAcceptableOrUnknown(
          data['audio_file_uuid']!,
          _audioFileUuidMeta,
        ),
      );
    }
    if (data.containsKey('fluency_score')) {
      context.handle(
        _fluencyScoreMeta,
        fluencyScore.isAcceptableOrUnknown(
          data['fluency_score']!,
          _fluencyScoreMeta,
        ),
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
  Set<GeneratedColumn> get $primaryKey => {userAnswerId, order};
  @override
  SpeakingUtterancesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeakingUtterancesTableData(
      userAnswerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_answer_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      isUser: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      audioFileUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_file_uuid'],
      ),
      fluencyScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fluency_score'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SpeakingUtterancesTableTable createAlias(String alias) {
    return $SpeakingUtterancesTableTable(attachedDatabase, alias);
  }
}

class SpeakingUtterancesTableData extends DataClass
    implements Insertable<SpeakingUtterancesTableData> {
  final int userAnswerId;
  final int order;
  final bool isUser;
  final String message;
  final String? audioFileUuid;
  final double? fluencyScore;
  final DateTime updatedAt;
  const SpeakingUtterancesTableData({
    required this.userAnswerId,
    required this.order,
    required this.isUser,
    required this.message,
    this.audioFileUuid,
    this.fluencyScore,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_answer_id'] = Variable<int>(userAnswerId);
    map['order'] = Variable<int>(order);
    map['is_user'] = Variable<bool>(isUser);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || audioFileUuid != null) {
      map['audio_file_uuid'] = Variable<String>(audioFileUuid);
    }
    if (!nullToAbsent || fluencyScore != null) {
      map['fluency_score'] = Variable<double>(fluencyScore);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SpeakingUtterancesTableCompanion toCompanion(bool nullToAbsent) {
    return SpeakingUtterancesTableCompanion(
      userAnswerId: Value(userAnswerId),
      order: Value(order),
      isUser: Value(isUser),
      message: Value(message),
      audioFileUuid: audioFileUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(audioFileUuid),
      fluencyScore: fluencyScore == null && nullToAbsent
          ? const Value.absent()
          : Value(fluencyScore),
      updatedAt: Value(updatedAt),
    );
  }

  factory SpeakingUtterancesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeakingUtterancesTableData(
      userAnswerId: serializer.fromJson<int>(json['userAnswerId']),
      order: serializer.fromJson<int>(json['order']),
      isUser: serializer.fromJson<bool>(json['isUser']),
      message: serializer.fromJson<String>(json['message']),
      audioFileUuid: serializer.fromJson<String?>(json['audioFileUuid']),
      fluencyScore: serializer.fromJson<double?>(json['fluencyScore']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userAnswerId': serializer.toJson<int>(userAnswerId),
      'order': serializer.toJson<int>(order),
      'isUser': serializer.toJson<bool>(isUser),
      'message': serializer.toJson<String>(message),
      'audioFileUuid': serializer.toJson<String?>(audioFileUuid),
      'fluencyScore': serializer.toJson<double?>(fluencyScore),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SpeakingUtterancesTableData copyWith({
    int? userAnswerId,
    int? order,
    bool? isUser,
    String? message,
    Value<String?> audioFileUuid = const Value.absent(),
    Value<double?> fluencyScore = const Value.absent(),
    DateTime? updatedAt,
  }) => SpeakingUtterancesTableData(
    userAnswerId: userAnswerId ?? this.userAnswerId,
    order: order ?? this.order,
    isUser: isUser ?? this.isUser,
    message: message ?? this.message,
    audioFileUuid: audioFileUuid.present
        ? audioFileUuid.value
        : this.audioFileUuid,
    fluencyScore: fluencyScore.present ? fluencyScore.value : this.fluencyScore,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SpeakingUtterancesTableData copyWithCompanion(
    SpeakingUtterancesTableCompanion data,
  ) {
    return SpeakingUtterancesTableData(
      userAnswerId: data.userAnswerId.present
          ? data.userAnswerId.value
          : this.userAnswerId,
      order: data.order.present ? data.order.value : this.order,
      isUser: data.isUser.present ? data.isUser.value : this.isUser,
      message: data.message.present ? data.message.value : this.message,
      audioFileUuid: data.audioFileUuid.present
          ? data.audioFileUuid.value
          : this.audioFileUuid,
      fluencyScore: data.fluencyScore.present
          ? data.fluencyScore.value
          : this.fluencyScore,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeakingUtterancesTableData(')
          ..write('userAnswerId: $userAnswerId, ')
          ..write('order: $order, ')
          ..write('isUser: $isUser, ')
          ..write('message: $message, ')
          ..write('audioFileUuid: $audioFileUuid, ')
          ..write('fluencyScore: $fluencyScore, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userAnswerId,
    order,
    isUser,
    message,
    audioFileUuid,
    fluencyScore,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeakingUtterancesTableData &&
          other.userAnswerId == this.userAnswerId &&
          other.order == this.order &&
          other.isUser == this.isUser &&
          other.message == this.message &&
          other.audioFileUuid == this.audioFileUuid &&
          other.fluencyScore == this.fluencyScore &&
          other.updatedAt == this.updatedAt);
}

class SpeakingUtterancesTableCompanion
    extends UpdateCompanion<SpeakingUtterancesTableData> {
  final Value<int> userAnswerId;
  final Value<int> order;
  final Value<bool> isUser;
  final Value<String> message;
  final Value<String?> audioFileUuid;
  final Value<double?> fluencyScore;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SpeakingUtterancesTableCompanion({
    this.userAnswerId = const Value.absent(),
    this.order = const Value.absent(),
    this.isUser = const Value.absent(),
    this.message = const Value.absent(),
    this.audioFileUuid = const Value.absent(),
    this.fluencyScore = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpeakingUtterancesTableCompanion.insert({
    required int userAnswerId,
    required int order,
    required bool isUser,
    required String message,
    this.audioFileUuid = const Value.absent(),
    this.fluencyScore = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userAnswerId = Value(userAnswerId),
       order = Value(order),
       isUser = Value(isUser),
       message = Value(message);
  static Insertable<SpeakingUtterancesTableData> custom({
    Expression<int>? userAnswerId,
    Expression<int>? order,
    Expression<bool>? isUser,
    Expression<String>? message,
    Expression<String>? audioFileUuid,
    Expression<double>? fluencyScore,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userAnswerId != null) 'user_answer_id': userAnswerId,
      if (order != null) 'order': order,
      if (isUser != null) 'is_user': isUser,
      if (message != null) 'message': message,
      if (audioFileUuid != null) 'audio_file_uuid': audioFileUuid,
      if (fluencyScore != null) 'fluency_score': fluencyScore,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpeakingUtterancesTableCompanion copyWith({
    Value<int>? userAnswerId,
    Value<int>? order,
    Value<bool>? isUser,
    Value<String>? message,
    Value<String?>? audioFileUuid,
    Value<double?>? fluencyScore,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SpeakingUtterancesTableCompanion(
      userAnswerId: userAnswerId ?? this.userAnswerId,
      order: order ?? this.order,
      isUser: isUser ?? this.isUser,
      message: message ?? this.message,
      audioFileUuid: audioFileUuid ?? this.audioFileUuid,
      fluencyScore: fluencyScore ?? this.fluencyScore,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userAnswerId.present) {
      map['user_answer_id'] = Variable<int>(userAnswerId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (isUser.present) {
      map['is_user'] = Variable<bool>(isUser.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (audioFileUuid.present) {
      map['audio_file_uuid'] = Variable<String>(audioFileUuid.value);
    }
    if (fluencyScore.present) {
      map['fluency_score'] = Variable<double>(fluencyScore.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeakingUtterancesTableCompanion(')
          ..write('userAnswerId: $userAnswerId, ')
          ..write('order: $order, ')
          ..write('isUser: $isUser, ')
          ..write('message: $message, ')
          ..write('audioFileUuid: $audioFileUuid, ')
          ..write('fluencyScore: $fluencyScore, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
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
  late final $SpeakingAnswerDetailsTableTable speakingAnswerDetailsTable =
      $SpeakingAnswerDetailsTableTable(this);
  late final $SpeakingUtterancesTableTable speakingUtterancesTable =
      $SpeakingUtterancesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userAnswersTable,
    writingAnswerDetailsTable,
    promptTopicsTable,
    speakingAnswerDetailsTable,
    speakingUtterancesTable,
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
          db.writingAnswerDetailsTable.userAnswerId,
        ),
      );

  $$WritingAnswerDetailsTableTableProcessedTableManager
  get writingAnswerDetailsTableRefs {
    final manager = $$WritingAnswerDetailsTableTableTableManager(
      $_db,
      $_db.writingAnswerDetailsTable,
    ).filter((f) => f.userAnswerId.id.sqlEquals($_itemColumn<int>('id')!));

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
          db.promptTopicsTable.userAnswerId,
        ),
      );

  $$PromptTopicsTableTableProcessedTableManager get promptTopicsTableRefs {
    final manager = $$PromptTopicsTableTableTableManager(
      $_db,
      $_db.promptTopicsTable,
    ).filter((f) => f.userAnswerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _promptTopicsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SpeakingAnswerDetailsTableTable,
    List<SpeakingAnswerDetailsTableData>
  >
  _speakingAnswerDetailsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.speakingAnswerDetailsTable,
        aliasName: $_aliasNameGenerator(
          db.userAnswersTable.id,
          db.speakingAnswerDetailsTable.userAnswerId,
        ),
      );

  $$SpeakingAnswerDetailsTableTableProcessedTableManager
  get speakingAnswerDetailsTableRefs {
    final manager = $$SpeakingAnswerDetailsTableTableTableManager(
      $_db,
      $_db.speakingAnswerDetailsTable,
    ).filter((f) => f.userAnswerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _speakingAnswerDetailsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SpeakingUtterancesTableTable,
    List<SpeakingUtterancesTableData>
  >
  _speakingUtterancesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.speakingUtterancesTable,
        aliasName: $_aliasNameGenerator(
          db.userAnswersTable.id,
          db.speakingUtterancesTable.userAnswerId,
        ),
      );

  $$SpeakingUtterancesTableTableProcessedTableManager
  get speakingUtterancesTableRefs {
    final manager = $$SpeakingUtterancesTableTableTableManager(
      $_db,
      $_db.speakingUtterancesTable,
    ).filter((f) => f.userAnswerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _speakingUtterancesTableRefsTable($_db),
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
          getReferencedColumn: (t) => t.userAnswerId,
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
      getReferencedColumn: (t) => t.userAnswerId,
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

  Expression<bool> speakingAnswerDetailsTableRefs(
    Expression<bool> Function($$SpeakingAnswerDetailsTableTableFilterComposer f)
    f,
  ) {
    final $$SpeakingAnswerDetailsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speakingAnswerDetailsTable,
          getReferencedColumn: (t) => t.userAnswerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeakingAnswerDetailsTableTableFilterComposer(
                $db: $db,
                $table: $db.speakingAnswerDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> speakingUtterancesTableRefs(
    Expression<bool> Function($$SpeakingUtterancesTableTableFilterComposer f) f,
  ) {
    final $$SpeakingUtterancesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speakingUtterancesTable,
          getReferencedColumn: (t) => t.userAnswerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeakingUtterancesTableTableFilterComposer(
                $db: $db,
                $table: $db.speakingUtterancesTable,
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
          getReferencedColumn: (t) => t.userAnswerId,
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
          getReferencedColumn: (t) => t.userAnswerId,
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

  Expression<T> speakingAnswerDetailsTableRefs<T extends Object>(
    Expression<T> Function(
      $$SpeakingAnswerDetailsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$SpeakingAnswerDetailsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speakingAnswerDetailsTable,
          getReferencedColumn: (t) => t.userAnswerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeakingAnswerDetailsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.speakingAnswerDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> speakingUtterancesTableRefs<T extends Object>(
    Expression<T> Function($$SpeakingUtterancesTableTableAnnotationComposer a)
    f,
  ) {
    final $$SpeakingUtterancesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.speakingUtterancesTable,
          getReferencedColumn: (t) => t.userAnswerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpeakingUtterancesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.speakingUtterancesTable,
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
            bool speakingAnswerDetailsTableRefs,
            bool speakingUtterancesTableRefs,
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
                speakingAnswerDetailsTableRefs = false,
                speakingUtterancesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (writingAnswerDetailsTableRefs)
                      db.writingAnswerDetailsTable,
                    if (promptTopicsTableRefs) db.promptTopicsTable,
                    if (speakingAnswerDetailsTableRefs)
                      db.speakingAnswerDetailsTable,
                    if (speakingUtterancesTableRefs) db.speakingUtterancesTable,
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
                                (e) => e.userAnswerId == item.id,
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
                                (e) => e.userAnswerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (speakingAnswerDetailsTableRefs)
                        await $_getPrefetchedData<
                          UserAnswersTableData,
                          $UserAnswersTableTable,
                          SpeakingAnswerDetailsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserAnswersTableTableReferences
                              ._speakingAnswerDetailsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserAnswersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).speakingAnswerDetailsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userAnswerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (speakingUtterancesTableRefs)
                        await $_getPrefetchedData<
                          UserAnswersTableData,
                          $UserAnswersTableTable,
                          SpeakingUtterancesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserAnswersTableTableReferences
                              ._speakingUtterancesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserAnswersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).speakingUtterancesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userAnswerId == item.id,
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
        bool speakingAnswerDetailsTableRefs,
        bool speakingUtterancesTableRefs,
      })
    >;
typedef $$WritingAnswerDetailsTableTableCreateCompanionBuilder =
    WritingAnswerDetailsTableCompanion Function({
      Value<int> id,
      required int userAnswerId,
      required String promptType,
      required String taskContext,
      required String taskInstruction,
      Value<String?> diagramDescription,
      Value<String?> diagramFileUuid,
      required String answerText,
      required int duration,
      Value<double?> bandScore,
      Value<double?> taskScore,
      Value<double?> coherenceScore,
      Value<double?> lexialScore,
      Value<double?> grammaticalScore,
      Value<bool> isGraded,
      Value<String?> taskFeedback,
      Value<String?> coherencekFeedback,
      Value<String?> lexialFeedback,
      Value<String?> grammaticalFeedback,
      Value<DateTime> updatedAt,
    });
typedef $$WritingAnswerDetailsTableTableUpdateCompanionBuilder =
    WritingAnswerDetailsTableCompanion Function({
      Value<int> id,
      Value<int> userAnswerId,
      Value<String> promptType,
      Value<String> taskContext,
      Value<String> taskInstruction,
      Value<String?> diagramDescription,
      Value<String?> diagramFileUuid,
      Value<String> answerText,
      Value<int> duration,
      Value<double?> bandScore,
      Value<double?> taskScore,
      Value<double?> coherenceScore,
      Value<double?> lexialScore,
      Value<double?> grammaticalScore,
      Value<bool> isGraded,
      Value<String?> taskFeedback,
      Value<String?> coherencekFeedback,
      Value<String?> lexialFeedback,
      Value<String?> grammaticalFeedback,
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

  static $UserAnswersTableTable _userAnswerIdTable(_$AppDatabase db) =>
      db.userAnswersTable.createAlias(
        $_aliasNameGenerator(
          db.writingAnswerDetailsTable.userAnswerId,
          db.userAnswersTable.id,
        ),
      );

  $$UserAnswersTableTableProcessedTableManager get userAnswerId {
    final $_column = $_itemColumn<int>('user_answer_id')!;

    final manager = $$UserAnswersTableTableTableManager(
      $_db,
      $_db.userAnswersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userAnswerIdTable($_db));
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

  ColumnFilters<String> get taskContext => $composableBuilder(
    column: $table.taskContext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskInstruction => $composableBuilder(
    column: $table.taskInstruction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diagramDescription => $composableBuilder(
    column: $table.diagramDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diagramFileUuid => $composableBuilder(
    column: $table.diagramFileUuid,
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

  ColumnFilters<double> get bandScore => $composableBuilder(
    column: $table.bandScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taskScore => $composableBuilder(
    column: $table.taskScore,
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

  ColumnFilters<String> get taskFeedback => $composableBuilder(
    column: $table.taskFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coherencekFeedback => $composableBuilder(
    column: $table.coherencekFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lexialFeedback => $composableBuilder(
    column: $table.lexialFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammaticalFeedback => $composableBuilder(
    column: $table.grammaticalFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserAnswersTableTableFilterComposer get userAnswerId {
    final $$UserAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

  ColumnOrderings<String> get taskContext => $composableBuilder(
    column: $table.taskContext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskInstruction => $composableBuilder(
    column: $table.taskInstruction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diagramDescription => $composableBuilder(
    column: $table.diagramDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diagramFileUuid => $composableBuilder(
    column: $table.diagramFileUuid,
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

  ColumnOrderings<double> get bandScore => $composableBuilder(
    column: $table.bandScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taskScore => $composableBuilder(
    column: $table.taskScore,
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

  ColumnOrderings<String> get taskFeedback => $composableBuilder(
    column: $table.taskFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coherencekFeedback => $composableBuilder(
    column: $table.coherencekFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lexialFeedback => $composableBuilder(
    column: $table.lexialFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammaticalFeedback => $composableBuilder(
    column: $table.grammaticalFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserAnswersTableTableOrderingComposer get userAnswerId {
    final $$UserAnswersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

  GeneratedColumn<String> get taskContext => $composableBuilder(
    column: $table.taskContext,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taskInstruction => $composableBuilder(
    column: $table.taskInstruction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get diagramDescription => $composableBuilder(
    column: $table.diagramDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get diagramFileUuid => $composableBuilder(
    column: $table.diagramFileUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerText => $composableBuilder(
    column: $table.answerText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<double> get bandScore =>
      $composableBuilder(column: $table.bandScore, builder: (column) => column);

  GeneratedColumn<double> get taskScore =>
      $composableBuilder(column: $table.taskScore, builder: (column) => column);

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

  GeneratedColumn<String> get taskFeedback => $composableBuilder(
    column: $table.taskFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coherencekFeedback => $composableBuilder(
    column: $table.coherencekFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lexialFeedback => $composableBuilder(
    column: $table.lexialFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammaticalFeedback => $composableBuilder(
    column: $table.grammaticalFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UserAnswersTableTableAnnotationComposer get userAnswerId {
    final $$UserAnswersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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
          PrefetchHooks Function({bool userAnswerId})
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
                Value<int> userAnswerId = const Value.absent(),
                Value<String> promptType = const Value.absent(),
                Value<String> taskContext = const Value.absent(),
                Value<String> taskInstruction = const Value.absent(),
                Value<String?> diagramDescription = const Value.absent(),
                Value<String?> diagramFileUuid = const Value.absent(),
                Value<String> answerText = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<double?> bandScore = const Value.absent(),
                Value<double?> taskScore = const Value.absent(),
                Value<double?> coherenceScore = const Value.absent(),
                Value<double?> lexialScore = const Value.absent(),
                Value<double?> grammaticalScore = const Value.absent(),
                Value<bool> isGraded = const Value.absent(),
                Value<String?> taskFeedback = const Value.absent(),
                Value<String?> coherencekFeedback = const Value.absent(),
                Value<String?> lexialFeedback = const Value.absent(),
                Value<String?> grammaticalFeedback = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WritingAnswerDetailsTableCompanion(
                id: id,
                userAnswerId: userAnswerId,
                promptType: promptType,
                taskContext: taskContext,
                taskInstruction: taskInstruction,
                diagramDescription: diagramDescription,
                diagramFileUuid: diagramFileUuid,
                answerText: answerText,
                duration: duration,
                bandScore: bandScore,
                taskScore: taskScore,
                coherenceScore: coherenceScore,
                lexialScore: lexialScore,
                grammaticalScore: grammaticalScore,
                isGraded: isGraded,
                taskFeedback: taskFeedback,
                coherencekFeedback: coherencekFeedback,
                lexialFeedback: lexialFeedback,
                grammaticalFeedback: grammaticalFeedback,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userAnswerId,
                required String promptType,
                required String taskContext,
                required String taskInstruction,
                Value<String?> diagramDescription = const Value.absent(),
                Value<String?> diagramFileUuid = const Value.absent(),
                required String answerText,
                required int duration,
                Value<double?> bandScore = const Value.absent(),
                Value<double?> taskScore = const Value.absent(),
                Value<double?> coherenceScore = const Value.absent(),
                Value<double?> lexialScore = const Value.absent(),
                Value<double?> grammaticalScore = const Value.absent(),
                Value<bool> isGraded = const Value.absent(),
                Value<String?> taskFeedback = const Value.absent(),
                Value<String?> coherencekFeedback = const Value.absent(),
                Value<String?> lexialFeedback = const Value.absent(),
                Value<String?> grammaticalFeedback = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WritingAnswerDetailsTableCompanion.insert(
                id: id,
                userAnswerId: userAnswerId,
                promptType: promptType,
                taskContext: taskContext,
                taskInstruction: taskInstruction,
                diagramDescription: diagramDescription,
                diagramFileUuid: diagramFileUuid,
                answerText: answerText,
                duration: duration,
                bandScore: bandScore,
                taskScore: taskScore,
                coherenceScore: coherenceScore,
                lexialScore: lexialScore,
                grammaticalScore: grammaticalScore,
                isGraded: isGraded,
                taskFeedback: taskFeedback,
                coherencekFeedback: coherencekFeedback,
                lexialFeedback: lexialFeedback,
                grammaticalFeedback: grammaticalFeedback,
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
          prefetchHooksCallback: ({userAnswerId = false}) {
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
                    if (userAnswerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userAnswerId,
                                referencedTable:
                                    $$WritingAnswerDetailsTableTableReferences
                                        ._userAnswerIdTable(db),
                                referencedColumn:
                                    $$WritingAnswerDetailsTableTableReferences
                                        ._userAnswerIdTable(db)
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
      PrefetchHooks Function({bool userAnswerId})
    >;
typedef $$PromptTopicsTableTableCreateCompanionBuilder =
    PromptTopicsTableCompanion Function({
      required int userAnswerId,
      required int order,
      required String title,
      Value<int> rowid,
    });
typedef $$PromptTopicsTableTableUpdateCompanionBuilder =
    PromptTopicsTableCompanion Function({
      Value<int> userAnswerId,
      Value<int> order,
      Value<String> title,
      Value<int> rowid,
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

  static $UserAnswersTableTable _userAnswerIdTable(_$AppDatabase db) =>
      db.userAnswersTable.createAlias(
        $_aliasNameGenerator(
          db.promptTopicsTable.userAnswerId,
          db.userAnswersTable.id,
        ),
      );

  $$UserAnswersTableTableProcessedTableManager get userAnswerId {
    final $_column = $_itemColumn<int>('user_answer_id')!;

    final manager = $$UserAnswersTableTableTableManager(
      $_db,
      $_db.userAnswersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userAnswerIdTable($_db));
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
  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  $$UserAnswersTableTableFilterComposer get userAnswerId {
    final $$UserAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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
  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserAnswersTableTableOrderingComposer get userAnswerId {
    final $$UserAnswersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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
  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  $$UserAnswersTableTableAnnotationComposer get userAnswerId {
    final $$UserAnswersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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
          PrefetchHooks Function({bool userAnswerId})
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
                Value<int> userAnswerId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromptTopicsTableCompanion(
                userAnswerId: userAnswerId,
                order: order,
                title: title,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userAnswerId,
                required int order,
                required String title,
                Value<int> rowid = const Value.absent(),
              }) => PromptTopicsTableCompanion.insert(
                userAnswerId: userAnswerId,
                order: order,
                title: title,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PromptTopicsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userAnswerId = false}) {
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
                    if (userAnswerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userAnswerId,
                                referencedTable:
                                    $$PromptTopicsTableTableReferences
                                        ._userAnswerIdTable(db),
                                referencedColumn:
                                    $$PromptTopicsTableTableReferences
                                        ._userAnswerIdTable(db)
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
      PrefetchHooks Function({bool userAnswerId})
    >;
typedef $$SpeakingAnswerDetailsTableTableCreateCompanionBuilder =
    SpeakingAnswerDetailsTableCompanion Function({
      Value<int> id,
      required int userAnswerId,
      required int duration,
      Value<double?> bandScore,
      Value<double?> coherenceScore,
      Value<double?> lexialScore,
      Value<double?> grammaticalScore,
      Value<double?> fluencyScore,
      required bool isGraded,
      Value<String?> coherenceFeedback,
      Value<String?> lexicalFeedback,
      Value<String?> grammaticalFeedback,
      Value<String?> fluencyFeedback,
      Value<String?> note,
      Value<DateTime> updatedAt,
    });
typedef $$SpeakingAnswerDetailsTableTableUpdateCompanionBuilder =
    SpeakingAnswerDetailsTableCompanion Function({
      Value<int> id,
      Value<int> userAnswerId,
      Value<int> duration,
      Value<double?> bandScore,
      Value<double?> coherenceScore,
      Value<double?> lexialScore,
      Value<double?> grammaticalScore,
      Value<double?> fluencyScore,
      Value<bool> isGraded,
      Value<String?> coherenceFeedback,
      Value<String?> lexicalFeedback,
      Value<String?> grammaticalFeedback,
      Value<String?> fluencyFeedback,
      Value<String?> note,
      Value<DateTime> updatedAt,
    });

final class $$SpeakingAnswerDetailsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpeakingAnswerDetailsTableTable,
          SpeakingAnswerDetailsTableData
        > {
  $$SpeakingAnswerDetailsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserAnswersTableTable _userAnswerIdTable(_$AppDatabase db) =>
      db.userAnswersTable.createAlias(
        $_aliasNameGenerator(
          db.speakingAnswerDetailsTable.userAnswerId,
          db.userAnswersTable.id,
        ),
      );

  $$UserAnswersTableTableProcessedTableManager get userAnswerId {
    final $_column = $_itemColumn<int>('user_answer_id')!;

    final manager = $$UserAnswersTableTableTableManager(
      $_db,
      $_db.userAnswersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userAnswerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpeakingAnswerDetailsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SpeakingAnswerDetailsTableTable> {
  $$SpeakingAnswerDetailsTableTableFilterComposer({
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

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bandScore => $composableBuilder(
    column: $table.bandScore,
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

  ColumnFilters<double> get fluencyScore => $composableBuilder(
    column: $table.fluencyScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGraded => $composableBuilder(
    column: $table.isGraded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coherenceFeedback => $composableBuilder(
    column: $table.coherenceFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lexicalFeedback => $composableBuilder(
    column: $table.lexicalFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammaticalFeedback => $composableBuilder(
    column: $table.grammaticalFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fluencyFeedback => $composableBuilder(
    column: $table.fluencyFeedback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserAnswersTableTableFilterComposer get userAnswerId {
    final $$UserAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

class $$SpeakingAnswerDetailsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeakingAnswerDetailsTableTable> {
  $$SpeakingAnswerDetailsTableTableOrderingComposer({
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

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bandScore => $composableBuilder(
    column: $table.bandScore,
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

  ColumnOrderings<double> get fluencyScore => $composableBuilder(
    column: $table.fluencyScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGraded => $composableBuilder(
    column: $table.isGraded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coherenceFeedback => $composableBuilder(
    column: $table.coherenceFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lexicalFeedback => $composableBuilder(
    column: $table.lexicalFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammaticalFeedback => $composableBuilder(
    column: $table.grammaticalFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fluencyFeedback => $composableBuilder(
    column: $table.fluencyFeedback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserAnswersTableTableOrderingComposer get userAnswerId {
    final $$UserAnswersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

class $$SpeakingAnswerDetailsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeakingAnswerDetailsTableTable> {
  $$SpeakingAnswerDetailsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<double> get bandScore =>
      $composableBuilder(column: $table.bandScore, builder: (column) => column);

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

  GeneratedColumn<double> get fluencyScore => $composableBuilder(
    column: $table.fluencyScore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isGraded =>
      $composableBuilder(column: $table.isGraded, builder: (column) => column);

  GeneratedColumn<String> get coherenceFeedback => $composableBuilder(
    column: $table.coherenceFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lexicalFeedback => $composableBuilder(
    column: $table.lexicalFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammaticalFeedback => $composableBuilder(
    column: $table.grammaticalFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fluencyFeedback => $composableBuilder(
    column: $table.fluencyFeedback,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UserAnswersTableTableAnnotationComposer get userAnswerId {
    final $$UserAnswersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

class $$SpeakingAnswerDetailsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeakingAnswerDetailsTableTable,
          SpeakingAnswerDetailsTableData,
          $$SpeakingAnswerDetailsTableTableFilterComposer,
          $$SpeakingAnswerDetailsTableTableOrderingComposer,
          $$SpeakingAnswerDetailsTableTableAnnotationComposer,
          $$SpeakingAnswerDetailsTableTableCreateCompanionBuilder,
          $$SpeakingAnswerDetailsTableTableUpdateCompanionBuilder,
          (
            SpeakingAnswerDetailsTableData,
            $$SpeakingAnswerDetailsTableTableReferences,
          ),
          SpeakingAnswerDetailsTableData,
          PrefetchHooks Function({bool userAnswerId})
        > {
  $$SpeakingAnswerDetailsTableTableTableManager(
    _$AppDatabase db,
    $SpeakingAnswerDetailsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeakingAnswerDetailsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SpeakingAnswerDetailsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpeakingAnswerDetailsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userAnswerId = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<double?> bandScore = const Value.absent(),
                Value<double?> coherenceScore = const Value.absent(),
                Value<double?> lexialScore = const Value.absent(),
                Value<double?> grammaticalScore = const Value.absent(),
                Value<double?> fluencyScore = const Value.absent(),
                Value<bool> isGraded = const Value.absent(),
                Value<String?> coherenceFeedback = const Value.absent(),
                Value<String?> lexicalFeedback = const Value.absent(),
                Value<String?> grammaticalFeedback = const Value.absent(),
                Value<String?> fluencyFeedback = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SpeakingAnswerDetailsTableCompanion(
                id: id,
                userAnswerId: userAnswerId,
                duration: duration,
                bandScore: bandScore,
                coherenceScore: coherenceScore,
                lexialScore: lexialScore,
                grammaticalScore: grammaticalScore,
                fluencyScore: fluencyScore,
                isGraded: isGraded,
                coherenceFeedback: coherenceFeedback,
                lexicalFeedback: lexicalFeedback,
                grammaticalFeedback: grammaticalFeedback,
                fluencyFeedback: fluencyFeedback,
                note: note,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userAnswerId,
                required int duration,
                Value<double?> bandScore = const Value.absent(),
                Value<double?> coherenceScore = const Value.absent(),
                Value<double?> lexialScore = const Value.absent(),
                Value<double?> grammaticalScore = const Value.absent(),
                Value<double?> fluencyScore = const Value.absent(),
                required bool isGraded,
                Value<String?> coherenceFeedback = const Value.absent(),
                Value<String?> lexicalFeedback = const Value.absent(),
                Value<String?> grammaticalFeedback = const Value.absent(),
                Value<String?> fluencyFeedback = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SpeakingAnswerDetailsTableCompanion.insert(
                id: id,
                userAnswerId: userAnswerId,
                duration: duration,
                bandScore: bandScore,
                coherenceScore: coherenceScore,
                lexialScore: lexialScore,
                grammaticalScore: grammaticalScore,
                fluencyScore: fluencyScore,
                isGraded: isGraded,
                coherenceFeedback: coherenceFeedback,
                lexicalFeedback: lexicalFeedback,
                grammaticalFeedback: grammaticalFeedback,
                fluencyFeedback: fluencyFeedback,
                note: note,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpeakingAnswerDetailsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userAnswerId = false}) {
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
                    if (userAnswerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userAnswerId,
                                referencedTable:
                                    $$SpeakingAnswerDetailsTableTableReferences
                                        ._userAnswerIdTable(db),
                                referencedColumn:
                                    $$SpeakingAnswerDetailsTableTableReferences
                                        ._userAnswerIdTable(db)
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

typedef $$SpeakingAnswerDetailsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeakingAnswerDetailsTableTable,
      SpeakingAnswerDetailsTableData,
      $$SpeakingAnswerDetailsTableTableFilterComposer,
      $$SpeakingAnswerDetailsTableTableOrderingComposer,
      $$SpeakingAnswerDetailsTableTableAnnotationComposer,
      $$SpeakingAnswerDetailsTableTableCreateCompanionBuilder,
      $$SpeakingAnswerDetailsTableTableUpdateCompanionBuilder,
      (
        SpeakingAnswerDetailsTableData,
        $$SpeakingAnswerDetailsTableTableReferences,
      ),
      SpeakingAnswerDetailsTableData,
      PrefetchHooks Function({bool userAnswerId})
    >;
typedef $$SpeakingUtterancesTableTableCreateCompanionBuilder =
    SpeakingUtterancesTableCompanion Function({
      required int userAnswerId,
      required int order,
      required bool isUser,
      required String message,
      Value<String?> audioFileUuid,
      Value<double?> fluencyScore,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SpeakingUtterancesTableTableUpdateCompanionBuilder =
    SpeakingUtterancesTableCompanion Function({
      Value<int> userAnswerId,
      Value<int> order,
      Value<bool> isUser,
      Value<String> message,
      Value<String?> audioFileUuid,
      Value<double?> fluencyScore,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SpeakingUtterancesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpeakingUtterancesTableTable,
          SpeakingUtterancesTableData
        > {
  $$SpeakingUtterancesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserAnswersTableTable _userAnswerIdTable(_$AppDatabase db) =>
      db.userAnswersTable.createAlias(
        $_aliasNameGenerator(
          db.speakingUtterancesTable.userAnswerId,
          db.userAnswersTable.id,
        ),
      );

  $$UserAnswersTableTableProcessedTableManager get userAnswerId {
    final $_column = $_itemColumn<int>('user_answer_id')!;

    final manager = $$UserAnswersTableTableTableManager(
      $_db,
      $_db.userAnswersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userAnswerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpeakingUtterancesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SpeakingUtterancesTableTable> {
  $$SpeakingUtterancesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUser => $composableBuilder(
    column: $table.isUser,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioFileUuid => $composableBuilder(
    column: $table.audioFileUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fluencyScore => $composableBuilder(
    column: $table.fluencyScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserAnswersTableTableFilterComposer get userAnswerId {
    final $$UserAnswersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

class $$SpeakingUtterancesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SpeakingUtterancesTableTable> {
  $$SpeakingUtterancesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUser => $composableBuilder(
    column: $table.isUser,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioFileUuid => $composableBuilder(
    column: $table.audioFileUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fluencyScore => $composableBuilder(
    column: $table.fluencyScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserAnswersTableTableOrderingComposer get userAnswerId {
    final $$UserAnswersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

class $$SpeakingUtterancesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpeakingUtterancesTableTable> {
  $$SpeakingUtterancesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<bool> get isUser =>
      $composableBuilder(column: $table.isUser, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get audioFileUuid => $composableBuilder(
    column: $table.audioFileUuid,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fluencyScore => $composableBuilder(
    column: $table.fluencyScore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UserAnswersTableTableAnnotationComposer get userAnswerId {
    final $$UserAnswersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userAnswerId,
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

class $$SpeakingUtterancesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpeakingUtterancesTableTable,
          SpeakingUtterancesTableData,
          $$SpeakingUtterancesTableTableFilterComposer,
          $$SpeakingUtterancesTableTableOrderingComposer,
          $$SpeakingUtterancesTableTableAnnotationComposer,
          $$SpeakingUtterancesTableTableCreateCompanionBuilder,
          $$SpeakingUtterancesTableTableUpdateCompanionBuilder,
          (
            SpeakingUtterancesTableData,
            $$SpeakingUtterancesTableTableReferences,
          ),
          SpeakingUtterancesTableData,
          PrefetchHooks Function({bool userAnswerId})
        > {
  $$SpeakingUtterancesTableTableTableManager(
    _$AppDatabase db,
    $SpeakingUtterancesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeakingUtterancesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SpeakingUtterancesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpeakingUtterancesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> userAnswerId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> isUser = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> audioFileUuid = const Value.absent(),
                Value<double?> fluencyScore = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeakingUtterancesTableCompanion(
                userAnswerId: userAnswerId,
                order: order,
                isUser: isUser,
                message: message,
                audioFileUuid: audioFileUuid,
                fluencyScore: fluencyScore,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userAnswerId,
                required int order,
                required bool isUser,
                required String message,
                Value<String?> audioFileUuid = const Value.absent(),
                Value<double?> fluencyScore = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpeakingUtterancesTableCompanion.insert(
                userAnswerId: userAnswerId,
                order: order,
                isUser: isUser,
                message: message,
                audioFileUuid: audioFileUuid,
                fluencyScore: fluencyScore,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpeakingUtterancesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userAnswerId = false}) {
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
                    if (userAnswerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userAnswerId,
                                referencedTable:
                                    $$SpeakingUtterancesTableTableReferences
                                        ._userAnswerIdTable(db),
                                referencedColumn:
                                    $$SpeakingUtterancesTableTableReferences
                                        ._userAnswerIdTable(db)
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

typedef $$SpeakingUtterancesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpeakingUtterancesTableTable,
      SpeakingUtterancesTableData,
      $$SpeakingUtterancesTableTableFilterComposer,
      $$SpeakingUtterancesTableTableOrderingComposer,
      $$SpeakingUtterancesTableTableAnnotationComposer,
      $$SpeakingUtterancesTableTableCreateCompanionBuilder,
      $$SpeakingUtterancesTableTableUpdateCompanionBuilder,
      (SpeakingUtterancesTableData, $$SpeakingUtterancesTableTableReferences),
      SpeakingUtterancesTableData,
      PrefetchHooks Function({bool userAnswerId})
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
  $$SpeakingAnswerDetailsTableTableTableManager
  get speakingAnswerDetailsTable =>
      $$SpeakingAnswerDetailsTableTableTableManager(
        _db,
        _db.speakingAnswerDetailsTable,
      );
  $$SpeakingUtterancesTableTableTableManager get speakingUtterancesTable =>
      $$SpeakingUtterancesTableTableTableManager(
        _db,
        _db.speakingUtterancesTable,
      );
}
