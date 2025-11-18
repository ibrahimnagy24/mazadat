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

class DeleteAccountSuccessDialog extends StatelessWidget {
  const DeleteAccountSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        customImageIconSVG(
          imageName: AppSvg.success,
          width: 90.w,
          height: 90.w,
        ),
        24.sbH,
        Text(
          AppStrings.accountDeletedSuccessfully.tr,
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        8.sbH,
        Text(
          AppStrings.youWillBeRedirectedToTheLoginPage.tr,
          style: AppTextStyles.textLgRegular,
          textAlign: TextAlign.center,
        ),
        24.sbH,
        DefaultButton(
          text: AppStrings.goToLogin.tr,
          onPressed: () =>
              CustomNavigator.push(Routes.LOGIN_SCREEN, clean: true),
        )
      ],
    );
  }
}
