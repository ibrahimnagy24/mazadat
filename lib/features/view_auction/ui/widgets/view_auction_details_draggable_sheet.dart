import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/services/toast_service.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../auction_joining/ui/pages/validate_joining_auction_view.dart';
import '../../../favourites/ui/widgets/favourite_button.dart';
import '../../data/entity/view_auction_details_entity.dart';
import '../../data/params/auction_bid_params.dart';
import '../../logic/view_auction_details_cubit.dart';
import '../../utils/view_auction_details_controller.dart';
import '../bottom_sheets/bidding_options_bottom_sheet.dart';
import 'glassy_images_row.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';

class ViewAuctionDetailsDraggableSheet extends StatelessWidget {
  const ViewAuctionDetailsDraggableSheet({
    super.key,
    required this.controller,
  });

  final ViewAuctionDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewAuctionDetailsCubit>();
    return DraggableScrollableSheet(
      controller: controller.sheetController,
      initialChildSize: 0.5,
      minChildSize: .4,
      maxChildSize: 0.7,
      snap: true,
      snapSizes: const [0.4, 0.7],
      builder: (context, scrollController) {
        return Column(
          children: [
            ViewAuctionDetailsGlassyImagesRow(controller: controller),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: AppColors.kOpacityGrey3,
                      width: 1,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 50,
                    )
                  ],
                ),
                child: ListAnimator(
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 50,
                    left: 24,
                    right: 24,
                  ),
                  data: [
                    _buildAuctionHeader(cubit.auctionDetails!),
                    const SizedBox(height: 16),
                    _BuildPriceWidget(auction: cubit.auctionDetails!),
                    const SizedBox(height: 16),
                    _buildDescription(cubit.auctionDetails!),
                    const SizedBox(height: 16),
                    _buildEstimatedValueOrDates(context, cubit.auctionDetails!),
                    const SizedBox(height: 24),
                    _ViewAuctionDetailsContent(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAuctionHeader(ViewAuctionDetailsEntity auction) {
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

  Widget _buildDescription(ViewAuctionDetailsEntity auction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.productDescription.tr,
          style:
              AppTextStyles.textLgBold.copyWith(color: AppColors.kPrimary900),
        ),
        const SizedBox(height: 16),
        Text(
          auction.description,
          style: AppTextStyles.textLgRegular
              .copyWith(color: AppColors.textPrimaryParagraph),
        ),
      ],
    );
  }

  Widget _buildEstimatedValueOrDates(
      BuildContext context, ViewAuctionDetailsEntity auction) {
    return auction.isStarted
        ? _buildEstimatedValue(context, auction)
        : _buildAuctionDates(auction);
  }

  Widget _buildEstimatedValue(
      BuildContext context, ViewAuctionDetailsEntity auction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.estimatedValue.tr,
          style:
              AppTextStyles.textLgBold.copyWith(color: AppColors.kPrimary900),
        ),
        const SizedBox(height: 28),
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
                price: '${auction.currentBiddingAmount}',
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                colorFilter: const ColorFilter.mode(
                  AppColors.kPrimary,
                  BlendMode.srcIn,
                ),
                priceStyle: AppTextStyles.displaySMMedium
                    .copyWith(color: AppColors.kPrimary, fontSize: 20),
              ),
            ),
            PositionedDirectional(
              top: 0,
              start: 20,
              child: Transform.translate(
                offset: const Offset(0, -10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.kOpacityGrey3,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: MainText(
                    text: AppStrings.actualPrice.tr,
                    style: AppTextStyles.textMdRegular
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: AppColors.iconDefault,
              size: 16,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                AppStrings
                    .theCurrentPriceIsDeterminedAutomaticallyBasedOnAPercentageOfTheOpeningPriceValue
                    .tr,
                style: AppTextStyles.textMdRegular,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildAuctionDates(ViewAuctionDetailsEntity auction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (auction.startDate != null)
          _buildDateRow(
            AppStrings.auctionStartDate.tr,
            auction.startDate!,
          ),
        if (auction.endDate != null) const SizedBox(height: 8),
        if (auction.endDate != null)
          _buildDateRow(
            AppStrings.auctionEndDate.tr,
            auction.endDate!,
          ),
      ],
    );
  }

  Widget _buildDateRow(String label, DateTime date) {
    return Row(
      spacing: 8.w,
      children: [
        customImageIconSVG(
          imageName: AppSvg.calendar,
          width: 16.w,
          height: 16.w,
          color: AppColors.textSecondaryParagraph,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label  ',
              style: AppTextStyles.textLgRegular,
              children: [
                TextSpan(
                  text: date.toDateFormat(
                    format: 'd MMMM yyyy',
                    locale: mainAppBloc.lang.valueOrNull,
                  ),
                  style: AppTextStyles.textLgRegular
                      .copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ViewAuctionDetailsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAuctionDetailsCubit, ViewAuctionDetailsState>(
      builder: (context, state) {
        final cubit = context.read<ViewAuctionDetailsCubit>();
        final auction = cubit.auctionDetails;
        if (!Utility.isUserLoggedIn()) {
          return const SizedBox();
        }
        if (auction == null) {
          return const SizedBox();
        }

        if (auction.isEnded) {
          return _buildEndedAuctionButton();
        }

        if (auction.isJoined == false) {
          return _buildJoinAuctionButton(context, auction.id);
        }
        if (auction.isJoined && auction.firstBid) {
          return _buildButtonBidWidget(context, auction);
        }
        if (_shouldShowManualBidding(auction)) {
          return _buildButtonBidWidget(context, auction);
        }
        if (_shouldShowAutoBiddingSwitch(auction)) {
          return _buildAutoBiddingButton(context, auction);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildEndedAuctionButton() {
    return DefaultButton(
      onPressed: () {},
      text: AppStrings.auctionEnded.tr,
      textStyle: AppTextStyles.bodyXlBold.copyWith(color: AppColors.kWhite),
    );
  }

  Widget _buildJoinAuctionButton(
    BuildContext context,
    int auctionId,
  ) {
    return DefaultButton(
      onPressed: () => CustomBottomSheet.show(
        widget: ValidateJoiningAuctionView(
          id: auctionId,
          onSuccess: () => context
              .read<ViewAuctionDetailsCubit>()
              .viewAuctionDetailsStatesHandled(),
        ),
      ),
      text: AppStrings.registerForTheAuction.tr,
      textStyle: AppTextStyles.bodyXlBold.copyWith(color: AppColors.kWhite),
    );
  }

  Widget _buildButtonBidWidget(
    BuildContext context,
    ViewAuctionDetailsEntity auction,
  ) {
    return BlocConsumer<ViewAuctionDetailsCubit, ViewAuctionDetailsState>(
      listener: (context, state) {
        if (state is AuctionBidError) {
          ToastService.showError(
            state.error.message,
            context,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is AuctionBidSuccess ||
          current is AuctionBidError ||
          current is AuctionBidLoading,
      builder: (context, state) {
        return Column(
          children: [
            DefaultButton(
              onPressed: state is AuctionBidLoading
                  ? null
                  : () {
                      final cubit = context.read<ViewAuctionDetailsCubit>();
                      if (auction.firstBid == false) {
                        cubit.auctionBidStatesHandled(
                          AuctionBidParams(
                            auctionId: auction.id,
                            biddingMethod: BiddingMethod.manual,
                          ),
                        );
                        return;
                      }
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (bottomSheetContext) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: BiddingOptionsBottomSheet(
                              cubit: context.read<ViewAuctionDetailsCubit>(),
                              bottomSheetContext: bottomSheetContext,
                            ),
                          );
                        },
                      );
                      return;
                    },
              text: auction.firstBid
                  ? AppStrings.bidding.tr
                  : '${AppStrings.bidWith.tr} ${(auction.currentBiddingAmount + auction.biddingIncrementAmount)}',
              isLoading: state is AuctionBidLoading,
              isInActive: context
                  .read<ViewAuctionDetailsCubit>()
                  .isIamLastBidder(context),
              textStyle:
                  AppTextStyles.bodyXlBold.copyWith(color: AppColors.kWhite),
            ),
            if (_shouldShowAutoBiddingSwitch(auction) &&
                context
                        .read<ViewAuctionDetailsCubit>()
                        .isIamLastBidder(context) ==
                    false)
              _buildAutoBiddingButton(context, auction),
          ],
        );
      },
    );
  }

  Widget _buildAutoBiddingButton(
    BuildContext context,
    ViewAuctionDetailsEntity auction,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: BiddingOptionsBottomSheet(
                  cubit: context.read<ViewAuctionDetailsCubit>(),
                  bottomSheetContext: bottomSheetContext,
                  title: AppStrings.areYouSureYouWantToBidAutomatically.tr,
                  isAutoBidding: true,
                  needToSelectBiddingMethod: false,
                ),
              );
            },
          );
          return;
        },
        child: Text(
          AppStrings.automaticBidding.tr,
          style: AppTextStyles.bodyXsMed
              .copyWith(color: const Color.fromRGBO(81, 94, 50, 1)),
        ),
      ),
    );
  }

  bool _shouldShowManualBidding(ViewAuctionDetailsEntity auction) {
    return (auction.isJoined &&
            !auction.firstBid &&
            auction.currentBiddingMethod == BiddingMethod.manual) ||
        (auction.currentBiddingAmount >= auction.maxBiddingAmount &&
            auction.currentBiddingMethod == BiddingMethod.auto);
  }

  bool _shouldShowAutoBiddingSwitch(ViewAuctionDetailsEntity auction) {
    return (auction.isJoined &&
            !auction.firstBid &&
            auction.autoBiddingEnabled &&
            auction.currentBiddingMethod == BiddingMethod.manual) ||
        (auction.currentBiddingAmount >= auction.maxBiddingAmount &&
            auction.currentBiddingMethod == BiddingMethod.auto &&
            !auction.autoBiddingEnabled);
  }
}

class _BuildPriceWidget extends StatelessWidget {
  const _BuildPriceWidget({required this.auction});
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
                    'No Date Available',
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
                startDate: startDate,
                endTime: now,
                textStyle: AppTextStyles.bodyXlBold.copyWith(
                  color: AppColors.textSuccess,
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
                    'Ends At',
                    style: AppTextStyles.bodyXsMed
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              CountdownTimerWidget(
                startDate: endDate,
                endTime: now,
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
                'Auction Ended At',
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
