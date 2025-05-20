import 'package:cache_storage_demo/data/source/local/floor/floor_cache_database.dart';

abstract class FloorClientModule {
  Future<AppFloorCacheDatabase> makeFloorInstance() async {
    final database = await $FloorAppFloorCacheDatabase
        .databaseBuilder('floor_cache.db')
        .build();
    return database;
  }
}
