import 'package:flutter/material.dart';
import '../../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/view_auction_details_entity.dart';

class AuctionEstimatedValueComponent extends StatelessWidget {
  const AuctionEstimatedValueComponent({
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
          AppStrings.estimatedValue.tr,
          style:
              AppTextStyles.textLgBold.copyWith(color: AppColors.kPrimary900),
        ),
        const SizedBox(height: 28),
        Stack(
          children: [
            Container(
              height: 60,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppColors.kOpacityGrey3,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: PriceWidgetWithFlagWidget(
                price: '${auction.currentBiddingAmount}',
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                colorFilter: const ColorFilter.mode(
                  AppColors.kPrimary,
                  BlendMode.srcIn,
                ),
                priceStyle: AppTextStyles.displaySMMedium
                    .copyWith(color: AppColors.kPrimary, fontSize: 20),
              ),
            ),
            PositionedDirectional(
              top: 0,
              start: 20,
              child: Transform.translate(
                offset: const Offset(0, -10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.kOpacityGrey3,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: MainText(
                    text: AppStrings.actualPrice.tr,
                    style: AppTextStyles.textMdRegular
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: AppColors.iconDefault,
              size: 16,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                AppStrings
                    .theCurrentPriceIsDeterminedAutomaticallyBasedOnAPercentageOfTheOpeningPriceValue
                    .tr,
                style: AppTextStyles.textMdRegular,
              ),
            )
          ],
        )
      ],
    );
  }
}
