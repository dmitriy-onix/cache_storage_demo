import 'dart:async';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class CacheStorageAlgorithmStream<T> {
  final CacheStorage<T> _storage;

  const CacheStorageAlgorithmStream({
    required CacheStorage<T> storage,
  }) : _storage = storage;

  static CacheStorageAlgorithmStream<T> fromPolicy<T>({
    required CacheStorage<T> cacheStorage,
    required CacheStoragePolicy policy,
  }) {
    return switch (policy) {
      CacheStoragePolicy.networkPreferably =>
        _NetworkPreferablyAlgorithmStream(storage: cacheStorage),
      CacheStoragePolicy.cachePreferably =>
        _CachePreferablyAlgorithmStream(storage: cacheStorage),
      CacheStoragePolicy.cacheAndBackgroundUpdate =>
        _CacheAndBackgroundUpdateAlgorithm(storage: cacheStorage),
    };
  }

  Stream<Result<T>> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  });

  Future<void> _safeCache(String key, T value) async {
    try {
      await _storage.save(key, value);
    } catch (error, stackTrace) {
      logger.e(
        '$runtimeType._safeCacheSave() failed for key $key',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

class _CachePreferablyAlgorithmStream<T>
    extends CacheStorageAlgorithmStream<T> {
  const _CachePreferablyAlgorithmStream({required super.storage});

  @override
  Stream<Result<T>> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  }) {
    final controller = StreamController<Result<T>>();

    controller.onListen = () async {
      try {
        final cacheResult = await _storage.get(
          key,
          expirationDuration: expirationDuration,
        );

        if (cacheResult.isOk) {
          controller.add(cacheResult);
          await controller.close();
          return;
        }

        logger.i(
          '_CachePreferablyAlgorithmStream: Cache miss/error for key "$key", trying network for stream.',
        );
        final networkResult = await sourceAction();
        controller.add(networkResult);

        if (networkResult.isOk) {
          await _safeCache(key, networkResult.data);
        }
      } catch (e, s) {
        controller.add(Result.error(error: CacheStorageUndefinedFailure(e, s)));
      } finally {
        if (!controller.isClosed) {
          await controller.close();
        }
      }
    };
    return controller.stream;
  }
}

class _NetworkPreferablyAlgorithmStream<T>
    extends CacheStorageAlgorithmStream<T> {
  const _NetworkPreferablyAlgorithmStream({required super.storage});

  @override
  Stream<Result<T>> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  }) {
    final controller = StreamController<Result<T>>();

    controller.onListen = () async {
      try {
        final networkResult = await sourceAction();

        if (networkResult.isOk) {
          controller.add(networkResult);
          await _safeCache(key, networkResult.data);
          await controller.close();
          return;
        }

        logger.i(
          '_NetworkPreferablyAlgorithmStream: Network action failed for key "$key", trying cache',
        );

        final cacheResult = await _storage.get(
          key,
          expirationDuration: expirationDuration,
        );

        if (cacheResult.isOk) {
          controller.add(cacheResult);
        } else {
          controller.add(networkResult);
        }
        await controller.close();
      } catch (e, s) {
        controller.add(Result.error(error: CacheStorageUndefinedFailure(e, s)));
      } finally {
        if (!controller.isClosed) {
          await controller.close();
        }
      }
    };
    return controller.stream;
  }
}

class _CacheAndBackgroundUpdateAlgorithm<T>
    extends CacheStorageAlgorithmStream<T> {
  const _CacheAndBackgroundUpdateAlgorithm({required super.storage});

  @override
  Stream<Result<T>> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  }) {
    final controller = StreamController<Result<T>>();

    controller.onListen = () async {
      try {
        await _performOperation(
            controller, key, expirationDuration, sourceAction);
      } catch (e, s) {
        controller.add(Result.error(error: CacheStorageUndefinedFailure(e, s)));
      } finally {
        if (!controller.isClosed) {
          await controller.close();
        }
      }
    };

    return controller.stream;
  }

  Future<void> _performOperation(
    StreamController<Result<T>> controller,
    String key,
    Duration? expirationDuration,
    Future<Result<T>> Function() sourceAction,
  ) async {
    final cachedData = await _storage.get(
      key,
      expirationDuration: expirationDuration,
    );

    if (cachedData.isOk) {
      controller.add(cachedData);

      await _backgroundFetchAndEmit(controller, sourceAction, key);
    } else {
      await _backgroundFetchAndEmit(controller, sourceAction, key);
    }

    await controller.close();
  }

  Future<void> _backgroundFetchAndEmit(
    StreamController<Result<T>> controller,
    Future<Result<T>> Function() sourceAction,
    String key,
  ) async {
    final networkResult = await _backgroundUpdateFuture(sourceAction, key);
    controller.add(networkResult);
  }

  Future<Result<T>> _backgroundUpdateFuture(
    Future<Result<T>> Function() sourceAction,
    String key,
  ) async {
    try {
      final freshNetworkResult = await sourceAction();

      if (freshNetworkResult.isOk) {
        await _safeCache(key, freshNetworkResult.data);
      }

      return freshNetworkResult;
    } catch (e, s) {
      return Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}
