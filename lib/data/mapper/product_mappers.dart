import 'package:cache_storage_demo/data/model/local/hive_db/product_ho.dart';
import 'package:cache_storage_demo/data/model/remote/product/product_response.dart';
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

class _ProductResponseToEntity
    implements Mapper<ProductResponse, ProductEntity> {
  @override
  ProductEntity map(ProductResponse from) {
    return ProductEntity(
      id: from.id,
      name: from.name,
      price: from.price,
    );
  }
}

class _ProductResponseToDB
    implements Mapper<ProductResponse, ProductHO> {
  @override
  ProductHO map(ProductResponse from) {
    return ProductHO(
      id: from.id,
      name: from.name,
      price: from.price,
    );
  }
}

class ProductMappers {
  final _productEntityToDb = _ProductEntityToDb();
  final _productDbToEntity = _ProductDbToEntity();
  final _productResponseToEntity = _ProductResponseToEntity();
  final _productResponseToDb = _ProductResponseToDB();

  ProductHO mapProductEntityToDb(ProductEntity entity) {
    return _productEntityToDb.map(entity);
  }

  ProductEntity mapProductDbToEntity(ProductHO db) {
    return _productDbToEntity.map(db);
  }

  ProductEntity mapProductResponseToEntity(ProductResponse response) {
    return _productResponseToEntity.map(response);
  }

  ProductHO mapProductResponseToDb(ProductResponse response) {
    return _productResponseToDb.map(response);
  }
}
