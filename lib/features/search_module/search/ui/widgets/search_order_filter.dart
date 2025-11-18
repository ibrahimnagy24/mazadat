import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../data/enum/search_enums.dart';

class SearchOrderFilter extends StatelessWidget {
  const SearchOrderFilter({super.key, this.initialValue, this.onTap});
  final SearchOrder? initialValue;
  final Function(SearchOrder)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            AppStrings.order.tr,
            style: AppTextStyles.displaySMMedium.copyWith(
              color: const Color.fromRGBO(46, 46, 46, 1),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.h,
            runSpacing: 8,
            children: [
              Text(AppStrings.fromTo.tr, style: AppTextStyles.textMdRegular),
              ...List.generate(
                SearchOrder.values.length,
                (i) => GestureDetector(
                  onTap: () => onTap?.call(SearchOrder.values[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: initialValue == SearchOrder.values[i]
                          ? const Color.fromRGBO(81, 94, 50, 0.1)
                          : Colors.white,
                      border: Border.all(
                        color: initialValue == SearchOrder.values[i]
                            ? AppColors.borderPrimary
                            : AppColors.borderNeutralSecondary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.rS),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        Flexible(
                          child: Text(
                            SearchOrder.values[i] == SearchOrder.NEW
                                ? AppStrings.newToOld.tr
                                : AppStrings.oldToNew.tr,
                            style: AppTextStyles.textMdRegular.copyWith(
                              color: initialValue == SearchOrder.values[i]
                                  ? const Color.fromRGBO(81, 94, 50, 1)
                                  : const Color.fromRGBO(162, 162, 162, 1),
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          SearchOrder.values[i] == SearchOrder.NEW
                              ? AppSvg.ascending
                              : AppSvg.descending,
                          color: initialValue == SearchOrder.values[i]
                              ? AppColors.textPrimary
                              : AppColors.textPrimaryParagraph,
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
