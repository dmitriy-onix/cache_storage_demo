import 'dart:async';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/domain/entity/failure/db_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class CacheStorageAlgorithmValueNotifier<T> {
  final CacheStorage<T> _storage;

  final ValueNotifier<Result<T>?> resultNotifier;

  CacheStorageAlgorithmValueNotifier({required CacheStorage<T> storage})
      : _storage = storage,
        resultNotifier = ValueNotifier<Result<T>?>(null);

  Future<void> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  });

  static CacheStorageAlgorithmValueNotifier<T> fromPolicy<T>({
    required CacheStorage<T> cacheStorage,
    required CacheStoragePolicy policy,
  }) {
    return switch (policy) {
      CacheStoragePolicy.networkPreferably =>
        _NetworkPreferablyAlgorithmChangeNotifier(storage: cacheStorage),
      CacheStoragePolicy.cachePreferably =>
        _CachePreferablyAlgorithmChangeNotifier(storage: cacheStorage),
      CacheStoragePolicy.cacheOnly =>
        _CacheOnlyAlgorithmChangeNotifier(storage: cacheStorage),
      CacheStoragePolicy.cacheAndBackgroundUpdate =>
        _CacheAndBackgroundUpdateAlgorithmChangeNotifier(storage: cacheStorage),
    };
  }

  Future<void> _safeCache(String key, T value) async {
    try {
      await _storage.save(key, value);
    } catch (error, stackTrace) {
      logger.e(
        '$runtimeType._safeCache() failed for key $key',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void dispose() {
    resultNotifier.dispose();
  }
}

class _CachePreferablyAlgorithmChangeNotifier<T>
    extends CacheStorageAlgorithmValueNotifier<T> {
  _CachePreferablyAlgorithmChangeNotifier({required super.storage});

  @override
  Future<void> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  }) async {
    try {
      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );

      if (cache.isOk) {
        resultNotifier.value = cache;
        return;
      }

      final networkResult = await sourceAction();
      resultNotifier.value = networkResult;

      if (networkResult.isOk) {
        await _safeCache(key, networkResult.data);
      }
    } catch (e, s) {
      resultNotifier.value =
          Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}

class _CacheOnlyAlgorithmChangeNotifier<T>
    extends CacheStorageAlgorithmValueNotifier<T> {
  _CacheOnlyAlgorithmChangeNotifier({required super.storage});

  @override
  Future<void> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  }) async {
    try {
      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );
      resultNotifier.value = cache;
    } catch (e, s) {
      resultNotifier.value =
          Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}

class _NetworkPreferablyAlgorithmChangeNotifier<T>
    extends CacheStorageAlgorithmValueNotifier<T> {
  _NetworkPreferablyAlgorithmChangeNotifier({required super.storage});

  @override
  Future<void> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  }) async {
    try {
      final networkResult = await sourceAction();

      if (networkResult.isOk) {
        resultNotifier.value = networkResult;
        await _safeCache(key, networkResult.data);
        return;
      }

      final cache = await _storage.get(
        key,
        expirationDuration: expirationDuration,
      );

      if (cache.isOk) {
        resultNotifier.value = cache;
      } else {
        resultNotifier.value = networkResult;
      }
    } catch (e, s) {
      resultNotifier.value =
          Result.error(error: CacheStorageUndefinedFailure(e, s));
    }
  }
}

class _CacheAndBackgroundUpdateAlgorithmChangeNotifier<T>
    extends CacheStorageAlgorithmValueNotifier<T> {
  _CacheAndBackgroundUpdateAlgorithmChangeNotifier({required super.storage});

  @override
  Future<void> execute({
    required Future<Result<T>> Function() sourceAction,
    required String key,
    Duration? expirationDuration,
  }) async {
    final cachedData = await _storage.get(
      key,
      expirationDuration: expirationDuration,
    );

    if (cachedData.isOk) {
      resultNotifier.value = cachedData;
    }

    try {
      final freshNetworkResult = await sourceAction();
      resultNotifier.value = freshNetworkResult;

      if (freshNetworkResult.isOk) {
        await _safeCache(key, freshNetworkResult.data);
      }
    } catch (e, s) {
      if (resultNotifier.value == null || resultNotifier.value!.isError) {
        resultNotifier.value =
            Result.error(error: CacheStorageUndefinedFailure(e, s));
      } else {
        logger.w(
          '$runtimeType: Background update failed for key $key, keeping stale cache data. Error: $e',
        );
      }
    }
  }
}
