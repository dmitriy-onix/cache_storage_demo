import 'dart:async';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/data/source/local/cache/cache_storage_consts.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_drift_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_floor_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_hive_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_object_box_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_realm_cache_storage.dart';
import 'package:cache_storage_demo/data/source/local/cache/product_sembast_cache_storage.dart';
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
    on<MainScreenEventIsarCall>(_onIsarCall);
    on<MainScreenEventObjectBoxCall>(_onObjectBoxCall);
    on<MainScreenEventEmitObjectBoxStreamResult>(_onObjectBoxStreamResult);
    on<MainScreenEventSembastCall>(_onSembastCall);
    on<MainScreenEventDriftCall>(_onDriftCall);
    on<MainScreenEventFloorCall>(_onFloorCall);
    on<MainScreenEventRealmCall>(_onRealmCall);
  }

  final _hiveCacheStorage = GetIt.I.get<ProductHiveCacheStorage>();
  final _objectBoxCacheStorage = GetIt.I.get<ProductObjectBoxCacheStorage>();
  final _sembastCacheStorage = GetIt.I.get<ProductSembastCacheStorage>();
  final _driftCacheStorage = GetIt.I.get<ProductDriftCacheStorage>();
  final _floorCacheStorage = GetIt.I.get<ProductFloorCacheStorage>();
  final _realmCacheStorage = GetIt.I.get<ProductRealmCacheStorage>();

  // final _isarCacheStorage = GetIt.I.get<ProductIsarCacheStorage>();

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

  StreamSubscription<Result<ProductEntity>>? _streamSubscription;

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

    _streamSubscription = stream.listen((data) {
      final duration  = stopWatch.elapsed;
      logger.i('objectBox data: ${data.data}, call time: $duration');
      add(MainScreenEvent.emitObjectBoxStreamResult(duration));
    });

    /*final startTime = DateTime.now();

    final data = await _onCallDB(_objectBoxCacheStorage, _getProductAction);

    final endTime = DateTime.now();
    final timeDiff = endTime.difference(startTime);

    logger.i('objectBox data: ${data.data}, call time: $timeDiff');

    emit(state.copyWith(objectBox: _formatTimeDiff(timeDiff)));*/
  }

  Future<void> _onObjectBoxStreamResult(
    MainScreenEventEmitObjectBoxStreamResult event,
    Emitter<MainScreenState> emit,
  ) async {
    final duration = event.duration;
    emit(state.copyWith(objectBox: _formatTimeDiff(duration)));
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

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
