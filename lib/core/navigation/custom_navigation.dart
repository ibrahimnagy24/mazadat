import 'package:flutter/material.dart';
import '../utils/utility.dart';
import 'app_router.dart';

/// CustomNavigator provides a backwards-compatible navigation interface that uses go_router internally
abstract class CustomNavigator {
  /// Global key for the app's navigator state
  static final GlobalKey<NavigatorState> navigatorState = navigatorKey;

  /// Current context from the navigator state
  static BuildContext get context => navigatorState.currentContext!;

  /// Route observer for analytics or other navigation tracking
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  /// Global key for scaffold messenger state
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();

  /// Global key for scaffold state
  static final GlobalKey<ScaffoldState> scaffoldState =
      GlobalKey<ScaffoldState>();

  /// Navigate back from the current screen
  static pop({dynamic result}) {
    if (appRouter.canPop()) {
      appRouter.pop(result);
    }
  }

  /// Navigate to a new screen
  ///
  /// [routeName] The name of the route to navigate to
  /// [pathParameters] Optional path parameters to include in the route path (e.g., {'id': '123'})
  /// [queryParameters] Optional query parameters to append to the route URL (e.g., {'sort': 'asc'})
  /// [extra] Optional extra data to pass to the route (not included in the URL)
  /// [replace] Whether to replace the current route
  /// [clean] Whether to remove all routes and navigate to this route
  static Future<Object?> push(
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    dynamic extra,
    bool replace = false,
    bool clean = false,
  }) {
    cprint('Route==> $routeName');

    if (clean == true) {
      appRouter.goNamed(
        routeName,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
        extra: extra,
      );
      return Future.value(null);
    }

    if (replace == true) {
      appRouter.replaceNamed(
        routeName,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {},
        extra: extra,
      );
      return Future.value(null);
    }

    return appRouter.pushNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  /// This method is kept for backwards compatibility with the app.dart file
  /// It shouldn't be used in new code
  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    // This is a stub that should never be called but needs to exist
    // for backwards compatibility
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('This route is not supported anymore')),
      ),
    );
  }
}

class OtpParams {
  final String phone;
  final bool isFromRegistration;
  final bool isUserLogin;
  final bool isForgetPassword;

  OtpParams({
    required this.phone,
    required this.isFromRegistration,
    required this.isUserLogin,
    required this.isForgetPassword,
  });
}
