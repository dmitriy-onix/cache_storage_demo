/*
import 'package:isar/isar.dart';

part 'isar_cache_record.g.dart';

@collection
class IsarCacheRecord {
  final String key;

  final String? group;

  final DateTime createdAt;

  final String value;

  IsarCacheRecord({
    required this.key,
    required this.value,
    required this.createdAt,
    this.group,
  });

  Id get id => _fastHash(group != null ? '$group-$key' : key);

  @override
  String toString() {
    return 'IsarCacheRecord{key: $key, group: $group, createdAt: $createdAt, value: $value}';
  }
}

int _fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
*/
