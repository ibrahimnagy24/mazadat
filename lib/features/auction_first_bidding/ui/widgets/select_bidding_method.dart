import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../logic/auction_first_bidding_state.dart';

class SelectBiddingMethod extends StatelessWidget {
  const SelectBiddingMethod(
      {super.key, required this.currentAuctionPrice, this.initialValue});
  final double currentAuctionPrice;
  final BiddingMethod? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            AppStrings.selectBiddingMethod.tr,
            style: AppTextStyles.textLgBold,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.h,
            runSpacing: 8.w,
            runAlignment: WrapAlignment.start,
            children: List.generate(
              BiddingMethod.values.length,
              (i) => GestureDetector(
                onTap: () {
                  context
                      .read<AuctionFirstBiddingCubit>()
                      .updateBiddingMethod(BiddingMethod.values[i]);
                  context
                      .read<AuctionFirstBiddingCubit>()
                      .updateMaxBiddingValue(currentAuctionPrice);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: initialValue == BiddingMethod.values[i]
                        ? AppColors.kPrimary.withValues(alpha: 0.1)
                        : AppColors.kWhite,
                    border: Border.all(
                      color: initialValue == BiddingMethod.values[i]
                          ? AppColors.borderPrimary
                          : AppColors.borderNeutralSecondary,
                      width: initialValue == BiddingMethod.values[i] ? 1.5 : .6,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.rS),
                  ),
                  child: Text(
                    '${BiddingMethod.values[i].name}_bidding'.tr,
                    style: initialValue == BiddingMethod.values[i]
                        ? AppTextStyles.textMdBold
                        : AppTextStyles.textMdRegular,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
