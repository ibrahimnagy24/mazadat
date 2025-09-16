part of 'check_on_joining_auction_state.dart';

class CheckOnJoiningAuctionCubit extends Cubit<CheckOnJoiningAuctionState> {
  CheckOnJoiningAuctionCubit() : super(CheckOnJoiningAuctionInitial());

//---------------------------------VARIABLES----------------------------------//

  Future<void> checkOnJoinAuction(Map<String, dynamic> data) async {
    emit(CheckOnJoiningAuctionLoading());
    loadingDialog();
    Map<String, dynamic> body = {
      'auctionId': data['auctionId'],
      'paymentTransactionId': data['paymentTransactionId'],
    };
    try {
      final response = await JoiningAuctionRepo.checkOnJoining(body);
      CustomNavigator.pop();

      response.fold((failure) {
        CustomSimpleDialog.parentSimpleDialog(
          isDismissible: false,
          customListWidget: PaymentSuccessDialog(
            isSuccess: false,
            error: failure.message,
            onTap: () {
              checkOnJoinAuction(data);
              CustomNavigator.pop();
            },
          ),
        );
        return emit(CheckOnJoiningAuctionError(failure));
      }, (success) {
        CustomSimpleDialog.parentSimpleDialog(
          isDismissible: false,
          customListWidget: PaymentSuccessDialog(
            isSuccess: success.statusCode == 200,
            error: success.data['MESSAGE'] ?? '',
            onTap: () {
              CustomNavigator.pop();
              (data['onSuccess'] as Function()).call();
            },
          ),
        );
        return emit(const CheckOnJoiningAuctionSuccess());
      });
    } catch (e) {
      return emit(CheckOnJoiningAuctionError(ErrorEntity(
          message: e.toString(), statusCode: 400, errors: const [])));
    }
  }
}
