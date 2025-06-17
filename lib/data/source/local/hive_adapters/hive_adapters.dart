import 'package:cache_storage_demo/data/model/local/hive_db/product_ho.dart';
import 'package:cache_storage_demo/data/source/local/hive_cache/hive_cache_record.dart';
import 'package:cache_storage_demo/data/source/local/hive_cache_no_json/hive_meta_record.dart';
import 'package:hive_ce/hive.dart';

@GenerateAdapters([
  AdapterSpec<ProductHO>(),
  AdapterSpec<HiveMetaRecord>(),
  AdapterSpec<HiveCacheRecord>(),
])
part 'hive_adapters.g.dart';
