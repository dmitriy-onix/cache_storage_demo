import 'package:cache_storage_demo/core/arch/data/local/cache/cache_algorithm_factory.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm_stream.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_policy.dart';

class DefaultCacheAlgorithmFactory<T> implements CacheAlgorithmFactory<T> {
  final CacheStoragePolicy policy;

  const DefaultCacheAlgorithmFactory(this.policy);

  @override
  CacheStorageAlgorithm<T> createAlgorithm(CacheStorage<T> storage) {
    return CacheStorageAlgorithm.fromPolicy(
      cacheStorage: storage,
      policy: policy,
    );
  }

  @override
  CacheStorageAlgorithmStream<T> createStreamAlgorithm(
    CacheStorage<T> storage,
  ) {
    return CacheStorageAlgorithmStream.fromPolicy(
      cacheStorage: storage,
      policy: policy,
    );
  }
}
