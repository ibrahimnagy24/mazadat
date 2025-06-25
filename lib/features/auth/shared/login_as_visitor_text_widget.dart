import 'package:flutter/material.dart';

import '../../../core/navigation/custom_navigation.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/theme/colors/styles.dart';

import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/utils/widgets/buttons/default_button.dart';

class LoginAsVisitorTextWidget extends StatelessWidget {
  const LoginAsVisitorTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Divider(
                    color: AppColors.border,
                    height: 12.h,
                  )),
              Text(
                '  ${AppStrings.or.tr}  ',
                style: AppTextStyles.textMdMedium,
              ),
              Expanded(
                  child: Divider(
                    color: AppColors.border,
                    height: 12.h,
                  )),
            ],
          ),
        ),
        DefaultButton(
          text: AppStrings.loginAsAVisitor.tr,
          backgroundColor: AppColors.innerColor,
          textColor: AppColors.tertiary,
          borderColor: AppColors.tertiary,
          onPressed: () {
            CustomNavigator.push(Routes.CHOOSE_FAV_CATEGORY);
          },
        ),
      ],
    );
  }
}
