import 'package:flutter/material.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import 'more_card.dart';

class MoreStaticButtons extends StatelessWidget {
  const MoreStaticButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GridListAnimator(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      data: [
        MoreCard(
            icon: AppSvg.customerService, title: AppStrings.customerService.tr),
        MoreCard(
          icon: AppSvg.quiz,
          title: AppStrings.faqs.tr,
          background: AppColors.borderSecondary.withValues(alpha: 0.5),
          iconColor: AppColors.kSecondary,
        ),
        MoreCard(icon: AppSvg.terms, title: AppStrings.termsAndConditions.tr),
        MoreCard(icon: AppSvg.policy, title: AppStrings.privacyPolicy.tr),
      ],
      crossAxisCount: 2,
      aspectRatio: 1.1,
    );
  }
}
