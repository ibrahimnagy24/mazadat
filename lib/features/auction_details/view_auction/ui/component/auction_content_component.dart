import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/utility.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../checkout/check_out_address/data/params/checkout_address_route_params.dart';
import '../../../../checkout/shipment_order_details/data/params/shipment_details_route_params.dart';
import '../../../auction_joining/ui/pages/validate_joining_auction_view.dart';
import '../../data/entity/view_auction_details_entity.dart';
import '../../data/params/auction_bid_params.dart';
import '../../logic/view_auction_details_cubit.dart';
import '../bottom_sheets/bidding_options_bottom_sheet.dart';

class AuctionContentComponent extends StatelessWidget {
  const AuctionContentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAuctionDetailsCubit, ViewAuctionDetailsState>(
      builder: (context, state) {
        final cubit = context.read<ViewAuctionDetailsCubit>();
        final auction = cubit.auctionDetails;
        if (!Utility.isUserLoggedIn()) {
          return DefaultButton(
            text: AppStrings.login.tr,
            onPressed: () {
              CustomNavigator.push(Routes.LOGIN_SCREEN);
            },
            textStyle: AppTextStyles.bodyXlBold.copyWith(
              color: AppColors.kWhite,
            ),
          );
        }
        if (auction == null) {
          return const SizedBox.shrink();
        }
        if (auction.shipment != null && auction.winner) {
          return _buildShipmentWidget(auction.shipment!);
        }
        if (auction.isEnded) {
          return _buildEndedAuctionButton(auction, cubit);
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

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShipmentWidget(AuctionShipmentEntity shipment) {
    return DefaultButton(
      onPressed: () {
        CustomNavigator.push(
          Routes.SHIPMENT_ORDER_DETAILS,
          extra: ShipmentDetailsRouteParams(shipmentId: shipment.id),
        );
      },
      text: AppStrings.orderTracking.tr,
      textStyle: AppTextStyles.bodyXlBold.copyWith(color: AppColors.kWhite),
    );
  }

  Widget _buildEndedAuctionButton(
    ViewAuctionDetailsEntity? auction,
    ViewAuctionDetailsCubit? cubit,
  ) {
    if (auction == null) {
      return const SizedBox.shrink();
    }
    if (auction.winner == true) {
      return DefaultButton(
        onPressed: () {
          CustomNavigator.push(
            Routes.CHECKOUT_ADDRESS,
            extra: CheckoutAddressRouteParams(
              auctionId: auction.id,
              cubit: cubit,
            ),
          );
        },
        text: AppStrings.completeYourPurchase.tr,
        textStyle: AppTextStyles.bodyXlBold.copyWith(color: AppColors.kWhite),
      );
    }
    if (auction.winner == false) {
      return DefaultButton(
        isInActive: true,
        text: AppStrings.auctionEnded.tr,
        textStyle: AppTextStyles.bodyXlBold.copyWith(color: AppColors.kWhite),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildJoinAuctionButton(BuildContext context, int auctionId) {
    return DefaultButton(
      onPressed: () => CustomBottomSheet.show(
        widget: ValidateJoiningAuctionView(
          id: auctionId,
          onSuccess: () => context
              .read<ViewAuctionDetailsCubit>()
              .viewAuctionDetailsStatesHandled(),
        ),
        dragColor: const Color.fromRGBO(46, 46, 46, 1),
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
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
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
              textStyle: AppTextStyles.bodyXlBold.copyWith(
                color: AppColors.kWhite,
              ),
            ),
            if (_shouldShowAutoBiddingSwitch(auction) &&
                context.read<ViewAuctionDetailsCubit>().isIamLastBidder(
                      context,
                    ) ==
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
          style: AppTextStyles.bodyXsMed.copyWith(
            color: const Color.fromRGBO(81, 94, 50, 1),
          ),
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
