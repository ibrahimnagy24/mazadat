import 'package:flutter/cupertino.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/model/addresses_model.dart';

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key, required this.address, this.fromAddress = true});
  final AddressModel address;
  final bool fromAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: address.isDefault == true
              ? AppColors.kWhite
              : AppColors.background,
          border: Border.all(
            color: address.isDefault == true
                ? AppColors.kPrimary
                : AppColors.borderNeutralSecondary,
          ),
          borderRadius: BorderRadius.circular(8.w)),
      child: Row(
        spacing: 8.w,
        children: [
          customImageIconSVG(
            imageName: AppSvg.location,
            width: 24.w,
            height: 24.w,
            color: address.isDefault == true
                ? AppColors.kPrimary
                : AppColors.iconDefault,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.h,
              children: [
                Text(
                  address.addressType?.name ?? '',
                  style: AppTextStyles.textLgBold,
                ),
                Text(
                  address.desc ?? '',
                  style: AppTextStyles.textMdRegular,
                ),
              ],
            ),
          ),
          if (fromAddress)
            customImageIconSVG(
              onTap: () =>
                  CustomNavigator.push(Routes.ADD_ADDRESSES, extra: address),
              imageName: AppSvg.edit,
              width: 20.w,
              height: 20.w,
              color: address.isDefault == true
                  ? AppColors.kPrimary
                  : AppColors.iconDefault,
            ),
        ],
      ),
    );
  }
}
