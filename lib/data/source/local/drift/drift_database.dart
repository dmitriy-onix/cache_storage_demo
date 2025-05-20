import 'dart:io';

import 'package:cache_storage_demo/data/source/local/drift/drift_cache_record.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [DriftCacheRecords])
class AppDriftCacheDatabase extends _$AppDriftCacheDatabase {
  AppDriftCacheDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  AppDriftCacheDatabase.connect(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'drift_cache_db.sqlite'));

    // work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cacheBase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}
