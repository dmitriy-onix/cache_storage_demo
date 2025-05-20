import 'dart:convert';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/source/local/objectbox/object_box_cache_record.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:cache_storage_demo/objectbox.g.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class ObjectBoxCacheStorage<T> extends CacheStorage<T> {
  final Store _store;
  final String group;

  ObjectBoxCacheStorage({
    required Store store,
    required this.group,
  }) : _store = store;

  T mapFromJson(dynamic json);

  dynamic mapToJson(T value);

  Box<ObjectBoxCacheRecord> _getBox() {
    return _store.box<ObjectBoxCacheRecord>();
  }

  @override
  Future<void> clear() async {
    final box = _getBox();
    final query = box.query(ObjectBoxCacheRecord_.group.equals(group)).build();
    final results = query.findIds();
    query.close();
    if (results.isNotEmpty) {
      box.removeMany(results);
    }
  }

  @override
  Future<void> delete(String key) async {
    final box = _getBox();
    final query = box
        .query(
          ObjectBoxCacheRecord_.cacheKey
              .equals(key)
              .and(ObjectBoxCacheRecord_.group.equals(group)),
        )
        .build();
    final recordId = query.findFirst()?.id;
    query.close();

    if (recordId != null) {
      box.remove(recordId);
    }
  }

  @override
  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    final box = _getBox();
    final query = box
        .query(
          ObjectBoxCacheRecord_.cacheKey
              .equals(key)
              .and(ObjectBoxCacheRecord_.group.equals(group)),
        )
        .build();
    final item = query.findFirst();
    query.close();

    if (item == null) {
      return Result.error(error: NoDataFoundFailure());
    }

    if (expirationDuration != null) {
      final now = DateTime.now();
      final createdAt = item.createdAt;
      final isExpired = now.difference(createdAt) > expirationDuration;
      if (isExpired) {
        box.remove(item.id);
        return Result.error(error: ExpiredDataFailure());
      }
    }

    try {
      final json = jsonDecode(item.value);
      return Result.ok(mapFromJson(json));
    } catch (e, s) {
      box.remove(item.id);
      logger.e(
        'Error decoding ObjectBox cache for key "$key" in group "$group": $e',
      );
      return Result.error(error: DecodingFailure(e, s));
    }
  }

  @override
  Future<void> save(String key, T value) async {
    final box = _getBox();
    final dynamic jsonValue = mapToJson(value);
    final valueString = jsonEncode(jsonValue);

    final query = box
        .query(
          ObjectBoxCacheRecord_.cacheKey
              .equals(key)
              .and(ObjectBoxCacheRecord_.group.equals(group)),
        )
        .build();
    final existingItem = query.findFirst();
    query.close();

    final ObjectBoxCacheRecord itemToSave;
    if (existingItem != null) {
      itemToSave = existingItem
        ..value = valueString
        ..createdAt = DateTime.now();
    } else {
      itemToSave = ObjectBoxCacheRecord(
        cacheKey: key,
        group: group,
        value: valueString,
        createdAt: DateTime.now(),
      );
    }
    box.put(itemToSave);
  }
}
