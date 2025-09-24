import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          spacing: 16,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(250, 250, 250, 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 24,
                    height: 24,
                    color: iconColor ?? AppColors.kPrimary,
                  ),
                ],
              ),
            ),
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
