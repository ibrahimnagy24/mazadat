part of 'joining_auction_state.dart';

class JoiningAuctionCubit extends Cubit<JoiningAuctionState> {
  JoiningAuctionCubit() : super(JoiningAuctionInitial());

//---------------------------------VARIABLES----------------------------------//

//---------------------------------FUNCTIONS----------------------------------//

  Future<void> joinAuction(int id) async {
    emit(JoiningAuctionLoading());

    final response = await JoiningAuctionRepo.validateJoiningAuction(id);
    response.fold((failure) {
      return emit(JoiningAuctionError(failure));
    }, (success) {
      if (success.statusCode == 200 && success.data['DATA'] != null) {
        AuctionPolicyModel? res =
            AuctionPolicyModel.fromJson(success.data['DATA']);
        return emit(JoiningAuctionSuccess(data: res));
      } else {
        return emit(JoiningAuctionError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
