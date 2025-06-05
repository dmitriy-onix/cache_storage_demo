import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/mapper/hive_db_mapper.dart';
import 'package:cache_storage_demo/data/source/local/cache/cache_storage_consts.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_drift_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_floor_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_hive_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_hive_no_json_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_object_box_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_realm_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_sembast_cache_storage.dart';
import 'package:cache_storage_demo/domain/entity/cache/product_ho.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:cache_storage_demo/presentation/screen/main_screen/bloc/main_screen_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onix_flutter_bloc/onix_flutter_bloc.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

class MainScreenBloc
    extends BaseBloc<MainScreenEvent, MainScreenState, MainScreenSR> {
  MainScreenBloc() : super(const MainScreenState()) {
    on<MainScreenEventHiveCall>(_onHiveCall);
    on<MainScreenEventHiveNoJsonCall>(_onHiveNoJsonCall);
    on<MainScreenEventIsarCall>(_onIsarCall);
    on<MainScreenEventObjectBoxCall>(
      _onObjectBoxCall,
      transformer: restartable(),
    );
    on<MainScreenEventSembastCall>(_onSembastCall);
    on<MainScreenEventDriftCall>(_onDriftCall);
    on<MainScreenEventFloorCall>(_onFloorCall);
    on<MainScreenEventRealmCall>(_onRealmCall);
  }

  final _hiveCacheStorage = GetIt.I.get<ProductHiveCacheStorage>();
  final _hiveNoJsonCacheStorage = GetIt.I.get<ProductHiveCacheStorageNoJson>();
  final _objectBoxCacheStorage = GetIt.I.get<ProductObjectBoxCacheStorage>();
  final _sembastCacheStorage = GetIt.I.get<ProductSembastCacheStorage>();
  final _driftCacheStorage = GetIt.I.get<ProductDriftCacheStorage>();
  final _floorCacheStorage = GetIt.I.get<ProductFloorCacheStorage>();
  final _realmCacheStorage = GetIt.I.get<ProductRealmCacheStorage>();

  // final _isarCacheStorage = GetIt.I.get<ProductIsarCacheStorage>();

  final _hiveMappers = HiveDbMappers();

  Future<void> _onRealmCall(
    MainScreenEventRealmCall event,
    Emitter<MainScreenState> emit,
  ) async {
    final startTime = DateTime.now();

    final data = await _onCallDB(_realmCacheStorage, _getProductAction);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('realm data: ${data.data}, call time: $timeDiff');

    emit(state.copyWith(realm: _formatTimeDiff(timeDiff)));
  }

  Future<void> _onFloorCall(
    MainScreenEventFloorCall event,
    Emitter<MainScreenState> emit,
  ) async {
    final startTime = DateTime.now();

    final data = await _onCallDB(_floorCacheStorage, _getProductAction);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('floor data: ${data.data}, call time: $timeDiff');

    emit(state.copyWith(floor: _formatTimeDiff(timeDiff)));
  }

  Future<void> _onDriftCall(
    MainScreenEventDriftCall event,
    Emitter<MainScreenState> emit,
  ) async {
    final startTime = DateTime.now();

    final data = await _onCallDB(_driftCacheStorage, _getProductAction);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('drift data: ${data.data}, call time: $timeDiff');

    emit(state.copyWith(drift: _formatTimeDiff(timeDiff)));
  }

  Future<void> _onSembastCall(
    MainScreenEventSembastCall event,
    Emitter<MainScreenState> emit,
  ) async {
    final startTime = DateTime.now();

    final data = await _onCallDB(_sembastCacheStorage, _getProductAction);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('sembast data: ${data.data}, call time: $timeDiff');

    emit(state.copyWith(sembast: _formatTimeDiff(timeDiff)));
  }

  Future<void> _onObjectBoxCall(
    MainScreenEventObjectBoxCall event,
    Emitter<MainScreenState> emit,
  ) async {
    final stopWatch = Stopwatch()..start();
    final stream = _objectBoxCacheStorage
        .cachingAlgorithmForPolicyStream(
          CacheStoragePolicy.cacheAndBackgroundUpdate,
        )
        .execute(
          _getProductAction,
          'product-1',
          expirationDuration: CacheStorageConsts.testValueExpirationDuration,
        );

    await emit.forEach<Result<ProductEntity>>(
      stream,
      onData: (resultData) {
        final duration = stopWatch.elapsed;
        logger.i('objectBox data: ${resultData.data}, call time: $duration');
        return state.copyWith(objectBox: _formatTimeDiff(duration));
      },
    );

    logger.f('stream completed and closed');

    if (stopWatch.isRunning) {
      stopWatch.stop();
    }

    /*final startTime = DateTime.now();

    final data = await _onCallDB(_objectBoxCacheStorage, _getProductAction);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('objectBox data: ${data.data}, call time: $timeDiff');

    emit(state.copyWith(objectBox: _formatTimeDiff(timeDiff)));*/
  }

  Future<void> _onIsarCall(
    MainScreenEventIsarCall event,
    Emitter<MainScreenState> emit,
  ) async {
    /*final startTime = DateTime.now();
    final data = await _isarCacheStorage
        .cachingAlgorithmForPolicy(CacheStoragePolicy.staleWhileRevalidate)
        .execute(
          _getProductAction,
          'product-1',
          expirationDuration: CacheStorageConsts.testValueExpirationDuration,
        );

    final endTime = DateTime.now();

    logger.i('isar data: $data, call time: ${endTime.difference(startTime)}');*/
  }

  Future<void> _onHiveCall(
    MainScreenEventHiveCall event,
    Emitter<MainScreenState> emit,
  ) async {
    final startTime = DateTime.now();

    final data = await _onCallDB(_hiveCacheStorage, _getProductAction);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('hive data: ${data.data}, call time: $timeDiff');

    emit(state.copyWith(hive: _formatTimeDiff(timeDiff)));
  }

  Future<void> _onHiveNoJsonCall(
    MainScreenEventHiveNoJsonCall event,
    Emitter<MainScreenState> emit,
  ) async {
    final startTime = DateTime.now();

    Future<Result<ProductHO>> getProductAction() async {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));
      final data = ProductEntity(
        id: 'product-1',
        name: 'Product 1',
        price: 10,
      );

      final result = _hiveMappers.mapProductEntityToDb(data);

      return Result.ok(result);
    }

    final data = await _onCallDB(_hiveNoJsonCacheStorage, getProductAction);

    final result = _hiveMappers.mapProductDbToEntity(data.data);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('hive data: $result, call time: $timeDiff');

    emit(state.copyWith(hiveNoJson: _formatTimeDiff(timeDiff)));
  }

  Future<Result<ProductEntity>> _getProductAction() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
    final data = ProductEntity(
      id: 'product-1',
      name: 'Product 1',
      price: 10,
    );
    return Result.ok(data);
  }

  Future<Result<T>> _onCallDB<T>(
    CacheStorage<T> storage,
    Future<Result<T>> Function() action,
  ) async {
    final data = await storage
        .cachingAlgorithmForPolicy(CacheStoragePolicy.cacheAndBackgroundUpdate)
        .execute(
          action,
          'product-1',
          expirationDuration: CacheStorageConsts.testValueExpirationDuration,
        );

    return data;
  }

  String _formatTimeDiff(Duration diff) {
    return '${diff.inSeconds}sec, ${diff.inMilliseconds}ms, ${diff.inMicroseconds}microsec';
  }
}
