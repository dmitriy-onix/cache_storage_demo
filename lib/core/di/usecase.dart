import 'package:cache_storage_demo/domain/repository/product_repository.dart';
import 'package:cache_storage_demo/domain/usecase/get_product_use_case.dart';
import 'package:get_it/get_it.dart';

void registerUseCases(GetIt getIt) {
  getIt.registerSingleton<GetProductUseCase>(
    GetProductUseCase(getIt.get<ProductRepository>()),
  );
}
