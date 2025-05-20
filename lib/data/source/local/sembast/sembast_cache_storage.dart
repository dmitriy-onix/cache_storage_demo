import 'dart:convert';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/source/local/sembast/sembast_cache_data.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';
import 'package:sembast/sembast.dart';

abstract class SembastCacheStorage<T> extends CacheStorage<T> {
  final Database _db;

  final StoreRef<String, Map<String, Object?>> _store;

  SembastCacheStorage({
    required Database database,
    required String storeName,
  })  : _db = database,
        _store = stringMapStoreFactory.store(storeName);

  T mapFromJson(dynamic json);

  dynamic mapToJson(T value);

  @override
  Future<void> clear() async {
    await _store.delete(_db);
  }

  @override
  Future<void> delete(String key) async {
    await _store.record(key).delete(_db);
  }

  @override
  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    final recordJson = await _store.record(key).get(_db);

    if (recordJson == null) {
      return Result.error(error: NoDataFoundFailure());
    }

    final SembastCacheData item;
    try {
      item = SembastCacheData.fromJson(recordJson);
    } catch (e, s) {
      await _store.record(key).delete(_db);
      logger.e('Error parsing Sembast cache data for key "$key": $e');
      return Result.error(error: DecodingFailure(e, s));
    }

    if (expirationDuration != null) {
      final now = DateTime.now();
      final createdAt = item.createdAt;
      final isExpired = now.difference(createdAt) > expirationDuration;
      if (isExpired) {
        await _store.record(key).delete(_db);
        return Result.error(error: ExpiredDataFailure());
      }
    }

    try {
      final json = jsonDecode(item.value);
      return Result.ok(mapFromJson(json));
    } catch (e, s) {
      await _store.record(key).delete(_db);
      logger.e('Error decoding Sembast cache value for key "$key": $e');
      return Result.error(error: DecodingFailure(e, s));
    }
  }

  @override
  Future<void> save(String key, T value) async {
    final dynamic jsonValue = mapToJson(value);
    final valueString = jsonEncode(jsonValue);

    final cacheData = SembastCacheData(
      value: valueString,
      createdAtMillis: DateTime.now().millisecondsSinceEpoch,
    );

    await _store.record(key).put(_db, cacheData.toJson());
  }
}
