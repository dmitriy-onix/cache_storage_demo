import 'package:cache_storage_demo/app/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[ReusableRouteFlow] designed to build nested flow with few screens
///with functionality to return to flow begin point.
///Usage: Extend yor Flow class with [ReusableRouteFlow]
///Example
///class KycFlow extends ReusableRouteFlow {
///
///   KycFlow(super.rootNavigatorKey);
///
///   @override
///   List<GoRoute> routes({
///     bool useRootNavigator = true,
///   }) =>
///       [
///         //flow routes here
///       ];
/// }
///
/// Declare Flow in AppRouter and
/// add to GoRouter top level routes from Flow also
/// ...yourFlow.routes()
///
abstract class ReusableRouteFlow {
  final GlobalKey<NavigatorState> rootNavigatorKey;
  String? _flowRedirect;
  Map<String, String>? _redirectParameters;
  Object? _redirectExtra;
  int _flowIndex = 0;

  ReusableRouteFlow(this.rootNavigatorKey);

  ///Starts Flow rom first screen in flow
  ///AppRouter.myFlow.startFlow(context)
  void startFlow(
    BuildContext context, {
    AppRoute? flowRedirect,
    Map<String, String>? redirectParameters,
    Object? redirectExtra,
  }) {
    if (flowRedirect != null) {
      _flowRedirect = flowRedirect.routePath;
      _redirectParameters = redirectParameters;
      _redirectExtra = redirectExtra;
    } else {
      _flowRedirect = _getRedirectToCurrentPath(context);
      _redirectParameters = _getRedirectToCurrentParameters(context);
      _redirectExtra = _getRedirectToCurrentExtra(context);
    }
    _flowIndex = 0;
    final flowEntry = routes().first.name;
    if (flowEntry == null) {
      throw Exception('Flow entry invalid');
    }
    context.pushNamed(flowEntry);
  }

  ///Navigates to next screen in Flow
  void next(
    BuildContext context, {
    Map<String, String>? parameters,
    Object? extra,
  }) {
    _flowIndex++;
    if (_flowIndex >= routes().length) {
      finishFlow(context);
      return;
    }
    final flowStep = routes()[_flowIndex].name;
    if (flowStep == null) {
      throw Exception('Next flow step invalid');
    }
    context.pushNamed(
      flowStep,
      pathParameters: parameters ?? {},
      extra: extra,
    );
  }

  ///Navigates to Previous screen in flow
  void previous(
    BuildContext context, {
    Object? result,
  }) {
    _flowIndex--;
    if (_flowIndex <= 0) {
      finishFlow(context);
      return;
    }
    context.pop(result);
  }

  ///Finish flow and go back to declared redirect location
  ///AppRouter.myFlow.finishFlow(context)
  ///
  void finishFlow(BuildContext context) {
    final flowRedirect = _flowRedirect;
    if (flowRedirect == null) {
      throw Exception('Flow entry invalid');
    }
    if (flowRedirect.contains('/')) {
      context.go(
        flowRedirect,
        extra: _redirectExtra,
      );
    } else {
      context.goNamed(
        flowRedirect,
        pathParameters: _redirectParameters ?? {},
        extra: _redirectExtra,
      );
    }
    _flowRedirect = null;
    _redirectParameters = null;
    _redirectExtra = null;
    _flowIndex = 0;
  }

  @protected
  List<GoRoute> routes({
    bool useRootNavigator = true,
  });

  String _getRedirectToCurrentPath(BuildContext context) {
    final router = GoRouter.maybeOf(context);
    if (router == null) {
      throw Exception('GoRouter not found');
    }
    return router.routerDelegate.currentConfiguration.fullPath;
  }

  Map<String, String> _getRedirectToCurrentParameters(BuildContext context) {
    final router = GoRouter.maybeOf(context);
    if (router == null) {
      throw Exception('GoRouter not found');
    }
    return router.routerDelegate.currentConfiguration.pathParameters;
  }

  Object? _getRedirectToCurrentExtra(BuildContext context) {
    final router = GoRouter.maybeOf(context);
    if (router == null) {
      throw Exception('GoRouter not found');
    }
    return router.routerDelegate.currentConfiguration.extra;
  }
}
