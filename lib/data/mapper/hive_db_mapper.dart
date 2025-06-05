import 'package:cache_storage_demo/domain/entity/cache/product_ho.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';

class _ProductEntityToDb implements Mapper<ProductEntity, ProductHO> {
  @override
  ProductHO map(ProductEntity from) {
    return ProductHO(
      id: from.id,
      name: from.name,
      price: from.price,
    );
  }
}

class _ProductDbToEntity implements Mapper<ProductHO, ProductEntity> {
  @override
  ProductEntity map(ProductHO from) {
    return ProductEntity(
      id: from.id,
      name: from.name,
      price: from.price,
    );
  }
}

class HiveDbMappers {
  final _productEntityToDb = _ProductEntityToDb();
  final _productDbToEntity = _ProductDbToEntity();

  ProductHO mapProductEntityToDb(ProductEntity entity) {
    return _productEntityToDb.map(entity);
  }

  ProductEntity mapProductDbToEntity(ProductHO db) {
    return _productDbToEntity.map(db);
  }
}
