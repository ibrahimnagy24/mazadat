import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../../utils/enums/enums.dart';

class StackedAuctionCardWidget extends StatelessWidget {
  const StackedAuctionCardWidget({
    super.key,
    this.onTap,
    this.height = 213,
    this.imageHeight = 137,
    required this.image,
    this.auctionStatus,
    required this.auctionType,
    this.needFavouriteIcon = true,
    this.isFav = false,
    this.auctionFinanceText,
    this.auctionFianancePrice,
    this.startDate,
    this.endDate,
    required this.auctionId,
  });
  final void Function()? onTap;
  final double height;
  final double imageHeight;
  final String image;
  final String? auctionStatus;
  final AuctionType auctionType;
  final bool needFavouriteIcon;
  final bool isFav;
  final String? auctionFinanceText;
  final String? auctionFianancePrice;
  final DateTime? startDate;
  final DateTime? endDate;
  final int auctionId;

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
                          DefaultNetworkImage(
                            image,
                            height: 137,
                          ),
                          if (auctionStatus != null &&
                              auctionStatus!.isNotEmpty)
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
                                  auctionStatus!,
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
                              AppSvg.auctionType(auctionType),
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
                          Expanded(
                            child: _AuctionFinance(
                              auctionFinanceText: auctionFinanceText,
                              auctionFianancePrice: auctionFianancePrice,
                            ),
                          ),
                          if (needFavouriteIcon) const SizedBox(width: 16),
                          if (needFavouriteIcon)
                            Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundBody,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, -1),
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                    color: Colors.black.withValues(alpha: 0.1),
                                  )
                                ],
                              ),
                              child: SvgPicture.asset(
                                isFav ? AppSvg.fillFav : AppSvg.fav,
                                width: 40,
                                height: 40,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AuctionInfo(startDate: startDate, endDate: endDate),
          ],
        ),
      ),
    );
  }
}

class _AuctionFinance extends StatelessWidget {
  const _AuctionFinance({
    required this.auctionFinanceText,
    required this.auctionFianancePrice,
  });
  final String? auctionFinanceText;
  final String? auctionFianancePrice;

  @override
  Widget build(BuildContext context) {
    if (auctionFinanceText == null && auctionFianancePrice == null) {
      return const SizedBox.shrink();
    }
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
            text: auctionFinanceText ?? AppStrings.openingPrice.tr,
            style:
                AppTextStyles.textMdRegular.copyWith(color: AppColors.kWhite),
          ),
          MainText(
            text: auctionFianancePrice,
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
    this.endDate,
    this.startDate,
  });
  final DateTime? startDate;
  final DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (startDate != null && endDate != null)
            Row(
              children: [
                SvgPicture.asset(
                  AppSvg.timer,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 6),
                CountdownTimerWidget(
                  startDate: startDate!,
                  endTime: endDate!,
                  textStyle: AppTextStyles.textLgBold
                      .copyWith(color: const Color.fromRGBO(69, 173, 34, 1)),
                ),
              ],
            ),
          if (endDate != null)
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
                  endDate!.toDateFormat(
                    format: 'd MMMM yyyy',
                    locale: mainAppBloc.lang.valueOrNull,
                  ),
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
