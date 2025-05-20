import 'package:cache_storage_demo/data/source/local/realm/realm_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';

class ProductRealmCacheStorage extends RealmCacheStorage<ProductEntity> {
  ProductRealmCacheStorage({required super.realm})
      : super(group: 'products_realm');

  @override
  ProductEntity mapFromJson(dynamic json) => ProductEntity.fromJson(json);

  @override
  dynamic mapToJson(ProductEntity value) => value.toJson();
}
