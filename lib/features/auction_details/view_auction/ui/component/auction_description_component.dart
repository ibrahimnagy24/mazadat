import 'package:flutter/material.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../data/entity/view_auction_details_entity.dart';

class AuctionDescriptionComponent extends StatelessWidget {
  const AuctionDescriptionComponent({
    super.key,
    required this.auction,
  });

  final ViewAuctionDetailsEntity auction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.productDescription.tr,
          style:
              AppTextStyles.textLgBold.copyWith(color: AppColors.kPrimary900),
        ),
        const SizedBox(height: 16),
        Text(
          auction.description,
          style: AppTextStyles.textLgRegular
              .copyWith(color: AppColors.textPrimaryParagraph),
        ),
      ],
    );
  }
}
