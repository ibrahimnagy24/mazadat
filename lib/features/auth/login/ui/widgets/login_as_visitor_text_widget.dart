import 'package:flutter/material.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class LoginAsVisitorTextWidget extends StatelessWidget {
  const LoginAsVisitorTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainText(
      text: AppStrings.loginAsAVisitor.tr,
      style: AppTextStyles.bodyXsMed,
      onTap: () {
        CustomNavigator.push(Routes.CHOOSE_FAV_CATEGORY);
      },
    );
  }
}
