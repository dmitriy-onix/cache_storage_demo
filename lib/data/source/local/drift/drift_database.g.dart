// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DriftCacheRecordsTable extends DriftCacheRecords
    with TableInfo<$DriftCacheRecordsTable, DriftCacheEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftCacheRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cacheKeyMeta =
      const VerificationMeta('cacheKey');
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
      'cache_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupMeta = const VerificationMeta('group');
  @override
  late final GeneratedColumn<String> group = GeneratedColumn<String>(
      'group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, cacheKey, group, value, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_cache_records';
  @override
  VerificationContext validateIntegrity(Insertable<DriftCacheEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cache_key')) {
      context.handle(_cacheKeyMeta,
          cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta));
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('group')) {
      context.handle(
          _groupMeta, group.isAcceptableOrUnknown(data['group']!, _groupMeta));
    } else if (isInserting) {
      context.missing(_groupMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftCacheEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftCacheEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cacheKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cache_key'])!,
      group: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DriftCacheRecordsTable createAlias(String alias) {
    return $DriftCacheRecordsTable(attachedDatabase, alias);
  }
}

class DriftCacheEntry extends DataClass implements Insertable<DriftCacheEntry> {
  final int id;
  final String cacheKey;
  final String group;
  final String value;
  final DateTime createdAt;
  const DriftCacheEntry(
      {required this.id,
      required this.cacheKey,
      required this.group,
      required this.value,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cache_key'] = Variable<String>(cacheKey);
    map['group'] = Variable<String>(group);
    map['value'] = Variable<String>(value);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DriftCacheRecordsCompanion toCompanion(bool nullToAbsent) {
    return DriftCacheRecordsCompanion(
      id: Value(id),
      cacheKey: Value(cacheKey),
      group: Value(group),
      value: Value(value),
      createdAt: Value(createdAt),
    );
  }

  factory DriftCacheEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftCacheEntry(
      id: serializer.fromJson<int>(json['id']),
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      group: serializer.fromJson<String>(json['group']),
      value: serializer.fromJson<String>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cacheKey': serializer.toJson<String>(cacheKey),
      'group': serializer.toJson<String>(group),
      'value': serializer.toJson<String>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DriftCacheEntry copyWith(
          {int? id,
          String? cacheKey,
          String? group,
          String? value,
          DateTime? createdAt}) =>
      DriftCacheEntry(
        id: id ?? this.id,
        cacheKey: cacheKey ?? this.cacheKey,
        group: group ?? this.group,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
      );
  DriftCacheEntry copyWithCompanion(DriftCacheRecordsCompanion data) {
    return DriftCacheEntry(
      id: data.id.present ? data.id.value : this.id,
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      group: data.group.present ? data.group.value : this.group,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftCacheEntry(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('group: $group, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cacheKey, group, value, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftCacheEntry &&
          other.id == this.id &&
          other.cacheKey == this.cacheKey &&
          other.group == this.group &&
          other.value == this.value &&
          other.createdAt == this.createdAt);
}

class DriftCacheRecordsCompanion extends UpdateCompanion<DriftCacheEntry> {
  final Value<int> id;
  final Value<String> cacheKey;
  final Value<String> group;
  final Value<String> value;
  final Value<DateTime> createdAt;
  const DriftCacheRecordsCompanion({
    this.id = const Value.absent(),
    this.cacheKey = const Value.absent(),
    this.group = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DriftCacheRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String cacheKey,
    required String group,
    required String value,
    required DateTime createdAt,
  })  : cacheKey = Value(cacheKey),
        group = Value(group),
        value = Value(value),
        createdAt = Value(createdAt);
  static Insertable<DriftCacheEntry> custom({
    Expression<int>? id,
    Expression<String>? cacheKey,
    Expression<String>? group,
    Expression<String>? value,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cacheKey != null) 'cache_key': cacheKey,
      if (group != null) 'group': group,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DriftCacheRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? cacheKey,
      Value<String>? group,
      Value<String>? value,
      Value<DateTime>? createdAt}) {
    return DriftCacheRecordsCompanion(
      id: id ?? this.id,
      cacheKey: cacheKey ?? this.cacheKey,
      group: group ?? this.group,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (group.present) {
      map['group'] = Variable<String>(group.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftCacheRecordsCompanion(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('group: $group, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDriftCacheDatabase extends GeneratedDatabase {
  _$AppDriftCacheDatabase(QueryExecutor e) : super(e);
  $AppDriftCacheDatabaseManager get managers =>
      $AppDriftCacheDatabaseManager(this);
  late final $DriftCacheRecordsTable driftCacheRecords =
      $DriftCacheRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [driftCacheRecords];
}

typedef $$DriftCacheRecordsTableCreateCompanionBuilder
    = DriftCacheRecordsCompanion Function({
  Value<int> id,
  required String cacheKey,
  required String group,
  required String value,
  required DateTime createdAt,
});
typedef $$DriftCacheRecordsTableUpdateCompanionBuilder
    = DriftCacheRecordsCompanion Function({
  Value<int> id,
  Value<String> cacheKey,
  Value<String> group,
  Value<String> value,
  Value<DateTime> createdAt,
});

class $$DriftCacheRecordsTableFilterComposer
    extends Composer<_$AppDriftCacheDatabase, $DriftCacheRecordsTable> {
  $$DriftCacheRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get group => $composableBuilder(
      column: $table.group, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DriftCacheRecordsTableOrderingComposer
    extends Composer<_$AppDriftCacheDatabase, $DriftCacheRecordsTable> {
  $$DriftCacheRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cacheKey => $composableBuilder(
      column: $table.cacheKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get group => $composableBuilder(
      column: $table.group, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DriftCacheRecordsTableAnnotationComposer
    extends Composer<_$AppDriftCacheDatabase, $DriftCacheRecordsTable> {
  $$DriftCacheRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get group =>
      $composableBuilder(column: $table.group, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DriftCacheRecordsTableTableManager extends RootTableManager<
    _$AppDriftCacheDatabase,
    $DriftCacheRecordsTable,
    DriftCacheEntry,
    $$DriftCacheRecordsTableFilterComposer,
    $$DriftCacheRecordsTableOrderingComposer,
    $$DriftCacheRecordsTableAnnotationComposer,
    $$DriftCacheRecordsTableCreateCompanionBuilder,
    $$DriftCacheRecordsTableUpdateCompanionBuilder,
    (
      DriftCacheEntry,
      BaseReferences<_$AppDriftCacheDatabase, $DriftCacheRecordsTable,
          DriftCacheEntry>
    ),
    DriftCacheEntry,
    PrefetchHooks Function()> {
  $$DriftCacheRecordsTableTableManager(
      _$AppDriftCacheDatabase db, $DriftCacheRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DriftCacheRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DriftCacheRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DriftCacheRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> cacheKey = const Value.absent(),
            Value<String> group = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DriftCacheRecordsCompanion(
            id: id,
            cacheKey: cacheKey,
            group: group,
            value: value,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String cacheKey,
            required String group,
            required String value,
            required DateTime createdAt,
          }) =>
              DriftCacheRecordsCompanion.insert(
            id: id,
            cacheKey: cacheKey,
            group: group,
            value: value,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DriftCacheRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDriftCacheDatabase,
    $DriftCacheRecordsTable,
    DriftCacheEntry,
    $$DriftCacheRecordsTableFilterComposer,
    $$DriftCacheRecordsTableOrderingComposer,
    $$DriftCacheRecordsTableAnnotationComposer,
    $$DriftCacheRecordsTableCreateCompanionBuilder,
    $$DriftCacheRecordsTableUpdateCompanionBuilder,
    (
      DriftCacheEntry,
      BaseReferences<_$AppDriftCacheDatabase, $DriftCacheRecordsTable,
          DriftCacheEntry>
    ),
    DriftCacheEntry,
    PrefetchHooks Function()>;

class $AppDriftCacheDatabaseManager {
  final _$AppDriftCacheDatabase _db;
  $AppDriftCacheDatabaseManager(this._db);
  $$DriftCacheRecordsTableTableManager get driftCacheRecords =>
      $$DriftCacheRecordsTableTableManager(_db, _db.driftCacheRecords);
}
