import 'package:flutter/material.dart';

import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../auction_first_bidding/ui/pages/auction_first_bidding_view.dart';
import '../../../joining_auction/ui/pages/validate_joining_auction_view.dart';

class AuctionActions extends StatelessWidget {
  const AuctionActions({
    super.key,
    required this.id,
    this.isJoined = false,
    required this.firstBidding,
    required this.autoBiddingEnabled,
    required this.canBid,
    required this.currentPrice,
  });

  final int id;
  final bool isJoined, firstBidding,autoBiddingEnabled,canBid;

  final double currentPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ///To Join Auction
        // if (isJoined != true)
        //   DefaultButton(
        //     onPressed: () => CustomBottomSheet.show(
        //       widget: ValidateJoiningAuctionView(id: id),
        //     ),
        //     text: AppStrings.registerForTheAuction.tr,
        //   ),


        ///To First Bidding
        // if (isJoined == true && firstBidding == true)
          DefaultButton(
            onPressed: () => CustomBottomSheet.show(
                label: AppStrings.selectBiddingMethod.tr,
                widget: AuctionFirstBiddingView(id: id,currentAuctionPrice:currentPrice)),
            text: AppStrings.bidding.tr,
          ),
      ],
    );
  }
}
