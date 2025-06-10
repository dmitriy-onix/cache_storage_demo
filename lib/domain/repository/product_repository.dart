import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class ProductRepository {
  Future<Result<ProductEntity>> getProduct();
}
