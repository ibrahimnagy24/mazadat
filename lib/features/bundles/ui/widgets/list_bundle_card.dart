import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../bundle_details/data/params/bundle_details_route_params.dart';
import '../../data/entity/bundle_entity.dart';

class ListBundleCard extends StatelessWidget {
  const ListBundleCard({super.key, required this.bundle,this.fromMyBundles = false});
  final BundleEntity bundle;
  final bool fromMyBundles;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.push(Routes.BUNDLE_DETAILS,
            extra: BundleDetailsRouteParams(
                bundleId: bundle.id, fromMyBundles: fromMyBundles));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Row(
          spacing: 12.w,
          children: [
            Container(
              height: 60.w,
              width: 60.w,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.rXS),
                color: AppColors.fillColor,
                border: Border.all(color: AppColors.iconSecondary, width: 1.5),
              ),
              child: customImageIconSVG(
                imageName: AppSvg.package,
                color: AppColors.iconSecondary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: bundle.name,
                    style: AppTextStyles.textLgMedium
                        .copyWith(color: AppColors.textPrimary),
                  ),
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
                      ),
                      Expanded(
                        child: Row(
                          spacing: 4.w,
                          children: [
                            Text(
                              '${AppStrings.auctionsNumber.tr}: ',
                              style: AppTextStyles.textMdRegular,
                            ),
                            Text(
                              bundle.numberOfAuctions,
                              style: AppTextStyles.textMdBold
                                  .copyWith(color: AppColors.tertiary),
                            ),
                          ],
                        ),
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
