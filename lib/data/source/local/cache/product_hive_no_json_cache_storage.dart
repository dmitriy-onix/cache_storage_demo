import 'package:cache_storage_demo/data/model/local/hive_db/product_ho.dart';
import 'package:cache_storage_demo/data/source/local/hive_cache_no_json/hive_cache_storage_no_json.dart';

class ProductHiveCacheStorageNoJson extends HiveCacheStorageNoJson<ProductHO> {
  ProductHiveCacheStorageNoJson({required super.hive})
      : super(groupName: 'products-no-json');
}
