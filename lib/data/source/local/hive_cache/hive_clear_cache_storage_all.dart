import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_all.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveClearCacheStorageAll extends ClearCacheStorageAll {
  final HiveInterface _hive;

  HiveClearCacheStorageAll({
    required HiveInterface hive,
  }) : _hive = hive;

  @override
  Future<void> clear() => _hive.deleteFromDisk();
}
