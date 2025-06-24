import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/navigation/custom_navigation.dart';
import '../../core/navigation/routes.dart';
import '../../core/theme/colors/styles.dart';
import '../../core/theme/text_styles/text_styles.dart';
import '../../core/utils/utility.dart';
import '../../core/utils/widgets/text/main_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                    child: Image.asset('assets/lunchers/logo_for_splashh.png',
                        height: 150))
                .animate()
                .moveX(begin: -250, duration: 300.ms),
            Center(
                    child: MainText(
              text: 'Mazadat',
              style: AppTextStyles.balooBhaijaan2W700Size14KGold2
                  .copyWith(fontSize: 70),
            ))
                .animate(
                  onComplete: (controller) async {
                    // CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
                    // return;
                    if (Utility.isUserLoggedIn()) {
                      CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
                      return;
                    } else {
                      CustomNavigator.push(Routes.LOGIN_SCREEN, clean: true);
                      return;
                    }
                  },
                )
                .scale(delay: 500.ms)
                .shimmer(duration: 1500.ms, colors: [
                  AppColors.kPrimary700,
                  AppColors.kPrimary1000,
                  AppColors.kGold2,
                ]),
          ],
        ));
  }
}
