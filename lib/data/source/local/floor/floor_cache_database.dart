import 'dart:async';

import 'package:cache_storage_demo/data/source/local/floor/floor_cache_record.dart';
import 'package:cache_storage_demo/data/source/local/floor/floor_cache_record_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'floor_cache_database.g.dart';

@Database(version: 1, entities: [FloorCacheRecord])
abstract class AppFloorCacheDatabase extends FloorDatabase {
  FloorCacheDao get floorCacheDao;
}
