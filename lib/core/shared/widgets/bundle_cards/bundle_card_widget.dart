import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';

class BundleCardWidget extends StatelessWidget {
  const BundleCardWidget({
    super.key,
    this.onTap,
    required this.bundleId,
    this.bundleName,
    this.bundlePrice,
    this.numberOfAuctions,
  });
  final void Function()? onTap;
  final int bundleId;
  final String? bundleName;
  final String? bundlePrice;
  final String? numberOfAuctions;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.rXS),
                      color: AppColors.fillColor,
                      border: Border.all(
                        color: AppColors.iconSecondary,
                        width: 1.5,
                      ),
                    ),
                    child: SvgPicture.asset(
                      AppSvg.package,
                      color: AppColors.iconSecondary,
                    ),
                  ),

                  ///Auctions Number
                  if (numberOfAuctions != null)
                    PositionedDirectional(
                      start: 12,
                      top: 12,
                      child: Row(
                        spacing: 4,
                        children: [
                          MainText(
                            text: '${AppStrings.auctionsNumber.tr}: ',
                            style: AppTextStyles.textMdRegular,
                          ),
                          MainText(
                            text: numberOfAuctions,
                            style: AppTextStyles.textMdBold
                                .copyWith(color: AppColors.tertiary),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (bundleName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  bundleName!,
                  style: AppTextStyles.textLgMedium
                      .copyWith(color: AppColors.textPrimary),
                ),
              ),
            if (bundlePrice != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MainText(
                      text: AppStrings.openingPrice.tr,
                      style: AppTextStyles.textSmRegular,
                    ),
                  ),
                  Row(
                    children: [
                      MainText(
                        text: bundlePrice,
                        style: AppTextStyles.textMdRegular.copyWith(
                            color: const Color.fromRGBO(81, 94, 50, 1)),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        AppSvg.saudiArabiaSymbol,
                        color: const Color.fromRGBO(81, 94, 50, 1),
                        height: 14,
                        width: 14,
                      ),
                    ],
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
