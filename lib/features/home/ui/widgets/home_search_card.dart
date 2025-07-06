import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../logic/home_cubit.dart';

class HomeSearchCard extends StatelessWidget {
  const HomeSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
      child: Row(
        spacing: 8.w,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => CustomNavigator.push(Routes.SEARCH),
              child: Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: AppColors.fillColor,
                    border: Border.all(
                      color: AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.rMd)),
                child: Row(
                  spacing: 8.w,
                  children: [
                    customImageIconSVG(
                      imageName: AppSvg.searchIcon,
                      width: 20.w,
                      height: 20.w,
                      color: AppColors.iconDefault,
                    ),
                    Expanded(
                        child: Text(
                      AppStrings.lookingForAuctions.tr,
                      style: AppTextStyles.textLgRegular,
                    )),
                    customImageIconSVG(
                      imageName: AppSvg.filterIcon,
                      width: 20.w,
                      height: 20.w,
                      color: AppColors.iconDefault,
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///Listing Button
          StreamBuilder(
              stream: context.read<HomeCubit>().listingStream,
              builder: (c, snapshot) {
                return InkWell(
                  onTap: () => context
                      .read<HomeCubit>()
                      .updateListing(snapshot.data == true ? false : true),
                  child: Container(
                    height: 50.h,
                    width: 50.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                    decoration: BoxDecoration(
                        color: AppColors.fillColor,
                        border: Border.all(
                          color: AppColors.border,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.rMd)),
                    child: customImageIconSVG(
                      imageName:
                          snapshot.data == true ? AppSvg.list : AppSvg.grid,
                      width: 20.w,
                      height: 20.w,
                      color: AppColors.iconDefault,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
