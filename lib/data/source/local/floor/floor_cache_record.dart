import 'package:floor/floor.dart';

@Entity(
  tableName: 'floor_cache_records',
  primaryKeys: ['cacheKey', 'group'],
)
class FloorCacheRecord {
  final String cacheKey;
  final String group;
  final String value;

  @ColumnInfo(name: 'created_at')
  final int createdAtMillis;

  FloorCacheRecord({
    required this.cacheKey,
    required this.group,
    required this.value,
    required this.createdAtMillis,
  });

  DateTime get createdAt =>
      DateTime.fromMillisecondsSinceEpoch(createdAtMillis);
}
