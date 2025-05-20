import 'dart:async';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class CacheStorageAlgorithmStream<T> {
  final CacheStorage<T> _storage;

  const CacheStorageAlgorithmStream({required CacheStorage<T> storage})
      : _storage = storage;

  static CacheStorageAlgorithmStream<T> fromPolicy<T>({
    required CacheStorage<T> cacheStorage,
    CacheStoragePolicy policy = CacheStoragePolicy.networkPreferably,
  }) =>
      switch (policy) {
        CacheStoragePolicy.networkPreferably =>
          _NetworkPreferablyAlgorithm(storage: cacheStorage),
        CacheStoragePolicy.cachePreferably =>
          _CachePreferablyAlgorithm(storage: cacheStorage),
        CacheStoragePolicy.cacheOnly =>
          _CacheOnlyAlgorithm(storage: cacheStorage),
        CacheStoragePolicy.cacheAndBackgroundUpdate =>
          _CacheAndBackgroundUpdateAlgorithm(storage: cacheStorage),
      };

  Stream<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  });

  Future<void> _safeCache(String key, T value) async {
    try {
      await _storage.save(key, value);
    } catch (error, stackTrace) {
      logger.e(
        '$runtimeType._safeCache()',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

class _CachePreferablyAlgorithm<T> extends CacheStorageAlgorithmStream<T> {
  const _CachePreferablyAlgorithm({required super.storage});

  @override
  Stream<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) {
    final controller = StreamController<Result<T>>();

    _performOperation(controller, key, expirationDuration, action);

    return controller.stream;
  }

  Future<void> _performOperation(
    StreamController<Result<T>> controller,
    String key,
    Duration? expirationDuration,
    Future<Result<T>> Function() action,
  ) async {
    try {
      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );

      if (cache.isOk) {
        controller.add(cache);
      }

      final networkResult = await action();

      if (networkResult.isOk) {
        await _safeCache(key, networkResult.data);
      }
      controller.add(networkResult);
    } catch (e, s) {
      controller.add(Result.error(error: CacheStorageUndefinedFailure(e, s)));
    } finally {
      await controller.close();
    }
  }
}

class _CacheOnlyAlgorithm<T> extends CacheStorageAlgorithmStream<T> {
  const _CacheOnlyAlgorithm({required super.storage});

  @override
  Stream<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) {
    final controller = StreamController<Result<T>>();

    _performOperation(controller, key, expirationDuration);

    return controller.stream;
  }

  Future<void> _performOperation(
    StreamController<Result<T>> controller,
    String key,
    Duration? expirationDuration,
  ) async {
    try {
      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );
      controller.add(cache);
    } catch (e, s) {
      controller.add(Result.error(error: CacheStorageUndefinedFailure(e, s)));
    } finally {
      await controller.close();
    }
  }
}

class _NetworkPreferablyAlgorithm<T> extends CacheStorageAlgorithmStream<T> {
  const _NetworkPreferablyAlgorithm({required super.storage});

  @override
  Stream<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) {
    final controller = StreamController<Result<T>>();

    _performOperation(controller, key, expirationDuration, action);

    return controller.stream;
  }

  Future<void> _performOperation(
    StreamController<Result<T>> controller,
    String key,
    Duration? expirationDuration,
    Future<Result<T>> Function() action,
  ) async {
    try {
      final networkResult = await action();

      if (networkResult.isOk) {
        await _safeCache(key, networkResult.data);
        controller.add(networkResult);
      } else {
        final cache = await _storage.get(
          key,
          expirationDuration: expirationDuration,
        );

        if (cache.isOk) {
          controller.add(cache);
        } else {
          controller.add(networkResult);
        }
      }
    } catch (e, s) {
      controller.add(Result.error(error: CacheStorageUndefinedFailure(e, s)));
    } finally {
      await controller.close();
    }
  }
}

class _CacheAndBackgroundUpdateAlgorithm<T>
    extends CacheStorageAlgorithmStream<T> {
  const _CacheAndBackgroundUpdateAlgorithm({required super.storage});

  @override
  Stream<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) {
    final controller = StreamController<Result<T>>();

    _performOperation(controller, key, expirationDuration, action);

    return controller.stream;
  }

  Future<void> _performOperation(
    StreamController<Result<T>> controller,
    String key,
    Duration? expirationDuration,
    Future<Result<T>> Function() action,
  ) async {
    final cachedData = await _storage.get(
      key,
      expirationDuration: expirationDuration,
    );

    if (cachedData.isOk) {
      controller.add(cachedData);

      unawaited(
        _backgroundUpdateFuture(action, key).then((result) {
          controller
            ..add(result)
            ..close();
        }),
      );
    } else {
      final networkResult = await _backgroundUpdateFuture(action, key);
      controller.add(networkResult);
      await controller.close();
    }
  }

  Future<Result<T>> _backgroundUpdateFuture(
    Future<Result<T>> Function() action,
    String key,
  ) async {
    try {
      final freshNetworkResult = await action();

      if (freshNetworkResult.isOk) {
        await _safeCache(key, freshNetworkResult.data);
      }

      return freshNetworkResult;
    } catch (e, s) {
      return Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}
