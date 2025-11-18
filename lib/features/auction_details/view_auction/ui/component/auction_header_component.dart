import 'package:flutter/material.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../../favourites/ui/widgets/favourite_button.dart';
import '../../data/entity/view_auction_details_entity.dart';

class AuctionHeaderComponent extends StatelessWidget {
  const AuctionHeaderComponent({
    super.key,
    required this.auction,
  });

  final ViewAuctionDetailsEntity auction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FavouriteButton(
          id: auction.id,
          isFav: auction.myfav == true,
          withBackGround: true,
          height: 44,
          width: 44,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                auction.name,
                style: AppTextStyles.displaySMMedium
                    .copyWith(color: AppColors.buttonBackgroundPrimaryDefault),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  text: AppStrings.auctionNumber.tr,
                  style: AppTextStyles.textMdRegular
                      .copyWith(color: AppColors.textSecondaryParagraph),
                  children: [
                    const WidgetSpan(child: SizedBox(width: 4)),
                    TextSpan(
                      text: ' ${auction.auctionNumber}',
                      style: AppTextStyles.textLgRegular
                          .copyWith(color: AppColors.textPrimaryParagraph),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Center(
            child: MainText(
              text: auction.auctionType == AuctionType.public
                  ? AppStrings.public.tr
                  : AppStrings.private.tr,
              style: AppTextStyles.textMdRegular
                  .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
            ),
          ),
        )
      ],
    );
  }
}
