import 'package:cache_storage_demo/data/source/local/hive_cache/hive_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';

class ProductHiveCacheStorage extends HiveCacheStorage<ProductEntity> {
  ProductHiveCacheStorage({required super.hive}) : super(groupName: 'products');

  @override
  ProductEntity mapFromJson(dynamic json) => ProductEntity.fromJson(json);

  @override
  dynamic mapToJson(ProductEntity value) => value.toJson();
}
