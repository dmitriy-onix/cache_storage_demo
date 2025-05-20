//@formatter:off

import 'package:cache_storage_demo/app/router/app_route.dart';
import 'package:cache_storage_demo/core/di/services.dart';
import 'package:cache_storage_demo/presentation/screen/main_screen/main_screen.dart';
import 'package:go_router/go_router.dart';

//{imports end}

class AppRouter {
  static const _initialLocation = '/main';

  static final AppRouter _instance = AppRouter._privateConstructor();
  static late GoRouter router;

  AppRouter._privateConstructor() {
    _initialize();
  }

  factory AppRouter.init() {
    return _instance;
  }

  void _initialize({String initialLocation = _initialLocation}) {
    router = GoRouter(
      initialLocation: initialLocation,
      refreshListenable: sessionService(),
      redirect: (context, state) {
        return null;
      },
      routes: <GoRoute>[
        GoRoute(
          path: AppRoute.main.routePath,
          name: AppRoute.main.name,
          builder: (context, state) => const MainScreen(),
        ), //{routes end}
      ],
    );
  }
}
