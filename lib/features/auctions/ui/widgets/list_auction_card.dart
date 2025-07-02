import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radiuos/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../../favourites/ui/widgets/favourite_button.dart';
import '../../../auction_details/data/params/view_auction_route_params.dart';
import '../../data/entity/auction_entity.dart';

class ListAuctionCard extends StatelessWidget {
  const ListAuctionCard({super.key, required this.auction});
  final AuctionEntity auction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.push(
          Routes.VIEW_AUCTION,
          extra: ViewAuctionRouteParams(auctionId: auction.id.toString()),
        );
      },
      child: Container(
        height: 215.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  DefaultNetworkImage(auction.image),
                  Transform.translate(
                    offset: Offset(0, 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16.w,
                      children: [
                        Expanded(child: _AuctionFinance(auction: auction)),
                        FavouriteButton(
                          id: auction.id,
                          isFav: auction.isFav,
                          withBackGround: true,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Auction Status
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.h, horizontal: 12.w),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(AppRadius.rM),
                              bottomStart: Radius.circular(AppRadius.rM),
                            ),
                            color: AppColors.backgroundSecondary,
                          ),
                          child: Text(
                            auction.auctionStatus,
                            style: AppTextStyles.textMdRegular
                                .copyWith(color: AppColors.textPrimary),
                          ),
                        ),

                        ///Auction Type
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 8.w, top: 8.h),
                          child: customImageIconSVG(
                              imageName:
                                  AppSvg.auctionType(auction.auctionType),
                              color: AppColors.kWhite,
                              width: 24.w,
                              height: 24.w),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            AuctionInfo(auction: auction),
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
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Row(
        spacing: 4.w,
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
          SvgPicture.asset(AppSvg.saudiArabiaSymbol),
        ],
      ),
    );
  }
}

class AuctionInfo extends StatelessWidget {
  const AuctionInfo({super.key, required this.auction});
  final AuctionEntity auction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 4.w,
              children: [
                customImageIconSVG(
                    imageName: AppSvg.timer,
                    width: 16.w,
                    height: 16.w,
                    color: AppColors.iconDefault),
                Flexible(
                  child: Text(
                    AppStrings.auctionDuration.tr,
                    style: AppTextStyles.textMdRegular,
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  child: CountdownTimerWidget(
                    startDate: auction.startDate,
                    endTime: auction.endDate,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 4.w,
              children: [
                customImageIconSVG(
                    imageName: AppSvg.calendar,
                    width: 16.w,
                    height: 16.w,
                    color: AppColors.iconDefault),
                Flexible(
                  flex: 1,
                  child: Text(
                    AppStrings.endDate.tr,
                    style: AppTextStyles.textMdRegular,
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    auction.endDate.toDateFormat(
                        format: 'd MMMM yyyy',
                        locale: mainAppBloc.lang.valueOrNull),
                    maxLines: 1,
                    style: AppTextStyles.textLgRegular
                        .copyWith(color: AppColors.textPrimaryParagraph),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
