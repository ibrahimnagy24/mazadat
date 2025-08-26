import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../../favourites/ui/widgets/favourite_button.dart';
import '../../../view_auction/data/params/view_auction_details_route_params.dart';
import '../../data/entity/auction_entity.dart';

class ListAuctionCard extends StatelessWidget {
  const ListAuctionCard(
      {super.key, required this.auction, this.fromMyPurchase = false});
  final AuctionEntity auction;
  final bool fromMyPurchase;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (fromMyPurchase) {
          CustomNavigator.push(Routes.VIEW_ORDER_DETAILS, extra: auction.id);
        } else {
          // CustomNavigator.push(
          //   Routes.AUCTION_DETAILS,
          //   extra: AuctionDetailsRouteParams(
          //     auctionId: auction.id,
          //     primaryImage: auction.primaryPhoto,
          //   ),
          // );
          // CustomNavigator.push(
          //   Routes.PREVIEW_AUCTION,
          //   extra: PreviewAuctionRouteParams(
          //       auctionId: auction.id, primaryImage: auction.primaryPhoto),
          // );
          CustomNavigator.push(
            Routes.VIEW_AUCTION_DETAILS,
            extra: ViewAuctionDetailsRouteParams(
              auctionId: auction.id,
              primaryImage: auction.primaryPhoto,
            ),
          );
        }
      },
      child: Container(
        height: 213,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rMd),
          color: const Color.fromRGBO(255, 255, 255, 0.5),
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 153,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  SizedBox(
                    height: 137,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.rMd),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          DefaultNetworkImage(
                            auction.primaryPhoto,
                            height: 137,
                          ),
                          PositionedDirectional(
                            top: 0,
                            start: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(AppRadius.rMd),
                                  topStart: Radius.circular(AppRadius.rMd),
                                ),
                                color: AppColors.backgroundSecondary,
                              ),
                              child: Text(
                                auction.auctionStatus,
                                style: AppTextStyles.textMdRegular
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                            ),
                          ),

                          ///Auction Type
                          PositionedDirectional(
                            start: 8,
                            top: 35,
                            child: SvgPicture.asset(
                              AppSvg.auctionType(auction.auctionType),
                              color: AppColors.kWhite,
                              width: 24,
                              height: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: _AuctionFinance(auction: auction)),
                          const SizedBox(width: 16),
                          FavouriteButton(
                            id: auction.id,
                            isFav: auction.isFav,
                            withBackGround: true,
                            height: 40,
                            width: 40,
                            favIconHeight: 35,
                            favIconWidth: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AuctionInfo(
              auction: auction,
              fromMyPurchase: fromMyPurchase,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuctionFinance extends StatelessWidget {
  const _AuctionFinance({required this.auction});
  final AuctionEntity auction;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kPrimary500,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        spacing: 4,
        children: [
          MainText(
            text: AppStrings.openingPrice.tr,
            style:
                AppTextStyles.textMdRegular.copyWith(color: AppColors.kWhite),
          ),
          MainText(
            text: auction.openingPrice,
            style: AppTextStyles.textLgBold.copyWith(color: AppColors.kWhite),
          ),
          SvgPicture.asset(
            AppSvg.saudiArabiaSymbol,
            height: 14,
            width: 14,
          ),
        ],
      ),
    );
  }
}

class AuctionInfo extends StatelessWidget {
  const AuctionInfo({
    super.key,
    required this.auction,
    this.fromMyPurchase = false,
  });
  final AuctionEntity auction;
  final bool fromMyPurchase;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (!fromMyPurchase)
                SvgPicture.asset(
                  AppSvg.timer,
                  width: 16,
                  height: 16,
                  color: AppColors.textSecondaryParagraph,
                ),
              const SizedBox(width: 4),
              if (fromMyPurchase)
                Text(
                  AppStrings.orderNumber.tr,
                  style: AppTextStyles.textMdRegular,
                  maxLines: 1,
                ),
              fromMyPurchase
                  ? Text(
                      auction.orderNumber ?? 'ss2',
                      style: AppTextStyles.bodySReq,
                      maxLines: 1,
                    )
                  : CountdownTimerWidget(
                      startDate: auction.startDate,
                      endTime: auction.endDate,
                    ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                height: 16,
                color: AppColors.textSecondaryParagraph,
              ),
              const SizedBox(width: 4),
              Text(
                AppStrings.endDate.tr,
                style: AppTextStyles.textMdRegular,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                auction.endDate.toDateFormat(
                    format: 'd MMMM yyyy',
                    locale: mainAppBloc.lang.valueOrNull),
                maxLines: 1,
                style: AppTextStyles.textLgRegular
                    .copyWith(color: AppColors.textPrimaryParagraph),
              )
            ],
          )
        ],
      ),
    );
  }
}
