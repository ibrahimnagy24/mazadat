import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.alreadyHaveAnAccount.tr,
            style: AppTextStyles.textMdRegular,
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: AppStrings.login.tr,
            style: AppTextStyles.textMdBold,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // CustomNavigator.pop();
                CustomNavigator.push(Routes.LOGIN_SCREEN, replace: true);
              },
          ),
        ],
      ),
    );
  }
}
