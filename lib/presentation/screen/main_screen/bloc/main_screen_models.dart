import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_models.freezed.dart';

@freezed
sealed class MainScreenEvent with _$MainScreenEvent {
  const factory MainScreenEvent.isarCall() = MainScreenEventIsarCall;

  const factory MainScreenEvent.hiveCall() = MainScreenEventHiveCall;

  const factory MainScreenEvent.objectBoxCall() = MainScreenEventObjectBoxCall;

  const factory MainScreenEvent.emitObjectBoxStreamResult(Duration duration) =
      MainScreenEventEmitObjectBoxStreamResult;

  const factory MainScreenEvent.sembastCall() = MainScreenEventSembastCall;

  const factory MainScreenEvent.driftCall() = MainScreenEventDriftCall;

  const factory MainScreenEvent.floorCall() = MainScreenEventFloorCall;

  const factory MainScreenEvent.realmCall() = MainScreenEventRealmCall;
}

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    @Default('') String isar,
    @Default('') String hive,
    @Default('') String objectBox,
    @Default('') String sembast,
    @Default('') String drift,
    @Default('') String floor,
    @Default('') String realm,
  }) = _MainScreenState;
}

@freezed
sealed class MainScreenSR with _$MainScreenSR {
  const factory MainScreenSR.loadFinished() = LoadFinished;
}
