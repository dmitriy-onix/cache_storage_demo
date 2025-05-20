import 'dart:convert';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/source/local/hive_cache/hive_cache_record.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class HiveCacheStorage<T> extends CacheStorage<T> {
  final HiveInterface _hive;
  final String groupName;
  Box<HiveCacheRecord>? _box;

  HiveCacheStorage({
    required HiveInterface hive,
    required this.groupName,
  }) : _hive = hive;

  T mapFromJson(dynamic json);

  dynamic mapToJson(T value);

  Future<Box<HiveCacheRecord>> _getBox() async {
    if (_box == null || !_box!.isOpen) {
      if (!_hive.isAdapterRegistered(HiveCacheRecordAdapter().typeId)) {
        _hive.registerAdapter(HiveCacheRecordAdapter());
        logger.w(
          'HiveCacheRecordAdapter registered in _getBox for $groupName',
        );
      }
      _box = await _hive.openBox<HiveCacheRecord>(groupName);
    }
    return _box!;
  }

  @override
  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }

  @override
  Future<void> delete(String key) async {
    final box = await _getBox();
    await box.delete(key);
  }

  @override
  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    final box = await _getBox();
    final item = box.get(key);

    if (item == null) {
      return Result.error(error: NoDataFoundFailure());
    }

    if (expirationDuration != null) {
      final now = DateTime.now();
      final createdAt = item.createdAt;
      final isExpired = now.difference(createdAt) > expirationDuration;
      if (isExpired) {
        await box.delete(key);
        return Result.error(error: ExpiredDataFailure());
      }
    }

    try {
      final json = jsonDecode(item.value);
      return Result.ok(mapFromJson(json));
    } catch (e, s) {
      await box.delete(key);
      logger.e(
          'Error decoding Hive cache for key "$key" in group "$groupName": $e');
      return Result.error(error: DecodingFailure(e, s));
    }
  }

  @override
  Future<void> save(String key, T value) async {
    final box = await _getBox();
    final jsonValue = mapToJson(value);
    final valueString = jsonEncode(jsonValue);

    final item = HiveCacheRecord(
      createdAt: DateTime.now(),
      value: valueString,
    );
    await box.put(key, item);
  }

  Future<void> dispose() async {
    if (_box != null && (_box?.isOpen ?? false)) {
      await _box?.close();
      _box = null;
    }
  }
}
