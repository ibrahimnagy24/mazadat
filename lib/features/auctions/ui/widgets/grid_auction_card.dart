import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../../favourites/ui/widgets/favourite_button.dart';
import '../../../auction_details/data/params/auction_details_route_params.dart';
import '../../data/entity/auction_entity.dart';

class GridAuctionCard extends StatelessWidget {
  const GridAuctionCard(
      {super.key,
      required this.auction,
      this.fromMyPurchase = false,
      this.height});
  final AuctionEntity auction;
  final bool fromMyPurchase;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (fromMyPurchase) {
          CustomNavigator.push(Routes.VIEW_ORDER_DETAILS, extra: auction.id);
        } else {
          CustomNavigator.push(
            Routes.AUCTION_DETAILS,
            extra: AuctionDetailsRouteParams(
                auctionId: auction.id, primaryImage: auction.primaryPhoto),
          );
        }
      },
      child: Container(
        height: height,
        width: MediaQueryHelper.width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rXS),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                DefaultNetworkImage(
                  auction.primaryPhoto,
                  radius: AppRadius.rXXS,
                  height: 135,
                ),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(AppRadius.rXXS),
                          bottomEnd: Radius.circular(AppRadius.rLg),
                        ),
                        color: AppColors.backgroundSecondary,
                      ),
                      child: Text(
                        auction.auctionStatus,
                        style: AppTextStyles.textMdRegular
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    )),
                PositionedDirectional(
                  end: 4,
                  top: 4,
                  child: SvgPicture.asset(
                    AppSvg.auctionType(auction.auctionType),
                    color: AppColors.kWhite,
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                  text: AppStrings.openingPrice.tr,
                  style: AppTextStyles.bodyXXsReq
                      .copyWith(color: AppColors.textSecondaryParagraph),
                ),
                Center(
                  child: MainText(
                    text: auction.openingPrice,
                    style: AppTextStyles.bodySMed
                        .copyWith(color: AppColors.kPrimary),
                  ),
                ),
                SvgPicture.asset(
                  AppSvg.saudiArabiaSymbol,
                  color: AppColors.textPrimary,
                  height: 14,
                  width: 14,
                ),
              ],
            ),
            const SizedBox(height: 9),
            AuctionInfo(
              auction: auction,
              fromMyPurchase: fromMyPurchase,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class AuctionInfo extends StatelessWidget {
  const AuctionInfo(
      {super.key, required this.auction, this.fromMyPurchase = false});
  final AuctionEntity auction;
  final bool fromMyPurchase;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!fromMyPurchase)
          SvgPicture.asset(
            AppSvg.timer,
            color: AppColors.textSecondaryParagraph,
            height: 16,
            width: 16,
          ),
        const SizedBox(width: 6),
        Expanded(
          child: fromMyPurchase
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        AppStrings.orderNumber.tr,
                        style: AppTextStyles.textMdRegular,
                        maxLines: 1,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        auction.orderNumber ?? 'ss2',
                        style: AppTextStyles.bodySReq,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              : CountdownTimerWidget(
                  startDate: auction.startDate,
                  endTime: auction.endDate,
                  textStyle: AppTextStyles.textMdRegular.copyWith(
                    color: const Color.fromRGBO(69, 173, 34, 1),
                  ),
                ),
        ),
        FavouriteButton(
          id: auction.id,
          isFav: auction.isFav,
          withBackGround: false,
        ),
      ],
    );
  }
}
