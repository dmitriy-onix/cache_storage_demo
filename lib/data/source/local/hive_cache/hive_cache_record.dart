import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveCacheRecord extends HiveObject {
  final DateTime createdAt;

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
