import 'package:cache_storage_demo/core/di/app.dart';
import 'package:cache_storage_demo/core/di/bloc.dart';
import 'package:cache_storage_demo/core/di/local.dart';
import 'package:cache_storage_demo/core/di/remote.dart';
import 'package:cache_storage_demo/core/di/repository.dart';
import 'package:cache_storage_demo/core/di/services.dart';
import 'package:cache_storage_demo/core/di/source.dart';
import 'package:cache_storage_demo/core/di/usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> initializeDi(GetIt getIt) async {
  await registerLocal(getIt);
  registerCoreServices(getIt);
  registerRemote(getIt);
  registerSources(getIt);
  registerRepositories(getIt);
  registerApp(getIt);
  registerAppServices(getIt);
  registerUseCases(getIt);
  registerBloc(getIt);
}
