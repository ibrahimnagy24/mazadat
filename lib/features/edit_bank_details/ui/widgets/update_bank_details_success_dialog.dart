import 'package:flutter/material.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart' ;
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';

class UpdateBankDetailsSuccessDialog extends StatelessWidget {
  const UpdateBankDetailsSuccessDialog({super.key});

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
          AppStrings.changesSavedSuccessfully.tr,
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        24.sbH,
        DefaultButton(
          text: AppStrings.profile.tr,
          onPressed: () {
            CustomNavigator.pop();
            CustomNavigator.pop();
          },
        )
      ],
    );
  }
}
