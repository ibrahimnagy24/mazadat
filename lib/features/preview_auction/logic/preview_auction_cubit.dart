import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pusher_service/pusher_cubit.dart';
import '../../pusher_service/pusher_state.dart';
import '../data/params/get_preview_auction_details_params.dart';
import '../data/repo/preview_auction_repository.dart';
import '../data/params/auction_details_route_params.dart';
import '../data/params/preview_auction_joining_params.dart';
import '../data/params/preview_auction_validation_params.dart';
import '../data/params/preview_auction_bidding_params.dart';
import '../data/params/preview_auction_withdrawal_params.dart';
import '../data/model/auction_details_model.dart';
import 'preview_auction_state.dart';

class PreviewAuctionCubit extends Cubit<PreviewAuctionState> {
  PreviewAuctionCubit({required this.pusherCubit})
      : super(PreviewAuctionInitial()) {
    // _pusherSubscription = pusherCubit.stream.listen(_onPusherStateChanged);
  }

  final PusherCubit pusherCubit;
  late StreamSubscription<PusherState> _pusherSubscription;
  late PreviewAuctionRouteParams routeParams;
  //---------------------------------FUCTIONS----------------------------------//
  void init(PreviewAuctionRouteParams routeParams) {
    this.routeParams = routeParams;
  }
  //---------------------------------AUCTION DETAILS----------------------------------//

  Future<void> fetchAuctionDetails() async {
    emit(PreviewAuctionLoading());

    final result = await PreviewAuctionRepository.getAuctionDetails(
      GetPreviewAuctionDetailsParams(id: routeParams.auctionId),
    );
    result.fold(
      (error) => emit(PreviewAuctionError(error.message)),
      (response) {
        try {
          final auctionDetails = response.data['DATA'];
          final auction = auctionDetails != null
              ? AuctionDetailsModel.fromJson(auctionDetails)
              : null;

          if (auction != null) {
            emit(PreviewAuctionDetailsSuccess(auction));
            // _setupPusherForAuction(routeParams.auctionId);
          } else {
            emit(const PreviewAuctionError('Failed to load auction details'));
          }
        } catch (e) {
          emit(PreviewAuctionError('Error parsing auction details: $e'));
        }
      },
    );
  }

  //---------------------------------AUCTION VALIDATION----------------------------------//

  Future<void> validateJoiningAuction(PreviewAuctionRouteParams params) async {
    emit(PreviewAuctionValidationLoading());

    final validationParams = PreviewAuctionValidationParams(
      auctionId: params.auctionId,
      validationType: 'joining',
    );
    final result =
        await PreviewAuctionRepository.validateJoiningAuction(validationParams);

    result.fold(
      (error) => emit(PreviewAuctionValidationError(error.message)),
      (response) => emit(PreviewAuctionValidationSuccess(response.data)),
    );
  }

  Future<void> validateJoiningAuctionById(int auctionId) async {
    emit(PreviewAuctionValidationLoading());

    final result =
        await PreviewAuctionRepository.validateJoiningAuctionById(auctionId);

    result.fold(
      (error) => emit(PreviewAuctionValidationError(error.message)),
      (response) => emit(PreviewAuctionValidationSuccess(response.data)),
    );
  }

  //---------------------------------AUCTION JOINING----------------------------------//

  Future<void> submitJoining(PreviewAuctionJoiningParams params) async {
    emit(PreviewAuctionJoiningLoading());

    final result = await PreviewAuctionRepository.submitJoining(params);

    result.fold(
      (error) => emit(PreviewAuctionError(error.message)),
      (response) {
        final message =
            response.data['message'] ?? 'Successfully joined auction';
        emit(PreviewAuctionJoinSuccess(message));
      },
    );
  }

  Future<void> checkOnJoining(PreviewAuctionValidationParams params) async {
    emit(PreviewAuctionValidationLoading());

    final result = await PreviewAuctionRepository.checkOnJoining(params);

    result.fold(
      (error) => emit(PreviewAuctionValidationError(error.message)),
      (response) => emit(PreviewAuctionValidationSuccess(response.data)),
    );
  }

  //---------------------------------BIDDING METHODS----------------------------------//

  Future<void> submitBid(
      PreviewAuctionBiddingParams params, bool isFirstBid) async {
    emit(PreviewAuctionBiddingLoading());

    final result = isFirstBid
        ? await PreviewAuctionRepository.firstBid(params)
        : await PreviewAuctionRepository.manualBidding(params);

    result.fold(
      (error) => emit(PreviewAuctionError(error.message)),
      (response) {
        final message = response.data['message'] ?? 'Bid placed successfully';
        final bidAmount = params.amount;
        emit(PreviewAuctionBidSuccess(message, bidAmount));
      },
    );
  }

  Future<void> switchBiddingMethod(PreviewAuctionBiddingParams params) async {
    emit(PreviewAuctionLoading());

    final result = await PreviewAuctionRepository.switchBidding(params);

    result.fold(
      (error) => emit(PreviewAuctionError(error.message)),
      (response) {
        final message =
            response.data['message'] ?? 'Bidding method switched successfully';
        emit(PreviewAuctionJoinSuccess(message));
      },
    );
  }

  Future<void> withdrawFromAuction(
      PreviewAuctionWithdrawalParams params) async {
    emit(PreviewAuctionWithdrawalLoading());

    final result = await PreviewAuctionRepository.auctionWithdrawal(params);

    result.fold(
      (error) => emit(PreviewAuctionError(error.message)),
      (response) {
        final message =
            response.data['message'] ?? 'Successfully withdrew from auction';
        emit(PreviewAuctionWithdrawalSuccess(message));
      },
    );
  }

  //---------------------------------PUSHER INTEGRATION----------------------------------//

  // void _setupPusherForAuction(int auctionId) {
  //   // Initialize Pusher connection if not already connected
  //   if (!pusherCubit.isSubscribedTo('DEV_BIDDING_FLOW')) {
  //     pusherCubit.init().then((_) {
  //       pusherCubit.connect().then((_) {
  //         pusherCubit.subscribeToChannel('DEV_BIDDING_FLOW');
  //         pusherCubit.bindEvent('DEV_BIDDING_FLOW', 'PLACE_BID_$auctionId');
  //       });
  //     });
  //   } else {
  //     // Just bind to the new auction event
  //     pusherCubit.bindEvent('DEV_BIDDING_FLOW', 'PLACE_BID_$auctionId');
  //   }
  // }

  // void _onPusherStateChanged(PusherState pusherState) {
  //   if (pusherState is PusherEventReceived) {
  //     final eventName = 'PLACE_BID_${routeParams.auctionId}';

  //     try {
  //       final pusherModel = AuctionPusherModel.fromJson(pusherState.data);
  //       log('Received real-time bid update: ${pusherModel.toJson()}');
  //       emit(PreviewAuctionBidUpdate(pusherModel));
  //     } catch (e) {
  //       log('Error parsing Pusher event data: $e');
  //     }
  //   }
  // }

  //---------------------------------UTILITY METHODS----------------------------------//

  void resetToInitial() {
    emit(PreviewAuctionInitial());
  }

  @override
  Future<void> close() async {
    await _pusherSubscription.cancel();
    return super.close();
  }
}
