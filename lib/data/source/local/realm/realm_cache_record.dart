import 'package:realm/realm.dart';

part 'realm_cache_record.realm.dart';

@RealmModel()
class _RealmCacheRecord {
  @PrimaryKey()
  late String compoundKey;

  late String cacheKey;
  late String group;
  late String value;
  late DateTime createdAt;
}
