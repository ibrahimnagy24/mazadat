import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../../favourites/ui/widgets/favourite_button.dart';
import '../../data/model/auction_details_model.dart';
import 'auction_actions.dart';

class AuctionContent extends StatelessWidget {
  const AuctionContent({super.key, required this.model});
  final AuctionDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        ///Auction Header
        Row(
          spacing: 12.w,
          children: [
            FavouriteButton(
              id: model.id,
              isFav: model.myfav == true,
              withBackGround: true,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name ?? '',
                    style: AppTextStyles.displaySMMedium.copyWith(fontSize: 20),
                  ),
                  RichText(
                    text: TextSpan(
                        text: AppStrings.auctionNumber.tr,
                        style: AppTextStyles.textMdRegular,
                        children: [
                          TextSpan(
                            text: " ${model.auctionNumber ?? ''}",
                            style: AppTextStyles.textLgRegular,
                          ),
                        ]),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.kOpacityGrey3,
                borderRadius: BorderRadius.circular(AppRadius.rM),
                border: Border.all(color: AppColors.kOpacityGrey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                model.auctionType?.name.tr ?? '',
                style: AppTextStyles.bodyXsReq,
              ),
            )
          ],
        ),
        DottedBorder(
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
                if (model.isStarted == true) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4.h,
                      children: [
                        Text(
                          AppStrings.endAfter.tr,
                          style: AppTextStyles.bodyXsReq,
                        ),
                        CountdownTimerWidget(
                          startDate: model.startDate ?? DateTime.now(),
                          endTime: model.endDate ?? DateTime.now(),
                        ),
                      ],
                    ),
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
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4.h,
                    children: [
                      Text(
                        AppStrings.openingPrice.tr,
                        style: AppTextStyles.bodyXsReq,
                      ),
                      PriceWidgetWithFlagWidget(
                        price: model.openingPrice ?? '',
                        priceStyle: AppTextStyles.textLgBold,
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
              ],
            ),
          ),
        ),

        ///Product Description
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              AppStrings.productDescription.tr,
              style: AppTextStyles.textLgBold
                  .copyWith(color: AppColors.textDefault),
            ),
            Text(
              model.description ?? '',
              style: AppTextStyles.textLgRegular,
            ),
          ],
        ),

        ///Estimated Value
        model.isStarted == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 14.h,
                children: [
                  Text(
                    AppStrings.estimatedValue.tr,
                    style: AppTextStyles.textLgBold
                        .copyWith(color: AppColors.textDefault),
                  ),
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
                          price: model.currentBiddingAmount ?? '',
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          colorFilter: const ColorFilter.mode(
                            AppColors.kPrimary,
                            BlendMode.srcIn,
                          ),
                          priceStyle: AppTextStyles.displaySMMedium.copyWith(
                              color: AppColors.kPrimary, fontSize: 20),
                        ),
                      ),
                      PositionedDirectional(
                        top: 0,
                        start: 20,
                        child: Transform.translate(
                          offset: const Offset(0, -10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.kOpacityGrey3,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: MainText(
                              text: AppStrings.actualPrice.tr,
                              style: AppTextStyles.textMdRegular,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  ///Estimated Value
                  Row(
                    spacing: 4.w,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.iconDefault,
                        size: 16,
                      ),
                      Expanded(
                          child: Text(
                        AppStrings
                            .theCurrentPriceIsDeterminedAutomaticallyBasedOnAPercentageOfTheOpeningPriceValue
                            .tr,
                        style: AppTextStyles.textMdRegular,
                      ))
                    ],
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.h,
                children: [
                  ///Auction Start Date
                  Row(
                    spacing: 8.w,
                    children: [
                      customImageIconSVG(
                          imageName: AppSvg.calendar,
                          width: 16.w,
                          height: 16.w,
                          color: AppColors.iconDefault),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: '${AppStrings.auctionStartDate.tr}  ',
                              style: AppTextStyles.textLgRegular,
                              children: [
                                TextSpan(
                                  text: model.startDate?.toDateFormat(
                                      format: 'd MMMM yyyy',
                                      locale: mainAppBloc.lang.valueOrNull),
                                  style: AppTextStyles.textLgRegular
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),

                  ///Auction End Date
                  Row(
                    spacing: 8.w,
                    children: [
                      customImageIconSVG(
                          imageName: AppSvg.calendar,
                          width: 16.w,
                          height: 16.w,
                          color: AppColors.iconDefault),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: '${AppStrings.auctionEndDate.tr}  ',
                              style: AppTextStyles.textLgRegular,
                              children: [
                                TextSpan(
                                  text: model.endDate?.toDateFormat(
                                      format: 'd MMMM yyyy',
                                      locale: mainAppBloc.lang.valueOrNull),
                                  style: AppTextStyles.textLgRegular
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

        SizedBox(height: 24.h),

        AuctionActions(
          id: model.id ?? 0,
          firstBidding: model.firstBid == true,
          isJoined: model.isJoined == true,
        ),
      ],
    );
  }
}
