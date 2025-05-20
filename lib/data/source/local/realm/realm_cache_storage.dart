import 'dart:convert';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/source/local/realm/realm_cache_record.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';
import 'package:realm/realm.dart';

abstract class RealmCacheStorage<T> extends CacheStorage<T> {
  final Realm _realm;
  final String group;

  RealmCacheStorage({
    required Realm realm,
    required this.group,
  }) : _realm = realm;

  T mapFromJson(dynamic json);

  dynamic mapToJson(T value);

  String _getCompoundKey(String key) {
    return '$group-$key';
  }

  @override
  Future<void> clear() async {
    final recordsToDelete =
        _realm.all<RealmCacheRecord>().query(r'group == $0', [group]);
    _realm.write(() {
      _realm.deleteMany(recordsToDelete);
    });
  }

  @override
  Future<void> delete(String key) async {
    final compoundKey = _getCompoundKey(key);
    final record = _realm.find<RealmCacheRecord>(compoundKey);
    if (record != null) {
      _realm.write(() {
        _realm.delete(record);
      });
    }
  }

  @override
  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  }) async {
    final compoundKey = _getCompoundKey(key);
    final item = _realm.find<RealmCacheRecord>(compoundKey);

    if (item == null) {
      return Result.error(error: NoDataFoundFailure());
    }

    if (expirationDuration != null) {
      final now = DateTime.now();
      final createdAt = item.createdAt;
      final isExpired = now.difference(createdAt) > expirationDuration;
      if (isExpired) {
        _realm.write(() {
          _realm.delete(item);
        });
        return Result.error(error: ExpiredDataFailure());
      }
    }

    try {
      final json = jsonDecode(item.value);
      return Result.ok(mapFromJson(json));
    } catch (e, s) {
      _realm.write(() {
        _realm.delete(item);
      });
      logger
          .e('Error decoding Realm cache for key "$key" in group "$group": $e');
      return Result.error(error: DecodingFailure(e, s));
    }
  }

  @override
  Future<void> save(String key, T value) async {
    final dynamic jsonValue = mapToJson(value);
    final valueString = jsonEncode(jsonValue);
    final compoundKey = _getCompoundKey(key);

    _realm.write(() {
      _realm.add(
        RealmCacheRecord(
          compoundKey,
          key,
          group,
          valueString,
          DateTime.now(),
        ),
        update: true,
      );
    });
  }
}
