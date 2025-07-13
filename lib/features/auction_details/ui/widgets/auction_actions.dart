import 'package:flutter/material.dart';

import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../joining_auction/ui/pages/validate_joining_auction_view.dart';

class AuctionActions extends StatelessWidget {
  const AuctionActions({super.key, this.isJoined = false, required this.id});
  final bool isJoined;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isJoined != true)
          DefaultButton(
            onPressed: () =>
                CustomBottomSheet.show(widget: ValidateJoiningAuctionView(id: id)),
            text: AppStrings.registerForTheAuction.tr,
          ),
      ],
    );
  }
}
