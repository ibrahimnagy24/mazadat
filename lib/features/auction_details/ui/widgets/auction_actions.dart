import 'package:flutter/material.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../auction_first_bidding/ui/pages/auction_first_bidding_view.dart';
import '../../../auction_manual_bidding/ui/widgets/auction_manual_bidding_button.dart';
import '../../../auction_switch_bidding/ui/pages/auction_switch_bidding_view.dart';
import '../../../auction_joining/ui/pages/validate_joining_auction_view.dart';

class AuctionActions extends StatelessWidget {
  const AuctionActions({
    super.key,
    required this.id,
    this.isJoined = false,
    required this.firstBidding,
    required this.autoBiddingEnabled,
    required this.canBid,
    required this.currentPrice,
    required this.biddingIncrementAmount,
    this.currentBiddingMethod,
  });

  final int id;
  final bool isJoined, firstBidding, autoBiddingEnabled, canBid;

  final double currentPrice, biddingIncrementAmount;
  final BiddingMethod? currentBiddingMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///To Join Auction
        if (isJoined != true)
          DefaultButton(
            onPressed: () => CustomBottomSheet.show(
                widget: ValidateJoiningAuctionView(id: id)),
            text: AppStrings.registerForTheAuction.tr,
          ),

        ///To First Bidding
        if (isJoined == true && firstBidding == true)
          DefaultButton(
            onPressed: () => CustomBottomSheet.show(
                label: AppStrings.selectBiddingMethod.tr,
                widget: AuctionFirstBiddingView(
                    id: id,
                    currentAuctionPrice: currentPrice,
                    biddingIncrementAmount: biddingIncrementAmount)),
            text: AppStrings.bidding.tr,
          ),

        ///To Manual Bidding
        if (isJoined == true && firstBidding != true && currentBiddingMethod == BiddingMethod.manual)
          AuctionManualBiddingButton(
            id: id,
            canBid: canBid,
            currentPrice: currentPrice,
            biddingIncrementAmount: biddingIncrementAmount,
          ),

        /// To Convert Bidding method to Auto
        if (isJoined == true && firstBidding != true && autoBiddingEnabled == true && currentBiddingMethod == BiddingMethod.manual)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: TextButton(
              onPressed: () => CustomBottomSheet.show(
                  label: AppStrings.areYouSureYouWantToBidAutomatically.tr,
                  widget: AuctionSwitchBiddingView(
                      id: id, currentAuctionPrice: currentPrice)),
              child: Text(
                AppStrings.automaticBidding.tr,
                style: AppTextStyles.bodyMBold.copyWith(
                  fontSize: 12,
                  color: AppColors.kPrimary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
