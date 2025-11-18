import 'package:flutter/material.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart'
    show CustomNavigator;
import '../../../../../core/navigation/routes.dart' show Routes;
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart'
    show AppTextStyles;
import '../../../../../core/utils/constant/app_strings.dart' show AppStrings;
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';

class RegisterSuccessDialog extends StatelessWidget {
  const RegisterSuccessDialog({super.key,  this.fromRegister = true});
  final bool fromRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        customImageIconSVG(
          imageName: AppSvg.success,
          width: 90.w,
          height: 90.w,
        ),
        Text(
          fromRegister? AppStrings.accountCreatedSuccessfully.tr:
          AppStrings.changesSavedSuccessfully.tr,
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        DefaultButton(
          text: AppStrings.mainPage.tr,
          onPressed: () =>
              CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true),
        )
      ],
    );
  }
}
