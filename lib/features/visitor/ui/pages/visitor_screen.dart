import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/text_styles/text_styles.dart';

import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/custom_button_with_inner_shadow_widget.dart';
import '../../../../core/utils/widgets/buttons/custom_gradient_button_widget.dart';
import '../../../../core/utils/widgets/responsive/responsive.dart';
import '../../../../core/utils/widgets/text/main_text.dart';

class VisitorScreen extends StatelessWidget {
  const VisitorScreen({super.key, this.fontSize});
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MainText(
            text:
                'Welcome, you have to register to enjoy the games with friends. If you are already a customer of ours, please log in again.'
                    .tr,
            style: AppTextStyles.balooBhaijaan2W400Size16kPrimary700
                .copyWith(fontSize: fontSize ?? 16),
            textAlign: TextAlign.center,
          ),
          Center(
            child:
                Image.asset('assets/launchers/logo_for_splash.png', height: 150),
          ).animate().fade(duration: 500.ms),
          // Center(
          //     child: SvgPicture.asset(
          //   AppSvg.barqText,
          //   height: 50,
          // )).animate().shimmer(
          //   duration: 1500.ms,
          //   colors: [
          //     AppColors.kPrimary700,
          //     AppColors.kPrimary1000,
          //     AppColors.kGold2,
          //   ],
          // ),
          25.sbH,
          if (Responsive.isSmall(context))
            Column(
              children: [
                loginButton(fontSize: fontSize),
                25.sbH,
                registerButton(fontSize: fontSize),
              ],
            ),
          if (!Responsive.isSmall(context))
            Row(
              children: [
                Expanded(child: loginButton(fontSize: fontSize)),
                25.sbW,
                Expanded(child: registerButton(fontSize: fontSize)),
              ],
            ),
        ],
      ),
    );
  }

  Widget loginButton({final double? fontSize}) {
    return CustomGradientButtonWidget(
      onPressed: () {
        CustomNavigator.push(Routes.LOGIN_SCREEN, clean: true);
      },
      text: 'AppStrings.login.tr',
      fontSize: fontSize,
    );
  }

  Widget registerButton({final double? fontSize}) {
    return CustomButtonWithInnerShadowWidget(
      onPressed: () {
        CustomNavigator.push(Routes.REGISTER_SCREEN, clean: true);
      },
      text: 'AppStrings.registerAndStartPlaying.tr',
      fontSize: fontSize,
    );
  }
}
