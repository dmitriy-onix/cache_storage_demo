import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_models.freezed.dart';

@freezed
sealed class MainScreenEvent with _$MainScreenEvent {
  const factory MainScreenEvent.hiveCall() = MainScreenEventHiveCall;

  const factory MainScreenEvent.hiveNoJsonCall() =
      MainScreenEventHiveNoJsonCall;

  const factory MainScreenEvent.objectBoxCall() = MainScreenEventObjectBoxCall;

  const factory MainScreenEvent.sembastCall() = MainScreenEventSembastCall;

  const factory MainScreenEvent.driftCall() = MainScreenEventDriftCall;

  const factory MainScreenEvent.floorCall() = MainScreenEventFloorCall;

  const factory MainScreenEvent.realmCall() = MainScreenEventRealmCall;

  const factory MainScreenEvent.realmVNCall() = MainScreenEventRealmVNCall;
}

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    @Default('') String hive,
    @Default('') String hiveNoJson,
    @Default('') String objectBox,
    @Default('') String sembast,
    @Default('') String drift,
    @Default('') String floor,
    @Default('') String realm,
    @Default('') String realmVN,
  }) = _MainScreenState;
}

@freezed
sealed class MainScreenSR with _$MainScreenSR {
  const factory MainScreenSR.loadFinished() = LoadFinished;
}
