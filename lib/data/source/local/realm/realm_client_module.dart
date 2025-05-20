import 'package:cache_storage_demo/data/source/local/realm/realm_cache_record.dart';
import 'package:realm/realm.dart';

abstract class RealmClientModule {
  Realm makeFloorInstance() {
    final config = Configuration.local([RealmCacheRecord.schema]);
    final realm = Realm(config);
    return realm;
  }
}
