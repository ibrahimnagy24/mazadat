import 'package:flutter/widgets.dart';

import '../../../core/navigation/custom_navigation.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/radius/app_radius.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/utils/widgets/buttons/default_button.dart';

class LoginAsVisitorButtonWidget extends StatelessWidget {
  const LoginAsVisitorButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: AppStrings.loginAsAVisitor.tr,
      backgroundColor: AppColors.innerColor,
      textColor: AppColors.tertiary,
      borderColor: AppColors.tertiary,
      onPressed: () {
        CustomNavigator.push(Routes.CHOOSE_FAV_CATEGORY);
      },
      textStyle: AppTextStyles.bodyXlBold
          .copyWith(color: const Color.fromRGBO(57, 40, 42, 1)),
      borderRadiusValue: AppRadius.rMD,
    );
  }
}
