//@formatter:off

import 'package:cache_storage_demo/data/repository/token_repository_impl.dart';
import 'package:cache_storage_demo/data/source/local/secure_storage/secure_storage_source.dart';
import 'package:cache_storage_demo/domain/repository/token_repository.dart';
import 'package:get_it/get_it.dart';

//{imports end}

void registerRepositories(GetIt getIt) {
  getIt.registerSingleton<TokenRepository>(
    TokenRepositoryImpl(getIt<SecureStorageSource>()),
  );
  //{repositories end}
}

TokenRepository get tokenRepository => GetIt.I.get<TokenRepository>();
