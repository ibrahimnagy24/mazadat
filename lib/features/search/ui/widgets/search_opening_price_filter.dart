import 'package:flutter/material.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';

class SearchOpeningPriceFilter extends StatelessWidget {
  const SearchOpeningPriceFilter({super.key, this.initialValue, this.onTap});
  final RangeValues? initialValue;
  final Function(RangeValues)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            AppStrings.openingPrice.tr,
            style: AppTextStyles.textLgBold,
          ),
          RangeSlider(
            activeColor: AppColors.kPrimary,
            inactiveColor: AppColors.border,
            values: initialValue ?? const RangeValues(0, 0),
            min: 0,
            max: 1000000000,
            divisions: 1000000000,
            onChanged: (value) {
              onTap?.call(value);
            },
            labels: RangeLabels(
              initialValue?.start.round().toString() ?? '0',
              initialValue?.end.round().toString() ?? '0',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        '0',
                        style: AppTextStyles.textLgRegular,
                      ),
                    ),
                    customImageIconSVG(
                        imageName: AppSvg.saudiArabiaSymbol,
                        color: AppColors.textSecondaryParagraph),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '1000000000',
                        style: AppTextStyles.textLgRegular,
                      ),
                    ),
                    customImageIconSVG(
                        imageName: AppSvg.saudiArabiaSymbol,
                        color: AppColors.textSecondaryParagraph),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
