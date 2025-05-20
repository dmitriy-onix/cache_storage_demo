import 'package:hive_ce_flutter/hive_flutter.dart';

part 'hive_cache_record.g.dart';

@HiveType(typeId: 0)
class HiveCacheRecord extends HiveObject {
  @HiveField(0)
  final DateTime createdAt;

  @HiveField(1)
  final String value;

  HiveCacheRecord({
    required this.value,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'HiveCacheRecord{createdAt: $createdAt, value: $value}';
  }
}
