//@formatter:off

import 'package:cache_storage_demo/core/arch/data/remote/dio/dio_const.dart';
import 'package:get_it/get_it.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';

void registerRemote(GetIt getIt) {
  final dioClientModule = _DioClientModule();

  getIt
    ..registerLazySingleton<RequestProcessor>(
      dioClientModule.createInternalDioRequestProcessor,
    )
    ..registerLazySingleton<ApiClient>(
      () => dioClientModule.makeApiClient(
        ApiClientParams(
          baseUrl: DioConst.defaultBaseUrl,
        ),
      ),
      instanceName: DioConst.defaultApiClientName,
    );

  //{remote end}
}

class _DioClientModule extends DioClientModule {}
