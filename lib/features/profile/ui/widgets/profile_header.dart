import 'package:flutter/material.dart';

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
      height: 220,
      padding: const EdgeInsetsDirectional.only(
        start: 18,
        end: 18,
        top: 24,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(64, 77, 38, 1),
            Color.fromRGBO(24, 28, 16, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
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
