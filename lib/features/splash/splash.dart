import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/assets/app_launchers.dart';
import '../../core/navigation/custom_navigation.dart';
import '../../core/navigation/routes.dart';
import '../../core/shared/widgets/custom_images.dart';

import '../../core/utils/extensions/extensions.dart';
import '../../core/utils/extensions/media_query_helper.dart';
import '../../core/utils/utility.dart';

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
              image: DecorationImage(
                  image: AssetImage(AppLaunchers.splash), fit: BoxFit.cover)),
          child: customImageIcon(
            imageName: AppLaunchers.logo,
            height: 95.h,
            width: 130.w,
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
              .scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.0, 1.0),
                duration: 1000.ms,
                delay: 0.ms,
                curve: Curves.easeInOut,
              )
              .then(delay: 200.ms)
              .shimmer(duration: 1000.ms, curve: Curves.easeInOut),
        ),
      ),
    );
  }
}
