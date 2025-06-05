import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_all.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_drift_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_floor_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_hive_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_hive_no_json_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_object_box_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_realm_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_sembast_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/drift/drift_database.dart';
import 'package:cache_storage_demo/data/source/local/floor/floor_cache_database.dart';
import 'package:cache_storage_demo/data/source/local/floor/floor_client_module.dart';
import 'package:cache_storage_demo/data/source/local/hive_cache/hive_clear_cache_storage_all.dart';
import 'package:cache_storage_demo/data/source/local/objectbox/objectbox_client_module.dart';
import 'package:cache_storage_demo/data/source/local/preferences_source/preferences_source.dart';
import 'package:cache_storage_demo/data/source/local/preferences_source/preferences_source_impl.dart';
import 'package:cache_storage_demo/data/source/local/realm/realm_client_module.dart';
import 'package:cache_storage_demo/data/source/local/secure_storage/secure_storage_source.dart';
import 'package:cache_storage_demo/data/source/local/secure_storage/secure_storage_source_impl.dart';
import 'package:cache_storage_demo/data/source/local/sembast/sembast_client_module.dart';
import 'package:cache_storage_demo/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
// import 'package:isar/isar.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';
import 'package:realm/realm.dart';
import 'package:sembast/sembast_io.dart';

Future<void> registerLocal(GetIt getIt) async {
  // final isarClientModule = _IsarClientModule();
  final objectBoxClientModule = _ObjectBoxClientModule();
  final sembastClientModule = _SembastClientModule();
  final floorClientModule = _FloorClientModule();
  final realmClientModule = _RealmClientModule();

  // final isar = await isarClientModule.makeIsarInstance();
  final objectBox = await objectBoxClientModule.makeObjectBoxInstance();
  final sembast = await sembastClientModule.makeSembastInstance();
  final floor = await floorClientModule.makeFloorInstance();

  getIt
    /*..registerSingleton<Isar>(isar)
    ..registerSingleton<ClearCacheStorageAll>(
      IsarClearCacheStorageAll(isar: isar),
    )*/
    ..registerSingleton<Realm>(realmClientModule.makeFloorInstance())
    ..registerSingleton<ProductRealmCacheStorage>(
      ProductRealmCacheStorage(realm: getIt.get<Realm>()),
    )
    ..registerSingleton<AppFloorCacheDatabase>(floor)
    ..registerSingleton<ProductFloorCacheStorage>(
      ProductFloorCacheStorage(database: getIt.get<AppFloorCacheDatabase>()),
    )
    ..registerSingleton<AppDriftCacheDatabase>(AppDriftCacheDatabase())
    ..registerSingleton<ProductDriftCacheStorage>(
      ProductDriftCacheStorage(database: getIt.get<AppDriftCacheDatabase>()),
    )
    ..registerSingleton<Store>(objectBox)
    ..registerSingleton<ProductObjectBoxCacheStorage>(
      ProductObjectBoxCacheStorage(store: getIt.get<Store>()),
    )
    ..registerSingleton<Database>(sembast)
    ..registerSingleton<ProductSembastCacheStorage>(
      ProductSembastCacheStorage(database: getIt.get<Database>()),
    )
    ..registerSingleton<ClearCacheStorageAll>(
      HiveClearCacheStorageAll(hive: Hive),
    )
    ..registerLazySingleton<SecureStorageSource>(SecureStorageSourceImpl.new)
    ..registerLazySingleton(SharedPreferencesStorage.new)
    ..registerLazySingleton<PreferencesSource>(
      () => PreferencesSourceImpl(getIt.get<SharedPreferencesStorage>()),
    )
    // ..registerSingleton(ProductIsarCacheStorage(isar: getIt.get<Isar>()))
    ..registerSingleton(
      ProductHiveCacheStorage(hive: Hive),
      dispose: (d) => d.dispose(),
    )
    ..registerSingleton(
      ProductHiveCacheStorageNoJson(hive: Hive),
      dispose: (d) => d.dispose(),
    );
}

// class _IsarClientModule extends IsarClientModule {}
class _ObjectBoxClientModule extends ObjectBoxClientModule {}

class _SembastClientModule extends SembastClientModule {}

class _FloorClientModule extends FloorClientModule {}

class _RealmClientModule extends RealmClientModule {}

SecureStorageSource secureStorageSource() => GetIt.I.get<SecureStorageSource>();

PreferencesSource preferencesSource() => GetIt.I.get<PreferencesSource>();
