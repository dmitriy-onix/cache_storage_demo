import 'dart:convert';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/source/local/drift/drift_database.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:drift/drift.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class DriftCacheStorage<T> extends CacheStorage<T> {
  final AppDriftCacheDatabase _db;
  final String group;

  DriftCacheStorage({
    required AppDriftCacheDatabase database,
    required this.group,
  }) : _db = database;

  T mapFromJson(dynamic json);

  dynamic mapToJson(T value);

  @override
  Future<void> clear() async {
    await (_db.delete(_db.driftCacheRecords)
          ..where((tbl) => tbl.group.equals(group)))
        .go();
  }

  @override
  Future<void> delete(String key) async {
    await (_db.delete(_db.driftCacheRecords)
          ..where((tbl) => tbl.cacheKey.equals(key) & tbl.group.equals(group)))
        .go();
  }

  @override
  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    final query = _db.select(_db.driftCacheRecords)
      ..where((tbl) => tbl.cacheKey.equals(key) & tbl.group.equals(group));
    final item = await query.getSingleOrNull();

    if (item == null) {
      return Result.error(error: NoDataFoundFailure());
    }

    if (expirationDuration != null) {
      final now = DateTime.now();
      final createdAt = item.createdAt;
      final isExpired = now.difference(createdAt) > expirationDuration;
      if (isExpired) {
        await (_db.delete(_db.driftCacheRecords)
              ..where((tbl) => tbl.id.equals(item.id)))
            .go();
        return Result.error(error: ExpiredDataFailure());
      }
    }

    try {
      final json = jsonDecode(item.value);
      return Result.ok(mapFromJson(json));
    } catch (e, s) {
      await (_db.delete(_db.driftCacheRecords)
            ..where((tbl) => tbl.id.equals(item.id)))
          .go();
      logger
          .e('Error decoding Drift cache for key "$key" in group "$group": $e');
      return Result.error(error: DecodingFailure(e, s));
    }
  }

  @override
  Future<void> save(String key, T value) async {
    final dynamic jsonValue = mapToJson(value);
    final valueString = jsonEncode(jsonValue);
    final now = DateTime.now();

    final existingQuery = _db.select(_db.driftCacheRecords)
      ..where((tbl) => tbl.cacheKey.equals(key) & tbl.group.equals(group));
    final existingEntry = await existingQuery.getSingleOrNull();

    if (existingEntry != null) {
      final updateCompanion = DriftCacheRecordsCompanion(
        value: Value(valueString),
        createdAt: Value(now),
      );
      await (_db.update(_db.driftCacheRecords)
            ..where((tbl) => tbl.id.equals(existingEntry.id)))
          .write(updateCompanion);
      logger
          .w('DriftCacheStorage: Updated entry for key "$key", group "$group"');
    } else {
      final insertCompanion = DriftCacheRecordsCompanion.insert(
        cacheKey: key,
        group: group,
        value: valueString,
        createdAt: now,
      );
      await _db.into(_db.driftCacheRecords).insert(insertCompanion);
      logger.w(
        'DriftCacheStorage: Inserted new entry for key "$key", group "$group"',
      );
    }
  }
}
