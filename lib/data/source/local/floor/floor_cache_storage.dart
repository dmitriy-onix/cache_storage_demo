import 'dart:convert';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/source/local/floor/floor_cache_database.dart';
import 'package:cache_storage_demo/data/source/local/floor/floor_cache_record.dart';
import 'package:cache_storage_demo/data/source/local/floor/floor_cache_record_dao.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class FloorCacheStorage<T> extends CacheStorage<T> {
  final AppFloorCacheDatabase _db;
  final String group;

  FloorCacheStorage({
    required AppFloorCacheDatabase database,
    required this.group,
  }) : _db = database;

  T mapFromJson(dynamic json);

  dynamic mapToJson(T value);

  FloorCacheDao get _dao => _db.floorCacheDao;

  @override
  Future<void> clear() async {
    await _dao.deleteRecordsByGroup(group);
  }

  @override
  Future<void> delete(String key) async {
    await _dao.deleteRecordByKeyAndGroup(key, group);
  }

  @override
  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    final item = await _dao.findRecordByKeyAndGroup(key, group);

    if (item == null) {
      return Result.error(error: NoDataFoundFailure());
    }

    if (expirationDuration != null) {
      final now = DateTime.now();
      final createdAt = item.createdAt;
      final isExpired = now.difference(createdAt) > expirationDuration;
      if (isExpired) {
        await _dao.deleteRecord(item.cacheKey, item.group);
        return Result.error(error: ExpiredDataFailure());
      }
    }

    try {
      final json = jsonDecode(item.value);
      return Result.ok(mapFromJson(json));
    } catch (e, s) {
      await _dao.deleteRecord(item.cacheKey, item.group);
      logger
          .e('Error decoding Floor cache for key "$key" in group "$group": $e');
      return Result.error(error: DecodingFailure(e, s));
    }
  }

  @override
  Future<void> save(String key, T value) async {
    final dynamic jsonValue = mapToJson(value);
    final valueString = jsonEncode(jsonValue);

    final record = FloorCacheRecord(
      cacheKey: key,
      group: group,
      value: valueString,
      createdAtMillis: DateTime.now().millisecondsSinceEpoch,
    );
    await _dao.insertRecord(record);
  }
}
