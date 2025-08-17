import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../logic/auction_switch_bidding_state.dart';
import '../widgets/auction_switch_bidding_button.dart';
import '../widgets/select_max_bidding_amount.dart';

class AuctionSwitchBiddingView extends StatelessWidget {
  const AuctionSwitchBiddingView({
    super.key,
    required this.id,
    required this.currentAuctionPrice,
    this.onSuccess,
    required this.biddingIncrementAmount,
  });
  final int id;
  final double currentAuctionPrice;
  final double biddingIncrementAmount;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuctionSwitchBiddingCubit()
          ..updateMaxBiddingValue(currentAuctionPrice),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child:
              BlocBuilder<AuctionSwitchBiddingCubit, AuctionSwitchBiddingState>(
                  builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.h,
              children: [
                Flexible(
                  child: StreamBuilder(
                      stream: context
                          .read<AuctionSwitchBiddingCubit>()
                          .biddingMethodStream,
                      builder: (context, snapshot) {
                        return ListAnimator(
                          data: [
                            SelectMaxBiddingAmount(
                              currentAuctionPrice: currentAuctionPrice,
                              currentBiddingMethod:
                                  snapshot.data ?? BiddingMethod.manual,
                              biddingIncrementAmount: biddingIncrementAmount,
                            ),

                            ///Current Auction Price
                            if (snapshot.data == BiddingMethod.auto)
                              Row(
                                spacing: 4.w,
                                children: [
                                  customImageIconSVG(
                                      imageName: AppSvg.money,
                                      width: 16.w,
                                      height: 16.h,
                                      color: AppColors.textSecondaryParagraph),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppStrings
                                                .currentAuctionPrice.tr,
                                            style: AppTextStyles.textMdRegular
                                                .copyWith(
                                                    color: AppColors
                                                        .textSecondaryParagraph),
                                          ),
                                          TextSpan(
                                            text: '  $currentAuctionPrice ',
                                            style: AppTextStyles.textLgMedium
                                                .copyWith(
                                                    color: AppColors
                                                        .textPrimaryParagraph),
                                          ),
                                          WidgetSpan(
                                            child: customImageIconSVG(
                                                imageName:
                                                    AppSvg.saudiArabiaSymbol,
                                                width: 16.w,
                                                height: 16.w,
                                                color: AppColors
                                                    .textPrimaryParagraph),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        );
                      }),
                ),
                AuctionSwitchBiddingButton(id: id, onSuccess: onSuccess),
              ],
            );
          }),
        ));
  }
}
