import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.action,
    this.leading,
  });
  final String icon, title;

  final Function()? onTap;

  final Widget? action;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16.h,
          children: [
            leading ??
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
              child: Text(title,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.textLgRegular),
            ),
            action ??
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: AppColors.iconPrimary,
                )
          ],
        ),
      ),
    );
  }
}
