import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm.dart';
import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm_stream.dart';

abstract class CacheAlgorithmFactory<T> {
  const CacheAlgorithmFactory();

  CacheStorageAlgorithm<T> createAlgorithm(CacheStorage<T> storage);

  CacheStorageAlgorithmStream<T> createStreamAlgorithm(CacheStorage<T> storage);
}
