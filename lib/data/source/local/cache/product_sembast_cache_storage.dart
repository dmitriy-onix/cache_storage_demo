import 'package:cache_storage_demo/data/source/local/sembast/sembast_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';

class ProductSembastCacheStorage extends SembastCacheStorage<ProductEntity> {
  ProductSembastCacheStorage({required super.database})
      : super(storeName: 'products_store');

  @override
  ProductEntity mapFromJson(dynamic json) {
    return ProductEntity.fromJson(json as Map<String, dynamic>);
  }

  @override
  dynamic mapToJson(ProductEntity value) {
    return value.toJson();
  }
}
