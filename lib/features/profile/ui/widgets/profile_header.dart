import 'package:flutter/material.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryHelper.width,
      padding: EdgeInsetsDirectional.only(
        start: 18.w,
        end: 18.w,
        top: 24.h,
        bottom: 100.h,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              AppImages.authHeaderBk,
            ),
            fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Row(
          spacing: 8.w,
          children: [
            const CustomBackIcon(iconColor: AppColors.kWhite),
            Expanded(
              child: Text(
                AppStrings.profile.tr,
                style: AppTextStyles.displayMdBold
                    .copyWith(color: AppColors.kWhite),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
