import 'package:flutter/material.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../auction_first_bidding/ui/pages/auction_first_bidding_view.dart';

class AuctionExceedMaxBiddingAlert extends StatelessWidget {
  const AuctionExceedMaxBiddingAlert(
      {super.key,
      this.onSuccess,
      required this.id,
      required this.currentAuctionPrice,
      required this.biddingIncrementAmount,
      required this.autoBiddingEnabled});
  final int id;
  final double currentAuctionPrice, biddingIncrementAmount;
  final bool autoBiddingEnabled;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 24.h,
      children: [
        customImageIconSVG(
          imageName: AppSvg.alert,
          width: 90.w,
          height: 90.w,
        ),
        Text(
          AppStrings.theSpecifiedBidValueHasBeeReached.tr,
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        DefaultButton(
          onPressed: () => CustomBottomSheet.show(
              label: AppStrings.selectBiddingMethod.tr,
              widget: AuctionFirstBiddingView(
                  id: id,
                  onSuccess: onSuccess,
                  currentAuctionPrice: currentAuctionPrice,
                  biddingIncrementAmount: biddingIncrementAmount)),
          text: AppStrings.newBidding.tr,
        ),
      ],
    );
  }
}
