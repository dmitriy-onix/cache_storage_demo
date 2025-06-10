//@formatter:off

import 'package:cache_storage_demo/data/source/remote/product_api_source.dart';
import 'package:get_it/get_it.dart';

//{imports end}

void registerSources(GetIt getIt) {
  getIt.registerSingleton<ProductApiSource>(ProductApiSource());
  //{sources end}
}
