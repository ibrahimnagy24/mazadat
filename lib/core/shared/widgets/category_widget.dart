import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../features/auth/choose_category/data/entity/category_entity.dart';
import '../../assets/app_svg.dart';
import '../../theme/colors/styles.dart';
import '../../theme/radiuos/app_radiuos.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/widgets/misc/default_network_image.dart';
import '../../utils/widgets/text/main_text.dart';

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
    }
  }
}

enum CategoryWidgetType { type1, type2 }

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
            color: isSelected ? AppColors.kPrimary500 : AppColors.kOpacityGrey2,
          ),
          borderRadius:
              BorderRadius.circular(borderRadiusValue ?? AppRadius.rS),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                if (category.iconUrl != null)
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 2,
                      ),
                      child: DefaultNetworkImage(
                        'https://s3-alpha-sig.figma.com/img/15ee/3809/2df2c095f32b4e47de6b3ee5c7010b6e?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=gc4cjxWa0QCfoKQPgdE4~G~wUYhYdkpkD8lF2aIDLFtaKEHsOoWlFfHU~jwUWn0RJFhdVHAcq4FUd~vM0q3k-5CeFPUdMMNEhnq6NQszQrdcM-RUfVT6tQam6CvaK-5A-wZyCJg3wKJXXjOxyPhptuRj3ngp74bLuWlkJEn1QzvnBX17NFoCXakTmSevXN-XlBfUa8acgEyEvknGYPtIp9ZRT4JCedd73-ni~3clcKATAryWOjKiKeyyq5usLh1yf-3aDsVYcBILrVqQStfNZ2eAJXtNGYckSF7CFNpjHdvtsVZ4woCwrUwdMHnlSBGvbM5DGtM3Kp9BZeJYMHrwcQ__', // cubit.allCategories![index].iconUrl!,
                      ),
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
                        ? AppTextStyles.bodyXsMed
                            .copyWith(color: AppColors.kPrimary500)
                        : AppTextStyles.bodyXsReq
                            .copyWith(color: AppColors.kGeryText9),
                  ),
                )
              ],
            ).animate().fadeIn(delay: animationDuration),
            if (isSelected)
              Positioned(
                top: 5,
                right: 5,
                child: SvgPicture.asset(
                  AppSvg.checkRightCircle,
                  height: 21,
                  width: 21,
                ),
              ).animate().fadeIn()
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
        height: height ?? 118,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          border: Border.all(
            color: isSelected ? AppColors.kPrimary500 : AppColors.kOpacityGrey2,
            width: isSelected ? 1.5 : .6,
          ),
          borderRadius:
              BorderRadius.circular(borderRadiusValue ?? AppRadius.rS),
        ),
        child: Column(
          children: [
            if (category.iconUrl != null)
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: DefaultNetworkImage(
                    'https://s3-alpha-sig.figma.com/img/15ee/3809/2df2c095f32b4e47de6b3ee5c7010b6e?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=gc4cjxWa0QCfoKQPgdE4~G~wUYhYdkpkD8lF2aIDLFtaKEHsOoWlFfHU~jwUWn0RJFhdVHAcq4FUd~vM0q3k-5CeFPUdMMNEhnq6NQszQrdcM-RUfVT6tQam6CvaK-5A-wZyCJg3wKJXXjOxyPhptuRj3ngp74bLuWlkJEn1QzvnBX17NFoCXakTmSevXN-XlBfUa8acgEyEvknGYPtIp9ZRT4JCedd73-ni~3clcKATAryWOjKiKeyyq5usLh1yf-3aDsVYcBILrVqQStfNZ2eAJXtNGYckSF7CFNpjHdvtsVZ4woCwrUwdMHnlSBGvbM5DGtM3Kp9BZeJYMHrwcQ__', // cubit.allCategories![index].iconUrl!,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 6,
                start: 4,
                end: 4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainText(
                    text: category.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: isSelected
                        ? AppTextStyles.bodyXsMed
                            .copyWith(color: AppColors.kPrimary500)
                        : AppTextStyles.bodyXsReq
                            .copyWith(color: AppColors.kGeryText9),
                  ),
                  if (isSelected)
                    Container(
                      height: 3,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
