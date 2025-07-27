part of 'auction_switch_bidding_state.dart';

class AuctionSwitchBiddingCubit extends Cubit<AuctionSwitchBiddingState> {
  AuctionSwitchBiddingCubit() : super(AuctionSwitchBiddingInitial()) {
    updateBiddingMethod(BiddingMethod.auto);
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

  Future<void> switchBidding({required int id, Function()? onSuccess}) async {
    emit(AuctionSwitchBiddingLoading());
    loadingDialog();

    Map<String, dynamic> data = {
      'auctionId': id,
      'biddingMethod': biddingMethod.valueOrNull?.name.toUpperCase(),
    if(biddingMethod.valueOrNull == BiddingMethod.auto)  'maxBiddingValue': maxBiddingValue.valueOrNull
    };

    final response = await AuctionAutoBiddingRepo.switchBidding(data);
    CustomNavigator.pop();

    response.fold((failure) {
      showErrorToast(failure.message);
      return emit(AuctionSwitchBiddingError(failure));
    }, (success) {
      if (success.statusCode == 200) {
        onSuccess?.call();
        CustomNavigator.pop();
      return emit(const AuctionFirstBiddingSuccess());
      } else {
        showErrorToast(success.data['MESSAGE']);
        return emit(AuctionSwitchBiddingError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
