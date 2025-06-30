import 'package:flutter/material.dart';
import '../../../core/shared/widgets/custom_images.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/extensions/extensions.dart';

class CustomNavbarItemWidget extends StatelessWidget {
  const CustomNavbarItemWidget({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.selectedItemHeight,
    this.selectedItemWidth,
    this.unselectedItemHeight,
    this.unselectedItemWidth,
    this.iconHeight,
    this.iconWidth,
    this.label,
  });

  final String icon;
  final bool isSelected;
  final double? selectedItemHeight;
  final double? selectedItemWidth;
  final double? unselectedItemHeight;
  final double? unselectedItemWidth;
  final double? iconHeight;
  final double? iconWidth;

  final String? label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10.h,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 4.h,
          width: 100.w,
          decoration: BoxDecoration(
              border: Border(
                  top: isSelected
                      ? BorderSide(color: AppColors.kPrimary, width: 4.h)
                      : BorderSide.none)),
        ),
        customImageIconSVG(
          imageName: icon,
          height: iconHeight,
          width: iconWidth,
          color: isSelected ? AppColors.kPrimary : AppColors.iconDefault,
        ),
        if (label != null)
          Text(
            label!,
            style: isSelected
                ? AppTextStyles.textLgBold.copyWith(height: 1)
                : AppTextStyles.textLgRegular.copyWith(height: 1),
          ),
      ],
    );
  }
}
