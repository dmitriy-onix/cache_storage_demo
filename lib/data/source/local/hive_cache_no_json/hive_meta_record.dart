import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveMetaRecord extends HiveObject {
  final DateTime createdAt;

  HiveMetaRecord({
    required this.createdAt,
  });

  @override
  String toString() {
    return 'HiveMetaRecord{createdAt: $createdAt}';
  }
}
