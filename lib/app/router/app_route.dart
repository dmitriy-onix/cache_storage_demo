import 'package:cache_storage_demo/app/router/app_route_location.dart';

enum AppRoute {
  main('/main'),
  example('/example');
//{routes declaration end}

  final String routePath;
  final AppRouteLocation location;

  const AppRoute(
    this.routePath, {
    this.location = AppRouteLocation.securedApp,
  });

  static AppRoute? fromName(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return AppRoute.values.firstWhere((e) => e.name == value);
  }

  static AppRoute? fromRoutePath(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return AppRoute.values.firstWhere((e) => e.routePath == value);
  }
}
