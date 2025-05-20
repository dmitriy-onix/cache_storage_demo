/*
import 'dart:convert';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/isar_cache/isar_cache_record.dart';
import 'package:isar/isar.dart';

abstract class IsarCacheStorage<T> extends CacheStorage<T> {
  final Isar isar;
  final String group;

  const IsarCacheStorage({
    required this.isar,
    required this.group,
  });

  T mapFromJson(dynamic json);

  dynamic mapToJson(T value);

  @override
  Future<void> clear() async {
    await isar.writeTxn(() {
      return isar.isarCacheRecords.filter().groupEqualTo(group).deleteAll();
    });
  }

  @override
  Future<void> delete(String key) async {
    await isar.writeTxn(() {
      return isar.isarCacheRecords.filter().keyEqualTo(key).deleteAll();
    });
  }

  @override
  Future<T?> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    final item =
        await isar.isarCacheRecords.filter().keyEqualTo(key).findFirst();
    if (item == null) return null;

    if (expirationDuration != null) {
      final now = DateTime.now();
      final createdAt = item.createdAt;
      final isExpired = now.difference(createdAt) > expirationDuration;
      if (isExpired) {
        await isar.writeTxn(() => isar.isarCacheRecords.delete(item.id));
        return null;
      }
    }
    final json = jsonDecode(item.value);
    return mapFromJson(json);
  }

  @override
  Future<void> save(String key, T value) async {
    final json = mapToJson(value);
    final valueString = jsonEncode(json);
    final item = IsarCacheRecord(
      key: key,
      value: valueString,
      group: group,
      createdAt: DateTime.now(),
    );
    await isar.writeTxn(() => isar.isarCacheRecords.put(item));
  }
}
*/
