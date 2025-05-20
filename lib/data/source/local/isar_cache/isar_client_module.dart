/*
import 'package:cache_storage_demo/data/source/local/isar_cache/isar_cache_record.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class IsarClientModule {
  Future<Isar> makeIsarInstance() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [IsarCacheRecordSchema],
      directory: dir.path,
    );
    return isar;
  }
}
*/
