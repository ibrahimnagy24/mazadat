import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../logic/auction_first_bidding_state.dart';

class SelectMaxBiddingAmount extends StatelessWidget {
  const SelectMaxBiddingAmount(
      {super.key,
      required this.currentPrice,
      required this.biddingIncrementAmount,
      required this.currentBiddingMethod});
  final double currentPrice, biddingIncrementAmount;

  final BiddingMethod currentBiddingMethod;


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
                if(currentBiddingMethod == BiddingMethod.auto)
                  Text(
                  AppStrings.selectMaxBiddingAmount.tr,
                  style: AppTextStyles.textLgBold,
                ),

                ///Current Auction Price
                Stack(
                  children: [
                    Container(
                      width: MediaQueryHelper.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          if(currentBiddingMethod == BiddingMethod.auto)
                          InkWell(
                            onTap: ()=> context.read<AuctionFirstBiddingCubit>().updateMaxBiddingValue(((snapshot.data??0)-1)),
                            child: Container(
                              width: 32.w,
                              height: 32.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.borderDefault,
                                  borderRadius: BorderRadius.circular(8.w)),
                              child: Text(
                                '—',
                                style: AppTextStyles.textLgBold.copyWith(
                                    fontSize: 17,
                                    color: AppColors.HEADER,
                                    height: 1),
                              ),
                            ),
                          ),

                          PriceWidgetWithFlagWidget(
                            price: '${
                                (currentBiddingMethod == BiddingMethod.manual)?
                                (currentPrice + biddingIncrementAmount)  :
                                snapshot.data ?? 0}',
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            colorFilter: const ColorFilter.mode(
                              AppColors.kPrimary,
                              BlendMode.srcIn,
                            ),
                            priceStyle: AppTextStyles.displaySMMedium
                                .copyWith(
                                    color: AppColors.kPrimary, fontSize: 20),
                          ),

                          if(currentBiddingMethod == BiddingMethod.auto)
                          InkWell(
                            onTap: ()=> context.read<AuctionFirstBiddingCubit>().updateMaxBiddingValue(((snapshot.data??0)+1)),
                            child: Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.kPrimary
                                  ),
                                  borderRadius: BorderRadius.circular(8.w)),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.HEADER,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
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
                            currentBiddingMethod == BiddingMethod.auto
                                ? AppStrings.selectedPrice.tr
                                : AppStrings.currentPrice.tr,
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
