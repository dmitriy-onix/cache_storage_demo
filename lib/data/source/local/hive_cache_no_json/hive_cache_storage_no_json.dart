import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/hive_cache_no_json/hive_meta_record.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class HiveCacheStorageNoJson<T extends HiveObject>
    extends CacheStorage<T> {
  final HiveInterface _hive;
  final String groupName;
  Box<T>? _dataBox;
  Box<HiveMetaRecord>? _metaBox;

  HiveCacheStorageNoJson({
    required HiveInterface hive,
    required this.groupName,
  }) : _hive = hive;

  Future<Box<T>> _getDataBox() async {
    if (_dataBox == null || !_dataBox!.isOpen) {
      _dataBox = await _hive.openBox<T>(groupName);
    }
    return _dataBox!;
  }

  Future<Box<HiveMetaRecord>> _getMetaBox() async {
    if (_metaBox == null || !_metaBox!.isOpen) {
      final metaBoxName = '${groupName}_meta';
      _metaBox = await _hive.openBox<HiveMetaRecord>(metaBoxName);
    }
    return _metaBox!;
  }

  @override
  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    try {
      final metaBox = await _getMetaBox();
      final meta = metaBox.get(key);

      if (meta == null) {
        return Result.error(error: NoDataFoundFailure());
      }

      if (expirationDuration != null) {
        final now = DateTime.now();
        final isExpired = now.difference(meta.createdAt) > expirationDuration;
        if (isExpired) {
          await delete(key);
          return Result.error(error: ExpiredDataFailure());
        }
      }

      final dataBox = await _getDataBox();
      final item = dataBox.get(key);

      if (item == null) {
        return Result.error(error: NoDataFoundFailure());
      }

      return Result.ok(item);
    } catch (e, s) {
      return Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }

  @override
  Future<void> save(String key, T value) async {
    final dataBox = await _getDataBox();
    await dataBox.put(key, value);

    final metaBox = await _getMetaBox();
    final meta = HiveMetaRecord(createdAt: DateTime.now());
    await metaBox.put(key, meta);
  }

  @override
  Future<void> delete(String key) async {
    final dataBox = await _getDataBox();
    await dataBox.delete(key);

    final metaBox = await _getMetaBox();
    await metaBox.delete(key);
  }

  @override
  Future<void> clear() async {
    final dataBox = await _getDataBox();
    await dataBox.clear();

    final metaBox = await _getMetaBox();
    await metaBox.clear();
  }

  Future<void> dispose() async {
    await _dataBox?.close();
    await _metaBox?.close();
    _dataBox = null;
    _metaBox = null;
  }
}
