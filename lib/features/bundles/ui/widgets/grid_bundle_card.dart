import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radiuos/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/bundle_entity.dart';

class GridBundleCard extends StatelessWidget {
  const GridBundleCard({super.key, required this.bundle});
  final BundleEntity bundle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.push(Routes.VIEW_BUNDLES, extra: bundle.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 30.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.rXS),
                      color: AppColors.fillColor,
                      border: Border.all(
                          color: AppColors.iconSecondary, width: 1.5),
                    ),
                    child: customImageIconSVG(
                      imageName: AppSvg.package,
                      color: AppColors.iconSecondary,
                    ),
                  ),

                  ///Auctions Number
                  PositionedDirectional(
                    start: 12.w,
                    top: 12.h,
                    child: Row(
                      spacing: 4.w,
                      children: [
                        MainText(
                          text: '${AppStrings.auctionsNumber.tr}: ',
                          style: AppTextStyles.textMdRegular,
                        ),
                        MainText(
                          text: bundle.numberOfAuctions,
                          style: AppTextStyles.textMdBold
                              .copyWith(color: AppColors.tertiary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
              child: Text(
                bundle.name,
                style: AppTextStyles.textLgMedium
                    .copyWith(color: AppColors.textPrimary),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 4.w,
              children: [
                MainText(
                  text: AppStrings.openingPrice.tr,
                  style: AppTextStyles.textSmRegular,
                ),
                Flexible(
                  child: MainText(
                      text: bundle.price,
                      style: AppTextStyles.textMdRegular
                          .copyWith(color: AppColors.textPrimary)),
                ),
                SvgPicture.asset(
                  AppSvg.saudiArabiaSymbol,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
