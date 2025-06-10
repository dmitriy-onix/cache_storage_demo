import 'package:cache_storage_demo/domain/entity/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_screen_models.freezed.dart';

@freezed
sealed class ExampleScreenEvent with _$ExampleScreenEvent {
  const factory ExampleScreenEvent.hiveCall() = ExampleScreenHiveCallEvent;
}

@freezed
class ExampleScreenState with _$ExampleScreenState {
  const factory ExampleScreenState({
    @Default('') String hive,
    ProductEntity? product,
  }) = _ExampleScreenState;
}

@freezed
sealed class ExampleScreenSR with _$ExampleScreenSR {
  const factory ExampleScreenSR.loadFinished() = LoadFinished;
}
