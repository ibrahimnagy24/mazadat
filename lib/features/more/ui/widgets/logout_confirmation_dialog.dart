import 'package:flutter/material.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/utility.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        customImageIconSVG(
          imageName: AppSvg.logoutConfirm,
          width: 90.w,
          height: 90.w,
        ),
        Text(
          AppStrings.areYouSureYouWantToLogout.tr,
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: DefaultButton(
                backgroundColor: AppColors.kWhite,
                borderColor: AppColors.RED,
                textColor: AppColors.RED,
                text: AppStrings.logout.tr,
                onPressed: () async => await Utility.logout(),
              ),
            ),
            Expanded(
              child: DefaultButton(
                text: AppStrings.cancel.tr,
                onPressed: () => CustomNavigator.pop(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
