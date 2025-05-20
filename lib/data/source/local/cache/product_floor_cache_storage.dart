import 'package:cache_storage_demo/data/source/local/floor/floor_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';

class ProductFloorCacheStorage extends FloorCacheStorage<ProductEntity> {
  ProductFloorCacheStorage({required super.database})
      : super(group: 'products_floor');

  @override
  ProductEntity mapFromJson(dynamic json) => ProductEntity.fromJson(json);

  @override
  dynamic mapToJson(ProductEntity value) => value.toJson();
}
