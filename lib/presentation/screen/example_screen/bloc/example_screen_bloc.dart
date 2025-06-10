import 'dart:async';

import 'package:cache_storage_demo/core/arch/data/local/cache/cache_storage_algorithm_value_notifier.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:cache_storage_demo/domain/usecase/get_product_use_case.dart';
import 'package:cache_storage_demo/presentation/screen/example_screen/bloc/example_screen_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_flutter_bloc/onix_flutter_bloc.dart';

class ExampleScreenBloc
    extends BaseBloc<ExampleScreenEvent, ExampleScreenState, ExampleScreenSR> {
  CacheStorageAlgorithmValueNotifier<ProductEntity>? realmCacheStorageNotifier;

  final GetProductUseCase _getProductUseCase;

  ExampleScreenBloc({
    required GetProductUseCase getProductUseCase,
  })  : _getProductUseCase = getProductUseCase,
        super(const ExampleScreenState()) {
    on<ExampleScreenHiveCallEvent>(_onHiveCall);
  }

  Future<void> _onHiveCall(
    ExampleScreenHiveCallEvent event,
    Emitter<ExampleScreenState> emit,
  ) async {
    final stopWatch = Stopwatch()..start();

    final result = await _getProductUseCase();

    final duration = stopWatch.elapsed;

    if(result.isOk) {
      logger.i('hive data: ${result.data}, call time: $duration');

      emit(
        state.copyWith(
          hive: _formatTimeDiff(duration),
          product: result.data,
        ),
      );
    }

    if (result.isError) {
      onFailure(result.asError.error);
    }

    if (stopWatch.isRunning) {
      stopWatch.stop();
    }
  }

  String _formatTimeDiff(Duration diff) {
    return '${diff.inSeconds}sec, ${diff.inMilliseconds}ms, ${diff.inMicroseconds}microsec';
  }

  @override
  void dispose() {
    realmCacheStorageNotifier?.dispose();
    super.dispose();
  }
}
