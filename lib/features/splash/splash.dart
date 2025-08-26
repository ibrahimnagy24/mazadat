import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/assets/app_launchers.dart';
import '../../core/navigation/custom_navigation.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils/extensions/media_query_helper.dart';
import '../../core/utils/utility.dart';
import '../../core/utils/widgets/misc/default_network_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQueryHelper.height,
          width: MediaQueryHelper.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(64, 77, 38, 1),
                Color.fromRGBO(24, 28, 16, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const DefaultNetworkImage(
            AppLaunchers.logo,
            height: 95,
            width: 130,
            fit: BoxFit.contain,
          )
              .animate(
                onComplete: (controller) async {
                  if (Utility.isUserLoggedIn()) {
                    CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
                    return;
                  } else {
                    CustomNavigator.push(Routes.LOGIN_SCREEN, clean: true);
                    return;
                  }
                },
              )
              .fadeIn(
                duration: 400.ms,
                curve: Curves.easeOutQuart,
              )
              .scale(
                begin: const Offset(0.2, 0.2),
                end: const Offset(1.05, 1.05),
                duration: 900.ms,
                delay: 100.ms,
                curve: Curves.easeOutBack,
              )
              .scale(
                begin: const Offset(1.05, 1.05),
                end: const Offset(1.0, 1.0),
                duration: 300.ms,
                curve: Curves.easeInOutQuart,
              )
              .shimmer(
                duration: 1000.ms,
                delay: 50.ms,
                curve: Curves.easeInOutSine,
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
        ),
      ),
    );
  }
}
