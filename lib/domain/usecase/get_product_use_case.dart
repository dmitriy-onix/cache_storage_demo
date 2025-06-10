import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:cache_storage_demo/domain/repository/product_repository.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

class GetProductUseCase {
  final ProductRepository _productRepository;

  GetProductUseCase(this._productRepository);

  Future<Result<ProductEntity>> call() async {
    return _productRepository.getProduct();
  }
}
