import 'package:flutter/material.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../nav_layout/cubit/navbar_layout_cubit.dart';
import 'more_button.dart';

class MoreProfileButtons extends StatelessWidget {
  const MoreProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.sbH,
        Text(
          AppStrings.myProfile.tr,
          style: AppTextStyles.textLgBold,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(AppRadius.rLg)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoreButton(
                title: AppStrings.myAddresses.tr,
                icon: AppSvg.location,
                onTap: () => CustomNavigator.push(Routes.ADDRESSES),

              ),
              MoreButton(
                  title: AppStrings.mySales.tr,
                  icon: AppSvg.saleTag,
                  // onTap: () => CustomNavigator.push(Routes.MY_SALES),
              ),
              MoreButton(
                title: AppStrings.favourite.tr,
                icon: AppSvg.wishlist,
                onTap: () {
                  NavbarLayoutCubit.instance.onItemTapped(1);
                  CustomNavigator.pop();
                },
              ),
              MoreButton(
                  title: AppStrings.myPurchases.tr,
                  icon: AppSvg.cart,
                  onTap: () => CustomNavigator.push(Routes.MY_PURCHASES),
              ),
              MoreButton(
                title: AppStrings.paymentHistory.tr,
                icon: AppSvg.clock,
              ),
              MoreButton(
                  title: AppStrings.myBundles.tr,
                  icon: AppSvg.package,
                  // onTap: () => CustomNavigator.push(Routes.MY_BUNDLES),
              ),
            ],
          ),
        )
      ],
    );
  }
}
