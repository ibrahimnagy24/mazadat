part of 'auction_withdrawal_state.dart';

class AuctionWithdrawalCubit extends Cubit<AuctionWithdrawalState> {
  AuctionWithdrawalCubit() : super(AuctionWithdrawalInitial());

//---------------------------------FUNCTIONS----------------------------------//

  Future<void> withdraw(int id) async {
    emit(AuctionWithdrawalLoading());
    loadingDialog();

    Map<String, dynamic> data = {'id': id};

    final response = await AuctionWithdrawalRepo.auctionWithdrawal(data);
    CustomNavigator.pop();

    response.fold((failure) {
      showErrorToast(failure.message);
      return emit(AuctionWithdrawalError(failure));
    }, (success) {
      if (success.statusCode == 200) {
        CustomNavigator.pop();
        return emit(const AuctionWithdrawalSuccess());
      } else {
        showErrorToast(success.data['MESSAGE']);
        return emit(AuctionWithdrawalError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
