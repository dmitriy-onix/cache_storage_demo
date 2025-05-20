import 'package:drift/drift.dart';

@DataClassName('DriftCacheEntry')
class DriftCacheRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cacheKey => text()();
  TextColumn get group => text()();
  TextColumn get value => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  List<String> get customConstraints => ['UNIQUE(cache_key, "group")'];
}