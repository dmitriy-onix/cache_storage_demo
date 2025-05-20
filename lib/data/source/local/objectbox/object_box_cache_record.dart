import 'package:objectbox/objectbox.dart';

@Entity()
class ObjectBoxCacheRecord {
  @Id()
  int id = 0;

  @Index()
  late String cacheKey;

  @Index()
  late String group;

  late String value;

  @Property(type: PropertyType.date)
  late DateTime createdAt;

  ObjectBoxCacheRecord({
    required this.cacheKey,
    required this.group,
    required this.value,
    required this.createdAt,
    this.id = 0,
  });

  @override
  String toString() {
    return 'ObjectBoxCacheRecord{id: $id, cacheKey: $cacheKey, group: $group, createdAt: $createdAt, value: $value}';
  }
}
