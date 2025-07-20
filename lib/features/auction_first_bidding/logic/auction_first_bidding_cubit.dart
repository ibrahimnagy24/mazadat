part of 'auction_first_bidding_state.dart';

class AuctionFirstBiddingCubit extends Cubit<AuctionFirstBiddingState> {
  AuctionFirstBiddingCubit() : super(AuctionFirstBiddingInitial()) {
    updateBiddingMethod(BiddingMethod.manual);
  }

//---------------------------------VARIABLES----------------------------------//

  final biddingMethod = BehaviorSubject<BiddingMethod>();
  Function(BiddingMethod) get updateBiddingMethod => biddingMethod.sink.add;
  Stream<BiddingMethod> get biddingMethodStream =>
      biddingMethod.stream.asBroadcastStream();

  final maxBiddingValue = BehaviorSubject<double>();
  Function(double) get updateMaxBiddingValue => maxBiddingValue.sink.add;
  Stream<double> get maxBiddingValueStream =>
      maxBiddingValue.stream.asBroadcastStream();

//---------------------------------FUNCTIONS----------------------------------//

  Future<void> bidding(int id) async {
    emit(AuctionFirstBiddingLoading());
    loadingDialog();

    Map<String, dynamic> data = {
      'auctionId': id,
      'biddingMethod': biddingMethod.valueOrNull?.name.toUpperCase(),
    if(biddingMethod.valueOrNull == BiddingMethod.auto)  'maxBiddingValue': maxBiddingValue.valueOrNull
    };

    final response = await AuctionFirstBiddingRepo.firstBid(data);
    CustomNavigator.pop();

    response.fold((failure) {
      showErrorToast(failure.message);
      return emit(AuctionFirstBiddingError(failure));
    }, (success) {
      if (success.statusCode == 200) {
        CustomNavigator.pop();
        return emit(const AuctionFirstBiddingSuccess());
      } else {
        showErrorToast(success.data['MESSAGE']);
        return emit(AuctionFirstBiddingError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
