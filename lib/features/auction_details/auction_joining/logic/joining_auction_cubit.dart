part of 'joining_auction_state.dart';

class JoiningAuctionCubit extends Cubit<JoiningAuctionState> {
  JoiningAuctionCubit() : super(JoiningAuctionInitial());

//---------------------------------VARIABLES----------------------------------//

  final payment = BehaviorSubject<PaymentModel?>();
  Function(PaymentModel?) get updatePayment => payment.sink.add;
  Stream<PaymentModel?> get paymentStream => payment.stream.asBroadcastStream();

//---------------------------------FUNCTIONS----------------------------------//

  Future<void> joinAuction({required int id, Function()? onSuccess}) async {
    emit(JoiningAuctionLoading());
    loadingDialog();

    Map<String, dynamic> data = {
      'auctionId': id,
      'paymentType': payment.valueOrNull?.id,
    };
    try {
      final response = await JoiningAuctionRepo.submitJoining(data);
      CustomNavigator.pop();

      response.fold((failure) {
        return emit(JoiningAuctionError(failure));
      }, (success) {
        if (success.statusCode == 200) {
          CustomNavigator.pop();
          CustomNavigator.navigatorState.currentContext
              ?.read<CheckOnJoiningAuctionCubit>()
              .checkOnJoinAuction({
            'auctionId': id,
            'paymentTransactionId': success.data['TRANSACTION_ID'],
            'onSuccess': onSuccess,
          });

          ///FORM_LINK

          ///TRANSACTION_ID

          return emit(const JoiningAuctionSuccess());
        } else {
          return emit(JoiningAuctionError(ErrorEntity(
              message: success.data['MESSAGE'],
              statusCode: success.statusCode ?? 400,
              errors: const [])));
        }
      });
    } catch (e) {
      return emit(JoiningAuctionError(ErrorEntity(
          message: e.toString(), statusCode: 400, errors: const [])));
    }
  }
}
