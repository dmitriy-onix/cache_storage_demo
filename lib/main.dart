import 'dart:async';
import 'dart:io';

import 'package:cache_storage_demo/app/app.dart';
import 'package:cache_storage_demo/app/app_initialization.dart';
import 'package:cache_storage_demo/app/banned_app.dart';
import 'package:cache_storage_demo/app/util/extension/orientation_extension.dart';
import 'package:cache_storage_demo/core/arch/logger/app_logger_impl.dart';
import 'package:cache_storage_demo/core/di/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_flutter_bloc/onix_flutter_bloc.dart';

Future<void> main() async {
  unawaited(
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Initialization.I.initApp();

        await OrientationExtension.lockVertical();

        Bloc.observer = AppBlocObserver();
        final isAllowedToUseApp = await environmentService().initialize();
        if (isAllowedToUseApp) {
          runApp(const App());
        } else {
          runApp(const BannedApp());
        }
      },
      _onError,
    )?.catchError(
      (error, stackTrace) {
        _onError(error, stackTrace);
        exit(-1);
      },
    ),
  );
}

Future<void> _onError(dynamic error, dynamic stackTrace) async {
  logger.crash(error: error, stackTrace: stackTrace, reason: 'main');
}
