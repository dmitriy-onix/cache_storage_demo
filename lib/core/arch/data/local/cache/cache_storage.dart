import 'package:cache_storage_demo/core/arch/data/local/cache/cache_algorithm_factory.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm_stream.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm_value_notifier.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/default_cache_algorithm_factory.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class CacheStorage<T> {
  const CacheStorage();

  CacheStorageAlgorithm<T> cachingAlgorithmForPolicy(
    CacheStoragePolicy policy,
  ) {
    return createAlgorithmWithFactory(DefaultCacheAlgorithmFactory<T>(policy));
  }

  CacheStorageAlgorithmStream<T> cachingAlgorithmForPolicyStream(
    CacheStoragePolicy policy,
  ) {
    return createAlgorithmStreamWithFactory(
      DefaultCacheAlgorithmFactory<T>(policy),
    );
  }

  CacheStorageAlgorithm<T> createAlgorithmWithFactory(
    CacheAlgorithmFactory<T> factory,
  ) {
    return factory.createAlgorithm(this);
  }

  CacheStorageAlgorithmStream<T> createAlgorithmStreamWithFactory(
    CacheAlgorithmFactory<T> factory,
  ) {
    return factory.createStreamAlgorithm(this);
  }

  CacheStorageAlgorithmValueNotifier<T> cachingAlgorithmForPolicyValueNotifier(
    CacheStoragePolicy policy,
  ) {
    return createAlgorithmValueNotifierWithFactory(
      DefaultCacheAlgorithmFactory<T>(policy),
    );
  }

  CacheStorageAlgorithmValueNotifier<T> createAlgorithmValueNotifierWithFactory(
    CacheAlgorithmFactory<T> factory,
  ) {
    return factory.createValueNotifierAlgorithm(this);
  }

  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  });

  Future<void> save(String key, T value);

  Future<void> delete(String key);

  Future<void> clear();
}
