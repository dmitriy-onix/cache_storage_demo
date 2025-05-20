/*
import 'package:cache_storage_demo/data/source/local/isar_cache/isar_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';

class ProductIsarCacheStorage extends IsarCacheStorage<ProductEntity> {
  ProductIsarCacheStorage({required super.isar}) : super(group: 'products');

  @override
  ProductEntity mapFromJson(dynamic json) {
    return ProductEntity.fromJson(json as Map<String, dynamic>);
  }

  @override
  dynamic mapToJson(ProductEntity value) {
    return value.toJson();
  }
}
*/
