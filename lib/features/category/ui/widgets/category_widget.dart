import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../data/entity/category_entity.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    this.onTap,
    required this.isSelected,
    this.animationDuration,
    this.type = CategoryWidgetType.type1,
    this.height,
    this.width,
    this.borderRadiusValue,
  });
  final void Function()? onTap;
  final CategoryEntity category;
  final bool isSelected;
  final Duration? animationDuration;
  final CategoryWidgetType type;
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CategoryWidgetType.type1:
        return _CategoryWidgetTypeOne(
          onTap: onTap,
          category: category,
          isSelected: isSelected,
          animationDuration: animationDuration,
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
        );
      case CategoryWidgetType.type2:
        return _CategoryWidgetTypeTwo(
          onTap: onTap,
          category: category,
          isSelected: isSelected,
          animationDuration: animationDuration,
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
        );

      case CategoryWidgetType.type3:
        return _CategoryWidgetTypeThree(
          onTap: onTap,
          category: category,
          isSelected: isSelected,
          animationDuration: animationDuration,
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
        );
    }
  }
}

enum CategoryWidgetType {
  type1,
  type2,
  type3,
}

class _CategoryWidgetTypeOne extends StatelessWidget {
  const _CategoryWidgetTypeOne({
    required this.onTap,
    required this.category,
    required this.isSelected,
    this.animationDuration,
    this.height,
    this.width,
    this.borderRadiusValue,
  });
  final void Function()? onTap;
  final CategoryEntity category;
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
        height: height ?? 118,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          border: Border.all(
            color: isSelected ? AppColors.kPrimary : AppColors.kOpacityGrey2,
          ),
          borderRadius:
              BorderRadius.circular(borderRadiusValue ?? AppRadius.rS),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 2,
                    ),
                    child: DefaultNetworkImage(category.iconUrl ?? ''),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 12,
                    start: 4,
                    end: 4,
                  ),
                  child: MainText(
                    text: category.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: isSelected
                        ? AppTextStyles.textMdBold
                            .copyWith(color: AppColors.kPrimary)
                        : AppTextStyles.textMdRegular
                            .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                )
              ],
            ).animate().fadeIn(delay: animationDuration),
            if (isSelected)
              PositionedDirectional(
                top: 5.w,
                end: 5.w,
                child: SvgPicture.asset(
                  AppSvg.tickCheck,
                  height: 20.w,
                  width: 20.w,
                ).animate().fadeIn(),
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryWidgetTypeTwo extends StatelessWidget {
  const _CategoryWidgetTypeTwo({
    required this.onTap,
    required this.category,
    required this.isSelected,
    this.animationDuration,
    this.height,
    this.width,
    this.borderRadiusValue,
  });
  final void Function()? onTap;
  final CategoryEntity category;
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
        height: height ?? 120.h,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 6.w),
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
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                child: category.categoryType == CategoryTypes.bundle
                    ? customImageIconSVG(
                        imageName: AppSvg.package,
                        color: isSelected
                            ? AppColors.kPrimary
                            : AppColors.textDefault,
                        fit: BoxFit.contain)
                    : DefaultNetworkImage(category.iconUrl ?? ''),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: 10.h,
                horizontal: 10.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    category.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: isSelected
                        ? AppTextStyles.textMdBold
                        : AppTextStyles.textMdRegular,
                  ),
                  if (isSelected)
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
                      height: 3.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.kPrimary300,
                      ),
                    ).animate().scale(),
                ],
              ),
            )
          ],
        ).animate().fadeIn(delay: animationDuration),
      ),
    );
  }
}

class _CategoryWidgetTypeThree extends StatelessWidget {
  const _CategoryWidgetTypeThree({
    required this.onTap,
    required this.category,
    required this.isSelected,
    this.animationDuration,
    this.height,
    this.width,
    this.borderRadiusValue,
  });
  final void Function()? onTap;
  final CategoryEntity category;
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
          category.name,
          style: isSelected
              ? AppTextStyles.textMdBold
              : AppTextStyles.textMdRegular,
        ),
      ),
    ).animate().fadeIn(delay: animationDuration);
  }
}
