import 'package:flutter/material.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/enum/search_enums.dart';

class SearchOrderFilter extends StatelessWidget {
  const SearchOrderFilter({super.key, this.initialValue, this.onTap});
  final SearchOrder? initialValue;
  final Function(SearchOrder)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            AppStrings.order.tr,
            style: AppTextStyles.textLgBold,
          ),
          Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8.h,
              runSpacing: 8.w,
              children: [
                Text(
                  AppStrings.fromTo.tr,
                  style: AppTextStyles.textMdRegular,
                ),
                ...List.generate(
                  SearchOrder.values.length,
                  (i) => GestureDetector(
                    onTap: () => onTap?.call(SearchOrder.values[i]),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          border: Border.all(
                            color: initialValue == SearchOrder.values[i]
                                ? AppColors.borderPrimary
                                : AppColors.borderNeutralSecondary,
                            width: initialValue == SearchOrder.values[i]
                                ? 1.5
                                : .6,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.rS),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            Flexible(
                              child: Text(
                                SearchOrder.values[i] == SearchOrder.NEW
                                    ? AppStrings.fromNewToOld.tr
                                    : AppStrings.fromOldToNew.tr,
                                style: initialValue == SearchOrder.values[i]
                                    ? AppTextStyles.textMdBold
                                    : AppTextStyles.textMdRegular,
                              ),
                            ),
                            customImageIconSVG(
                                imageName:
                                    SearchOrder.values[i] == SearchOrder.NEW
                                        ? AppSvg.ascending
                                        : AppSvg.descending,
                                color: initialValue == SearchOrder.values[i]
                                    ? AppColors.textPrimary
                                    : AppColors.textPrimaryParagraph,
                                width: 16.w,
                                height: 16.w),
                          ],
                        )),
                  ),
                ),
              ])
        ],
      ),
    );
  }
}
