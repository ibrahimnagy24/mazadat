import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';

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
      spacing: 10,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 4,
          width: 100,
          decoration: BoxDecoration(
            border: Border(
              top: isSelected
                  ? const BorderSide(color: AppColors.kPrimary, width: 4)
                  : BorderSide.none,
            ),
          ),
        ),
        SvgPicture.asset(
          icon,
          height: iconHeight,
          width: iconWidth,
          color: isSelected
              ? const Color.fromRGBO(81, 94, 50, 1)
              : const Color.fromRGBO(162, 162, 162, 1),
        ),
        if (label != null)
          Text(
            label!,
            style: isSelected
                ? AppTextStyles.textLgBold.copyWith(
                    height: 1,
                    color: const Color.fromRGBO(81, 94, 50, 1),
                  )
                : AppTextStyles.textLgRegular.copyWith(
                    height: 1,
                    color: const Color.fromRGBO(162, 162, 162, 1),
                  ),
          ),
      ],
    );
  }
}
