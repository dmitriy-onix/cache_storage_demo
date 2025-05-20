import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/core/di/injection.dart';
import 'package:cache_storage_demo/data/source/local/hive_cache/hive_cache_record.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class Initialization {
  static final Initialization _instance = Initialization._privateConstructor();

  static Initialization get I => _instance;

  Initialization._privateConstructor();

  Future<void> initApp() async {
    //TODO init firebase / Crashlytics / Messaging

    await initializeDi(GetIt.I);
    await _initializeHiveDatabase();
    logger.d('APP Init: done');
  }

  Future<void> _initializeHiveDatabase() async {
    Hive.registerAdapter(HiveCacheRecordAdapter());
    await Hive.initFlutter();
  }
}
