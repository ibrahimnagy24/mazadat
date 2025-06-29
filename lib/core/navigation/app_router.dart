import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app.dart';
import '../../features/auth/change_password/data/params/change_password_route_params.dart';
import '../../features/auth/change_password/ui/widgets/change_password_imports.dart';
import '../../features/auth/change_password_success/widgets/change_password_success_imports.dart';
import '../../features/auth/change_phone_number/ui/widgets/change_phone_number_imports.dart';
import '../../features/auth/choose_category/ui/screens/choose_categories_screen.dart';
import '../../features/auth/login/ui/widgets/login_imports.dart';
import '../../features/auth/register/ui/widgets/register_imports.dart';
import '../../features/auth/reset_password/ui/widgets/reset_password_imports.dart';
import '../../features/auth/verify_code/data/params/verify_code_route_params.dart';
import '../../features/auth/verify_code/ui/widgets/verify_code_imports.dart';
import '../../features/home/ui/pages/home_screen.dart';
import '../../features/nav_layout/pages/custom_navbar_layout_screen.dart';
import '../../features/splash/splash.dart';
import '../../features/static_pages/data/params/static_page_params.dart';
import '../../features/static_pages/ui/pages/static_pages_screen.dart';
import '../../features/view_auction/data/params/view_auction_route_params.dart';
import '../../features/view_auction/ui/pages/view_auction_screen.dart';
import '../../features/visitor/ui/pages/visitor_screen.dart';
import '../utils/widgets/misc/zoom_image.dart';
import 'routes.dart';

/// Global key for navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Router configuration for the app
final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    // App route (typically not needed with go_router but kept for compatibility)
    GoRoute(
      path: '/app',
      name: Routes.APP,
      builder: (context, state) => const MyApp(),
    ),

    // Splash screen
    GoRoute(
      path: '/splash',
      name: Routes.SPLASH,
      builder: (context, state) => const SplashScreen(),
    ),

    // Authentication routes
    GoRoute(
      path: '/login',
      name: Routes.LOGIN_SCREEN,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: Routes.REGISTER_SCREEN,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/choose-category',
      name: Routes.CHOOSE_FAV_CATEGORY,
      builder: (context, state) => const ChooseCategoriesScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      name: Routes.RESET_PASSWORD_SCREEN,
      builder: (context, state) => const ResetPasswordScreen(),
    ),

    GoRoute(
      path: '/change-phone-number',
      name: Routes.CHANGE_PHONE_NUMBER_SCREEN,
      builder: (context, state) => const ChangePhoneNumberScreen(),
    ),

    GoRoute(
      path: '/verify-code',
      name: Routes.VERIFY_CODE_SCREEN,
      builder: (context, state) {
        final verifyCodeRouteParams = state.extra as VerifyCodeRouteParams;
        return VerifyCodeScreen(verifyCodeRouteParams: verifyCodeRouteParams);
      },
    ),
    GoRoute(
      path: '/change-password',
      name: Routes.CHANGE_PASSWORD_SCREEN,
      builder: (context, state) {
        final routeParams = state.extra as ChangePasswordRouteParams;
        return ChangePasswordScreen(routeParams: routeParams);
      },
    ),
    GoRoute(
      path: '/change-password-success',
      name: Routes.CHANGE_PASSWORD_SUCCESS_SCREEN,
      builder: (context, state) => const ChangePasswordSuccessScreen(),
    ),

    // Home routes
    GoRoute(
      path: '/home',
      name: Routes.CUSTOM_HOME,
      builder: (context, state) => const HomeScreen(),
    ),

    // More routes
    GoRoute(
      path: '/static-page',
      name: Routes.STATIC_PAGE,
      builder: (context, state) {
        final params = state.extra as StaticPageParams;
        return StaticPageScreen(params: params);
      },
    ),

    // Misc routes
    GoRoute(
      path: '/nav-bar-layout',
      name: Routes.NAV_BAR_LAYOUT,
      builder: (context, state) => const CustomNavbarLayoutScreen(),
    ),
    GoRoute(
      path: '/zoom-image',
      name: Routes.ZOOM_IN_IMAGE,
      builder: (context, state) {
        final urlImage = state.extra as String;
        return ZoomImageScreen(urlImage: urlImage);
      },
    ),
    GoRoute(
      path: '/view-auction',
      name: Routes.VIEW_AUCTION,
      builder: (context, state) {
        final params = state.extra == null
            ? const ViewAuctionRouteParams(auctionId: '')
            : (state.extra as ViewAuctionRouteParams);
        return ViewAuctionScreen(routeParams: params);
      },
    ),
    GoRoute(
      path: '/test',
      name: Routes.TEST_SCREEN,
      builder: (context, state) => const VisitorScreen(),
    ),

    // Not Found route
    GoRoute(
      path: '/not-found',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    ),
  ],

  // Error handling
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);
