import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';

class ProfileDetailsInfo extends StatelessWidget {
  const ProfileDetailsInfo({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.action,
  });
  final String icon, title;
  final String? value;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16.h,
        children: [
          customContainerSvgIcon(
              imageName: icon,
              width: 40.w,
              height: 40.w,
              radius: 100.w,
              padding: 10.w,
              borderColor: AppColors.background,
              backGround: AppColors.background,
              color: AppColors.iconPrimary),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(title,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.textMdRegular),
                Text(value ?? '----------------',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.textLgRegular),
              ],
            ),
          ),
          if (action != null) action!
        ],
      ),
    );
  }
}
