import 'package:flutter/material.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>CustomNavigator.push(Routes.ADD_ADDRESSES),
      child: Container(
        width: MediaQueryHelper.width,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.kPrimary),
            borderRadius: BorderRadius.circular(8.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.h,
          children: [
            Container(
              padding: EdgeInsets.all(8.h),
              decoration: const BoxDecoration(
                  color: Color(0xffEAE7E7), shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                size: 24,
                color: AppColors.HEADER,
              ),
            ),
            Text(
              AppStrings.addAddress,
              style: AppTextStyles.textXLBold,
            ),
          ],
        ),
      ),
    );
  }
}
