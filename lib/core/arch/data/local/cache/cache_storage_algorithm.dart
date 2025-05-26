import 'dart:async';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class CacheStorageAlgorithm<T> {
  final CacheStorage<T> _storage;

  const CacheStorageAlgorithm({required CacheStorage<T> storage})
      : _storage = storage;

  static CacheStorageAlgorithm<T> fromPolicy<T>({
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

  Future<Result<T>> execute(
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

class _CachePreferablyAlgorithm<T> extends CacheStorageAlgorithm<T> {
  const _CachePreferablyAlgorithm({required super.storage});

  @override
  Future<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) async {
    try {
      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );

      if (cache.isOk) return cache;

      final networkResult = await action();

      if (networkResult.isOk) {
        await _safeCache(key, networkResult.data);
      }

      return networkResult;
    } catch (e, s) {
      return Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}

class _CacheOnlyAlgorithm<T> extends CacheStorageAlgorithm<T> {
  const _CacheOnlyAlgorithm({required super.storage});

  @override
  Future<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) async {
    try {
      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );
      return cache;
    } catch (e, s) {
      return Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}

class _NetworkPreferablyAlgorithm<T> extends CacheStorageAlgorithm<T> {
  const _NetworkPreferablyAlgorithm({required super.storage});

  @override
  Future<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) async {
    try {
      final networkResult = await action();

      if (networkResult.isOk) {
        await _safeCache(key, networkResult.data);
        return networkResult;
      }

      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );

      if (cache.isOk) return cache;

      return networkResult;
    } catch (e, s) {
      return Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}

class _CacheAndBackgroundUpdateAlgorithm<T> extends CacheStorageAlgorithm<T> {
  const _CacheAndBackgroundUpdateAlgorithm({required super.storage});

  @override
  Future<Result<T>> execute(
    Future<Result<T>> Function() action,
    String key, {
    Duration? expirationDuration,
  }) async {
    final cachedData = await _storage.get(
      key,
      expirationDuration: expirationDuration,
    );

    if (cachedData.isOk) {
      unawaited(_backgroundUpdateFuture(action, key));
      return cachedData;
    } else {
      final networkResult = await _backgroundUpdateFuture(action, key);
      return networkResult;
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
