import 'package:flutter/material.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class ForgotPasswordTextWidget extends StatelessWidget {
  const ForgotPasswordTextWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.push(Routes.FORGET_PASSWORD_SCREEN);
      },
      child: MainText(
        text: AppStrings.forgotYourPassword.tr,
        style: AppTextStyles.textSmSemibold.copyWith(
          color: const Color.fromRGBO(81, 94, 50, 1),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
