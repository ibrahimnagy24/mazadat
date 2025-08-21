import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/enums/enums.dart';
import '../data/model/auction_details_model.dart';
import '../data/repo/auction_details_repo.dart';
part 'view_auction_state.dart';

class AuctionDetailsCubit extends Cubit<AuctionDetailsState> {
  AuctionDetailsCubit() : super(AuctionDetailsInitial()) {
    updateImageIndex(0);
  }

//---------------------------------VARIABLES----------------------------------//
  AuctionDetailsModel? AuctionDetails;
//---------------------------------FUNCTIONS----------------------------------//

  /// Select a specific image from the gallery
  final imageIndex = BehaviorSubject<int>();
  Function(int) get updateImageIndex => imageIndex.sink.add;
  Stream<int> get imageIndexStream => imageIndex.stream.asBroadcastStream();

//----------------------------------REQUEST-----------------------------------//

  Future<void> auctionDetailsStatesHandled(int id) async {
    emit(const AuctionDetailsLoading());

    final response = await AuctionDetailsRepo.getAuctionDetails(id);
    response.fold((failure) {
      return emit(AuctionDetailsError(failure));
    }, (success) {
      if (success.statusCode == 200) {
        AuctionDetailsModel? res =
            AuctionDetailsModel.fromJson(success.data['DATA']);
        AuctionDetails = res;
        int currentIndex =
            res.attachments?.indexWhere((e) => e.url == res.primaryPhoto) ?? 0;
        updateImageIndex(currentIndex == -1 ? 0 : currentIndex);
        return emit(AuctionDetailsSuccess(AuctionDetails: res));
      } else {
        return emit(AuctionDetailsError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }

  // Future<void> switchAutomaticBiddToManual() async {

  //   if (biddingMethod == null || reachedToMaxBiddingValue == false) return;
  //   emit(const AuctionSwitchBiddingLoading());
  //   Map<String, dynamic> data = {
  //     'auctionId': AuctionDetails?.id,
  //     'biddingMethod': biddingMethod.name.toUpperCase(),
  //   };

  //   final response = await AuctionAutoBiddingRepo.switchBidding(data);

  //   response.fold((failure) {
  //     return emit(AuctionSwitchBiddingError(failure));
  //   }, (success) {
  //     if (success.statusCode == 200) {
  //       return emit(const AuctionFirstBiddingSuccess());
  //     } else {
  //       showErrorToast(success.data['MESSAGE']);
  //       return emit(AuctionSwitchBiddingError(ErrorEntity(
  //           message: success.data['MESSAGE'],
  //           statusCode: success.statusCode ?? 400,
  //           errors: const [])));
  //     }
  //   });
  // }

  bool isReachedToMaxBiddingValue() {
    final biddingMethod =
        AuctionDetails?.currentBiddingMethod == BiddingMethod.auto
            ? BiddingMethod.manual
            : null;
    final reachedToMaxBiddingValue =
        AuctionDetails?.currentBiddingMethod == BiddingMethod.auto &&
            AuctionDetails?.maxBiddingAmount != null &&
            double.parse(AuctionDetails?.maxBiddingAmount.toString() ?? '0') >=
                double.parse(
                    AuctionDetails?.currentBiddingAmount.toString() ?? '0');

    if (biddingMethod == null || reachedToMaxBiddingValue == false) {
      return false;
    } else {
      return true;
    }
  }
}
