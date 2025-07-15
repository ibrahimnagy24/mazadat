import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../logic/auction_first_bidding_state.dart';

class SelectMaxBiddingAmount extends StatelessWidget {
  const SelectMaxBiddingAmount({super.key, required this.currentAuctionPrice});
  final double currentAuctionPrice;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.read<AuctionFirstBiddingCubit>().maxBiddingValueStream,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.h,
              children: [
                Text(
                  AppStrings.selectMaxBiddingAmount.tr,
                  style: AppTextStyles.textLgBold,
                ),

                ///Bidding Amount
                Stack(
                  children: [
                    Container(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: PriceWidgetWithFlagWidget(
                        price: '${snapshot.data ?? 0}',
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        colorFilter: const ColorFilter.mode(
                          AppColors.kPrimary,
                          BlendMode.srcIn,
                        ),
                        priceStyle: AppTextStyles.displaySMMedium.copyWith(
                            color: AppColors.kPrimary, fontSize: 20),
                      ),
                    ),
                    PositionedDirectional(
                      top: 0,
                      start: 20,
                      child: Transform.translate(
                        offset: const Offset(0, -10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                             AppStrings.selectedPrice.tr,
                            style: AppTextStyles.textMdRegular,
                          ),
                        ),
                      ),
                    )
                  ],
                ),


              ],
            ),
          );
        });
  }
}
