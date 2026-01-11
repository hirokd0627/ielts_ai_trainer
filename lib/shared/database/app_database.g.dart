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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserAnswersTableTable userAnswersTable = $UserAnswersTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userAnswersTable];
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
          (
            UserAnswersTableData,
            BaseReferences<
              _$AppDatabase,
              $UserAnswersTableTable,
              UserAnswersTableData
            >,
          ),
          UserAnswersTableData,
          PrefetchHooks Function()
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        UserAnswersTableData,
        BaseReferences<
          _$AppDatabase,
          $UserAnswersTableTable,
          UserAnswersTableData
        >,
      ),
      UserAnswersTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserAnswersTableTableTableManager get userAnswersTable =>
      $$UserAnswersTableTableTableManager(_db, _db.userAnswersTable);
}
