import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart'
    show CustomNavigator;
import '../../../../../core/navigation/routes.dart' show Routes;
import '../../../../../core/theme/text_styles/text_styles.dart'
    show AppTextStyles;
import '../../../../../core/utils/constant/app_strings.dart' show AppStrings;
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';

class ResetPasswordSuccessDialog extends StatelessWidget {
  const ResetPasswordSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvg.success,
              width: 90,
              height: 90,
            ),
            Text(
              AppStrings.passwordChangedSuccessfully.tr,
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
            DefaultButton(
              text: AppStrings.login.tr,
              onPressed: () =>
                  CustomNavigator.push(Routes.LOGIN_SCREEN, clean: true),
              textStyle: AppTextStyles.bodyXlBold.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
