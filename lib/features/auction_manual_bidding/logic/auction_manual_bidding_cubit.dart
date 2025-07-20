part of 'auction_manual_bidding_state.dart';

class AuctionManualBiddingCubit extends Cubit<AuctionManualBiddingState> {
  AuctionManualBiddingCubit() : super(AuctionManualBiddingInitial()) ;




  Future<void> startManualBidding(int id) async {
    emit(AuctionManualBiddingLoading());
    loadingDialog();

    Map<String, dynamic> data = {
      'auctionId': id,
      'biddingMethod':'MANUAL'
   };

    final response = await AuctionManualBiddingRepo.manualBidding(data);
    CustomNavigator.pop();

    response.fold((failure) {
      showErrorToast(failure.message);
      return emit(AuctionManualBiddingError(failure));
    }, (success) {
      if (success.statusCode == 200) {
      return emit(const AuctionManualBiddingSuccess());
      } else {
        showErrorToast(success.data['MESSAGE']);
        return emit(AuctionManualBiddingError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
