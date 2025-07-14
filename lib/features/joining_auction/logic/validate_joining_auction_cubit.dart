part of 'validate_joining_auction_state.dart';

class ValidateJoiningAuctionCubit extends Cubit<ValidateJoiningAuctionState> {
  ValidateJoiningAuctionCubit() : super(ValidateJoiningAuctionInitial()) {
    updateCommission(false);
    updateInsurance(false);
  }

//---------------------------------VARIABLES----------------------------------//

  final commission = BehaviorSubject<bool>();
  Function(bool) get updateCommission => commission.sink.add;
  Stream<bool> get commissionStream => commission.stream.asBroadcastStream();

  final insurance = BehaviorSubject<bool>();
  Function(bool) get updateInsurance => insurance.sink.add;
  Stream<bool> get insuranceStream => insurance.stream.asBroadcastStream();

//---------------------------------FUNCTIONS----------------------------------//

  Future<void> validate(int id) async {
    emit(ValidateJoiningAuctionLoading());

    final response = await JoiningAuctionRepo.validateJoiningAuction(id);
    response.fold((failure) {
      return emit(ValidateJoiningAuctionError(failure));
    }, (success) {
      if (success.statusCode == 200 && success.data != null) {
        AuctionPolicyModel? res =
            AuctionPolicyModel.fromJson(success.data);
        return emit(ValidateJoiningAuctionSuccess(data: res));
      } else {
        return emit(ValidateJoiningAuctionError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
