import 'package:cache_storage_demo/data/source/local/floor/floor_cache_record.dart';
import 'package:floor/floor.dart';

@dao
abstract class FloorCacheDao {
  @Query(
      'SELECT * FROM floor_cache_records WHERE cacheKey = :key AND "group" = :group')
  Future<FloorCacheRecord?> findRecordByKeyAndGroup(String key, String group);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecord(FloorCacheRecord record);

  @Query(
      'DELETE FROM floor_cache_records WHERE cacheKey = :key AND "group" = :group')
  Future<void> deleteRecordByKeyAndGroup(String key, String group);

  @Query('DELETE FROM floor_cache_records WHERE "group" = :group')
  Future<void> deleteRecordsByGroup(String group);

  @Query(
      'DELETE FROM floor_cache_records WHERE cacheKey = :key AND "group" = :group')
  Future<void> deleteRecord(String key, String group);
}
