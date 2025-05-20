// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_cache_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppFloorCacheDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppFloorCacheDatabaseBuilderContract addMigrations(
      List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppFloorCacheDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppFloorCacheDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppFloorCacheDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppFloorCacheDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppFloorCacheDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppFloorCacheDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppFloorCacheDatabaseBuilder(null);
}

class _$AppFloorCacheDatabaseBuilder
    implements $AppFloorCacheDatabaseBuilderContract {
  _$AppFloorCacheDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppFloorCacheDatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppFloorCacheDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppFloorCacheDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppFloorCacheDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppFloorCacheDatabase extends AppFloorCacheDatabase {
  _$AppFloorCacheDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FloorCacheDao? _floorCacheDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `floor_cache_records` (`cacheKey` TEXT NOT NULL, `group` TEXT NOT NULL, `value` TEXT NOT NULL, `created_at` INTEGER NOT NULL, PRIMARY KEY (`cacheKey`, `group`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FloorCacheDao get floorCacheDao {
    return _floorCacheDaoInstance ??= _$FloorCacheDao(database, changeListener);
  }
}

class _$FloorCacheDao extends FloorCacheDao {
  _$FloorCacheDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _floorCacheRecordInsertionAdapter = InsertionAdapter(
            database,
            'floor_cache_records',
            (FloorCacheRecord item) => <String, Object?>{
                  'cacheKey': item.cacheKey,
                  'group': item.group,
                  'value': item.value,
                  'created_at': item.createdAtMillis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FloorCacheRecord> _floorCacheRecordInsertionAdapter;

  @override
  Future<FloorCacheRecord?> findRecordByKeyAndGroup(
    String key,
    String group,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM floor_cache_records WHERE cacheKey = ?1 AND \"group\" = ?2',
        mapper: (Map<String, Object?> row) => FloorCacheRecord(cacheKey: row['cacheKey'] as String, group: row['group'] as String, value: row['value'] as String, createdAtMillis: row['created_at'] as int),
        arguments: [key, group]);
  }

  @override
  Future<void> deleteRecordByKeyAndGroup(
    String key,
    String group,
  ) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM floor_cache_records WHERE cacheKey = ?1 AND \"group\" = ?2',
        arguments: [key, group]);
  }

  @override
  Future<void> deleteRecordsByGroup(String group) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM floor_cache_records WHERE \"group\" = ?1',
        arguments: [group]);
  }

  @override
  Future<void> deleteRecord(
    String key,
    String group,
  ) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM floor_cache_records WHERE cacheKey = ?1 AND \"group\" = ?2',
        arguments: [key, group]);
  }

  @override
  Future<void> insertRecord(FloorCacheRecord record) async {
    await _floorCacheRecordInsertionAdapter.insert(
        record, OnConflictStrategy.replace);
  }
}
