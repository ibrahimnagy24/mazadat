import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../data/entity/auction_status_entity.dart';

class AuctionStatusFilterCard extends StatelessWidget {
  const AuctionStatusFilterCard({
    super.key,
    required this.onTap,
    required this.auctionStatus,
    required this.isSelected,
    this.animationDuration,
    this.height,
    this.width,
    this.borderRadiusValue,
  });
  final void Function()? onTap;
  final AuctionStatusEntity auctionStatus;
  final bool isSelected;
  final Duration? animationDuration;
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          border: Border.all(
            color: isSelected
                ? AppColors.borderPrimary
                : AppColors.borderNeutralSecondary,
            width: isSelected ? 1.5 : .6,
          ),
          borderRadius:
              BorderRadius.circular(borderRadiusValue ?? AppRadius.rS),
        ),
        child: Text(
          auctionStatus.label,
          style: isSelected
              ? AppTextStyles.textMdBold
              : AppTextStyles.textMdRegular,
        ),
      ),
    ).animate().fadeIn(delay: animationDuration);
  }
}
