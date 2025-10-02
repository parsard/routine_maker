// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RoutineTableTable extends RoutineTable
    with TableInfo<$RoutineTableTable, RoutineTbl> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alarmHourMeta = const VerificationMeta(
    'alarmHour',
  );
  @override
  late final GeneratedColumn<int> alarmHour = GeneratedColumn<int>(
    'alarm_hour',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alarmMinuteMeta = const VerificationMeta(
    'alarmMinute',
  );
  @override
  late final GeneratedColumn<int> alarmMinute = GeneratedColumn<int>(
    'alarm_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF2196F3),
  );
  static const VerificationMeta _targetRepetitionsPerWeekMeta =
      const VerificationMeta('targetRepetitionsPerWeek');
  @override
  late final GeneratedColumn<int> targetRepetitionsPerWeek =
      GeneratedColumn<int>(
        'target_repetitions_per_week',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(1),
      );
  static const VerificationMeta _completedRepetitionsThisWeekMeta =
      const VerificationMeta('completedRepetitionsThisWeek');
  @override
  late final GeneratedColumn<int> completedRepetitionsThisWeek =
      GeneratedColumn<int>(
        'completed_repetitions_this_week',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    createdAt,
    alarmHour,
    alarmMinute,
    colorValue,
    targetRepetitionsPerWeek,
    completedRepetitionsThisWeek,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineTbl> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('alarm_hour')) {
      context.handle(
        _alarmHourMeta,
        alarmHour.isAcceptableOrUnknown(data['alarm_hour']!, _alarmHourMeta),
      );
    }
    if (data.containsKey('alarm_minute')) {
      context.handle(
        _alarmMinuteMeta,
        alarmMinute.isAcceptableOrUnknown(
          data['alarm_minute']!,
          _alarmMinuteMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('target_repetitions_per_week')) {
      context.handle(
        _targetRepetitionsPerWeekMeta,
        targetRepetitionsPerWeek.isAcceptableOrUnknown(
          data['target_repetitions_per_week']!,
          _targetRepetitionsPerWeekMeta,
        ),
      );
    }
    if (data.containsKey('completed_repetitions_this_week')) {
      context.handle(
        _completedRepetitionsThisWeekMeta,
        completedRepetitionsThisWeek.isAcceptableOrUnknown(
          data['completed_repetitions_this_week']!,
          _completedRepetitionsThisWeekMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineTbl map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineTbl(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      alarmHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alarm_hour'],
      ),
      alarmMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alarm_minute'],
      ),
      colorValue:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}color_value'],
          )!,
      targetRepetitionsPerWeek:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}target_repetitions_per_week'],
          )!,
      completedRepetitionsThisWeek:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}completed_repetitions_this_week'],
          )!,
    );
  }

  @override
  $RoutineTableTable createAlias(String alias) {
    return $RoutineTableTable(attachedDatabase, alias);
  }
}

class RoutineTbl extends DataClass implements Insertable<RoutineTbl> {
  final String id;
  final String title;
  final DateTime createdAt;
  final int? alarmHour;
  final int? alarmMinute;
  final int colorValue;
  final int targetRepetitionsPerWeek;
  final int completedRepetitionsThisWeek;
  const RoutineTbl({
    required this.id,
    required this.title,
    required this.createdAt,
    this.alarmHour,
    this.alarmMinute,
    required this.colorValue,
    required this.targetRepetitionsPerWeek,
    required this.completedRepetitionsThisWeek,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || alarmHour != null) {
      map['alarm_hour'] = Variable<int>(alarmHour);
    }
    if (!nullToAbsent || alarmMinute != null) {
      map['alarm_minute'] = Variable<int>(alarmMinute);
    }
    map['color_value'] = Variable<int>(colorValue);
    map['target_repetitions_per_week'] = Variable<int>(
      targetRepetitionsPerWeek,
    );
    map['completed_repetitions_this_week'] = Variable<int>(
      completedRepetitionsThisWeek,
    );
    return map;
  }

