import 'package:flutter/material.dart';

import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../joining_auction/ui/pages/validate_joining_auction_view.dart';

class AuctionActions extends StatelessWidget {
  const AuctionActions({
    super.key,
    required this.id,
    this.isJoined = false,
    required this.firstBidding,
  });

  final int id;
  final bool isJoined, firstBidding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isJoined != true)

          ///To Join Auction
          DefaultButton(
            onPressed: () => CustomBottomSheet.show(
              widget: ValidateJoiningAuctionView(id: id),
            ),
            text: AppStrings.registerForTheAuction.tr,
          ),
      ],
    );
  }
}
