import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';

class MoreCard extends StatelessWidget {
  const MoreCard(
      {super.key,
      required this.icon,
      required this.title,
      this.onTap,
      this.background,
      this.iconColor});
  final String icon, title;
  final Color? background, iconColor;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.h,
        ),
        decoration: BoxDecoration(
            color: background ?? AppColors.fillColor,
            borderRadius: BorderRadius.circular(AppRadius.rLg)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.h,
          children: [
            customContainerSvgIcon(
                imageName: icon,
                width: 48.w,
                height: 48.w,
                radius: 100.w,
                padding: 12.w,
                borderColor: background ?? AppColors.kWhite,
                color: iconColor ?? AppColors.kPrimary),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.textLgBold.copyWith(
                color: iconColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