  RoutineTableCompanion toCompanion(bool nullToAbsent) {
    return RoutineTableCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      alarmHour:
          alarmHour == null && nullToAbsent
              ? const Value.absent()
              : Value(alarmHour),
      alarmMinute:
          alarmMinute == null && nullToAbsent
              ? const Value.absent()
              : Value(alarmMinute),
      colorValue: Value(colorValue),
      targetRepetitionsPerWeek: Value(targetRepetitionsPerWeek),
      completedRepetitionsThisWeek: Value(completedRepetitionsThisWeek),
    );
  }

  factory RoutineTbl.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineTbl(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      alarmHour: serializer.fromJson<int?>(json['alarmHour']),
      alarmMinute: serializer.fromJson<int?>(json['alarmMinute']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      targetRepetitionsPerWeek: serializer.fromJson<int>(
        json['targetRepetitionsPerWeek'],
      ),
      completedRepetitionsThisWeek: serializer.fromJson<int>(
        json['completedRepetitionsThisWeek'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'alarmHour': serializer.toJson<int?>(alarmHour),
      'alarmMinute': serializer.toJson<int?>(alarmMinute),
      'colorValue': serializer.toJson<int>(colorValue),
      'targetRepetitionsPerWeek': serializer.toJson<int>(
        targetRepetitionsPerWeek,
      ),
      'completedRepetitionsThisWeek': serializer.toJson<int>(
        completedRepetitionsThisWeek,
      ),
    };
  }

  RoutineTbl copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    Value<int?> alarmHour = const Value.absent(),
    Value<int?> alarmMinute = const Value.absent(),
    int? colorValue,
    int? targetRepetitionsPerWeek,
    int? completedRepetitionsThisWeek,
  }) => RoutineTbl(
    id: id ?? this.id,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    alarmHour: alarmHour.present ? alarmHour.value : this.alarmHour,
    alarmMinute: alarmMinute.present ? alarmMinute.value : this.alarmMinute,
    colorValue: colorValue ?? this.colorValue,
    targetRepetitionsPerWeek:
        targetRepetitionsPerWeek ?? this.targetRepetitionsPerWeek,
    completedRepetitionsThisWeek:
        completedRepetitionsThisWeek ?? this.completedRepetitionsThisWeek,
  );
  RoutineTbl copyWithCompanion(RoutineTableCompanion data) {
    return RoutineTbl(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      alarmHour: data.alarmHour.present ? data.alarmHour.value : this.alarmHour,
      alarmMinute:
          data.alarmMinute.present ? data.alarmMinute.value : this.alarmMinute,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      targetRepetitionsPerWeek:
          data.targetRepetitionsPerWeek.present
              ? data.targetRepetitionsPerWeek.value
              : this.targetRepetitionsPerWeek,
      completedRepetitionsThisWeek:
          data.completedRepetitionsThisWeek.present
              ? data.completedRepetitionsThisWeek.value
              : this.completedRepetitionsThisWeek,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTbl(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('alarmHour: $alarmHour, ')
          ..write('alarmMinute: $alarmMinute, ')
          ..write('colorValue: $colorValue, ')
          ..write('targetRepetitionsPerWeek: $targetRepetitionsPerWeek, ')
          ..write('completedRepetitionsThisWeek: $completedRepetitionsThisWeek')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    createdAt,
    alarmHour,
    alarmMinute,
    colorValue,
    targetRepetitionsPerWeek,
    completedRepetitionsThisWeek,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineTbl &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.alarmHour == this.alarmHour &&
          other.alarmMinute == this.alarmMinute &&
          other.colorValue == this.colorValue &&
          other.targetRepetitionsPerWeek == this.targetRepetitionsPerWeek &&
          other.completedRepetitionsThisWeek ==
              this.completedRepetitionsThisWeek);
}

class RoutineTableCompanion extends UpdateCompanion<RoutineTbl> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<int?> alarmHour;
  final Value<int?> alarmMinute;
  final Value<int> colorValue;
  final Value<int> targetRepetitionsPerWeek;
  final Value<int> completedRepetitionsThisWeek;
  final Value<int> rowid;
  const RoutineTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.alarmHour = const Value.absent(),
    this.alarmMinute = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.targetRepetitionsPerWeek = const Value.absent(),
    this.completedRepetitionsThisWeek = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineTableCompanion.insert({
    required String id,
    required String title,
    required DateTime createdAt,
    this.alarmHour = const Value.absent(),
    this.alarmMinute = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.targetRepetitionsPerWeek = const Value.absent(),
    this.completedRepetitionsThisWeek = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdAt = Value(createdAt);
  static Insertable<RoutineTbl> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? alarmHour,
    Expression<int>? alarmMinute,
    Expression<int>? colorValue,
    Expression<int>? targetRepetitionsPerWeek,
    Expression<int>? completedRepetitionsThisWeek,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (alarmHour != null) 'alarm_hour': alarmHour,
      if (alarmMinute != null) 'alarm_minute': alarmMinute,
      if (colorValue != null) 'color_value': colorValue,
      if (targetRepetitionsPerWeek != null)
        'target_repetitions_per_week': targetRepetitionsPerWeek,
      if (completedRepetitionsThisWeek != null)
        'completed_repetitions_this_week': completedRepetitionsThisWeek,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<int?>? alarmHour,
    Value<int?>? alarmMinute,
    Value<int>? colorValue,
    Value<int>? targetRepetitionsPerWeek,
    Value<int>? completedRepetitionsThisWeek,
    Value<int>? rowid,
  }) {
    return RoutineTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      alarmHour: alarmHour ?? this.alarmHour,
      alarmMinute: alarmMinute ?? this.alarmMinute,
      colorValue: colorValue ?? this.colorValue,
      targetRepetitionsPerWeek:
          targetRepetitionsPerWeek ?? this.targetRepetitionsPerWeek,
      completedRepetitionsThisWeek:
          completedRepetitionsThisWeek ?? this.completedRepetitionsThisWeek,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (alarmHour.present) {
      map['alarm_hour'] = Variable<int>(alarmHour.value);
    }
    if (alarmMinute.present) {
      map['alarm_minute'] = Variable<int>(alarmMinute.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (targetRepetitionsPerWeek.present) {
      map['target_repetitions_per_week'] = Variable<int>(
        targetRepetitionsPerWeek.value,
      );
    }
    if (completedRepetitionsThisWeek.present) {
      map['completed_repetitions_this_week'] = Variable<int>(
        completedRepetitionsThisWeek.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('alarmHour: $alarmHour, ')
          ..write('alarmMinute: $alarmMinute, ')
          ..write('colorValue: $colorValue, ')
          ..write('targetRepetitionsPerWeek: $targetRepetitionsPerWeek, ')
          ..write(
            'completedRepetitionsThisWeek: $completedRepetitionsThisWeek, ',
          )
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoutineTableTable routineTable = $RoutineTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [routineTable];
}

typedef $$RoutineTableTableCreateCompanionBuilder =
    RoutineTableCompanion Function({
      required String id,
      required String title,
      required DateTime createdAt,
      Value<int?> alarmHour,
      Value<int?> alarmMinute,
      Value<int> colorValue,
      Value<int> targetRepetitionsPerWeek,
      Value<int> completedRepetitionsThisWeek,
      Value<int> rowid,
    });
typedef $$RoutineTableTableUpdateCompanionBuilder =
    RoutineTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<DateTime> createdAt,
      Value<int?> alarmHour,
      Value<int?> alarmMinute,
      Value<int> colorValue,
      Value<int> targetRepetitionsPerWeek,
      Value<int> completedRepetitionsThisWeek,
      Value<int> rowid,
    });

class $$RoutineTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alarmHour => $composableBuilder(
    column: $table.alarmHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alarmMinute => $composableBuilder(
    column: $table.alarmMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetRepetitionsPerWeek => $composableBuilder(
    column: $table.targetRepetitionsPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedRepetitionsThisWeek => $composableBuilder(
    column: $table.completedRepetitionsThisWeek,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alarmHour => $composableBuilder(
    column: $table.alarmHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alarmMinute => $composableBuilder(
    column: $table.alarmMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetRepetitionsPerWeek => $composableBuilder(
    column: $table.targetRepetitionsPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedRepetitionsThisWeek => $composableBuilder(
    column: $table.completedRepetitionsThisWeek,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get alarmHour =>
      $composableBuilder(column: $table.alarmHour, builder: (column) => column);

  GeneratedColumn<int> get alarmMinute => $composableBuilder(
    column: $table.alarmMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetRepetitionsPerWeek => $composableBuilder(
    column: $table.targetRepetitionsPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedRepetitionsThisWeek => $composableBuilder(
    column: $table.completedRepetitionsThisWeek,
    builder: (column) => column,
  );
}

class $$RoutineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineTableTable,
          RoutineTbl,
          $$RoutineTableTableFilterComposer,
          $$RoutineTableTableOrderingComposer,
          $$RoutineTableTableAnnotationComposer,
          $$RoutineTableTableCreateCompanionBuilder,
          $$RoutineTableTableUpdateCompanionBuilder,
          (
            RoutineTbl,
            BaseReferences<_$AppDatabase, $RoutineTableTable, RoutineTbl>,
          ),
          RoutineTbl,
          PrefetchHooks Function()
        > {
  $$RoutineTableTableTableManager(_$AppDatabase db, $RoutineTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RoutineTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RoutineTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$RoutineTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int?> alarmHour = const Value.absent(),
                Value<int?> alarmMinute = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> targetRepetitionsPerWeek = const Value.absent(),
                Value<int> completedRepetitionsThisWeek = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineTableCompanion(
                id: id,
                title: title,
                createdAt: createdAt,
                alarmHour: alarmHour,
                alarmMinute: alarmMinute,
                colorValue: colorValue,
                targetRepetitionsPerWeek: targetRepetitionsPerWeek,
                completedRepetitionsThisWeek: completedRepetitionsThisWeek,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required DateTime createdAt,
                Value<int?> alarmHour = const Value.absent(),
                Value<int?> alarmMinute = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> targetRepetitionsPerWeek = const Value.absent(),
                Value<int> completedRepetitionsThisWeek = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineTableCompanion.insert(
                id: id,
                title: title,
                createdAt: createdAt,
                alarmHour: alarmHour,
                alarmMinute: alarmMinute,
                colorValue: colorValue,
                targetRepetitionsPerWeek: targetRepetitionsPerWeek,
                completedRepetitionsThisWeek: completedRepetitionsThisWeek,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineTableTable,
      RoutineTbl,
      $$RoutineTableTableFilterComposer,
      $$RoutineTableTableOrderingComposer,
      $$RoutineTableTableAnnotationComposer,
      $$RoutineTableTableCreateCompanionBuilder,
      $$RoutineTableTableUpdateCompanionBuilder,
      (
        RoutineTbl,
        BaseReferences<_$AppDatabase, $RoutineTableTable, RoutineTbl>,
      ),
      RoutineTbl,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoutineTableTableTableManager get routineTable =>
      $$RoutineTableTableTableManager(_db, _db.routineTable);
}
