//@formatter:off

import 'package:cache_storage_demo/app/service/app_service.dart';
import 'package:cache_storage_demo/app/service/session_service/session_service.dart';
import 'package:get_it/get_it.dart';

void registerCoreServices(GetIt getIt) {
  getIt
    ..registerSingleton<SessionService>(SessionService())
    ..registerSingleton<AppService>(AppService());
}

void registerAppServices(GetIt getIt) {}

SessionService sessionService() => GetIt.I.get<SessionService>();

AppService environmentService() => GetIt.I.get<AppService>();
