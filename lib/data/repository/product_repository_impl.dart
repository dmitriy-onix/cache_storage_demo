import 'dart:math';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/data/remote/dio/dio_server_error_mapper.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/mapper/product_mappers.dart';
import 'package:cache_storage_demo/data/model/remote/product/product_response.dart';
import 'package:cache_storage_demo/data/source/local/cache/cache_storage_consts.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_hive_no_json_cache_storage.dart';
import 'package:cache_storage_demo/data/source/remote/product_api_source.dart';
import 'package:cache_storage_demo/domain/entity/cache/product_ho.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:cache_storage_demo/domain/repository/product_repository.dart';
import 'package:onix_flutter_core/onix_flutter_core.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductHiveCacheStorageNoJson _productLocalSource;
  final ProductApiSource _productApiSource;

  final _productMappers = ProductMappers();
  final _dioServerErrorMapper = DioServerErrorMapper();

  ProductRepositoryImpl({
    required ProductHiveCacheStorageNoJson localSource,
    required ProductApiSource apiSource,
  })  : _productLocalSource = localSource,
        _productApiSource = apiSource;

  @override
  Future<Result<ProductEntity>> getProduct() async {
    try {
      final data = await _productLocalSource
          .cachingAlgorithmForPolicy(
            CacheStoragePolicy.cacheAndBackgroundUpdate,
          )
          .execute(
            sourceAction: _getProductApiAction,
            key: 'product-1',
            expirationDuration:
                CacheStorageConsts.testValueExpirationDuration10Sec,
          );

      if (data.isOk) {
        final product = _productMappers.mapProductDbToEntity(data.data);
        return Result.ok(product);
      }

      return Result.error(error: data.asError.error);
    } catch (e, s) {
      logger.crash(error: e, stackTrace: s, reason: 'getProduct');
      return Result.error(
        error: ApiFailure(
          ServerFailure.exception,
          message: e.toString(),
        ),
      );
    }
  }

  Future<Result<ProductHO>> _getProductApiAction() async {
    final useFailedResponse = Random().nextBool();

    DataResponse<ProductResponse> response;

    if (useFailedResponse) {
      response = await _productApiSource.getProductFailure();
    } else {
      response = await _productApiSource.getProduct();
    }

    if (response.isSuccess()) {
      final data = _productMappers.mapProductResponseToDb(response.data);
      return Result.ok(data);
    }

    return Result.error(error: _dioServerErrorMapper.mapToFailure(response));
  }
}
