import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radiuos/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../../view_auction/data/params/view_auction_route_params.dart';
import '../../data/entity/auction_entity.dart';

class GridAuctionCard extends StatelessWidget {
  const GridAuctionCard({super.key, required this.auction});
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
        height: 260,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rM),
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _AuctionImage(image: auction.image),
                  Transform.translate(
                    offset: const Offset(0, 12),
                    child: _AuctionFinance(auction: auction),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(AppRadius.rM),
                          bottomEnd: Radius.circular(AppRadius.rM),
                        ),
                        color: AppColors.kPrimary400,
                      ),
                      child: MainText(
                        text: 'مُزايدة عامة',
                        style: AppTextStyles.bodyXsReq.copyWith(
                            color: const Color.fromRGBO(2, 136, 209, 1)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(AppRadius.rM),
                          bottomStart: Radius.circular(AppRadius.rM),
                        ),
                        color: AppColors.kPrimary500,
                      ),
                      child: MainText(
                        text: 'جارية',
                        style: AppTextStyles.bodyXsReq
                            .copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 2,
              child: AuctionInfo(auction: auction),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _AuctionImage extends StatelessWidget {
  const _AuctionImage({required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return DefaultNetworkImage(image);
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
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: PriceWidgetWithFlagWidget(price: auction.openingPrice),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MainText(
                  text: AppStrings.insuranceAmount.tr,
                  style: AppTextStyles.w500FontXXSkGeryText8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: MainText(
                    text: auction.insurancePrice,
                    style: AppTextStyles.bodyMBold,
                  ),
                ),
                SvgPicture.asset(AppSvg.saudiArabiaSymbol),
              ],
            ),
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                child: MainText(
                  text: auction.productName,
                  style: AppTextStyles.bodyMMed
                      .copyWith(color: AppColors.borderPrimary),
                  maxLines: 1,
                ),
              ),
              MainText(
                text: 'UC-${auction.id}',
                style: AppTextStyles.bodyXsReq
                    .copyWith(color: AppColors.kGeryText6),
                maxLines: 1,
              )
            ],
          ),
          const SizedBox(height: 8),
          MainText(
            text: auction.productDescription,
            style: AppTextStyles.bodySReq.copyWith(color: AppColors.kGeryText6),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppSvg.timer),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: MainText(
                        text: AppStrings.endsYet,
                        style: AppTextStyles.w400FontXXSkGeryText2,
                      ),
                    ),
                    CountdownTimerWidget(
                      language: mainAppBloc.isArabic ? 'ar' : 'en',
                      endTime: DateTime.parse(auction.endDate),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(AppSvg.calendar),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: MainText(
                        text: AppStrings.auctionDuration,
                        style: AppTextStyles.w400FontXXSkGeryText2,
                      ),
                    ),
                    MainText(
                      text: auction.auctionDuration,
                      style: AppTextStyles.bodyXsReq
                          .copyWith(color: AppColors.kGeryText4),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
