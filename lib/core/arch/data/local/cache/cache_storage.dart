import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm_stream.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class CacheStorage<T> {
  const CacheStorage();

  CacheStorageAlgorithm<T> cachingAlgorithmForPolicy(
    CacheStoragePolicy policy,
  ) {
    return CacheStorageAlgorithm.fromPolicy(
      cacheStorage: this,
      policy: policy,
    );
  }

  CacheStorageAlgorithmStream<T> cachingAlgorithmForPolicyStream(
    CacheStoragePolicy policy,
  ) {
    return CacheStorageAlgorithmStream.fromPolicy(
      cacheStorage: this,
      policy: policy,
    );
  }

  Future<Result<T>> get(
    String key, {
    Duration? expirationDuration,
  });

  Future<void> save(String key, T value);

  Future<void> delete(String key);

  Future<void> clear();
}
