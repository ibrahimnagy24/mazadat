import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../user/logic/user_cubit.dart';
import '../data/entity/view_auction_details_entity.dart';
import '../data/model/auction_bidding_model.dart';
import '../data/params/auction_bid_params.dart';
import '../data/params/get_auction_details_params.dart';
import '../data/params/view_auction_details_route_params.dart';
import '../data/repo/view_auction_details_repo.dart';
part 'view_auction_details_state.dart';

class ViewAuctionDetailsCubit extends Cubit<ViewAuctionDetailsState> {
  ViewAuctionDetailsCubit() : super(ViewAuctionDetailsInitial());
  //---------------------------------VARIABLES----------------------------------//
  late ViewAuctionDetailsRouteParams routeParams;
  ViewAuctionDetailsEntity? auctionDetails;
  int currentImageIndex = 0;
  //---------------------------------FUNCTIONS----------------------------------//
  void init(ViewAuctionDetailsRouteParams routeParams) {
    this.routeParams = routeParams;
  }

  void changeImageIndex(int index) {
    if (auctionDetails?.attachments != null &&
        index >= 0 &&
        index < auctionDetails!.attachments.length) {
      currentImageIndex = index;
      emit(ViewAuctionDetailsImageChanged(currentImageIndex));
    }
  }

  void nextImage() {
    if (auctionDetails?.attachments != null &&
        auctionDetails!.attachments.isNotEmpty) {
      final nextIndex =
          (currentImageIndex + 1) % auctionDetails!.attachments.length;
      changeImageIndex(nextIndex);
    }
  }

  void previousImage() {
    if (auctionDetails?.attachments != null &&
        auctionDetails!.attachments.isNotEmpty) {
      final prevIndex = currentImageIndex == 0
          ? auctionDetails!.attachments.length - 1
          : currentImageIndex - 1;
      changeImageIndex(prevIndex);
    }
  }

  bool isIamLastBidder(BuildContext context) {
    if (auctionDetails == null || auctionDetails?.lastBidderId == null) {
      return false;
    }
    final lastBidderId = int.tryParse(auctionDetails!.lastBidderId.toString());

    if (lastBidderId == null) {
      return false;
    }

    final userId = mainAppBloc.globalUserData!.id;
    return lastBidderId == userId;
  }

  bool isUserExceedMaxBiddingAmount(BuildContext context) {
    if (auctionDetails?.isEnded == true) {
      return false;
    }
    if (auctionDetails?.currentBiddingMethod == BiddingMethod.manual) {
      return false;
    }
    return auctionDetails?.currentBiddingMethod == BiddingMethod.auto &&
        auctionDetails?.isJoined == true &&
        isIamLastBidder(context) == false &&
        (auctionDetails?.currentBiddingAmount ?? 0) >=
            (auctionDetails?.maxBiddingAmount ?? 0);
  }
  //----------------------------------REQUEST-----------------------------------//

  Future<void> viewAuctionDetailsStatesHandled() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const ViewAuctionDetailsLoading());
    try {
      final response = await ViewAuctionDetailsRepo.getAuctionDetails(
        GetAuctionDetailsParams(id: routeParams.auctionId),
      );
      response.fold(
        (failure) {
          CustomNavigator.context.loaderOverlay.hide();
          return emit(ViewAuctionDetailsError(failure));
        },
        (success) async {
          CustomNavigator.context.loaderOverlay.hide();
          auctionDetails = success;

          return emit(ViewAuctionDetailsSuccess(success));
        },
      );
    } catch (e) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(
        ViewAuctionDetailsError(
          ErrorEntity(message: e.toString(), statusCode: 400, errors: const []),
        ),
      );
    }
  }

  Future<void> auctionBidStatesHandled(AuctionBidParams params) async {
    emit(const AuctionBidLoading());
    try {
      final response = await ViewAuctionDetailsRepo.auctionBid(params);
      response.fold(
        (failure) {
          return emit(AuctionBidError(failure));
        },
        (success) async {
          return emit(AuctionBidSuccess(success));
        },
      );
    } catch (e) {
      return emit(
        AuctionBidError(
          ErrorEntity(message: e.toString(), statusCode: 400, errors: const []),
        ),
      );
    }
  }
}
