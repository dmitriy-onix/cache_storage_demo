import 'package:cache_storage_demo/data/source/local/objectbox/object_box_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';

class ProductObjectBoxCacheStorage
    extends ObjectBoxCacheStorage<ProductEntity> {
  ProductObjectBoxCacheStorage({required super.store})
      : super(group: 'products');

  @override
  ProductEntity mapFromJson(dynamic json) {
    return ProductEntity.fromJson(json as Map<String, dynamic>);
  }

  @override
  dynamic mapToJson(ProductEntity value) => value.toJson();
}
