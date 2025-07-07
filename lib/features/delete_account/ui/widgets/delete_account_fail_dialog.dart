import 'package:flutter/material.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/theme/colors/styles.dart';

class DeleteAccountFailDialog extends StatelessWidget {
  const DeleteAccountFailDialog({super.key, this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        customContainerSvgIcon(
            imageName: AppSvg.cancel,
            width: 90.w,
            height: 90.w,
            padding: 12.w,
            radius: 100.w,
            color: AppColors.kWhite,
            backGround: AppColors.RED),
        24.sbH,
        Text(
          AppStrings.youCantDeleteAccountNow.tr,
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        8.sbH,
        Text(
          error?? AppStrings
              .thereAreCurrentlyActiveAuctionsAssociatedWithYourAccount.tr,
          style: AppTextStyles.textLgRegular,
          textAlign: TextAlign.center,
        ),
        24.sbH,
        DefaultButton(
          text: AppStrings.okay.tr,
          onPressed: () => CustomNavigator.pop(),
        ),
      ],
    );
  }
}
