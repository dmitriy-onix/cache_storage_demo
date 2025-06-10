import 'package:cache_storage_demo/data/repository/product_repository_impl.dart';
import 'package:cache_storage_demo/data/repository/token_repository_impl.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_hive_no_json_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/secure_storage/secure_storage_source.dart';
import 'package:cache_storage_demo/data/source/remote/product_api_source.dart';
import 'package:cache_storage_demo/domain/repository/product_repository.dart';
import 'package:cache_storage_demo/domain/repository/token_repository.dart';
import 'package:get_it/get_it.dart';

//{imports end}

void registerRepositories(GetIt getIt) {
  getIt
    ..registerSingleton<TokenRepository>(
      TokenRepositoryImpl(getIt<SecureStorageSource>()),
    )
    ..registerSingleton<ProductRepository>(
      ProductRepositoryImpl(
        localSource: getIt.get<ProductHiveCacheStorageNoJson>(),
        apiSource: getIt.get<ProductApiSource>(),
      ),
    );
  //{repositories end}
}

TokenRepository get tokenRepository => GetIt.I.get<TokenRepository>();
