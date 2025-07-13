import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/custom_images.dart';
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
          CustomNavigator.push(
            Routes.AUCTION_DETAILS,
            extra: AuctionDetailsRouteParams(
                auctionId: auction.id, primaryImage: auction.primaryPhoto),
          );
        }
      },
      child: Container(
        height: 100.h,
        width: MediaQueryHelper.width,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  DefaultNetworkImage(auction.primaryPhoto,
                      radius: AppRadius.rXXS),

                  ///Auction Status
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.w),
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

                  ///Auction Type
                  PositionedDirectional(
                    end: 4.w,
                    top: 4.h,
                    child: customImageIconSVG(
                        imageName: AppSvg.auctionType(auction.auctionType),
                        color: AppColors.kWhite,
                        width: 24.w,
                        height: 24.w),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                spacing: 4.w,
                children: [
                  MainText(
                    text: AppStrings.openingPrice.tr,
                    style: AppTextStyles.bodyRegular.copyWith(fontSize: 10),
                  ),
                  MainText(
                    text: auction.openingPrice,
                    style: AppTextStyles.bodyMedium,
                  ),
                  SvgPicture.asset(AppSvg.saudiArabiaSymbol,
                      color: AppColors.textPrimary),
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

class AuctionInfo extends StatelessWidget {
  const AuctionInfo(
      {super.key, required this.auction, this.fromMyPurchase = false});
  final AuctionEntity auction;
  final bool fromMyPurchase;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        if (!fromMyPurchase)
          customImageIconSVG(
              imageName: AppSvg.timer,
              width: 16.w,
              height: 16.w,
              color: AppColors.iconDefault),
        Expanded(
          child: fromMyPurchase
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 4.w,
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
                  fontSize: 12),
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
