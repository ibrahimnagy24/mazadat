part of 'check_on_joining_auction_state.dart';

class CheckOnJoiningAuctionCubit extends Cubit<CheckOnJoiningAuctionState> {
  CheckOnJoiningAuctionCubit() : super(CheckOnJoiningAuctionInitial());

//---------------------------------VARIABLES----------------------------------//

  Future<void> checkOnJoinAuction(Map<String, dynamic> data) async {
    emit(CheckOnJoiningAuctionLoading());
    loadingDialog();

    final response = await JoiningAuctionRepo.checkOnJoining(data);
    CustomNavigator.pop();

    response.fold((failure) {
      CustomSimpleDialog.parentSimpleDialog(
        isDismissible: false,
        customListWidget: PaymentSuccessDialog(
          isSuccess: false,
          error: failure.message ,
        ),
      );
      return emit(CheckOnJoiningAuctionError(failure));
    }, (success) {
      CustomSimpleDialog.parentSimpleDialog(
        isDismissible: false,
        customListWidget: PaymentSuccessDialog(
          isSuccess: success.statusCode == 200,
          error: success.data['MESSAGE'] ?? '',
        ),
      );
      return emit(const CheckOnJoiningAuctionSuccess());
    });
  }
}
