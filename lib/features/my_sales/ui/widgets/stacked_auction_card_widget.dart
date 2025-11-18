import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/auction_entity.dart';

class StackedAuctionCardWidget extends StatelessWidget {
  const StackedAuctionCardWidget({
    super.key,
    this.onTap,
    this.height = 213,
    this.imageHeight = 137,
    required this.auction,
  });

  final void Function()? onTap;
  final double height;
  final double imageHeight;
  final AuctionEntity auction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
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
              height: imageHeight + 15,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  SizedBox(
                    height: imageHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.rMd),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          // Display auction image if available
                          auction.images.isNotEmpty
                              ? DefaultNetworkImage(
                                  auction.images.first.path,
                                  height: 137,
                                )
                              : Container(
                                  height: 137,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.rMd),
                                    color: AppColors.kGeryText8,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.gavel_outlined,
                                      size: 48,
                                      color: AppColors.textSecondaryParagraph,
                                    ),
                                  ),
                                ),
                          if (auction.status.isNotEmpty)
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
                                  auction.status,
                                  style: AppTextStyles.textMdRegular
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                              ),
                            ),
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
                          Expanded(
                            child: _AuctionFinance(
                              openingPrice: auction.openingPrice,
                              auction: auction,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _AuctionOrderInfo(
              auctionName: auction.name,
              auctionId: auction.id,
              auction: auction,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuctionFinance extends StatelessWidget {
  const _AuctionFinance({
    required this.openingPrice,
    required this.auction,
  });

  final String openingPrice;
  final AuctionEntity auction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(138, 147, 118, 1),
        borderRadius: BorderRadius.circular(AppRadius.rXXS),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainText(
            text: AppStrings.openingPrice.tr,
            style: AppTextStyles.textMdRegular
                .copyWith(color: const Color.fromRGBO(250, 250, 250, 1)),
          ),
          const SizedBox(width: 4),
          MainText(
            text: openingPrice,
            style: AppTextStyles.textLgBold
                .copyWith(color: const Color.fromRGBO(255, 255, 255, 1)),
          ),
          const SizedBox(width: 4),
          SvgPicture.asset(
            AppSvg.saudiArabiaSymbol,
            color: AppColors.kWhite,
            height: 14,
            width: 14,
          ),
        ],
      ),
    );
  }
}

class _AuctionOrderInfo extends StatelessWidget {
  const _AuctionOrderInfo({
    required this.auctionName,
    required this.auctionId,
    required this.auction,
  });

  final String auctionName;
  final int auctionId;
  final AuctionEntity auction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainText(
              text: AppStrings.orderNumber.tr,
              style: AppTextStyles.bodyXsReq
                  .copyWith(color: const Color.fromRGBO(162, 162, 162, 1)),
            ),
            const SizedBox(width: 4),
            MainText(
              text: auction.productId.toString(),
              style: AppTextStyles.bodySReq
                  .copyWith(color: const Color.fromRGBO(116, 116, 116, 1)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                height: 16,
                color: AppColors.textSecondaryParagraph,
              ),
              const SizedBox(width: 4),
              Text(
                auction.endDate.isNotEmpty
                    ? AppStrings.endDate.tr
                    : AppStrings.latestUpdate.tr,
                style: AppTextStyles.textMdRegular,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                DateTime.parse(auction.endDate).toDateFormat(
                  format: 'd MMMM yyyy',
                  locale: mainAppBloc.lang.valueOrNull,
                ),
                maxLines: 1,
                style: AppTextStyles.textLgRegular
                    .copyWith(color: AppColors.textPrimaryParagraph),
              )
            ],
          ),
        ),
      ],
    );
  }
}
