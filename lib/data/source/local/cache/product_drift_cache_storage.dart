import 'package:cache_storage_demo/data/source/local/drift/drift_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';

class ProductDriftCacheStorage extends DriftCacheStorage<ProductEntity> {
  ProductDriftCacheStorage({required super.database})
      : super(group: 'products_drift');

  @override
  ProductEntity mapFromJson(dynamic json) => ProductEntity.fromJson(json);

  @override
  dynamic mapToJson(ProductEntity value) => value.toJson();
}
