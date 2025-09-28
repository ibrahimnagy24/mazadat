import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../data/entity/view_auction_details_entity.dart';

class AuctionPriceWidgetComponent extends StatelessWidget {
  const AuctionPriceWidgetComponent({
    super.key,
    required this.auction,
  });

  final ViewAuctionDetailsEntity auction;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: const RectDottedBorderOptions(
        strokeWidth: 1,
        color: Color.fromRGBO(138, 147, 118, 1),
        dashPattern: [3, 5],
        padding: EdgeInsets.zero,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.kOpacityGrey3,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.kOpacityGrey),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _buildDynamicCountdownWidget(auction),
              ),
              const DottedBorder(
                options: RectDottedBorderOptions(
                  strokeWidth: 1,
                  color: Color.fromRGBO(138, 147, 118, 1),
                  dashPattern: [3, 5],
                  padding: EdgeInsets.zero,
                ),
                child: SizedBox(
                  width: 1,
                  height: 56,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      AppStrings.openingPrice.tr,
                      style: AppTextStyles.bodyXsMed
                          .copyWith(color: AppColors.textSecondaryParagraph),
                    ),
                    const SizedBox(height: 4),
                    PriceWidgetWithFlagWidget(
                      price: auction.openingPrice,
                      priceStyle: AppTextStyles.textXLBold,
                      colorFilter: const ColorFilter.mode(
                        AppColors.kPrimary,
                        BlendMode.srcIn,
                      ),
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Widget _buildDynamicCountdownWidget(ViewAuctionDetailsEntity auction) {
    return StreamBuilder<DateTime>(
      stream:
          Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final startDate = auction.startDate;
        final endDate = auction.endDate;

        // Handle null dates
        if (startDate == null || endDate == null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppSvg.clockIcon),
                  const SizedBox(width: 4),
                  Text(
                    mainAppBloc.isArabic
                        ? 'لا يوجد تاريخ'
                        : 'No Date Available',
                    style: AppTextStyles.bodyXsMed
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '--:--:--',
                style: AppTextStyles.bodyXlBold.copyWith(
                  color: AppColors.textSecondaryParagraph,
                ),
              ),
            ],
          );
        }

        // Type 1: startTime > currentTime - countdown to start (can go negative)
        if (startDate.isAfter(now)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppSvg.clockIcon),
                  const SizedBox(width: 4),
                  Text(
                    AppStrings.startsIn.tr,
                    style: AppTextStyles.bodyXsMed
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              CountdownTimerWidget(
                startDate: now,
                endTime: startDate,
                showSeconds: true,
                showMinutes: true,
                textStyle: AppTextStyles.bodyXlBold.copyWith(
                  color: AppColors.textSuccess,
                  fontSize: 12,
                ),
              ),
            ],
          );
        }

        // Type 2: startTime < currentTime - countdown to end with "Ends At"
        else if (endDate.isAfter(now)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppSvg.clockIcon),
                  const SizedBox(width: 4),
                  Text(
                    mainAppBloc.isArabic ? 'ينتهي في' : 'Ends At',
                    style: AppTextStyles.bodyXsMed
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              CountdownTimerWidget(
                startDate: now,
                endTime: endDate,
                showSeconds: true,
                showMinutes: true,
                textStyle: AppTextStyles.bodyXlBold.copyWith(
                  color: AppColors.textError,
                ),
              ),
            ],
          );
        }

        // Type 3: endTime < currentTime - show static end date without countdown
        else {
          final endTimeFormatted =
              "${endDate.day}/${endDate.month}/${endDate.year} ${endDate.hour.toString().padLeft(2, '0')}:${endDate.minute.toString().padLeft(2, '0')}";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Text(
                mainAppBloc.isArabic ? 'انتهي المزاد في' : 'Auction Ended At',
                style: AppTextStyles.bodyXsReq.copyWith(
                  color: AppColors.textSecondaryParagraph,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                endTimeFormatted,
                style: AppTextStyles.bodyXlBold.copyWith(
                  color: AppColors.textSecondaryParagraph,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
