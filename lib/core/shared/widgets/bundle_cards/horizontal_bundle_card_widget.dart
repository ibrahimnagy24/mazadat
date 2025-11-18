import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';

class HorizontalBundleCardWidget extends StatelessWidget {
  const HorizontalBundleCardWidget({
    super.key,
    required this.bundleId,
    this.bundleName,
    this.bundlePrice,
    this.numberOfAuctions,
    this.onTap,
    this.height = 72,
  });
  final void Function()? onTap;
  final int bundleId;
  final String? bundleName;
  final String? bundlePrice;
  final String? numberOfAuctions;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.rXS),
                color: AppColors.fillColor,
                border: Border.all(color: AppColors.iconSecondary, width: 1.5),
              ),
              child: SvgPicture.asset(
                AppSvg.package,
                color: AppColors.iconSecondary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (bundleName != null)
                    MainText(
                      text: bundleName,
                      style: AppTextStyles.textLgMedium
                          .copyWith(color: const Color.fromRGBO(34, 39, 21, 1)),
                    ),
                  if (bundlePrice != null)
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 4.w,
                            children: [
                              MainText(
                                text: AppStrings.openingPrice.tr,
                                style: AppTextStyles.textSmRegular.copyWith(
                                    color:
                                        const Color.fromRGBO(162, 162, 162, 1)),
                              ),
                              Flexible(
                                child: MainText(
                                  text: bundlePrice,
                                  style: AppTextStyles.textMdRegular.copyWith(
                                      color:
                                          const Color.fromRGBO(81, 94, 50, 1)),
                                ),
                              ),
                              SvgPicture.asset(
                                AppSvg.saudiArabiaSymbol,
                                color: const Color.fromRGBO(81, 94, 50, 1),
                                height: 14,
                                width: 14,
                              ),
                            ],
                          ),
                        ),
                        if (numberOfAuctions != null)
                          Row(
                            spacing: 4,
                            children: [
                              Text(
                                '${AppStrings.auctionsNumber.tr}: ',
                                style: AppTextStyles.textMdRegular,
                              ),
                              Text(
                                numberOfAuctions!,
                                style: AppTextStyles.textMdBold
                                    .copyWith(color: AppColors.tertiary),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
